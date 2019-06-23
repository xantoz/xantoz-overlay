EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_MIN_CLONE_TYPE="single"
EGIT_REPO_URI="https://git.ffmpeg.org/ffmpeg.git"
EGIT_COMMIT=97ddc5d1f741ed246fd81234a4ec3d3ef7038593

source /usr/portage/media-video/ffmpeg/ffmpeg-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
