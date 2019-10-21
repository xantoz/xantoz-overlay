# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="lightweight Linux console locking tool"
HOMEPAGE="https://github.com/muennich/physlock"
SRC_URI="https://github.com/muennich/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"

RDEPEND="sys-libs/pam
systemd? ( sys-apps/systemd )
elogind? ( sys-auth/elogind )
"
DEPEND="${RDEPEND}"

REQUIRED_USE="?? ( elogind systemd )"

IUSE="elogind systemd"

src_prepare() {
	default
	tc-export CC
	sed -i \
	    -e '/^lib_systemd_1/a lib_systemd_2 = -lelogind' \
	    -e '/^\$(V).SILENT:/d' \
	    -e '/^cppflags/a cppflags += -DHAVE_SYSTEMD=$(HAVE_SYSTEMD)' \
	    Makefile
	sed -i -e 's@^#include <systemd/sd-login.h>@#if HAVE_SYSTEMD == 2\n#include <elogind/sd-login.h>\n#else\n#include <systemd/sd-login.h>\n#endif@' session.c
}

src_compile() {
	:
}

src_install() {
	if $(use systemd); then
		local have_systemd=1
	elif $(use elogind); then
		local have_systemd=2
	else
		local have_systemd=0
	fi
	emake DESTDIR="${D}" PREFIX=/usr HAVE_SYSTEMD=${have_systemd} install
	dosym login /etc/pam.d/${PN}
}
