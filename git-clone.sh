basedir=`pwd`
cd ..
while read line
do
  git clone git@github.com:marmooo/$line.git
done < $basedir/all.lst
cd $basedir

