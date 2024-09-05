source "$(dirname "$0")/get_filenames.sh"
echo $(grep -Ril docs/Dossiers --include=\*.md -e "$outName")
