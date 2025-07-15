# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash@0.8.12
	aho-corasick@1.1.3
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.8
	anstyle@1.0.10
	anyhow@1.0.98
	bindgen@0.69.5
	bitflags@1.3.2
	bitflags@2.9.1
	cc@1.2.24
	cexpr@0.6.0
	cfg-if@1.0.0
	clang-sys@1.8.1
	colorchoice@1.0.3
	cursor-icon@1.2.0
	darling@0.20.11
	darling_core@0.20.11
	darling_macro@0.20.11
	deranged@0.4.0
	derive_builder@0.20.2
	derive_builder_core@0.20.2
	derive_builder_macro@0.20.2
	downcast-rs@1.2.1
	either@1.15.0
	env_filter@0.1.3
	env_logger@0.10.2
	env_logger@0.11.8
	errno@0.3.12
	fnv@1.0.7
	glob@0.3.2
	hashbrown@0.14.5
	hecs-macros@0.10.0
	hecs@0.10.5
	hermit-abi@0.5.1
	home@0.5.11
	humantime@2.2.0
	ident_case@1.0.1
	is-terminal@0.4.16
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itoa@1.0.15
	jiff-static@0.2.14
	jiff@0.2.14
	lazy_static@1.5.0
	lazycell@1.3.0
	libc@0.2.172
	libloading@0.8.8
	linux-raw-sys@0.4.15
	log@0.4.27
	memchr@2.7.4
	memmap2@0.9.5
	minimal-lexical@0.2.1
	nom@7.1.3
	num-conv@0.1.0
	num_threads@0.1.7
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	pkg-config@0.3.32
	portable-atomic-util@0.2.4
	portable-atomic@1.11.0
	powerfmt@0.2.0
	pretty_env_logger@0.5.0
	prettyplease@0.2.32
	proc-macro2@1.0.95
	quick-xml@0.30.0
	quick-xml@0.37.5
	quote@1.0.40
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rustc-hash@1.1.0
	rustix@0.38.44
	rustversion@1.0.21
	sd-notify@0.4.5
	serde@1.0.219
	serde_derive@1.0.219
	shlex@1.3.0
	smallvec@1.15.0
	smithay-client-toolkit@0.19.2
	spin@0.9.8
	strsim@0.11.1
	syn@2.0.101
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror@1.0.69
	time-core@0.1.4
	time-macros@0.2.22
	time@0.3.41
	unicode-ident@1.0.18
	utf8parse@0.2.2
	vergen-gitcl@1.0.8
	vergen-lib@0.1.6
	vergen@9.0.6
	version_check@0.9.5
	wayland-backend@0.3.10
	wayland-client@0.31.10
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.10
	wayland-protocols-wlr@0.3.8
	wayland-protocols@0.32.8
	wayland-scanner@0.31.6
	wayland-server@0.31.9
	wayland-sys@0.31.6
	which@4.4.2
	winapi-util@0.1.9
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows-targets@0.53.0
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	xcb-util-cursor-sys@0.1.4
	xcb-util-cursor@0.3.3
	xcb@1.5.0
	xcursor@0.3.8
	xkeysym@0.2.1
	zerocopy-derive@0.8.25
	zerocopy@0.8.25
"

LLVM_COMPAT=( {17..20} )
# LLVM_COMPAT=( 19 )
# RUST_MIN_VER="1.86.0"
RUST_NEEDS_LLVM=1

inherit llvm-r1 cargo

EGIT_COMMIT="ba78881a68182ce338041846164cbfed0d70935c"
DESCRIPTION="Xwayland outside your Wayland"
HOMEPAGE="https://github.com/Supreeeme/xwayland-satellite"
SRC_URI="
	https://github.com/Supreeeme/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"
# DEPS_URI="https://github.com/freijon/${PN}/releases/download/v0.6/${PN}-0.6-crates.tar.xz"
# SRC_URI+=" ${DEPS_URI}"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}/"

LICENSE="MPL-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# disable tests which need a running display server
RESTRICT="test"

DEPEND="
	>=x11-base/xwayland-23.1
	x11-libs/libxcb
	x11-libs/xcb-util-cursor
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}=')
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

DOCS=( README.md )

pkg_setup() {
	llvm-r1_pkg_setup
	rust_pkg_setup
}

src_install() {
	cargo_src_install
	einstalldocs
}
