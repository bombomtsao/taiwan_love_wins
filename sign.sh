#!/bin/bash

# uncomment this for debug
# set -o xtrace

# This is a file use to sign. Please input file as parameter.
# Usage: ./sign.sh signed_by_${USERNAME}.md

pushd $(dirname $0)
REPO=$(cat .git/config | grep "git@github.com" | cut -f 2 -d ':' | sed s/\.git//)

git pull
git remote add upstream https://github.com/RainbowEngineer/taiwan_love_wins.git 2> /dev/null
git fetch upstream
git merge upstream/master
git push
git add $1
git commit
git push

if [ -f $(which hub) ]; then
  echo '自動送 pull-request...'
  hub pull-request -m "Please add my sign!!" -b RainbowEngineer/taiwan_love_wins:master
else
  echo '系統沒有安裝hub，請前往以下網址送出pull request：'
  echo "https://github.com/${REPO}/pull/new/master"
fi

popd
