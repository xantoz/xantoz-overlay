# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools elisp-common toolchain-funcs

DESCRIPTION="window manager without mouse dependency"
HOMEPAGE="https://www.nongnu.org/ratpoison/"
EGIT_COMMIT=ce52592c128a7feec9949d458912087a0823f80e
SRC_URI="https://github.com/xantoz/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${EGIT_COMMIT}/

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug emacs +history sloppy +xft +xrandr"

RDEPEND="
	emacs? ( >=app-editors/emacs-23.1:* )
	history? ( sys-libs/readline:= )
	xft? ( x11-libs/libXft )
	xrandr? ( x11-libs/libXrandr )
	dev-perl/Pod-Parser
	x11-libs/libX11
	x11-libs/libXtst
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
"

SITEFILE=50ratpoison-gentoo.el
DOCS=(
	AUTHORS
	ChangeLog
	NEWS
	README
	TODO
)

PATCHES=(
	"${FILESDIR}"/ratpoison.el-gentoo.patch
)

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable history) \
		$(use_with xft) \
		$(use_with xrandr) \
		--without-electric-fence
}

src_compile() {
	emake CFLAGS="${CFLAGS}"
	if use emacs; then
		elisp-compile contrib/ratpoison.el || die
	fi

	if use sloppy; then
		pushd contrib
		$(tc-getCC) \
			${CFLAGS} \
			${LDFLAGS} \
			-o sloppy{,.c} \
			$( $(tc-getPKG_CONFIG) --libs x11) \
			|| die
	fi
}

src_install() {
	default

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/ratpoison.xsession ratpoison

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/${PN}.desktop

	use sloppy && dobin contrib/sloppy

	docinto example
	dodoc contrib/{genrpbindings,split.sh} \
		doc/{ipaq.ratpoisonrc,sample.ratpoisonrc}

	rm -rf "${ED}/usr/share/"{doc/ratpoison,ratpoison}

	if use emacs; then
		elisp-install ${PN} contrib/ratpoison.*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
