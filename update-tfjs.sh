keywordFrom='https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@3.15.0/dist/tf.min.js';
keywordTo='https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@3.16.0/dist/tf.min.js';

replace="sd -s '$keywordFrom' '$keywordTo' \$(fdfind --type file -e js . src)"
basedir=`pwd`
while read line
do
  cd ../$line
  eval $replace
done < tfjs.lst
cd $basedir



bash update-sw.js.sh tfjs.lst
bash build.sh tfjs.lst
bash git-push.sh tfjs.lst "bump tfjs from 3.15.0 to 3.16.0"
