basedir=`pwd`
while read line
do
  cd ../$line
  git add *
  git commit -m "$2"
  git push
  sleep 10
done < $1
cd $basedir
