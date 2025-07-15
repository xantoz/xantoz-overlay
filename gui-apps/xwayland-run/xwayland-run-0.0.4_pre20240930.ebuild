EAPI=8

PYTHON_COMPAT=( python3_{12,13} )
inherit python-single-r1 meson

DESCRIPTION="xwayland-run contains a set of small utilities revolving around running Xwayland and various Wayland compositor headless."
HOMEPAGE="https://gitlab.freedesktop.org/ofourdan/xwayland-run"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE=${PYTHON_REQUIRED_USE}

RDEPEND="
	${PYTHON_DEPS}
	x11-base/xwayland
	dev-libs/weston
	gui-wm/cage
"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

KEYWORDS="~amd64 ~arm64"

EGIT_COMMIT=3d0a3841226e8d48b5d48c2f69c69ff9d26006f9
SRC_URI="
	https://gitlab.freedesktop.org/ofourdan/${PN}/-/archive/${EGIT_COMMIT}/${PN}-${EGIT_COMMIT}.tar.bz2 -> ${P}.tar.bz2
"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}/"

# TODO: Need to fix missing .opt-1.pyc .opt-2.pyc files to get rid of a QA warning

src_install() {
	meson_src_install
	# Fix the shebangs after they've landed in the install directory.
	# Perhaps it would be prettier to do this before or something, but this was expedient
	sed -i "s|^#!.*python.*|#!${PYTHON}|" "${D}/usr/bin/"{xwayland-run,wlheadless-run,xwfb-run} || die "Couldn't fix shebangs"
}
