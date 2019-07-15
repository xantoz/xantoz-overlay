# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

AUTOTOOLS_AUTORECONF=1
EGIT_REPO_URI="https://github.com/xantoz/dcaenc"

inherit autotools autotools-multilib

[[ ${PV} == 9999* ]] && inherit git-r3

DESCRIPTION="DTS Coherent Acoustics audio encoder"
HOMEPAGE="http://aepatrakov.narod.ru/index/0-2"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="alsa"

RDEPEND="alsa? ( media-libs/alsa-lib[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"