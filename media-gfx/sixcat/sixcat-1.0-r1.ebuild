EAPI=7

DESCRIPTION="sixcat: Like 'cat' but show images directly in the terminal using SIXEL graphics"
HOMEPAGE="https://gist.github.com/hackerb9/a96cea91e6122d09a6c97f5eb797d5fa"
S="${FILESDIR}"

SLOT=0
KEYWORDS="amd64"

RDEPEND="virtual/imagemagick-tools
	app-shells/bash"

src_install() {
	dobin sixcat
	dosym sixcat /usr/bin/sixgif
}
