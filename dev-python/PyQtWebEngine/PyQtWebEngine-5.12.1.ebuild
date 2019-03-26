# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )
inherit multibuild python-r1 qmake-utils

DESCRIPTION="Python bindings for QtWebEngine"
HOMEPAGE="https://www.riverbankcomputing.com/software/pyqtwebengine/intro"

MY_P=${PN}_gpl-${PV/_pre/.dev}
SRC_URI="https://www.riverbankcomputing.com/static/Downloads/PyQtWebEngine/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"

IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# Minimal supported version of Qt.
QT_PV="5.12:5"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/PyQt5-5.12.1[network,widgets,printsupport,webchannel]
	>=dev-qt/qtwebengine-${QT_PV}[widgets]
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

pyqt_use_enable() {
	use "$1" || return

	if [[ $# -eq 1 ]]; then
		echo --enable=Qt$(tr 'a-z' 'A-Z' <<< ${1:0:1})${1:1}
	else
		shift
		echo ${@/#/--enable=}
	fi
}

src_configure() {
	configuration() {
		local myconf=(
			"${PYTHON}"
			"${S}"/configure.py
			$(usex debug '--debug --qml-debug --trace' '')
			--verbose
			--qmake="$(qt5_get_bindir)"/qmake
			--sip-incdir="$(python_get_includedir)"
		)
		echo "${myconf[@]}"
		"${myconf[@]}" || die

		eqmake5 -recursive ${PN}.pro
	}
	python_foreach_impl run_in_build_dir configuration
}

src_compile() {
	python_foreach_impl run_in_build_dir default
}

src_install() {
	installation() {
		local tmp_root=${D}/${PN}_tmp_root
		# parallel install fails (same issue as qscintilla-python-2.10.8)
		emake -j1 INSTALL_ROOT="${tmp_root}" install

		multibuild_merge_root "${tmp_root}" "${D}"
		python_optimize
	}
	python_foreach_impl run_in_build_dir installation

	einstalldocs
}
