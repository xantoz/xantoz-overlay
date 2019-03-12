EAPI=7

inherit meson

DESCRIPTION="A lightweight notification daemon for Wayland"
HOMEPAGE="https://github.com/emersion/mako"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/emersion/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/emersion/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+icons"

DEPEND="
	>=dev-libs/libinput-1.7.0:0=
	>=dev-libs/wayland-1.14.0
	x11-libs/cairo
	x11-libs/pango
	icons? ( x11-libs/gtk+:3 )
	icons? ( x11-libs/gdk-pixbuf )
	|| ( >=sys-auth/elogind-237  >=sys-apps/systemd-237 )
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=app-text/scdoc-1.9.3
	>=dev-libs/wayland-protocols-1.14
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Dicons=$(usex icons enabled disabled)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
}
