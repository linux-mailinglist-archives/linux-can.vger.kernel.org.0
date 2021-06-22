Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D063AFD75
	for <lists+linux-can@lfdr.de>; Tue, 22 Jun 2021 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhFVG4u (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Jun 2021 02:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFVG4u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Jun 2021 02:56:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42440C061574
        for <linux-can@vger.kernel.org>; Mon, 21 Jun 2021 23:54:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lvaIo-000842-Hq; Tue, 22 Jun 2021 08:54:30 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f4a:9a72:36be:c814])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E4E43640FEC;
        Tue, 22 Jun 2021 06:54:28 +0000 (UTC)
Date:   Tue, 22 Jun 2021 08:54:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@kernel-space.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH v3 4/5] can: flexcan: update Kconfig to allow non-of cases
Message-ID: <20210622065427.z5dnixenf47zag4g@pengutronix.de>
References: <20210621184615.3345846-1-angelo@kernel-space.org>
 <20210621184615.3345846-4-angelo@kernel-space.org>
 <CAMuHMdV8a=YKowGLY3kGqwsfAPd3VPEXS8x7xqYaUz9ZBh64hg@mail.gmail.com>
 <20210621201816.pk6n4xa7j4bi6vfk@pengutronix.de>
 <CAMuHMdUHQyPB8G5QX-oK7+MDvkLihR6QCoD+9_3pQKQZWu7TGw@mail.gmail.com>
 <20210621204127.xwrk2tlxggct7kst@pengutronix.de>
 <CAMuHMdUrFa6r2VQdNTgr8mV_wGoOb4VhK0Y5_XQQ1Xzgc93NMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s6dgs2ngnlnhqaoo"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUrFa6r2VQdNTgr8mV_wGoOb4VhK0Y5_XQQ1Xzgc93NMw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--s6dgs2ngnlnhqaoo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.06.2021 08:52:05, Geert Uytterhoeven wrote:
> > Probably. What about the original proposed change: "(OF || M5441x) && H=
AS_IOMEM"?
>=20
> Yeah, the Flexcan might pop up on RISC-V, too.
> But any new platforms should use OF.
> Given the Flexcan is probably present on more than just M5441x,
> I'd go for:
>=20
>     depends on OF || COLDFIRE || COMPILE_TEST
>     depends on HAS_IOMEM

Looks good to me!

> > > > So I think there won't be too many configs where the oldconfig ques=
tion
> > > > would pop up.
> > >
> > > Now it will, as Mr. Torvalds' main machine does not satisfy "ARM || P=
PC"
> > > or "OF && HAS_IOMEM", but does "HAS_IOMEM" ;-)
> >
> > IC, that would be one question too much :)
>=20
> I do doubt he has CONFIG_CAN enabled ;-)

:D

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--s6dgs2ngnlnhqaoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDRiSEACgkQqclaivrt
76lZCAf/ekQ8XfkOJIawXZDDpjaVLO1FOL9o4/es0jY+ytWjQWUWshRKWgTbxeY3
EP+LTnf+0R3jVGXVslMaANyyfhgYjRrM2aCQD6I55cXBkxJsrmWVeNRbLYl0giHh
GOkykIEJejF6h+HCz1sq2vHftbb0JA5YFB0VrjJqY4bYf5W5sXT4EytRwLneT9Na
p+sdTPE4hPV+bRwWjsd0Tz0P4RW1cz6mPejTXRr/PXJoyINv5kBCFEUiYW/mOIQD
k36vLMdR8tooj1eK5IqQJRGkgMgpAvtnpmYtBFSurmohesu4iGyfDob4348oTvJa
uyRISslDj+tPyMk2udDn4vTzwvzKxA==
=pPbT
-----END PGP SIGNATURE-----

--s6dgs2ngnlnhqaoo--
