Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6633B8FDD
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhGAJjh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbhGAJjh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jul 2021 05:39:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781C0C061756
        for <linux-can@vger.kernel.org>; Thu,  1 Jul 2021 02:37:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lyt83-0000Zl-VI; Thu, 01 Jul 2021 11:37:04 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6b79:f6d8:f46:d3ca])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 93941646E8C;
        Thu,  1 Jul 2021 09:37:02 +0000 (UTC)
Date:   Thu, 1 Jul 2021 11:37:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Angelo Dureghello <angelo@kernel-space.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        linux-can@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH v4 2/5] m68k: stmark2: update board setup
Message-ID: <20210701093701.ixn7rwwtwe6x4rsk@pengutronix.de>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-2-angelo@kernel-space.org>
 <20210701065327.maawrm546dkfzxbx@pengutronix.de>
 <7effec9f-e3aa-12d1-fc91-cb7b2c4ae9ab@linux-m68k.org>
 <20210701074255.jutewhpjqxsi7bdl@pengutronix.de>
 <7252e8f0-7d16-4707-d091-784c27911173@linux-m68k.org>
 <CAMuHMdV0nMOO734NAXdhbUmmHJYz781QFZT-k85jbd3hZ=qypg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="trxnob3kln5qiwv7"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV0nMOO734NAXdhbUmmHJYz781QFZT-k85jbd3hZ=qypg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--trxnob3kln5qiwv7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2021 11:10:21, Geert Uytterhoeven wrote:
> > >> I am happy to take the m68k specific changes (patches 2 and 3)
> > >> through the m68knommu git tree.
> > >
> > > Make it so. \o/ I'll take the rest.
> >
> > As soon as the current merge window closes I will pull them in.
>=20
> Patch 3 depends on patch 1 through <linux/can/platform/flexcan.h>.

I'll take the other patches via net-next, so it might take a while until
they git mainline.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--trxnob3kln5qiwv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDdjLsACgkQqclaivrt
76m3aAf+Ksh+Bhm2Rc5CWW2JtMR/XuDa5fEbnFD20VBpYjflq+UnU8ESoRp7k/Aj
Pg/Si9m3SazMqj0piuJsn7xRUSTE3LPTz3Lvz6lZ0aHFe0QMqKmiZC6b14Va1s8M
ivllUpLH/3G2uso+Yu1UrmFtl0+aWIWgYX8G/Tha+7r29ZtCkEU+vaxv6zWfVFWB
FF1nNk5LlwLm0b6nk0jn1mlhPdzKX0kVUvDZqZPMcEDjeOcbYN2pZO5dBKr+dYl8
JvVNgguj/v78Cnj1tR0xWJufYFH5kOzc7vmxN7klgOILR+RVozzGN0SbJh20BGsx
sn+9v2JMwtJ4fdUpfZ/sAG7s00hOBQ==
=l7PE
-----END PGP SIGNATURE-----

--trxnob3kln5qiwv7--
