# bash grep.sh <keyword> **/*.html
while read line
do
  echo ===== $line
  cd ../$line && rg $@
done < all.lst
cd $basedir

