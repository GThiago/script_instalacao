#!/usr/bin/env bash

set -e

packages=(
    "wine_stable"
    "winehq_stable"
    "virtualbox"
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
