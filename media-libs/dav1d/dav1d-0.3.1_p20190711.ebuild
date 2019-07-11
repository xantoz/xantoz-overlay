EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_REPO_URI="https://code.videolan.org/videolan/dav1d"
EGIT_COMMIT=6ef9a030145eef79fdeab6d4d38e00423ae7a83d

source /usr/portage/media-libs/dav1d/dav1d-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
