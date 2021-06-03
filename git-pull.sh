basedir=`pwd`
while read line
do
  cd ../$line && git pull
done < all.lst
cd $basedir

