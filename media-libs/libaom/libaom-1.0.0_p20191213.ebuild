EAPI=7

inherit git-r3
EGIT_REPO_URI="https://aomedia.googlesource.com/aom"
EGIT_COMMIT=961d13f1b18b7fa96a2f61c5fa649b2e9c4e2428

source /usr/portage/media-libs/libaom/libaom-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
