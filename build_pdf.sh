source template/get_filenames.sh

echo "\033[0;32m     $fileName to print/$outName \033[0m"

mkdir -p "print/$outName"

pandoc "$(pwd)/$fileName" \
    --from markdown+tex_math_single_backslash \
    --to pdf \
    --shift-heading-level-by=-1 \
    --template="template/tufte-book.tex" \
    --quiet \
    --resource-path="$(dirname "$fileName")" \
    --output "print/$outName/proof.pdf" \
    $@


num_pages="$(pdftk "print/$outName/proof.pdf" dump_data | grep NumberOfPages | awk '{print $2}')"
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

pdftk A="print/$outName/proof.pdf" B="template/blank.pdf" cat $forward_pages output "print/$outName/forward.pdf"
pdftk A="print/$outName/proof.pdf" B="template/blank.pdf" cat $backward_pages output "print/$outName/backwards.pdf"
