# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 eutils toolchain-funcs user multilib-minimal

DESCRIPTION="small audio and MIDI framework part of the OpenBSD project"
HOMEPAGE="http://www.sndio.org/"

EGIT_MIN_CLONE_TYPE="single"
EGIT_REPO_URI="http://caoua.org/git/sndio"
# master branch HEAD as of 20191127
EGIT_COMMIT=c38dfbf530240dba6b102fc210dd5f304377941f
EGIT_BRANCH=mixer

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64"
IUSE="alsa rmidi umidi"
REQUIRED_USE="umidi? ( rmidi )"

RDEPEND="alsa? ( media-libs/alsa-lib )"
DEPEND="${REPEND}"

pkg_setup() {
	if ! use alsa ; then
		ewarn "alsa output disabled, no local output"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0_p20120925-configure.patch

	eapply_user

	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(use_enable alsa) \
		$(use_enable rmidi) \
		$(use_enable umidi) \
		--privsep-user=${PN}d \
		--disable-sun \
		--without-libbsd

	tc-export CC
}

multilib_src_install_all() {
	dodir /var/lib/sndio
	newinitd "${FILESDIR}"/initd ${PN}d
	newconfd "${FILESDIR}"/confd ${PN}d
}

pkg_postinst() {
	enewuser ${PN}d -1 -1 /var/lib/${PN} audio
}
