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

RDEPEND="virtual/pam
systemd? ( sys-apps/systemd )
elogind? ( sys-auth/elogind )
"
DEPEND="${RDEPEND}"

REQUIRED_USE="?? ( elogind systemd )"

IUSE="elogind systemd"

src_prepare() {
	default
	tc-export CC
	sed -i -e '/^lib_systemd_1/a lib_systemd_2 = -lelogind' Makefile
	eapply_user
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
