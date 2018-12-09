#!/bin/bash
set -eu
TEMPLATE=TEMPLATE_SELECTOROPEN
URL=URL_LIST
BUFIFS=${IFS}
grep -v '^#' ${URL} | while IFS=, read TITLE KEYWORD TARGET_URL APP; do
    IFS=
    :> SelectOrOpen_${KEYWORD}.applescript
    while read line; do
        eval echo \"$line\" >> SelectOrOpen_${KEYWORD}.applescript
    done<${TEMPLATE}
    IFS=${BUFIFS}
done

# eval echo ... でテンプレートの"${TARGET_URL}"から「""」が消えてしまい
# AppleScriptとしてエラーが出てしまう。
# とりあえずの解決策としてURL_LISTの方のURLをあらかじめ""で囲った
# まともな解決策を知りたいが時間をかけすぎるわけにもいかないのでひとまずここまで

# URL_LISTファイルのコメント行以外について（,区切り）
# TEMPLATE_SELECTOROPENファイルの形式でKEYWORDを元にしたファイル名で作成
# 強制上書きな上にエラー検証ほとんどないはずだがまあ1回使ったらまず再使用しないので良しとする
# コピペ脱却のために頑張ってみたので許してほしい