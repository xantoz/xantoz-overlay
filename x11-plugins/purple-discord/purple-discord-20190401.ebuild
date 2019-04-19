EAPI=7

inherit toolchain-funcs

DESCRIPTION="Discord protocol plugin for libpurple"
HOMEPAGE="https://github.com/EionRobb/purple-discord"

EGIT_COMMIT=bad7fc29666a2c5db064fbde42e6115530444dfc
SRC_URI="https://github.com/EionRobb/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/json-glib
	 net-im/pidgin"
DEPEND="${RDEPEND}"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	# Remove build-time dependency on imagemagick[svg] by including pre-converted icon pngs
	cp "${FILESDIR}"/discord{16,22,48}.png ./
	eapply_user
}
