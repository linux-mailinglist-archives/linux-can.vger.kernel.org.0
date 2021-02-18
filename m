Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C451431E928
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBRLcF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 06:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhBRKd6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2021 05:33:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A239C061788
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 02:23:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lCgSl-00041f-Qe; Thu, 18 Feb 2021 11:23:11 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:30b:bf0c:f6:5da0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 107BF5E3F96;
        Thu, 18 Feb 2021 10:23:11 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:23:10 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     linux-can@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 0/3] can: flexcan: fixes for freeze mode
Message-ID: <20210218102310.g2tttexihncszr52@pengutronix.de>
References: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hvcwknectj56t4ti"
Content-Disposition: inline
In-Reply-To: <20210203100255.12472-1-qiangqing.zhang@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--hvcwknectj56t4ti
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.02.2021 18:02:52, Joakim Zhang wrote:
> Fixes for freeze mode.
>=20
> ---
> ChangLogs:
> V1->V2:
> 	* make use of existing functions flexcan_chip_freeze().
> 	* add patch #1 and #3.
>=20
> Joakim Zhang (3):
>   can: flexcan: assert FRZ bit in flexcan_chip_freeze()
>   can: flexcan: enable RX FIFO after FRZ/HALT valid
>   can: flexcan: invoke flexcan_chip_freeze() to enter freeze mode

Patch 2 is broken, the others look ok.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hvcwknectj56t4ti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmAuQAsACgkQqclaivrt
76mYywf/atguwRUr8XoW9xTtUCjYfizt3qPxnOgbNFDapDrEfbAAe4QpjOfVOvzR
zCIFKT8D1/mxDYBHJnkrfz+ozcD0tcCGE6CpBfnhGkUsyXuIY7fspg8V/5p43zwB
yh3GVf6k541FilAB8vtPyW0DPhKZhtv9k8qIkKHQ9a+dDc22FBE2IHQ/L/bATiAU
5HbmB5wm2u3OJzXVP8mPx/3vVpRLP/fxZSGYdfPD4XfSX/KwCVFntQUDdaInDqnH
aNpWCQ2svLwkpXJ/Fbzrm4Ed9SrPjUoOPYsIeUpwCdN7TIJRSzKQBV+dULQn7tt4
MeIcsBiqjKLjCgAmQr88uyH951s2Wg==
=Dw4R
-----END PGP SIGNATURE-----

--hvcwknectj56t4ti--
