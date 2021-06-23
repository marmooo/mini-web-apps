keywordFrom='<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">'
keywordTo='<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">'

replace="sd -s '$keywordFrom' '$keywordTo' \$(fd --type file -e html . src)"
basedir=`pwd`
while read line
do
  cd ../$line
  eval $replace
done < static.lst
cd $pwd

cd $basedir
while read line
do
  replace="sd -s '$keywordFrom' '$keywordTo' ../$line"
  eval $replace
done < generator.lst

