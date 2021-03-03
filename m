Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF232C5B6
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 02:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382072AbhCDAYE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhCCVUV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 16:20:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1ABC061756
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 13:19:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHYu3-0004et-Lt; Wed, 03 Mar 2021 22:19:31 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0000B5ED151;
        Wed,  3 Mar 2021 21:19:29 +0000 (UTC)
Date:   Wed, 3 Mar 2021 22:19:29 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?dWtyZm9pbC5jb20sIEPRgtGD0LTQuNC+0L/QsNC6INCj0LrRgNCw0LjQvdCw?=
         =?utf-8?B?LCDQktC+0YHRgtC+0YfQvdGL0Lkg0YDQtdCz0LjQvtC9?= 
        <ukrfoil@gmail.com>
Cc:     =?utf-8?B?U2NobMO8w59sZXIs?= Timo <t.schluessler@krause.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: mcp251x hangs during ifup
Message-ID: <20210303211929.gvgbk2aimwbsj6x7@pengutronix.de>
References: <CACGOs=TG4jyXKHBfPGDEJp1gSA+PyNVqCM7grPGMpe9+wYDBLA@mail.gmail.com>
 <20210303072653.zb66tkdlsxtval5n@pengutronix.de>
 <CACGOs=TJhoV99D=V-7xa8LG6Ftx8SWUO_XCHGAP3L1_UGLVm3w@mail.gmail.com>
 <20210303074841.me5egjpecebrpxc4@pengutronix.de>
 <CACGOs=SOxiN1PKhZvhTizH92vneKUOfjxL+9fg4-=JmHHgYtNw@mail.gmail.com>
 <20210303080825.lcpphr2ihvuugfl7@pengutronix.de>
 <CACGOs=SSEvb=5AG9a7dSpOuiaq-wX+FLe3NAMEtKcMFdwJx8Pw@mail.gmail.com>
 <20210303083336.4rn47cnzcexk7czq@pengutronix.de>
 <ce8e93fce5e44fa9a4c097d06e3e2be1@HG-SRV-053.HG.local>
 <CACGOs=Ry7DtLooobKzuK7PWLOaWVnawMNTkErKC8e4OJKjNJPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvtpvjrj7pkogzjb"
Content-Disposition: inline
In-Reply-To: <CACGOs=Ry7DtLooobKzuK7PWLOaWVnawMNTkErKC8e4OJKjNJPQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--kvtpvjrj7pkogzjb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 20:46:25, ukrfoil.com, C=D1=82=D1=83=D0=B4=D0=B8=D0=BE=D0=BF=
=D0=B0=D0=BA =D0=A3=D0=BA=D1=80=D0=B0=D0=B8=D0=BD=D0=B0, =D0=92=D0=BE=D1=81=
=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=B3=D0=B8=D0=BE=D0=BD w=
rote:
> You have set IRQ_TYPE_LEVEL_LOW correctly
>=20
> After installation and with the default driver, everything works,
> there is no hang.

\o/

> It looks like I was wrong in my experiments, I was led astray, there
> is a lot of information on the Internet about setting
> IRQ_TYPE_EDGE_FALLING as correct. Therefore, I apologize for the time
> spent solving this problem. Thanks for the help.

No problem!

> data after changing to IRQ_TYPE_LEVEL_LOW
>=20
> root@nanopi-neo:~#cat /proc/interrupts
> >            CPU0       CPU1       CPU2       CPU3
> > 107:          0          0          0          0  sunxi_pio_level  40 L=
evel     spi0.0

This looks consistent.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--kvtpvjrj7pkogzjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA//V0ACgkQqclaivrt
76kfxQf/bQVMYrGQS9qqCnwCiPBu/K4BLeE0XApZ8ZD57z96pBPMxsOiwTLI4Tlt
n8Ghs7rL2DAgVAUd+vONWd6k2cYZqDtjwTCtyGE3fLbIxOuqkd5YvRWvQHbys4ei
P5RmmIVsCjHIB/b/3maLIMSg/VBDrAxJ2R9zq+zbwmeHSnrvz4TAyEPcK8WQdhVM
IBFpC/vHHTUD80uWTBRlzURlPUb2QYULxMl35sXLs5wPmyyTjL0qk+6swa6uF/+N
xvJ4HS7Pa08s9T46bkavFDZiPprG57dgolrNaIFCdyojbmZrNfGWqj14tC0PB8P1
tjPVVgv3Gjou3fqotKOM+TP4uucFOA==
=4209
-----END PGP SIGNATURE-----

--kvtpvjrj7pkogzjb--
