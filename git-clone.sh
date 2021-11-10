basedir=`pwd`
cd ..
while read line
do
  git clone git@github.com:marmooo/$line.git
done < all.lst
cd $basedir

