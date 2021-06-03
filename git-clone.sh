basedir=`pwd`
cd ..
while read line
do
  git clone https://github.com/marmooo/$line
done < all.lst
cd $basedir

