source template/get_filenames.sh

#echo "pdf filename $fileName outname $outName"

echo "\033[0;32m     $fileName to out/$outName.pdf \033[0m"

mkdir -p "$(dirname "print/$outName")"

pandoc "$(pwd)/$fileName" \
    --from markdown+tex_math_single_backslash \
    --to pdf \
    --shift-heading-level-by=-1 \
    --template="template/tufte-book.tex" \
    --quiet \
    --resource-path="$(dirname "$fileName")" \
    --output "$(pwd)/print/$outName.pdf" \
    $@
