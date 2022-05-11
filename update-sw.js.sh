timestamp=$(date '+%Y-%m-%d %H:%M')
keywordFrom="^var CACHE_NAME.*$"
keywordTo='var CACHE_NAME = \"$timestamp\";'
replace="sd -f m \"$keywordFrom\" \"$keywordTo\" src/sw.js"
basedir=`pwd`
while read line
do
  echo $replace
  cd ../$line && eval $replace
done < $1
cd $basedir

