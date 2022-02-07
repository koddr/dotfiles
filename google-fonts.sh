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
    "Fira+Code" \
    "Open+Sans" \
    "PT+Serif" \
    "PT+Sans" \
    "Roboto" \
    "Inter"
)

for FONT in ${FONTS[@]}
do
    ZIP_NAME="${FONT/+/_}"

    rm -rf $HOME/.fonts/$ZIP_NAME
    curl -L -o /tmp/$ZIP_NAME.zip https://fonts.google.com/download?family=$FONT
    unzip -d $HOME/.fonts/$ZIP_NAME /tmp/$ZIP_NAME.zip
    rm /tmp/$ZIP_NAME.zip
done

echo $HEADER
echo "$MIDDLE Updating the font cache"
echo $FOOTER

fc-cache -f