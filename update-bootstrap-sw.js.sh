keywordFrom='https://cdn.jsdelivr.net/npm/bootstrap@5.1.2'
keywordTo='https://cdn.jsdelivr.net/npm/bootstrap@5.1.3'
replace="sd -s '$keywordFrom' '$keywordTo' src/sw.js"
replaceJa="sd -s '$keywordFrom' '$keywordTo' src/ja/sw.js"
replaceEn="sd -s '$keywordFrom' '$keywordTo' src/en/sw.js"

basedir=`pwd`
while read line
do
  cd ../$line
  eval $replace
  eval $replaceJa
  eval $replaceEn
done < all.lst
cd $basedir
