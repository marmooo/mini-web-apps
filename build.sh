basedir=`pwd`

cd ../kanji-dict && node build.js && cd $basedir
cd ../graded-vocab-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../graded-idioms-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../homonym-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../spelling-variants-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../shogi-beginners && hugo --minify && cd $basedir
cd ../photo-scanner && bash build_release.sh && cd $basedir

build="bash build.sh"
while read line
do
  echo ===== $line
  cd ../$line && eval $build
done < all.lst
cd $basedir

