#!/bin/bash

##############
# RUN SCRIPT #
##############

echo -e "\n✓ Install VS Code extensions"

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

echo -e "\n✓ Add podman.socket to Docker Host option in settings.json (VS Code):"
echo -e "\t- 'docker.host' with 'unix:///run/user/$(id -u)/podman/podman.sock' value"