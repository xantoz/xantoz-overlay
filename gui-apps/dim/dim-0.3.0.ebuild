# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

CRATES="
	aho-corasick-1.1.3
	anstream-0.6.18
	anstyle-1.0.10
	anstyle-parse-0.2.6
	anstyle-query-1.1.2
	anstyle-wincon-3.0.6
	anyhow-1.0.93
	autocfg-1.4.0
	bitflags-2.6.0
	bytemuck-1.19.0
	bytemuck_derive-1.8.0
	calloop-0.13.0
	calloop-wayland-source-0.3.0
	cc-1.1.37
	cfg-if-1.0.0
	clap-4.5.20
	clap_builder-4.5.20
	clap_complete-4.5.37
	clap_derive-4.5.18
	clap_lex-0.7.2
	colorchoice-1.0.3
	concurrent-queue-2.5.0
	crossbeam-utils-0.8.20
	cursor-icon-1.1.0
	dlib-0.5.2
	downcast-rs-1.2.1
	env_filter-0.1.2
	env_logger-0.11.5
	equivalent-1.0.1
	errno-0.3.9
	hashbrown-0.15.1
	heck-0.5.0
	hermit-abi-0.4.0
	humantime-2.1.0
	indexmap-2.6.0
	is_terminal_polyfill-1.70.1
	libc-0.2.162
	libloading-0.8.5
	linux-raw-sys-0.4.14
	log-0.4.22
	memchr-2.7.4
	memmap2-0.8.0
	memmap2-0.9.5
	pin-project-lite-0.2.15
	pkg-config-0.3.31
	polling-3.7.4
	proc-macro2-1.0.89
	quick-xml-0.36.2
	quote-1.0.37
	regex-1.11.1
	regex-automata-0.4.8
	regex-syntax-0.8.5
	rustix-0.38.39
	scoped-tls-1.0.1
	serde-1.0.214
	serde_derive-1.0.214
	serde_spanned-0.6.8
	shlex-1.3.0
	slab-0.4.9
	smallvec-1.13.2
	smithay-client-toolkit-0.19.2
	strsim-0.11.1
	syn-2.0.87
	thiserror-1.0.68
	thiserror-impl-1.0.68
	toml-0.8.19
	toml_datetime-0.6.8
	toml_edit-0.22.22
	tracing-0.1.40
	tracing-core-0.1.32
	unicode-ident-1.0.13
	utf8parse-0.2.2
	wayland-backend-0.3.7
	wayland-client-0.31.7
	wayland-csd-frame-0.3.0
	wayland-cursor-0.31.7
	wayland-protocols-0.32.5
	wayland-protocols-wlr-0.3.5
	wayland-scanner-0.31.5
	wayland-sys-0.31.5
	windows-sys-0.52.0
	windows-sys-0.59.0
	windows-targets-0.52.6
	windows_aarch64_gnullvm-0.52.6
	windows_aarch64_msvc-0.52.6
	windows_i686_gnu-0.52.6
	windows_i686_gnullvm-0.52.6
	windows_i686_msvc-0.52.6
	windows_x86_64_gnu-0.52.6
	windows_x86_64_gnullvm-0.52.6
	windows_x86_64_msvc-0.52.6
	winnow-0.6.20
	xcursor-0.3.8
	xkbcommon-0.7.0
	xkeysym-0.2.1
"

inherit cargo

DESCRIPTION="Native Wayland screen dimming tool"
# Double check the homepage as the cargo_metadata crate
# does not provide this value so instead repository is used
HOMEPAGE="https://github.com/marcelohdez/dim"
SRC_URI="
	https://github.com/marcelohdez/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions GPL-3 ISC MIT unicode Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/libxkbcommon[wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkg-config
	app-text/scdoc
"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	export PKG_CONFIG_ALLOW_CROSS=1
	rust_pkg_setup
}

src_compile() {
	cargo_src_compile
	scdoc < man/dim.1.scd > man/dim.1 || die "conversation of man page failed"
}

src_install() {
	cargo_src_install
	dodoc README.md
	dodoc LICENSE
	doman man/*.1
}
