basedir=`pwd`

# cd ../kanji-dict && node build.js && cd $basedir
# # cd ../homonym-ja && node build.js && cd $basedir
# # cd ../spelling-variants-ja && node build.js && cd $basedir
# # cd ../shogi-beginners && hugo --minify && cd $basedir

build="bash build.sh"
while read line
do
  cd ../$line && eval $build
  cd $basedir
done < all.lst
cd $basedir

