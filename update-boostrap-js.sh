keywordFrom='<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>'
keywordTo='<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>'

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

