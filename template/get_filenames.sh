fileName=$1
outName=${fileName%.*}
#remove spaces (can't use params cause cloudflare has a conniption)
outBaseNameWithSpace="$(basename "$outName")"
outName=$(echo "$outName" | tr ' ' '_' )
#remove docs
outName="${outName#"docs/"}"
#respect index
outName=${outName%"/index"}
shift
