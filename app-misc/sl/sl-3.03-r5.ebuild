# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils toolchain-funcs flag-o-matic

SL_PATCH="sl5-1.patch"

DESCRIPTION="sophisticated graphical program which corrects your miss typing"
HOMEPAGE="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/index_e.html http://www.izumix.org.uk/sl/"
SRC_URI="http://www.tkl.iis.u-tokyo.ac.jp/~toyoda/sl/${PN}.tar"

LICENSE="freedist"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="debug linguas_ja vanilla"

REQUIRED_USE="debug? ( !vanilla )"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	tc-export CC
	use debug && append-cppflags -DDEBUG
}

src_prepare() {
	if ! use vanilla ; then
		epatch -p1 "${FILESDIR}/${SL_PATCH}"
		epatch "${FILESDIR}/fix-missing-include.patch"
	fi

	cp "${FILESDIR}"/Makefile "${S}" || die

	if use linguas_ja; then
		for i in README*; do
			iconv -f ISO-2022-JP -t UTF-8 "${i}" > "${i}.converted"
			mv "${i}.converted" "${i}"
		done
		iconv -f ISO-2022-JP -t UTF-8 sl.1 > sl.ja.1
	fi
}

src_compile() {
	emake LDLIBS="$($(tc-getPKG_CONFIG) --libs ncurses)"
}

src_install() {
	dobin sl
	dodoc sl.txt

	if ! use vanilla ; then
		newman "${FILESDIR}/sl.en.1" sl.1
	fi

	if use linguas_ja ; then
		dodoc README*
		insinto /usr/share/man/ja/man1
		newins sl.ja.1 sl.1
	fi
}
