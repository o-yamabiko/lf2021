#!/bin/bash

declare -a arr=("_tusin" "_info")
for i in "${arr[@]}"
do
  cd $i
    for j in *
      do
        LC_COLLATE=C.UTF-8 sed \
          -e 's/^layout: .*/layout: print_noindex/' \
          -e 's/href=\"\(tusin[0-9]*\.html\)/href=\"\.\/p\/\1/g' \
          -e 's/io\/bn/io\/p\/bn/g' \
          -e 's/href=\"bn/href=\"\.\/p\/bn/g' \
          -e 's/<img src=\"media\/Speaker_Icon_gray\.png\" srcset=\"media\/Speaker_Icon_gray\.svg\" alt=\"音声付き\" class=\"gyo\" \/>//g' \
          -e 's/やまびこ通信 読み上げ版 バックナンバー/やまびこ通信 音声なし（印刷用）ページ バックナンバー/' \
          -e 's/以下は読み上げ版のリストです。/以下は音声なし（印刷用）ページのリストです。 各ページの右下に、読み上げ版へのリンクがあります。/' \
        $j > ../_p/$j
      done
  cd -
done
for i in index*.md
do
  echo '---' > _p/$i
  echo 'layout: print_noindex' >> _p/$i
  if [[ $i == 'index.md' ]]; then
    echo 'title: 音訳グループ やまびこ' >> _p/$i
  elif [[ $i == 'index-fra.md' ]]; then
    echo 'title: Yamabiko le groupe des aides vocaux' >> _p/$i
  elif [[ $i == 'index-eng.md' ]]; then
    echo 'title: The Voice Helpers&apos; Group Yamabiko' >> _p/$i
  elif [[ $i == 'index-zho.md' ]]; then
    echo 'title: 音译团体Yamabiko' >> _p/$i
  fi
  sed -n '/docid: /p' $i >> _p/$i
  sed -n '/lang: /p' $i >> _p/$i
  sed -n '/translator: /p' $i >> _p/$i
  sed -n '/date: /p' $i >> _p/$i
  sed -n '/oto: /p' $i >> _p/$i
  echo '---' >> _p/$i
  echo '' >> _p/$i
  if [[ $i == 'index.md' ]]; then
    echo '<img class="fullw" src="media/index/logo-w2color.png" alt="音訳グループ やまびこ" />' >> _p/$i
  elif [[ $i == 'index-fra.md' ]]; then
    echo '<img class="fullw" src="media/index/logo-w2color.png" alt="Yamabiko le groupe des aides vocaux" />' >> _p/$i
  elif [[ $i == 'index-eng.md' ]]; then
    echo '<img class="fullw" src="media/index/logo-w2color.png" alt="The Voice Helpers&apos; Group Yamabiko" />' >> _p/$i
  elif [[ $i == 'index-zho.md' ]]; then
    echo '<img class="fullw" src="media/index/logo-w2color.png" alt="音译团体Yamabiko" />' >> _p/$i
  fi
  echo '' >> _p/$i
  LC_COLLATE=C.UTF-8 sed \
  -e 's/今お聞きの声は/ホームページの声は/' \
  -e 's/href=\"\(tusin[0-9]*\.html\)/href=\"\.\/p\/\1/g' \
  -e 's/io\/bn/io\/p\/bn/g' \
  -e 's/href=\"bn/href=\"\.\/p\/bn/g' \
  -e 's/<img src=\"media\/Speaker_Icon_gray\.png\" srcset=\"media\/Speaker_Icon_gray\.svg\" alt=\"音声付き\" class=\"gyo\" \/>//g' \
  $i > temp
  sed -n '/##/,$p' temp >> _p/$i
  rm temp
done

