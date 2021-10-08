keywordFrom='<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">'
keywordTo='<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">'

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

