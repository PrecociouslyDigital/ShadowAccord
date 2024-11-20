mergeName=$1
shift

pdftk $@ cat output "$mergeName"
