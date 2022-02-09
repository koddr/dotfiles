#!/bin/bash

HEADER="┌───┐"
MIDDLE="│ > │"
FOOTER="└───┘"

echo $HEADER
echo "$MIDDLE Install VS Code extensions"
echo $FOOTER

declare -a EXTENSIONS=(
    "streetsidesoftware.code-spell-checker-russian" \
    "streetsidesoftware.code-spell-checker" \
    "vscode-icons-team.vscode-icons" \
    "zhuangtongfa.material-theme" \
    "ms-azuretools.vscode-docker" \
    "alefragnani.project-manager" \
    "bradlc.vscode-tailwindcss" \
    "naumovs.color-highlight" \
    "mhutchie.git-graph" \
    "humao.rest-client" \
    "mikestead.dotenv" \
    "ms-python.python" \
    "octref.vetur" \
    "golang.go"
)

for EXTENSION in ${EXTENSIONS[@]}
do
    code --install-extension $EXTENSION
done

echo $HEADER
echo "$MIDDLE Enable podman.socket to use in VS Code Docker extension"
echo $FOOTER

systemctl --user enable --now podman.socket

echo $HEADER
echo "$MIDDLE Manual actions to do"
echo $FOOTER

echo "Add podman.socket to Docker Host option in settings.json (VS Code):"
echo "  ✓ 'docker.host' with 'unix:///run/user/$(id -u)/podman/podman.sock' value"
echo ""