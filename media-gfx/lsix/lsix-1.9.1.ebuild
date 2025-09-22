EAPI=8

DESCRIPTION="Shows thumbnails of images with titles directly in terminal using Sixels"
HOMEPAGE="https://github.com/hackerb9/lsix"

SRC_URI="https://github.com/hackerb9/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="amd64"

RDEPEND="virtual/imagemagick-tools
	app-shells/bash"

src_install() {
	dobin lsix
	dodoc -r LICENSE README.md README.md.d
}
