keywordFrom='https://cdn.jsdelivr.net/npm/bootstrap@5.0.0'
keywordTo='https://cdn.jsdelivr.net/npm/bootstrap@5.0.1'

replace="sd -s '$keywordFrom' '$keywordTo' src/sw.js"
basedir=`pwd`
while read line
do
  cd ../$line && $replace
done < test.lst
cd $basedir

