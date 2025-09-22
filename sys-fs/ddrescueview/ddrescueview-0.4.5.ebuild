# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Graphical viewer for GNU ddrescue mapfiles"
HOMEPAGE="https://sourceforge.net/projects/ddrescueview/"
SRC_URI="https://downloads.sourceforge.net/project/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Lazarus/FreePascal dependencies
DEPEND="
	dev-lang/fpc
	dev-lang/lazarus
"
RDEPEND="${DEPEND}"

src_compile() {
	lazbuild source/${PN}.lpi || die "lazbuild failed"
}

src_install() {
	# binary
	dobin source/${PN}

	# documentation
	dodoc README* CHANGELOG* AUTHORS

	# man page
	doman resources/linux/man/man1/${PN}.1

	# desktop entry
	domenu resources/linux/applications/${PN}.desktop

	# icons (multiple sizes)
	for size in 16 22 24 32 48 64 128 256; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		newins resources/linux/icons/${size}x${size}/${PN}.png ${PN}.png
	done
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
