basedir=`pwd`
build="bash build.sh"
while read line
do
  echo ===== $line
  cd ../$line && eval $build
done < $1
cd $basedir

