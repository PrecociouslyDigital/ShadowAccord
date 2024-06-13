rm -rf out

mkdir out
cp -r css out

rm docs/index.md

echo "% Tiffany Foundling" > docs/index.md

for folder in docs/*; do
    if [[ "$folder" == "docs/index.md" ]]; then
        continue
    fi
    echo "### ${folder#"docs/"}" >> docs/index.md
    find "$folder" -type f -name "*.md"  -exec ./build.sh {} \;
done

./build.sh docs/index.md 

mv out/index/index.html out/index.html
rm -r out/index
