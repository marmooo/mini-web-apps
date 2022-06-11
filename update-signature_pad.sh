keywordFrom='<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.4/dist/signature_pad.umd.min.js" integrity="sha256-xuQgZE2VC1Soyw8LCQlcPXpfqO6HEQhFExfLVcSXY3c=" crossorigin="anonymous"></script>'
keywordTo='<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.0.5/dist/signature_pad.umd.min.js" integrity="sha256-DmYmpIUR97yasUhSuGMksoucIJaDfl2zDMpOrd4dNps=" crossorigin="anonymous"></script>'

replace="sd -s '$keywordFrom' '$keywordTo' \$(fdfind --type file -e html . src)"
basedir=`pwd`
while read line
do
  cd ../$line
  eval $replace
done < signature_pad.lst
cd $basedir



keywordFrom='https://cdn.jsdelivr.net/npm/signature_pad@4.0.4'
keywordTo='https://cdn.jsdelivr.net/npm/signature_pad@4.0.5'
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
done < signature_pad.lst
cd $basedir



bash update-sw.js.sh signature_pad.lst
bash build.sh signature_pad.lst
bash git-push.sh signature_pad.lst "bump signature_pad from 4.0.4 to 4.0.5"
