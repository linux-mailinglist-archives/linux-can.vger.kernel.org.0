Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051983B8E4D
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhGAHpb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhGAHpa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jul 2021 03:45:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4CC061756
        for <linux-can@vger.kernel.org>; Thu,  1 Jul 2021 00:43:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lyrLd-0004lP-B9; Thu, 01 Jul 2021 09:42:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6b79:f6d8:f46:d3ca])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AD1F4646D92;
        Thu,  1 Jul 2021 07:42:55 +0000 (UTC)
Date:   Thu, 1 Jul 2021 09:42:55 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Angelo Dureghello <angelo@kernel-space.org>, wg@grandegger.com,
        geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
Subject: Re: [PATCH v4 2/5] m68k: stmark2: update board setup
Message-ID: <20210701074255.jutewhpjqxsi7bdl@pengutronix.de>
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-2-angelo@kernel-space.org>
 <20210701065327.maawrm546dkfzxbx@pengutronix.de>
 <7effec9f-e3aa-12d1-fc91-cb7b2c4ae9ab@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5im3kggl5mg7ceb5"
Content-Disposition: inline
In-Reply-To: <7effec9f-e3aa-12d1-fc91-cb7b2c4ae9ab@linux-m68k.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5im3kggl5mg7ceb5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.07.2021 17:41:04, Greg Ungerer wrote:
>=20
> On 1/7/21 4:53 pm, Marc Kleine-Budde wrote:
> > On 01.07.2021 01:00:13, Angelo Dureghello wrote:
> > > Add configuration for flexcan pads.
> > >=20
> > > Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> >=20
> > How do we upstream the m68k changes? Should we split this series into
> > m68k and CAN?
>=20
> I am happy to take the m68k specific changes (patches 2 and 3)
> through the m68knommu git tree.

Make it so. \o/ I'll take the rest.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5im3kggl5mg7ceb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDdcfwACgkQqclaivrt
76nKYwgAqPDo5RhaqWamHKwSIuIyci24FSS21mbCb1ATDUBpRa+1hk6GEGDmdOpf
oiodIUwlSTLU8CAMXPsEJtT+yvOpSna4nwO/D6UWyuhoXDGMxWGPNanDL6qTzNu/
KahZIhWWOZgtZVeypVxjKF9xZAgX5cQSlcEQ4Q4rtSsbfi5ULho+pOwGwWPlPjmw
pwvyRQNi4HF/K0/LhqTwl7oqDw0Tabr7P8AwYjoQ/y/oF7+N4caNDG1LmQObXtRn
tYkwm/su3bBm0OSj5FRDtXvom99Vwe+NYVBMxws+qBBk0luq2Y3mbpHCoRtSC7Ho
t1LMgRf8fEoYv6v9jQionuOMpMWISw==
=SYVs
-----END PGP SIGNATURE-----

--5im3kggl5mg7ceb5--
