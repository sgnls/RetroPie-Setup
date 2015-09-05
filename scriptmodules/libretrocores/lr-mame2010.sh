#!/usr/bin/env bash

# This file is part of RetroPie.
# 
# (c) Copyright 2012-2015  Florian Müller (contact@petrockblock.com)
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="lr-mame2010"
rp_module_desc="Arcade emu - MAME 0.139 port for libretro"
rp_module_menus="4+"

function sources_lr-mame2010() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame2010-libretro.git
    sed -i "s/MD = -mkdir/MD = -mkdir -p" Makefile
}

function build_lr-mame2010() {
    make clean
    make -f Makefile.libretro VRENDER=soft ARM_ENABLED=1 ARCHOPTS="$CFLAGS" buildtools
    make -f Makefile.libretro VRENDER=soft ARM_ENABLED=1 ARCHOPTS="$CFLAGS"
}

function install_lr-mame2010() {
    md_ret_files=(
        'mame2010_libretro.so'
        'README.txt'
        'whatsnew.txt'
        'mame.ini'
    )
}

function configure_lr-mame2010() {
    mkRomDir "mame-libretro"
    ensureSystemretroconfig "mame"

    addSystem 0 "$md_id" "mame-libretro arcade mame" "$md_inst/mame2010_libretro.so"
}