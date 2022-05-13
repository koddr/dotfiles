# Editors
set -gx EDITOR gnome-text-editor
set -gx VISUAL code

# Podman
alias docker "podman"
set -gx DOCKER_HOST unix:///run/user/1000/podman/podman.sock

# Golang
set -gx PATH /usr/local/go/bin $PATH
set -gx GOPATH /home/koddr/.go