rm -rf out
mkdir out

if [[ $1 == "--build-pdf" ]]; then
    rm -rf print
    mkdir print
fi

cp -r css out

rm docs/index.md

echo "% Tiffany Foundling

<!---
Autogenerated File: edits will be overwritten
-->

" > docs/index.md

for folder in docs/*; do
    if [[ "$folder" == "docs/index.md" ]]; then
        continue
    fi
    echo "### ${folder#"docs/"}" >> docs/index.md
    echo "$(find "$folder" -type f -name "*.md"  -exec ./build.sh {} $@ \;)"
done

./build.sh docs/index.md 

mv out/index/index.html out/index.html
rm -r out/index
