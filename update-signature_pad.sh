keywordFrom='<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.2/dist/signature_pad.umd.min.js" integrity="sha256-r5+PB5YNxrCsBxRQfgksYr+JjCLB6XyvT/4BqGITlGU=" crossorigin="anonymous"></script>'
keywordTo='<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.3/dist/signature_pad.umd.min.js" integrity="sha256-1mwC80W4+q6J0SYkAw1X6OsoalMR03ub7nUgtrvF08M=" crossorigin="anonymous"></script>'

replace="sd -s '$keywordFrom' '$keywordTo' \$(fdfind --type file -e html . src)"
basedir=`pwd`
while read line
do
  cd ../$line
  eval $replace
done < signature_pad.lst
cd $basedir



keywordFrom='https://cdn.jsdelivr.net/npm/signature_pad@4.0.2'
keywordTo='https://cdn.jsdelivr.net/npm/signature_pad@4.0.3'

replace="sd -s '$keywordFrom' '$keywordTo' src/sw.js"
basedir=`pwd`
while read line
do
  cd ../$line && eval $replace
done < signature_pad.lst
cd $basedir



bash update-sw.js.sh signature_pad.lst
bash build.sh signature_pad.lst
bash git-push.sh signature_pad.lst "bump signature_pad from 4.0.2 to 4.0.3"
