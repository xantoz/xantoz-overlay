EAPI=7

inherit toolchain-funcs

DESCRIPTION="ALSA to sndio plugin"
HOMEPAGE="https://github.com/Duncaen/${PN}"
SRC_URI="https://github.com/Duncaen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT=0
KEYWORDS="amd64"

DEPEND="
|| ( media-sound/sndio media-sound/sndio-mixer )
media-libs/alsa-lib
"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc README.md LICENSE
}
