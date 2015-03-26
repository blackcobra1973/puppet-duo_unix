# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_blue/pam_blue-0.9.0.ebuild,v 1.6 2010/06/11 11:06:48 ssuominen Exp $

inherit pam autotools multilib

DESCRIPTION="Linux PAM module providing ability off Two-Facter authenticate via Duosecurity"
HOMEPAGE="https://www.duosecurity.com/"
SRC_URI="https://dl.duosecurity.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	tc-export CC

    # not an autotools generated script
    ./configure \
        --prefix=/usr \
        --sysconfdir=/etc/duo \
        || die "Configure failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	elog "For configuration info, see /etc/duo/login_duo.conf"
	elog "http://www.duosecurity.com/docs/duounix"
	elog "Edit the file as required."
}
