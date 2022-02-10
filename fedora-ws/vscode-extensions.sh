#!/bin/bash

echo "✓ Install VS Code extensions"

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

echo "✓ Enable podman.socket to use in VS Code Docker extension"

systemctl --user enable --now podman.socket

echo "✓ Manual actions to do"

echo "Add podman.socket to Docker Host option in settings.json (VS Code):"
echo "  - 'docker.host' with 'unix:///run/user/$(id -u)/podman/podman.sock' value"
echo ""