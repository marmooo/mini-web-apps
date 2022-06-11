basedir=`pwd`

# Dict
cd ..
git clone git@github.com:marmooo/graded-enja-corpus
git clone git@github.com:marmooo/graded-kanji-examples
git clone git@github.com:marmooo/yomi-dict
git clone git@github.com:marmooo/onkun
git clone git@github.com:marmooo/cmu-dict-ipa


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
xz -dv nwc2010-ngrams/word/over999/1gms/1gm-0000.xz
xz -dv nwc2010-ngrams/word/over999/2gms/2gm-0000.xz
xz -dv nwc2010-ngrams/word/over999/3gms/3gm-0000.xz
xz -dv nwc2010-ngrams/word/over999/4gms/4gm-0000.xz
xz -dv nwc2010-ngrams/word/over999/5gms/5gm-0000.xz
xz -dv nwc2010-ngrams/word/over999/6gms/6gm-0000.xz
xz -dv nwc2010-ngrams/word/over999/7gms/7gm-0000.xz

git clone git@github.com:marmooo/google-ngram-small-en
cd google-ngram-small-en
gunzip -d dist/1gram/*
gunzip -d dist/2gram/*
gunzip -d dist/3gram/*
cd ..

wget https://dl.fbaipublicfiles.com/fasttext/vectors-english/crawl-300d-2M.vec.zip
unzip crawl-300d-2M.vec.zip
wget https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.ja.300.vec.gz
gunzip -d cc.ja.300.vec.gz
wget https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.zh.300.vec.gz
gunzip -d cc.zh.300.vec.gz

git clone git@github.com:MosasoM/inappropriate-words-ja
git clone git@github.com:fxsjy/jieba


# Link
dir=`pwd`
ln -fs $dir/mGSL vocabee/mGSL
ln -fs $dir/mGSL english-words-typing/mGSL
ln -fs $dir/graded-enja-corpus english-sentences-typing/graded-enja-corpus
ln -fs $dir/graded-vocab-ja kana-meiro/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kana-sagashi/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kana-siritori/graded-vocab-ja
ln -fs $dir/graded-idioms-ja kanji-meiro/graded-idioms-ja
ln -fs $dir/graded-idioms-ja jukugo3-sagashi/graded-idioms-ja
ln -fs $dir/graded-kanji-examples touch-shodo/graded-kanji-examples
ln -fs $dir/SudachiDict dajare-ondoku/SudachiDict
ln -fs $dir/SudachiDict hayakuchi-ondoku/SudachiDict
ln -fs $dir/marmooo.github.io/docs/kanjivg touch-50on/kanjivg
ln -fs $dir/marmooo.github.io/docs/kanjivg touch-de-kakijun/kanjivg
ln -fs $dir/yomi-dict emoji-typing/yomi-dict

# kanji-siritori
ln -fs $dir/yomi-dict kanji-siritori/yomi-dict
ln -fs $dir/graded-idioms-ja kanji-siritori/graded-idioms-ja

# touch-kanji
ln -fs $dir/graded-kanji-examples touch-kanji/graded-kanji-examples
ln -fs $dir/marmooo.github.io/docs/kanjivg touch-kanji/kanjivg

# touch-shuji
ln -fs $dir/graded-kanji-examples touch-shuji/graded-kanji-examples
ln -fs $dir/marmooo.github.io/docs/animCJK touch-kanji/animCJK

# kanji-typing
ln -fs $dir/yomi-dict kanji-typing/yomi-dict
ln -fs $dir/graded-vocab-ja kanji-typing/graded-vocab-ja
ln -fs $dir/graded-idioms-ja kanji-typing/graded-idioms-ja

# graded-kanji-examples
ln -fs $dir/onkun graded-kanji-examples/onkun
ln -fs $dir/yomi-dict graded-kanji-examples/yomi-dict
ln -fs $dir/graded-vocab-ja graded-kanji-examples/graded-vocab-ja
ln -fs $dir/graded-idioms-ja graded-kanji-examples/graded-idioms-ja

# kanji-dict
ln -fs $dir/graded-vocab-ja kanji-dict/graded-vocab-ja
ln -fs $dir/graded-idioms-ja kanji-dict/graded-idioms-ja

# homonym-ja
ln -fs $dir/SudachiDict homonym-ja/SudachiDict
ln -fs $dir/mecab-naist-jdic-0.6.3b-20111013 homonym-ja/mecab-naist-jdic-0.6.3b-20111013

# spelling-variants-ja
ln -fs $dir/SudachiDict spelling-variants-ja/SudachiDict
ln -fs $dir/mecab-naist-jdic-0.6.3b-20111013 spelling-variants-ja/mecab-naist-jdic-0.6.3b-20111013

# graded-vocab-ja
ln -fs $dir/SudachiDict graded-vocab-ja/SudachiDict
ln -fs $dir/nwc2010-ngrams graded-vocab-ja/nwc2010-ngrams
ln -fs $dir/inappropriate-words-ja graded-vocab-ja/inappropriate-words-ja

# graded-idioms-ja
ln -fs $dir/SudachiDict graded-idioms-ja/SudachiDict
ln -fs $dir/nwc2010-ngrams graded-idioms-ja/nwc2010-ngrams
ln -fs $dir/inappropriate-words-ja graded-idioms-ja/inappropriate-words-ja

# speecha
ln -fs $dir/graded-enja-corpus speecha/graded-enja-corpus
ln -fs $dir/google-ngram-small-en speecha/google-ngram-small-en

# gratalk
ln -fs $dir/google-ngram-small-en gratalk/google-ngram-small-en

# wncc-ja
ln -fs $dir/nwc2010-ngrams wncc-ja/nwc2010-ngrams

# wncc-en
ln -fs $dir/google-ngram-small-en wncc-en/google-ngram-small-en

# siminym-ja
ln -fs $dir/SudachiDict siminym-ja/SudachiDict
ln -fs $dir/nwc2010-ngrams siminym-ja/nwc2010-ngrams
ln -fs $dir/inappropriate-words-ja siminym-ja/inappropriate-words-ja
ln -fs $dir/cc.ja.300.vec siminym-ja/cc.ja.300.vec

# siminym-en
ln -fs $dir/mGSL siminym-en/mGSL
ln -fs $dir/google-ngram-small-en siminym-en/google-ngram-small-en
ln -fs $dir/crawl-300d-2M.vec siminym-en/crawl-300d-2M.vec

# siminym-zh
ln -fs $dir/jieba siminym-zh/jieba
ln -fs $dir/cc.zh.300.vec siminym-zh/cc.zh.300.vec

# rensole-ja
ln -fs $dir/SudachiDict rensole-ja/SudachiDict
ln -fs $dir/nwc2010-ngrams rensole-ja/nwc2010-ngrams
ln -fs $dir/inappropriate-words-ja rensole-ja/inappropriate-words-ja
ln -fs $dir/cc.ja.300.vec rensole-ja/cc.ja.300.vec
ln -fs $dir/siminym-ja/docs rensole-ja/siminym-ja

# rensole-en
ln -fs $dir/mGSL rensole-en/mGSL
ln -fs $dir/cmudict-ipa rensole-en/cmudict-ipa
ln -fs $dir/crawl-300d-2M.vec rensole-en/crawl-300d-2M.vec
ln -fs $dir/siminym-en/docs rensole-en/siminym-en

# rensole-zh
ln -fs $dir/jieba rensole-zh/jieba
ln -fs $dir/cc.zh.300.vec rensole-zh/cc.zh.300.vec
ln -fs $dir/siminym-zh/docs rensole-zh/siminym-zh

cd $basedir
