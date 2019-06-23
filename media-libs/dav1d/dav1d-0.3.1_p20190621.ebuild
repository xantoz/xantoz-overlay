EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_REPO_URI="https://code.videolan.org/videolan/dav1d"
EGIT_COMMIT=46980237595c3065f15106b0c3483cdd57fd3153

source /usr/portage/media-libs/dav1d/dav1d-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
