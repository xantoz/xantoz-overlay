EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_REPO_URI="https://code.videolan.org/videolan/dav1d"
EGIT_COMMIT=c09f10722ad0ed0d46ef6dae84370d44ad81c17c

source /usr/portage/media-libs/dav1d/dav1d-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
