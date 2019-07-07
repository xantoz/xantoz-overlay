EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_REPO_URI="https://code.videolan.org/videolan/dav1d"
EGIT_COMMIT=1681028f68f2cff9cd84476b1c1fe74dc715fe4b

source /usr/portage/media-libs/dav1d/dav1d-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
