basedir=`pwd`
while read line
do
  cd ../$line
  git add *
  git commit -m "$1"
  git push
  sleep 10
done < all.lst
cd $basedir

