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
    if [[ "$folder" == "docs/Dossiers" ]]; then
        echo "" >> docs/index.md
        echo "### Dossiers" >> docs/index.md
        for category in docs/Dossiers/*; do
            if [[ "$category" == "docs/Dossiers/blank.png" ]]; then
                continue
            fi
            echo "" >> docs/index.md
            echo "#### ${category#"docs/Dossiers/"}" >> docs/index.md
            find "$category" -type f -name "*.md"  -exec ./build.sh {} $@ \;
        done
    else
        echo "" >> docs/index.md
        name="${folder#"docs/"}"
        echo "### ${name:8} ${name:0:4}" >> docs/index.md
        find "$folder" -type f -name "*.md"  -exec ./build.sh {} $@ \;
    fi
done

./build.sh docs/index.md 

mv out/index/index.html out/index.html
rm -r out/index
