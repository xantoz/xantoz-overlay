# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..15} )

inherit distutils-r1

# Pinned to the master commit current as of this ebuild's creation.
# Re-derive with: git ls-remote https://github.com/sdilts/cl-bindgen.git master
EGIT_COMMIT="bad33f070cd51aa4f721c8edf96804b4f8547f8d"
MY_PN="cl-bindgen"
MY_P="${MY_PN}-${EGIT_COMMIT}"

DESCRIPTION="Command line tool and library for creating Common Lisp CFFI bindings from C headers"
HOMEPAGE="https://github.com/sdilts/cl-bindgen"
SRC_URI="https://github.com/sdilts/cl-bindgen/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/clang[${PYTHON_USEDEP}]
	llvm-core/clang:*
"
