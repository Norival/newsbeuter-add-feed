#!/bin/bash
# Add feed to ~/.newsbeuter/urls with given name and tags. Can be used directly
# from browser by clicking any 'Subscribe feed' button.
# Requires: xterm and dialog

xterm -title "Newsbeuter add feed" -geometry 30x10 -e bash -c \
  "dialog --no-shadow --title 'Customization' \
  --inputbox 'Name? (empty for none)' 7 25 \
  2>/tmp/name.ans"

xterm -title "Newsbeuter add feed" -geometry 30x10 -e bash -c \
  "dialog --no-shadow --title 'Customization' \
  --inputbox 'Tags? (empty for none)' 7 25 \
  2>/tmp/tags.ans"

if [ $(tr -d "\r\n" < /tmp/name.ans|wc -c) -eq 0 ]; then
  NAME=""
else
  NAME="\"~"`cat /tmp/name.ans`"\""
fi
if [ $(tr -d "\r\n" < /tmp/tags.ans|wc -c) -eq 0 ]; then
  TAGS=""
else
  TAGS=`cat /tmp/tags.ans`
fi

echo "http://"`echo $1 | sed "s/\/\//*/" | cut -d'*' -f2` `echo $NAME $TAGS` \
  >> ~/.newsbeuter/urls

rm /tmp/*.ans
