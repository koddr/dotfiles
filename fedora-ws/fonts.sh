#!/bin/bash

HEADER="┌───┐"
MIDDLE="│ > │"
FOOTER="└───┘"

echo $HEADER
echo "$MIDDLE Create ~/.fonts directory"
echo $FOOTER

mkdir -p $HOME/.fonts

echo $HEADER
echo "$MIDDLE Download & unzip needed Google Fonts"
echo $FOOTER

declare -a FONTS=(
    "Source+Code+Pro" \
    "JetBrains+Mono" \
    "Fira+Code" \
    "Open+Sans" \
    "PT+Serif" \
    "PT+Sans" \
    "Roboto" \
    "Inter" \
    "Hack"
)

for FONT in ${FONTS[@]}
do
    ZIP_NAME="${FONT//+/_}"

    rm -rf $HOME/.fonts/$ZIP_NAME
    curl -L -o /tmp/$ZIP_NAME.zip https://fonts.google.com/download?family=$FONT
    unzip -d $HOME/.fonts/$ZIP_NAME /tmp/$ZIP_NAME.zip
    rm /tmp/$ZIP_NAME.zip
done

echo $HEADER
echo "$MIDDLE Download & install Liberation(tm) Fonts"
echo $FOOTER

rm -rf $HOME/.fonts/liberation-fonts
wget -O /tmp/liberation-fonts.tar.gz https://github.com/liberationfonts/liberation-fonts/files/7261482/liberation-fonts-ttf-2.1.5.tar.gz
tar -C $HOME/.fonts -xzf /tmp/liberation-fonts.tar.gz
rm -rf /tmp/liberation-fonts.tar.gz

echo $HEADER
echo "$MIDDLE Updating the font cache"
echo $FOOTER

fc-cache -f