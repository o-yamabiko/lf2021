#!/bin/bash

declare -a arr=("_s")
for i in "${arr[@]}"
do
  cd $i
    for j in *
      do
        k=`echo $j | sed -e 's/\(.*\).md/\1/'`
        LC_COLLATE=C.UTF-8 sed \
          -e '/^oto:/d' \
          -e 's/^\(docid: .*\)/\1-p/' \
          -e 's/## </[音声付きのページ]('$k'-s.html){.migi}\n\n## </' \
        $j > ../_p/$j
        LC_COLLATE=C.UTF-8 sed \
          -e 's/^\(docid: .*\)/\1-s/' \
        $j > $k-s.md
        mv $j $k.old
      done
  cd -
done

