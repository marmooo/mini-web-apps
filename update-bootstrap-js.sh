keywordFrom='<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-kQtW33rZJAHjgefvhyyzcGF3C5TFyBQBA13V1RKPf4uH+bwyzQxZ6CmMZHmNBEfJ" crossorigin="anonymous"></script>'
keywordTo='<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>'

replace="sd -s '$keywordFrom' '$keywordTo' \$(fd --type file -e html . src)"
basedir=`pwd`
while read line
do
  cd ../$line
  eval $replace
done < static.lst
cd $basedir

cd $basedir
while read line
do
  replace="sd '$keywordFrom' '$keywordTo' ../$line"
  eval $replace
done < generator.lst

