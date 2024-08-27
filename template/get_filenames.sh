fileName=$1
outName=${fileName%.*}
#remove spaces (can't use params cause cloudflare has a conniption)
outName=$(echo "$outName" | tr ' ' '_' )
#remove docs
outName="${outName#"docs/"}"
shift
