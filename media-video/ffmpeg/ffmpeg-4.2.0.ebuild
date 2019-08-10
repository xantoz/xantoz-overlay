EAPI=6

inherit git-r3

SCM="git-r3"
EGIT_MIN_CLONE_TYPE="single"
EGIT_REPO_URI="https://git.ffmpeg.org/ffmpeg.git"
EGIT_COMMIT=n4.2

source /usr/portage/media-video/ffmpeg/ffmpeg-9999.ebuild

SRC_URI=""
S=${WORKDIR}/${P}/

RDEPEND="${RDEPEND} media-libs/aribb24"
EXTRA_FFMPEG_CONF="--enable-version3 --enable-libaribb24"
