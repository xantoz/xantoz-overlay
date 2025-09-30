# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="xrandr and lxrandr replacement for Sway"
HOMEPAGE="https://codeberg.org/snaums/swayrandr"
SRC_URI="https://codeberg.org/snaums/swayrandr/archive/1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+static"

src_compile() {
	emake VERSION="v${PV}" DESTDIR="${D}" all
}

src_install() {
	dodoc README.md LICENSE
	emake VERSION="v${PV}" DESTDIR="${D}" install
}
