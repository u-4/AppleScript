#!/bin/bash
set -eu

atexit() {
  [[ -d ${AS_DIRECTORY-} ]] && rm -rf "$AS_DIRECTORY"
}

trap atexit EXIT
trap atexit HUP INT QUIT TERM

OS="$(uname -s)"
AS_DIRECTORY="$HOME/AppleScript"
AS_TARBALL="https://github.com/u-4/AppleScript/tarball/master"
REMOTE_URL="git@github.com:u-4/AppleScript.git"
exclude=('.' '..' 'LICENSE' 'README.md' 'install.sh' 'URL_LIST')
INST_DIRECTORY="$HOME/Library/Scripts"
newlink=()
updated=()
exist=()

# コマンドの存在確認用
has() {
  type "$1" > /dev/null 2>&1
}

# Working only OS X.
case ${OSTYPE} in
  darwin*)
    ;;
  *)
    echo $(tput setaf 1)Working only OS X!!$(tput sgr0)
    exit 1
    ;;
esac

# If missing, download and extract the AppleScript repository
if [ ! -d ${AS_DIRECTORY} ]; then
  echo "Downloading AppleScripts..."
  mkdir ${AS_DIRECTORY}

  if has "git"; then
    git clone --recursive "${REMOTE_URL}" "${AS_DIRECTORY}"
  else
    curl -fsSLo ${HOME}/AppleScript.tar.gz ${AS_TARBALL}
    tar -zxf ${HOME}/AppleScript.tar.gz --strip-components 1 -C ${AS_DIRECTORY}
    rm -f ${HOME}/AppleScript.tar.gz
  fi

  echo $(tput setaf 2)Download AppleScripts complete!. ✔︎$(tput sgr0)
fi

#
# https://github.com/rcmdnk/AppleScript/blob/master/install.sh
# からオプション類を省いて改造
#

echo "**********************************************"
echo "Install X.applescript to $INST_DIRECTORY/X.scpt"
echo "**********************************************"
echo
mkdir -p "$INST_DIRECTORY"
cd ${AS_DIRECTORY}
for f in *.applescript;do
  for e in "${exclude[@]}";do
    flag=0
    if [ "$f" = "$e" ];then
      flag=1
      break
    fi
  done
  if [ $flag = 1 ];then
    continue
  fi
  name=${f%.applescript}.scpt
  install=1

  tmpscpt=".${name}.tmp"
  osacompile -o "$tmpscpt" "$AS_DIRECTORY/$f"

  if [ "$(ls "$INST_DIRECTORY/$name" 2>/dev/null)" != "" ];then
    diffret=$(diff "$INST_DIRECTORY/$name" "$tmpscpt")
    if [ "$diffret" != "" ];then
      updated=(${updated[@]} "$name")
      rm "$INST_DIRECTORY/$name"
    else
      exist=(${exist[@]} "$name")
      install=0
    fi
  else
    newlink=(${newlink[@]} "$name")
  fi
  if [ $install -eq 1 ];then
    mv "$tmpscpt" "$INST_DIRECTORY/$name"
  fi
  rm -f "$tmpscpt"
done
rm -rf ${AS_DIRECTORY}
echo ""
echo "Following files have updates, replaced old one:"
echo "  ${updated[*]}"
echo
echo "Following files were newly installed:"
echo "  ${newlink[*]}"
echo
echo -n "Following files exist and have no updaets"
echo "  ${exist[*]}"
echo
echo $(tput setaf 2)Deploy  AppleScripts complete!. ✔︎$(tput sgr0)