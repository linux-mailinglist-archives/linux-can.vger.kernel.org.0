Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EDA32C598
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 01:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355374AbhCDAXp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 3 Mar 2021 19:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843029AbhCCKYg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Mar 2021 05:24:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15AFC061226
        for <linux-can@vger.kernel.org>; Wed,  3 Mar 2021 00:33:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHMws-000832-OO; Wed, 03 Mar 2021 09:33:38 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:a20d:2fb6:f2cb:982e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 789375ECA89;
        Wed,  3 Mar 2021 08:33:37 +0000 (UTC)
Date:   Wed, 3 Mar 2021 09:33:36 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?dWtyZm9pbC5jb20sIEPRgtGD0LTQuNC+0L/QsNC6INCj0LrRgNCw0LjQvdCw?=
         =?utf-8?B?LCDQktC+0YHRgtC+0YfQvdGL0Lkg0YDQtdCz0LjQvtC9?= 
        <ukrfoil@gmail.com>
Cc:     =?utf-8?B?U2NobMO8w59sZXIs?= Timo <t.schluessler@krause.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: mcp251x hangs during ifup
Message-ID: <20210303083336.4rn47cnzcexk7czq@pengutronix.de>
References: <CAMZ6RqKfXR9cHxjvnPwxjWHWEuxYNV9V4qLSd0ZQGP0JOMKX0w@mail.gmail.com>
 <20210302071901.ptwvejkedascbdsv@pengutronix.de>
 <638520bccd0c44d091d5715fe7d303ec@HG-SRV-053.HG.local>
 <CACGOs=TG4jyXKHBfPGDEJp1gSA+PyNVqCM7grPGMpe9+wYDBLA@mail.gmail.com>
 <20210303072653.zb66tkdlsxtval5n@pengutronix.de>
 <CACGOs=TJhoV99D=V-7xa8LG6Ftx8SWUO_XCHGAP3L1_UGLVm3w@mail.gmail.com>
 <20210303074841.me5egjpecebrpxc4@pengutronix.de>
 <CACGOs=SOxiN1PKhZvhTizH92vneKUOfjxL+9fg4-=JmHHgYtNw@mail.gmail.com>
 <20210303080825.lcpphr2ihvuugfl7@pengutronix.de>
 <CACGOs=SSEvb=5AG9a7dSpOuiaq-wX+FLe3NAMEtKcMFdwJx8Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7w2qdn6u3jdykc32"
Content-Disposition: inline
In-Reply-To: <CACGOs=SSEvb=5AG9a7dSpOuiaq-wX+FLe3NAMEtKcMFdwJx8Pw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--7w2qdn6u3jdykc32
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 10:24:56, ukrfoil.com, C=D1=82=D1=83=D0=B4=D0=B8=D0=BE=D0=BF=
=D0=B0=D0=BA =D0=A3=D0=BA=D1=80=D0=B0=D0=B8=D0=BD=D0=B0, =D0=92=D0=BE=D1=81=
=D1=82=D0=BE=D1=87=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=B3=D0=B8=D0=BE=D0=BD w=
rote:
> I've tried this and that before - the effect is the same, I'll
> double-check it again later.

Thanks.

Timo, can you change the routine to keep the interrupts enabled?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--7w2qdn6u3jdykc32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA/Sd4ACgkQqclaivrt
76mvrAf/UAYVgc9u1G/JFbjQPgoDNXrdc3qMysq4jNpYZce1oIVfcrp1na4CPyu3
79IP7byFc8A9Y4RlaA8o/BRuxEzz4NKtHXlNNieNZ+kILHGBrUwC38t7cwlz+8ui
7u5cAbZ4i1u3xVcyDSKn9QV8XvOphSSAtYFkvuNcBFyGZM+VulcmgajS95JFGRmV
TvxoWKKea2QR1v2lHhzQUwXeEFI7rXEuawCqUFaYxaeRqlWnHFtZ3rAhx17fmliF
MOYebF0+FU9KG/6RJoldy5eUcrOwstHBroBMKKo9+QcZiJINqRBFgd3u/3J91wsw
GNdEgR8r9i6xzHK5Pd4ilWgkTR8yOQ==
=Hj7+
-----END PGP SIGNATURE-----

--7w2qdn6u3jdykc32--
