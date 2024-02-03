basedir=`pwd`
cd ..
dir=`pwd`

# CLI
sudo apt install minify ripgrep fd-find sqlite3
# cargo install sd
sudo npm install -g drop-inline-css
deno install -fr --allow-read --allow-write --allow-run --allow-env \
https://raw.githubusercontent.com/marmooo/gitn/main/gitn.js
deno install -fr --allow-read --allow-write --allow-run \
https://raw.githubusercontent.com/marmooo/yomico/main/src/yomico.js

# Dict
git clone git@github.com:marmooo/tanaka-corpus-plus
git clone git@github.com:marmooo/graded-enja-corpus
git clone git@github.com:marmooo/graded-kanji-examples
git clone git@github.com:marmooo/yomi-dict
git clone git@github.com:marmooo/onkun
git clone git@github.com:marmooo/cmu-dict-ipa

git clone git@github.com:WorksApplications/SudachiDict
cd SudachiDict/src/main/text
curl -O http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict-raw/20240109/small_lex.zip
curl -O http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict-raw/20240109/core_lex.zip
curl -O http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict-raw/20240109/notcore_lex.zip
cd SudachiDict/src/main/text
unzip -o small_lex.zip
unzip -o core_lex.zip
unzip -o notcore_lex.zip
cd $dir

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

git clone git@github.com:marmooo/icon-db
git clone git@github.com:marmooo/rare-icon-db


# Link
ln -fs $dir/mGSL vocabee/mGSL
ln -fs $dir/mGSL english-words-typing/mGSL
ln -fs $dir/graded-enja-corpus sentency/graded-enja-corpus
ln -fs $dir/graded-enja-corpus english-sentences-typing/graded-enja-corpus
ln -fs $dir/google-ngram-small-en gratalk/google-ngram-small-en
ln -fs $dir/google-ngram-small-en wncc-en/google-ngram-small-en
ln -fs $dir/nwc2010-ngrams wncc-ja/nwc2010-ngrams
ln -fs $dir/graded-vocab-ja kana-meiro/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kana-sagashi/graded-vocab-ja
ln -fs $dir/graded-vocab-ja kana-siritori/graded-vocab-ja
ln -fs $dir/graded-idioms-ja kanji-meiro/graded-idioms-ja
ln -fs $dir/graded-idioms-ja jukugo3-sagashi/graded-idioms-ja
ln -fs $dir/graded-kanji-examples touch-shodo/graded-kanji-examples
ln -fs $dir/SudachiDict dajare-ondoku/SudachiDict
ln -fs $dir/SudachiDict hayakuchi-ondoku/SudachiDict
ln -fs $dir/SudachiDict homonym-ja/SudachiDict
ln -fs $dir/SudachiDict spelling-variants-ja/SudachiDict
ln -fs $dir/marmooo.github.io/docs/kanjivg touch-50on/kanjivg
ln -fs $dir/marmooo.github.io/docs/kanjivg touch-de-kakijun/kanjivg
ln -fs $dir/marmooo.github.io/docs/svg number-icon/svg
ln -fs $dir/yomi-dict emoji-typing/yomi-dict

# graded-enja-corpus
ln -fs $dir/mGSL graded-enja-corpus/mGSL
ln -fs $dir/inappropriate-words-ja graded-enja-corpus/inappropriate-words-ja
ln -fs $dir/tanaka-corpus-plus graded-enja-corpus/tanaka-corpus-plus

# kanji-siritori
ln -fs $dir/yomi-dict kanji-siritori/yomi-dict
ln -fs $dir/graded-idioms-ja kanji-siritori/graded-idioms-ja

# touch-kanji
ln -fs $dir/graded-kanji-examples touch-kanji/graded-kanji-examples
ln -fs $dir/marmooo.github.io/docs/kanjivg touch-kanji/kanjivg

# touch-shuji
ln -fs $dir/graded-kanji-examples touch-shuji/graded-kanji-examples
ln -fs $dir/marmooo.github.io/docs/animCJK touch-shuji/animCJK

# talk-yomi
ln -fs $dir/graded-vocab-ja talk-yomi/graded-vocab-ja
ln -fs $dir/graded-idioms-ja talk-yomi/graded-idioms-ja
ln -fs $dir/yomi-dict talk-yomi/yomi-dict
ln -fs $dir/SudachiDict talk-yomi/SudachiDict

# tegaki-yomi
ln -fs $dir/graded-vocab-ja tegaki-kaki/graded-vocab-ja
ln -fs $dir/graded-idioms-ja tegaki-kaki/graded-idioms-ja
ln -fs $dir/yomi-dict tegaki-kaki/yomi-dict

# type-yomi
ln -fs $dir/graded-vocab-ja type-yomi/graded-vocab-ja
ln -fs $dir/graded-idioms-ja type-yomi/graded-idioms-ja
ln -fs $dir/yomi-dict type-yomi/yomi-dict

# tegaki-kaki
ln -fs $dir/graded-vocab-ja tegaki-kaki/graded-vocab-ja
ln -fs $dir/graded-idioms-ja tegaki-kaki/graded-idioms-ja
ln -fs $dir/yomi-dict tegaki-kaki/yomi-dict
ln -fs $dir/wncc-ja tegaki-kaki/wncc-ja

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
ln -fs $dir/marmooo.github.io/docs/kanjivg kanji-dict/kanjivg

# homonym-ja
ln -fs $dir/SudachiDict homonym-ja/SudachiDict

# spelling-variants-ja
ln -fs $dir/SudachiDict spelling-variants-ja/SudachiDict

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

# siminym-ja
ln -fs $dir/SudachiDict siminym-ja/SudachiDict
ln -fs $dir/nwc2010-ngrams siminym-ja/nwc2010-ngrams
ln -fs $dir/inappropriate-words-ja siminym-ja/inappropriate-words-ja
ln -fs $dir/cc.ja.300.vec siminym-ja/cc.ja.300.vec

# siminym-en
ln -fs $dir/mGSL siminym-en/mGSL
ln -fs $dir/crawl-300d-2M.vec siminym-en/crawl-300d-2M.vec

# siminym-zh
ln -fs $dir/jieba siminym-zh/jieba
ln -fs $dir/cc.zh.300.vec siminym-zh/cc.zh.300.vec

# rensole-ja
ln -fs $dir/SudachiDict rensole-ja/SudachiDict
ln -fs $dir/cc.ja.300.vec rensole-ja/cc.ja.300.vec
ln -fs $dir/siminym-ja rensole-en/siminym-ja-repo
ln -fs $dir/siminym-ja/docs rensole-ja/siminym-ja

# rensole-en
ln -fs $dir/mGSL rensole-en/mGSL
ln -fs $dir/cmudict-ipa rensole-en/cmudict-ipa
ln -fs $dir/crawl-300d-2M.vec rensole-en/crawl-300d-2M.vec
ln -fs $dir/siminym-en rensole-en/siminym-en-repo
ln -fs $dir/siminym-en/docs rensole-en/siminym-en

# rensole-zh
ln -fs $dir/jieba rensole-zh/jieba
ln -fs $dir/cc.zh.300.vec rensole-zh/cc.zh.300.vec
ln -fs $dir/siminym-zh rensole-en/siminym-zh-repo
ln -fs $dir/siminym-zh/docs rensole-zh/siminym-zh

# icon-search
ln -fs $dir/icon-db icon-search/icon-db/docs icon-search/icon-db
ln -fs $dir/icon-db icon-search/rare-icon-db/docs icon-search/rare-icon-db

cd $basedir
