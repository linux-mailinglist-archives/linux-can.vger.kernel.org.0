Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D443AC6D4
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhFRJNY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFRJNY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 05:13:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D3BC061574
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 02:11:15 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1luAWv-0008DH-P9; Fri, 18 Jun 2021 11:11:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e7d0:b47e:7728:2b24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2244663EB9F;
        Fri, 18 Jun 2021 09:11:13 +0000 (UTC)
Date:   Fri, 18 Jun 2021 11:11:12 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 2/2] can: netlink: clear tdc if fd is turned off
Message-ID: <20210618091112.oi4ozyznneeabhan@pengutronix.de>
References: <20210618081904.141114-1-mailhol.vincent@wanadoo.fr>
 <20210618081904.141114-3-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fatktjyg7x6si3tc"
Content-Disposition: inline
In-Reply-To: <20210618081904.141114-3-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--fatktjyg7x6si3tc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2021 17:19:04, Vincent Mailhol wrote:
> When the FD is turned off through the netlink interface, the value

values

> still remain in struct can_tdc and are displayed despite of the
> feature being disabled.
>=20
> This patch clears priv->tdc whenever FD is set to off. This way, the
> TDC variables are not displayed anymore.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Hi Marc,
>=20
> I would suggest to squash that into commit 5eb2cd8e2ded ("can:
> netlink: add interface for CAN-FD Transmitter Delay Compensation
> (TDC)").

Will do.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--fatktjyg7x6si3tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDMYy4ACgkQqclaivrt
76k5cAgAhdI76Z9b2qzl8EBW4FeQnxcIGA9yrNeH48Z8NSlmptDKPdFHVeFYkN9P
ZZkNkTZlg7apcfJruszyQrnYOEujSkXmTpi8eOzvurkW8ztS2+XbR3LhVmD75J6x
GHXcZQGJlPhXxw6crHtrW4xnDT1CjKOnRsU3yhV6sPuGiVPdfyib9E5CuDT30DLX
gpsu9kSxuycOMMR+sko2hRjJQ0Jy1xHQy4JLViGedXmVJU/dme3yTCQZzNJmDVRF
N3tsJVY2JbAryafeX3Q9TbKMxqYe4uxoFXsigYOzCPrQ1ZfVpQhh8M0Mb5yqMODW
PueufBRaCtKoQ/eYRWqWYRVXtyXXnw==
=IUy+
-----END PGP SIGNATURE-----

--fatktjyg7x6si3tc--
