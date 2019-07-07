EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_MIN_CLONE_TYPE="single"
EGIT_REPO_URI="https://git.ffmpeg.org/ffmpeg.git"
EGIT_COMMIT=2bd21b96096320bc12532119a6b0f7a974db6c19

source /usr/portage/media-video/ffmpeg/ffmpeg-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/
