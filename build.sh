shopt -s extglob
fileName=$1
outName=${fileName%.*}
#remove spaces
outName="${outName// /_}"

shift

echo "\033[0;36m     docs/$fileName to out/$outName \033[0m"

mkdir -p "out/$outName"

pandoc "$(pwd)/docs/$fileName" \
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

echo "out/$outName/index.html"

gsed -i -f template/post.sed "out/$outName/index.html"

cp -a "docs/$(dirname "$fileName")/." "out/$(dirname "$outName")"
rm "out/$(dirname "$outName")/$(basename "$fileName")"
