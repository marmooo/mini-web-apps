keywordFrom='https://cdn.jsdelivr.net/npm/bootstrap@5.0.2'
keywordTo='https://cdn.jsdelivr.net/npm/bootstrap@5.1.0'

replace="sd -s '$keywordFrom' '$keywordTo' src/sw.js"
basedir=`pwd`
while read line
do
  cd ../$line && eval $replace
done < all.lst
cd $basedir

