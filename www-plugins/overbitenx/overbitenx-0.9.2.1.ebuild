EAPI=7

DESCRIPTION="OverbiteNX is a Gopher client add-on for Firefox that allows Firefox to access sites over the historical Gopher protocol."
HOMEPAGE="https://github.com/classilla/overbitenx/"

SRC_URI="https://github.com/classilla/overbitenx/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="FFSL"
SLOT=0
KEYWORDS="amd64"

src_compile() {
	make -f Makefile.generic
	make -C ext
}

src_install() {
	# install the executable
	exeinto /usr/libexec/overbitenx
	doexe onyx

	# install the native messaging manifest
	target_dir="/usr/$(get_libdir)/mozilla/native-messaging-hosts"
	sed "s;/home/linus/bin/onyx;/usr/libexec/overbitenx/onyx;g" "EXAMPLE_onyx.json" > "onyx.json"
	insinto "${target_dir}"
	doins onyx.json

	# install the extension
	insinto "/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/"
	newins "overbitenx.xpi" "overbitenx@floodgap.com.xpi"
}
