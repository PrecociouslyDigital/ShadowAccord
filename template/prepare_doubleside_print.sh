proofName=$1
baseName="${proofName%.*}"

num_pages="$(pdftk "$proofName" dump_data | grep NumberOfPages | awk '{print $2}')"

if [ "$num_pages" = "1" ]; then
    echo "only one page in $proofName"
    exit 0
fi

forward_pages=""
backward_pages=""

for i in $(seq 1 $num_pages); do
    mod=$((i%4))
    if [ "$mod" = "1" ] || [ "$mod" = "0" ]; then
        forward_pages="$forward_pages A$i-$i" 
    elif [ "$mod" = "2" ] && [ "$i" = "$num_pages" ]; then
        # input an extra page to pad out and print the right page on the reverse
        backward_pages="B1-1 A$i-$i $backward_pages" 
        forward_pages="$forward_pages B1-1" 
    else
        backward_pages="A$i-$i $backward_pages" 
    fi
done

pdftk A="$proofName" B="$(dirname "$0")/blank.pdf" cat $forward_pages output "${baseName}_forward.pdf"
pdftk A="$proofName" B="$(dirname "$0")/blank.pdf" cat $backward_pages output "${baseName}_backwards.pdf"
