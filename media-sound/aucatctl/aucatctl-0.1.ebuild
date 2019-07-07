# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="utility to control the sndio master and per-program volume"
HOMEPAGE="http://www.sndio.org/"
SRC_URI="http://www.sndio.org/aucatctl-0.1.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="media-sound/sndio dev-libs/libbsd"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/0001-libbsd-overlay.patch
	epatch "${FILESDIR}"/0002-fix-broken-fprintf-s.patch

	eapply_user

	tc-export CC
}

src_install() {
	emake install \
		PREFIX=/usr MAN1_DIR=/usr/share/man/man1 DESTDIR="${D}"
}
