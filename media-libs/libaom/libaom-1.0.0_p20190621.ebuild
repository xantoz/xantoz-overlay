EAPI=7

inherit git-r3
EGIT_REPO_URI="https://aomedia.googlesource.com/aom"
EGIT_COMMIT=32185d165e0a238a32b20c5bbd59e360bd46d067

source /usr/portage/media-libs/libaom/libaom-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
