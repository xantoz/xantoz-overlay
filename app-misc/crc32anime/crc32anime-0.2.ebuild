EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )
inherit python-single-r1

DESCRIPTION="Checks CRC32 typically embedded in filename on anime video files"
S="${FILESDIR}"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="amd64"

RDEPEND="${PYTHON_DEPS}"

src_install() {
	mkdir -p "${D}/usr/bin"
	sed "s|#!/usr/bin/python|#!${PYTHON}|" crc32anime > "${D}/usr/bin/crc32anime" || die "Couldn't fix shebang"
	chmod +x "${D}/usr/bin/crc32anime"
}
