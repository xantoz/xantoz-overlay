EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_REPO_URI="https://code.videolan.org/videolan/dav1d"
EGIT_COMMIT=490a1420f34765f6b1aa9610e23aea247bec2dcc

source /usr/portage/media-libs/dav1d/dav1d-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
