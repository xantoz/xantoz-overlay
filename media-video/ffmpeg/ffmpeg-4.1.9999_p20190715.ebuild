EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_MIN_CLONE_TYPE="single"
EGIT_REPO_URI="https://git.ffmpeg.org/ffmpeg.git"
EGIT_COMMIT=7cb4f8c962bdd0e08881f8ce15f7bdd2d546ba44

source /usr/portage/media-video/ffmpeg/ffmpeg-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
