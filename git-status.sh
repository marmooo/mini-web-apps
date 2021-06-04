basedir=`pwd`
while read line
do
  echo ===== $line
  cd ../$line && git status
done < all.lst
cd $basedir

