#!/bin/bash
set -e

LB_CHROOT_NAME="$1"
if [ -z "$1" ]; then
  LB_CHROOT_NAME="none"
fi

LB_ARGS="--chroot=$LB_CHROOT_NAME"

LB_ARGS="$LB_ARGS --user=`id -u` --group=`id -g`"

export LIMBA_FULLNAME="Joe Tester"
export LIMBA_EMAIL="joe@foo.bar"
export LIMBA_TARGET_REPO="master"

function build {
  sudo -E limba-build run $LB_ARGS
}

function add_to_repo {
  for file in $1/*.ipk
  do
    limba-build repo-add $file
  done
}

function install_all {
  for file in `ls $1/*.ipk | sort -Vr`
  do
    sudo limba install-local $file
  done
}

cd alsa-lib-1.0.29
find . -name "*.ipk*" -exec rm -f {} \;
echo "Building ALSA Lib"
build
install_all lipkg/
cd ..

cd SDL1.2-full
sudo find . -name "*.ipk*" -exec chmod 777 {} \;
find . -name "*.ipk*" -exec rm -f {} \;
echo "Building SDL1.2 (full bundle)"
# install additional requirements
sudo limba install libjpeg-turbo.sdk/1.4.0
sudo limba install libpng.sdk/1.2.50
build
install_all lipkg/
cd ..

cd tomatoes-1.55
find . -name "*.ipk*" -exec rm -f {} \;
echo "Building Tomatoes"
build
install_all lipkg/
cd ..

echo ""
echo "____________________"
echo ""
echo "Creating repository..."


rm -rf out_lirepo
mkdir -p out_lirepo
cd out_lirepo

#limba-build repo-init .
add_to_repo ../alsa-lib-1.0.29/lipkg
add_to_repo ../SDL1.2-full/lipkg
add_to_repo ../tomatoes-1.55/lipkg

cd ..
chmod -R 0755 out_lirepo

echo "All done."
