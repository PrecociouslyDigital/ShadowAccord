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


./template/prepare_doubleside_print.sh "print/$outName/proof.pdf"
