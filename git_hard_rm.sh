#!/bin/sh
# Lara Maia <lara@craft.net.br>
# $1 = Arquivo ou pasta
# $2 = {,Pack}

IFS=$'\n'
objects=$(git verify-pack -v .git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head)

output="T.[Kb],Pack,SHA1,Caminho"
for y in $objects; do
	size=$((`echo $y | cut -f 5 -d ' '`/1024))
	compressedSize=$((`echo $y | cut -f 6 -d ' '`/1024))
	sha=`echo $y | cut -f 1 -d ' '`
	other=`git rev-list --all --objects | grep $sha`
	output="${output}\n${size},${compressedSize},${other}"
done

echo -e $output | column -t -s ', '
unset IFS

if [ "$1" != "" -a "$1" != "--" ]; then
	git filter-branch --index-filter "git rm -r --cached --ignore-unmatch $1"
	rm -rf .git/refs/original/
fi

if [ "$2" == "Pack" ]; then
	nano .git/packed-refs
	git reflog expire --all --expire-unreachable=0
	git repack -A -d
	git prune
fi


