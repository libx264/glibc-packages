TERMUX_PKG_HOMEPAGE=https://github.com/ptitSeb/box64
TERMUX_PKG_DESCRIPTION="Linux Userspace x86_64 Emulator with a twist"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=0.4.4
TERMUX_PKG_SRCURL=https://github.com/libx264/box64/archive/main.tar.gz
TERMUX_PKG_SHA256=185299f9f3c555a3a5f6ef0e611ad0ff36e5fe058c01f5222aa61dd87e67c8f8
TERMUX_PKG_DEPENDS="gcc-libs-glibc"
TERMUX_PKG_EXCLUDED_ARCHES="arm, i686"
TERMUX_PKG_CMAKE_BUILD="Unix Makefiles"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=RelWithDebInfo -DBOX32=ON -DBOX32_BINFMT=ON -DBAD_SIGNAL=ON -DNOGIT=1"
TERMUX_PKG_RM_AFTER_INSTALL="glibc/etc/binfmt.d"

termux_step_pre_configure() {
	if [ "${TERMUX_ARCH}" = "aarch64" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DARM_DYNAREC=ON"
	elif [ "${TERMUX_ARCH}" = "x86_64" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" -DLD80BITS=1 -DNOALIGN=1"
	fi
}

termux_step_make_install() {
	if [ "${TERMUX_ARCH}" = "aarch64" ]; then
		make install
	elif [ "${TERMUX_ARCH}" = "x86_64" ]; then
		install -Dm755 box64 -t ${TERMUX_PREFIX}/bin/
	fi
}
