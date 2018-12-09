#!/bin/bash
set -eu
TEMPLATE=TEMPLATE_SELECTOROPEN
URL=URL_LIST
BUFIFS=${IFS}
grep -v '^#' ${URL} | while IFS=, read TITLE KEYWORD TARGET_URL; do
    IFS=
    :> SelectOrOpen${KEYWORD}.applescript
    while read line; do
        eval echo \"$line\" >> SelectOrOpen_${KEYWORD}.applescript
    done<${TEMPLATE}
    IFS=${BUFIFS}
done

# URL_LISTファイルのコメント行以外について（,区切り）
# TEMPLATE_SELECTOROPENファイルの形式でKEYWORDを元にしたファイル名で作成
# 強制上書きな上にエラー検証ほとんどないはずだがまあ1回使ったらまず再使用しないので良しとする