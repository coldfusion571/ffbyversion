#!/bin/bash

cd ~;

if [ ! -d opt ] 
  then
    mkdir opt;
fi
cd opt;

if [ ! -d firefoxes ] 
  then
    mkdir firefoxes;
fi
cd firefoxes;

CMD=$1
VERSION=$2

if [ $CMD = "start" ]; then
  if [ ! -d "firefox-$VERSION" ]; then
      echo "  Installing $VERSION...";
      wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$VERSION/linux-i686/en-US/firefox-$VERSION.tar.bz2;
      tar -xjf firefox-$VERSION.tar.bz2;
      mv firefox firefox-$VERSION;
      rm firefox-$VERSION.tar.bz2;
      firefox -no-remote -CreateProfile firefox-$VERSION;
  fi 

  cd "firefox-$VERSION";
  echo "Starting firefox-$VERSION [`pwd`]";
  ./firefox -no-remote -P "firefox-$VERSION" &
 
elif [ $CMD = "list" ]; then
  ls;

elif [ $CMD = "list_all" ]; then
  wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/
  cat index.html | sed s/.*\"\>// | grep '</a>' | sed 's/\/.*//' | awk '{ printf "%-15s ",$0; if(FNR%5==0){ printf "\n"} }';
  echo "\n";
  rm index.html
  
fi

#ACTION=$1;
#
#if [ $ACTION = "install" ]; then
#
#  if [ ! -d firefox-3.0.17 ]; then
#    echo "  Installing firefox-3.0.17...";
#    wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/3.0.17/linux-i686/en-US/firefox-3.0.17.tar.bz2;
#    mv firefox firefox-3.0.17;
#    firefox -no-remote -CreateProfile firefox-3.0.17;
#  fi
#  
#  if [ ! -d firefox-3.6 ]; then
#    echo "  Installing firefox-3.6...";
#    wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/3.6/linux-i686/en-US/firefox-3.6.tar.bz2;
#    mv firefox firefox-3.6;
#    firefox -no-remote -CreateProfile firefox-3.6;
#  fi
#  
#  if [ ! -d firefox-4.0rc2 ]; then
#    echo "  Installing firefox-4.0rc2...";
#    wget ftp://ftp.mozilla.org/pub/mozilla.org/firefox/releases/4.0rc2/linux-i686/en-US/firefox-4.0rc2.tar.bz2;
#    mv firefox firefox-4.0rc2;
#    firefox -no-remote -CreateProfile firefox-4.0rc2;
#  fi
#
#elif [ $ACTION = "start" ]; then
#  
#  WHICH=$2;
#  cd "$WHICH";
#  echo "Starting $WHICH [`pwd`]";
#  ./firefox -no-remote -P "$WHICH" &
#
#else
#  echo "Valid actions are [install,start [version]]";
#
#fi
