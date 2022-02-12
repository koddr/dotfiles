#!/bin/bash

##############
# RUN SCRIPT #
##############

echo -e "\n✓ Create ~/.fonts directory"

mkdir -p $HOME/.fonts

echo -e "\n✓ Download & unzip needed Google Fonts"

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

echo -e "\n✓ Download & install Liberation(tm) Fonts"

rm -rf $HOME/.fonts/liberation-fonts
wget -O /tmp/liberation-fonts.tar.gz \
    https://github.com/liberationfonts/liberation-fonts/files/7261482/liberation-fonts-ttf-2.1.5.tar.gz
tar -C $HOME/.fonts -xzf /tmp/liberation-fonts.tar.gz
rm -rf /tmp/liberation-fonts.tar.gz

echo -e "\n✓ Updating the font cache"

fc-cache -f