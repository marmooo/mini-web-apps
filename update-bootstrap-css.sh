keywordFrom='<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-uWxY/CJNBR+1zjPWmfnSnVxwRheevXITnMqoEIeG1LJrdI0GlVs/9cVSyPYXdcSF" crossorigin="anonymous">'
keywordTo='<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">'

replace="sd -s '$keywordFrom' '$keywordTo' \$(fdfind --type file -e html . src)"
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

