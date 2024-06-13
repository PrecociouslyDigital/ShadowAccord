fileName=$1
outName=${fileName%.*}
#remove spaces (can't use params cause cloudflare has a conniption)
outName=$(echo "$outName" | tr ' ' '_' )
#remove docs
outName="${outName#"docs/"}"

shift

echo "\033[0;36m     $fileName to out/$outName \033[0m"

mkdir -p "out/$outName"

pandoc "$(pwd)/$fileName" \
    --katex \
    --section-divs \
    --from markdown+tex_math_single_backslash \
    --filter pandoc-sidenote \
    --to html5+smart \
    --standalone \
    --template="template/tufte.html5" \
    --css template/tufte.css \
    --css template/latex.css \
    --css template/pandoc.css \
    --css template/pandoc-solarized.css \
    --css template/tufte-extra.css \
    --output "$(pwd)/out/$outName/index.html"
    $@


gsed -i -f template/post.sed "out/$outName/index.html"

find "$(dirname "$fileName")" -type f ! -name "*.md" -exec cp {} "out/$(dirname "$outName")" \;

