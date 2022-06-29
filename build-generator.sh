basedir=`pwd`

cd ../kanji-dict && deno run --allow-read --allow-write build.js > build.log && cd $basedir
cd ../graded-vocab-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../graded-idioms-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../homonym-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../spelling-variants-ja && deno run --allow-read --allow-write build.js && cd $basedir
cd ../shogi-beginners && bash build.sh && cd $basedir
