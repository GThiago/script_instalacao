#!/usr/bin/env bash

set -e

packages=(
    "wine_stable"
    "winehq_stable"
    "virtualbox"
    "john"
    "john-data"
    "nodejs"
    "nodejs-doc"
    "nmap"
    "nmap-common"
    "network-manager"
    "net-tools"
    "php"
    "php-common"
    "perl"
    "perl-base"
    "ruby"
    "ruby-dev"
    "ruby-minitest"
    "ruby-net-telnet"
    "ruby-power-assert"
    "ruby-test-unit"
    "ruby-xmlrpc"
    "samba"
    "samba-common"
    "samba-common-bin"
    "samba-dsdb-modules"
    "samba-libs"
    "samba-vfs-modules"
    "sqlmap"
    "sqlite3"
    "texlive"
    "texlive-base"
    "texlive-binaries"
    "texlive-fonts-recommended"
    "texlive-lang-portuguese"
    "texlive-latex-base"
    "texlive-latex-extra"
    "texlive-latex-recommended"
    "texlive-pictures"
    "texlive-plain-generic"
    "textlive-publishers"
    "unzip"
    "virtualbox"
    "virtualbox-qt"
    "vim"
    "vim-common"
    "vim-runtime"
    "vim-tiny"
    "vino"
    "vlc"
    "vlc-bin"
    "vlc-data"
    "vlc-l10n"
    "vlc-plugin-access-extra"
    "vlc-plugin-base"
    "vlc-plugin-notify"
    "vlc-plugin-qt"
    "vlc-plugin-samba"
    "vlc-plugin-skins2"
    "vlc-plugin-video-output"
    "vlc-plugin-video-splitter"
    "vlc-plugin-visualization"
    "wapiti"
    "wdiff"
    "wget"
    "wireshark"
    "wireshark-common"
    "wireshark-qt"
    "wireless-regdb"
    "wireless-tools"
)

ppas=(
    "graphics-drivers/ppa"
    "libratbag-piper/piper-libratbag-git"
)

repositories=(
    "deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main"
)

download=(
    "https://github.com/sudo-give-me-coffee/PhotoGIMP/releases/download/continuous/PhotoGIMP-x86_64.AppImage"
)

# “mktemp” ela cria diretórios e arquivos temporários únicos para o seu
# script e imprime o local onde foram criados, como a gente vai baixar
# arquivos nós vamos pedir um diretório e já entrar nele

cd $(mktemp -d)

wget -nv -c ${download[@]}

# -nv remove texto desnecessario
# -c continua aonde parou

# sem uso de chaves (apt-key)
# sem suporte opcional para 32 bit

for repositorie in ${repositories[@]};; do
    apt-add-repository "$repositorie" -y
done

for ppa in ${ppas[@]}; do
  apt-add-repository "ppa:"$ppa  -y
done

apt update

apt install ${snaps[@]}
apt install --classic ${snaps_classic[@]}

# considerando que todos .deb esteja baixados neste momento
apt install ./*.deb

# sem AppImage

apt dist-upgrade -y
apt update
apt upgrade
apt autoclean

# falta:
# pacotes que n instalam dependências recomendadas (--install-recommend n resolve)
# suporte a Flatpaks
# suporte a função remover pacotes
