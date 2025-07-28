# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {18..20} )
RUST_MIN_VER="1.80.1"

MY_EGIT_COMMIT=fefc0bc0a71556eb75352e2b611e50eb5d3bf9c2
# used for version string
export NIRI_BUILD_COMMIT="fefc0bc"

CRATES="
	adler2@2.0.1
	ahash@0.8.12
	aho-corasick@1.1.3
	aliasable@0.1.3
	allocator-api2@0.2.21
	android-activity@0.6.0
	android-properties@0.2.2
	annotate-snippets@0.9.2
	anstream@0.6.19
	anstyle-parse@0.2.7
	anstyle-query@1.1.3
	anstyle-wincon@3.0.9
	anstyle@1.0.11
	anyhow@1.0.98
	appendlist@1.4.0
	approx@0.4.0
	approx@0.5.1
	arrayvec@0.7.6
	as-raw-xcb-connection@1.0.1
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-executor@1.13.2
	async-io@2.4.1
	async-lock@3.4.0
	async-process@2.3.1
	async-recursion@1.1.1
	async-signal@0.2.11
	async-task@4.7.1
	async-trait@0.1.88
	atomic-waker@1.1.2
	atomic@0.6.1
	atomic_float@1.1.0
	autocfg@1.5.0
	base64@0.21.7
	bindgen@0.69.5
	bit-set@0.8.0
	bit-vec@0.8.0
	bitflags@1.3.2
	bitflags@2.9.1
	block-buffer@0.10.4
	block2@0.5.1
	blocking@1.6.2
	bumpalo@3.19.0
	bytemuck@1.23.1
	bytemuck_derive@1.9.3
	bytes@1.10.1
	cairo-rs@0.20.12
	cairo-sys-rs@0.20.10
	calloop-wayland-source@0.3.0
	calloop-wayland-source@0.4.0
	calloop@0.13.0
	calloop@0.14.2
	cc@1.2.29
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-expr@0.15.8
	cfg-expr@0.18.0
	cfg-if@1.0.1
	cfg_aliases@0.2.1
	cgmath@0.18.0
	chumsky@0.9.3
	clang-sys@1.8.1
	clap@4.5.41
	clap_builder@4.5.41
	clap_complete@4.5.55
	clap_complete_nushell@4.5.8
	clap_derive@4.5.41
	clap_lex@0.7.5
	colorchoice@1.0.4
	combine@4.6.7
	concurrent-queue@2.5.0
	console@0.15.11
	convert_case@0.6.0
	cookie-factory@0.3.3
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	core-graphics-types@0.1.3
	core-graphics@0.23.2
	cpufeatures@0.2.17
	crc32fast@1.4.2
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crypto-common@0.1.6
	csscolorparser@0.7.2
	cursor-icon@1.2.0
	diff@0.1.13
	digest@0.10.7
	directories@6.0.0
	dirs-sys@0.5.0
	dispatch@0.2.0
	displaydoc@0.2.5
	dlib@0.5.2
	downcast-rs@1.2.1
	dpi@0.1.2
	drm-ffi@0.9.0
	drm-fourcc@2.2.0
	drm-sys@0.8.0
	drm@0.14.1
	dyn-clone@1.0.19
	either@1.15.0
	encode_unicode@1.0.0
	endi@1.1.0
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.2
	errno@0.3.13
	event-listener-strategy@0.5.4
	event-listener@5.4.0
	fastrand@2.3.0
	fdeflate@0.3.7
	field-offset@0.3.6
	flate2@1.1.2
	fnv@1.0.7
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.6.0
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	gbm-sys@0.4.0
	gbm@0.18.0
	gdk-pixbuf-sys@0.20.10
	gdk-pixbuf@0.20.10
	gdk4-sys@0.9.6
	gdk4@0.9.6
	generator@0.8.5
	generic-array@0.14.7
	gethostname@0.4.3
	getrandom@0.2.16
	getrandom@0.3.3
	gio-sys@0.20.10
	gio@0.20.12
	git-version-macro@0.3.9
	git-version@0.3.9
	gl_generator@0.14.0
	glam@0.30.4
	glib-macros@0.20.12
	glib-sys@0.20.10
	glib@0.20.12
	glob@0.3.2
	gobject-sys@0.20.10
	graphene-rs@0.20.10
	graphene-sys@0.20.10
	gsk4-sys@0.9.6
	gsk4@0.9.6
	gtk4-macros@0.9.5
	gtk4-sys@0.9.6
	gtk4@0.9.7
	hashbrown@0.14.5
	hashbrown@0.15.4
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.5.2
	hex@0.4.3
	icu_collections@1.5.0
	icu_locid@1.5.0
	icu_locid_transform@1.5.0
	icu_locid_transform_data@1.5.1
	icu_normalizer@1.5.0
	icu_normalizer_data@1.5.1
	icu_properties@1.5.1
	icu_properties_data@1.5.1
	icu_provider@1.5.0
	icu_provider_macros@1.5.0
	idna@1.0.3
	idna_adapter@1.2.0
	indexmap@2.10.0
	input-sys@1.18.0
	input@0.9.1
	insta@1.43.1
	io-lifetimes@1.0.11
	is-terminal@0.4.16
	is_ci@1.2.0
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itoa@1.0.15
	jni-sys@0.3.0
	jni@0.21.1
	jobserver@0.1.33
	js-sys@0.3.77
	keyframe@1.1.1
	khronos_api@3.1.0
	knuffel-derive@3.2.0
	knuffel@3.2.0
	lazy_static@1.5.0
	lazycell@1.3.0
	libadwaita-sys@0.7.2
	libadwaita@0.7.2
	libc@0.2.174
	libdisplay-info-derive@0.1.0
	libdisplay-info-sys@0.2.2
	libdisplay-info@0.2.2
	libloading@0.8.8
	libm@0.2.15
	libredox@0.1.4
	libseat-sys@0.1.9
	libseat@0.2.3
	libudev-sys@0.1.4
	linux-raw-sys@0.4.15
	linux-raw-sys@0.6.5
	linux-raw-sys@0.9.4
	litemap@0.7.4
	log@0.4.27
	loom@0.7.2
	matchers@0.1.0
	memchr@2.7.5
	memmap2@0.9.7
	memoffset@0.9.1
	miette-derive@5.10.0
	miette@5.10.0
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	ndk-context@0.1.1
	ndk-sys@0.6.0+11769913
	ndk@0.9.0
	nix@0.29.0
	nix@0.30.1
	nom@7.1.3
	nu-ansi-term@0.46.0
	num-traits@0.2.19
	num_enum@0.7.4
	num_enum_derive@0.7.4
	objc-sys@0.3.5
	objc2-app-kit@0.2.2
	objc2-cloud-kit@0.2.2
	objc2-contacts@0.2.2
	objc2-core-data@0.2.2
	objc2-core-image@0.2.2
	objc2-core-location@0.2.2
	objc2-encode@4.1.0
	objc2-foundation@0.2.2
	objc2-link-presentation@0.2.2
	objc2-metal@0.2.2
	objc2-quartz-core@0.2.2
	objc2-symbols@0.2.2
	objc2-ui-kit@0.2.2
	objc2-uniform-type-identifiers@0.2.2
	objc2-user-notifications@0.2.2
	objc2@0.5.2
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	option-ext@0.2.0
	orbclient@0.3.48
	ordered-float@5.0.0
	ordered-stream@0.2.0
	overload@0.1.1
	owo-colors@3.5.0
	pango-sys@0.20.10
	pango@0.20.12
	pangocairo-sys@0.20.10
	pangocairo@0.20.10
	parking@2.2.1
	paste@1.0.15
	percent-encoding@2.3.1
	phf@0.11.3
	phf_generator@0.11.3
	phf_macros@0.11.3
	phf_shared@0.11.3
	pin-project-internal@1.1.10
	pin-project-lite@0.2.16
	pin-project@1.1.10
	pin-utils@0.1.0
	piper@0.2.4
	pixman-sys@0.1.0
	pixman@0.2.1
	pkg-config@0.3.32
	png@0.17.16
	polling@3.8.0
	portable-atomic@1.11.1
	ppv-lite86@0.2.21
	pretty_assertions@1.4.1
	proc-macro-crate@3.3.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.95
	profiling-procmacros@1.0.17
	profiling@1.0.17
	proptest-derive@0.6.0
	proptest@1.7.0
	quick-error@1.2.3
	quick-xml@0.37.5
	quote@1.0.40
	r-efi@5.3.0
	rand@0.8.5
	rand@0.9.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	rand_xorshift@0.4.0
	raw-window-handle@0.6.2
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.4.1
	redox_syscall@0.5.13
	redox_users@0.5.0
	ref-cast-impl@1.0.24
	ref-cast@1.0.24
	regex-automata@0.1.10
	regex-automata@0.4.9
	regex-syntax@0.6.29
	regex-syntax@0.8.5
	regex@1.11.1
	rustc-hash@1.1.0
	rustc_version@0.4.1
	rustix@0.38.44
	rustix@1.0.7
	rustversion@1.0.21
	rusty-fork@0.3.0
	ryu@1.0.20
	same-file@1.0.6
	schemars@1.0.4
	schemars_derive@1.0.4
	scoped-tls@1.0.1
	sd-notify@0.4.5
	semver@1.0.26
	serde@1.0.219
	serde_derive@1.0.219
	serde_derive_internals@0.29.1
	serde_json@1.0.140
	serde_repr@0.1.20
	serde_spanned@0.6.9
	sha2@0.10.9
	sharded-slab@0.1.7
	shlex@1.3.0
	signal-hook-registry@1.4.5
	simd-adler32@0.3.7
	similar@2.7.0
	siphasher@1.0.1
	slab@0.4.10
	smallvec@1.15.1
	smawk@0.3.2
	smithay-client-toolkit@0.19.2
	smol_str@0.2.2
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	strsim@0.11.1
	supports-color@2.1.0
	supports-hyperlinks@2.1.0
	supports-unicode@2.1.0
	syn@1.0.109
	syn@2.0.104
	synstructure@0.13.2
	system-deps@6.2.2
	system-deps@7.0.5
	target-lexicon@0.12.16
	target-lexicon@0.13.2
	tempfile@3.20.0
	terminal_size@0.1.17
	textwrap@0.15.2
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	thread_local@1.1.9
	tinystr@0.7.6
	toml@0.8.23
	toml_datetime@0.6.11
	toml_edit@0.22.27
	tracing-attributes@0.1.30
	tracing-core@0.1.34
	tracing-log@0.2.0
	tracing-subscriber@0.3.19
	tracing@0.1.41
	tracy-client-sys@0.26.0
	tracy-client@0.18.2
	typenum@1.18.0
	udev@0.9.3
	uds_windows@1.1.0
	unarray@0.1.4
	unicode-ident@1.0.18
	unicode-linebreak@0.1.5
	unicode-segmentation@1.12.0
	unicode-width@0.1.14
	url@2.5.4
	utf16_iter@1.0.5
	utf8_iter@1.0.4
	utf8parse@0.2.2
	valuable@0.1.1
	version-compare@0.2.0
	version_check@0.9.5
	wait-timeout@0.2.1
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-futures@0.4.50
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	wayland-backend@0.3.10
	wayland-client@0.31.10
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.10
	wayland-egl@0.32.7
	wayland-protocols-misc@0.3.8
	wayland-protocols-plasma@0.3.8
	wayland-protocols-wlr@0.3.8
	wayland-protocols@0.32.8
	wayland-scanner@0.31.6
	wayland-server@0.31.9
	wayland-sys@0.31.6
	web-sys@0.3.77
	web-time@1.1.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-collections@0.2.0
	windows-core@0.61.2
	windows-future@0.2.1
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.3
	windows-numerics@0.2.0
	windows-result@0.3.4
	windows-strings@0.4.2
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.2
	windows-threading@0.1.0
	windows@0.61.3
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winit@0.30.11
	winnow@0.7.12
	wit-bindgen-rt@0.39.0
	write16@1.0.0
	writeable@0.5.5
	x11-dl@2.21.0
	x11rb-protocol@0.13.1
	x11rb@0.13.1
	xcursor@0.3.10
	xkbcommon-dl@0.4.2
	xkbcommon@0.8.0
	xkeysym@0.2.1
	xml-rs@0.8.27
	xshell-macros@0.2.7
	xshell@0.2.7
	yansi-term@0.1.2
	yansi@1.0.1
	yoke-derive@0.7.5
	yoke@0.7.5
	zbus@5.8.0
	zbus_macros@5.8.0
	zbus_names@4.2.0
	zerocopy-derive@0.8.26
	zerocopy@0.8.26
	zerofrom-derive@0.1.6
	zerofrom@0.1.5
	zerovec-derive@0.10.3
	zerovec@0.10.4
	zvariant@5.6.0
	zvariant_derive@5.6.0
	zvariant_utils@3.2.0
"

PIPEWIRE_RS_COMMIT="fd3d8f7861a29c2eeaa4c393402e013578bb36d9"
SMITHAY_COMMIT="7c1fc8951060a46a175d1adae7c8da66f3cfe67e"

# GIT_CRATES is borked for gitlab.freedesktop.org it seems, so we just add these things to SRC_URI manually and then add things to config.toml manually in src_unpack
# declare -A GIT_CRATES=(
# 	# [libspa-sys]='https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/%commit%/pipewire-rs-%commit%.tar.gz;fd3d8f7861a29c2eeaa4c393402e013578bb36d9;pipewire-rs-%commit%/libspa-sys'
# 	# [libspa]='https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/%commit%/pipewire-rs-%commit%.tar.gz;fd3d8f7861a29c2eeaa4c393402e013578bb36d9;pipewire-rs-%commit%/libspa'
# 	# [pipewire-sys]='https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/%commit%/pipewire-rs-%commit%.tar.gz;fd3d8f7861a29c2eeaa4c393402e013578bb36d9;pipewire-rs-%commit%/pipewire-sys'
# 	# [pipewire]='https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/%commit%/pipewire-rs-%commit%.tar.gz;fd3d8f7861a29c2eeaa4c393402e013578bb36d9;pipewire-rs-%commit%/pipewire'

# 	# [pipewire]='https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/%commit%/pipewire-rs-%commit%.tar.gz;fd3d8f7861a29c2eeaa4c393402e013578bb36d9;pipewire-rs-%commit%'

# 	# [pipewire]="https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/${PIPEWIRE_RS_COMMIT}/pipewire-rs-${PIPEWIRE_RS_COMMIT}.tar.gz;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}"

# 	# [libspa-sys]="https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/${PIPEWIRE_RS_COMMIT}/pipewire-rs-${PIPEWIRE_RS_COMMIT}.tar.gz;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/libspa-sys"
# 	# [libspa]="https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/${PIPEWIRE_RS_COMMIT}/pipewire-rs-${PIPEWIRE_RS_COMMIT}.tar.gz;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/libspa"
# 	# [pipewire-sys]="https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/${PIPEWIRE_RS_COMMIT}/pipewire-rs-${PIPEWIRE_RS_COMMIT}.tar.gz;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/pipewire-sys"
# 	# [pipewire]="https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/${PIPEWIRE_RS_COMMIT}/pipewire-rs-${PIPEWIRE_RS_COMMIT}.tar.gz;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/pipewire"

# 	# [libspa-sys]="https://gitlab.freedesktop.org/pipewire/pipewire-rs;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/libspa-sys"
# 	# [libspa]="https://gitlab.freedesktop.org/pipewire/pipewire-rs;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/libspa"
# 	# [pipewire-sys]="https://gitlab.freedesktop.org/pipewire/pipewire-rs;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/pipewire-sys"
# 	# [pipewire]="https://gitlab.freedesktop.org/pipewire/pipewire-rs;${PIPEWIRE_RS_COMMIT};pipewire-rs-${PIPEWIRE_RS_COMMIT}/pipewire"

# 	[smithay-drm-extras]='https://github.com/Smithay/smithay;7c1fc8951060a46a175d1adae7c8da66f3cfe67e;smithay-%commit%/smithay-drm-extras'
# 	[smithay]='https://github.com/Smithay/smithay;7c1fc8951060a46a175d1adae7c8da66f3cfe67e;smithay-%commit%'
# )

inherit cargo llvm-r2 optfeature systemd

DESCRIPTION="Scrollable-tiling Wayland compositor"
HOMEPAGE="https://github.com/YaLTeR/niri"

SRC_URI="
	https://github.com/YaLTeR/niri/archive/${MY_EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	https://gitlab.freedesktop.org/pipewire/pipewire-rs/-/archive/${PIPEWIRE_RS_COMMIT}/pipewire-rs-${PIPEWIRE_RS_COMMIT}.tar.gz
	https://github.com/Smithay/smithay/archive/${SMITHAY_COMMIT}.tar.gz -> smithay-${SMITHAY_COMMIT}.tar.gz
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-${MY_EGIT_COMMIT}/"

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD ISC MIT MPL-2.0
	Unicode-3.0
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+dbus screencast systemd"
REQUIRED_USE="
	screencast? ( dbus )
	systemd? ( dbus )
"

DEPEND="
	dev-libs/glib:2
	dev-libs/libinput:=
	dev-libs/wayland
	media-libs/libdisplay-info:=
	media-libs/mesa
	sys-auth/seatd:=
	virtual/libudev:=
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman
	screencast? ( media-video/pipewire:= )
"
RDEPEND="
	${DEPEND}
	screencast? ( sys-apps/xdg-desktop-portal-gnome )
"
# libclang is required for bindgen
BDEPEND="
	screencast? ( $(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}') )
"

ECARGO_VENDOR="${WORKDIR}/vendor"

QA_FLAGS_IGNORED="usr/bin/niri"

pkg_setup() {
	llvm-r2_pkg_setup
	rust_pkg_setup
}

src_unpack() {
	verify-sig_src_unpack
	cargo_src_unpack
	echo "
[patch.'https://gitlab.freedesktop.org/pipewire/pipewire-rs.git']
pipewire     = { path = \"${WORKDIR}/pipewire-rs-${PIPEWIRE_RS_COMMIT}/pipewire\" }
pipewire-sys = { path = \"${WORKDIR}/pipewire-rs-${PIPEWIRE_RS_COMMIT}/pipewire-sys\" }
libspa       = { path = \"${WORKDIR}/pipewire-rs-${PIPEWIRE_RS_COMMIT}/libspa\" }
libspa-sys   = { path = \"${WORKDIR}/pipewire-rs-${PIPEWIRE_RS_COMMIT}/libspa-sys\" }

[patch.'https://github.com/Smithay/smithay.git']
smithay-drm-extras = { path = \"${WORKDIR}/smithay-${SMITHAY_COMMIT}/smithay-drm-extras\" }
smithay            = { path = \"${WORKDIR}/smithay-${SMITHAY_COMMIT}\" }
" >> "${ECARGO_HOME}"/config.toml
}

src_prepare() {
	# sed -i 's/git = "[^ ]*"/version = "*"/' Cargo.toml || die
	# niri-session doesn't work on OpenRC
	if ! use systemd; then
		sed -i 's/niri-session/niri --session/' resources/niri.desktop || die
	fi
	default
}

src_configure() {
	local myfeatures=(
		$(usev dbus)
		$(usev screencast xdp-gnome-screencast)
		$(usev systemd)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	dobin resources/niri-session
	systemd_douserunit resources/niri{.service,-shutdown.target}

	insinto /usr/share/wayland-sessions
	doins resources/niri.desktop

	insinto /usr/share/xdg-desktop-portal
	doins resources/niri-portals.conf
}

src_test() {
	# tests create a wayland socket in the xdg runtime dir
	local -x XDG_RUNTIME_DIR="${T}/xdg"
	mkdir "${XDG_RUNTIME_DIR}" || die
	chmod 0700 "${XDG_RUNTIME_DIR}" || die

	# bug 950626
	# https://github.com/YaLTeR/niri/blob/main/wiki/Packaging-niri.md#running-tests
	local -x RAYON_NUM_THREADS=2
	cargo_src_test -- --test-threads=2
}

pkg_postinst() {
	optfeature "Default application launcher" "gui-apps/fuzzel"
	optfeature "Default status bar" "gui-apps/waybar"
	optfeature "Default terminal" "x11-terms/alacritty"
	optfeature "Xwayland support" "gui-apps/xwayland-satellite"
}
