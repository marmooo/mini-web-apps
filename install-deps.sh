basedir=`pwd`

# Dict
git clone git@github.com:marmooo/graded-enja-corpus

cd ..
sudo apt install git-lfs
git clone git@github.com:WorksApplications/SudachiDict
cd SudachiDict
git lfs install
git lfs pull
cd ..

wget http://iij.dl.sourceforge.jp/naist-jdic/53500/mecab-naist-jdic-0.6.3b-20111013.tar.gz
tar xzf mecab-naist-jdic-0.6.3b-20111013.tar.gz
cd mecab-naist-jdic-0.6.3b-20111013
iconv -f euc-jp -t utf8 naist-jdic.csv > naist-jdic.utf8.csv
cd ..

wget https://s3-ap-northeast-1.amazonaws.com/nwc2010-ngrams/word/over999/filelist
wget -xnH -i filelist
rm filelist
cd ..

git clone git@github.com:MosasoM/inappropriate-words-ja


# Link
dir=`pwd`
ln -fs $dir/mGSL vocabee/mGSL
ln -fs $dir/mGSL english-words-typing/mGSL
ln -fs $dir/graded-enja-corpus speecha/graded-enja-corpus
ln -fs $dir/graded-enja-corpus english-sentences-typing/graded-enja-corpus
ln -fs $dir/graded-vocab-ja kana-meiro/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kana-sagashi/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kana-siritori/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kanji-dict/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kanji-typing/graded-vocab-ja
ln -fs $dir/graded-idioms-ja kanji-meiro/graded-idioms-ja
ln -fs $dir/graded-idioms-ja jukugo3-sagashi/graded-idioms-ja
ln -fs $dir/graded-idioms-ja kanji-siritori/graded-idioms-ja
ln -fs $dir/graded-idioms-ja kanji-dict/graded-idioms-ja
ln -fs $dir/graded-idioms-ja kanji-typing/graded-idioms-ja

ln -fs $dir/nwc2010-ngrams graded-vocab-ja/nwc2010-ngrams
ln -fs $dir/nwc2010-ngrams graded-idioms-ja/nwc2010-ngrams
ln -fs $dir/SudachiDict graded-vocab-ja/SudachiDict
ln -fs $dir/SudachiDict graded-idioms-ja/SudachiDict
ln -fs $dir/SudachiDict homonym-ja/SudachiDict
ln -fs $dir/SudachiDict spelling-variants-ja/SudachiDict
ln -fs $dir/mecab-naist-jdic-0.6.3b-20111013 homonym-ja/mecab-naist-jdic-0.6.3b-20111013
ln -fs $dir/mecab-naist-jdic-0.6.3b-20111013 spelling-variants-ja/mecab-naist-jdic-0.6.3b-20111013

ln -fs $dir/inappropriate-words-ja graded-vocab-ja/inappropriate-words-ja
ln -fs $dir/inappropriate-words-ja graded-idioms-ja/inappropriate-words-ja

cd $basedir

