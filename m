Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7F328F76
	for <lists+linux-can@lfdr.de>; Mon,  1 Mar 2021 20:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbhCATwF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Mar 2021 14:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbhCATt7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Mar 2021 14:49:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C12C061756
        for <linux-can@vger.kernel.org>; Mon,  1 Mar 2021 11:49:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lGoXe-0000JN-6S; Mon, 01 Mar 2021 20:49:18 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6e66:a1a4:a449:44cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1755C5EBAEF;
        Mon,  1 Mar 2021 16:58:57 +0000 (UTC)
Date:   Mon, 1 Mar 2021 17:58:56 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     ukrfoil@gmail.com, linux-can <linux-can@vger.kernel.org>
Subject: mcp251x hangs during ifup
Message-ID: <20210301165856.37gvqkomvjkjvbj2@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a4kffyuiczafciuw"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--a4kffyuiczafciuw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

in the armbian forum a problem with the mcp215x was reported:

https://forum.armbian.com/topic/14909-orange-pi-mcp2515-ip-up-freezes/

In the last comment (Posted Saturday at 10:05 PM) Aleksey posted a
mcp251x.c with a workaround. After cleanup the diff looks like this:

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index f69fb4238a65..6d5fcf5a19a2 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1221,7 +1221,7 @@ static int mcp251x_open(struct net_device *net)
        INIT_WORK(&priv->tx_work, mcp251x_tx_work_handler);
        INIT_WORK(&priv->restart_work, mcp251x_restart_work_handler);
-       ret =3D mcp251x_hw_wake(spi);
+       ret =3D mcp251x_hw_reset(spi);
        if (ret)
                goto out_free_wq;
        ret =3D mcp251x_setup(net, spi);

Vincent, it seems the gpio support has broken the driver on some
platforms. Do you have an idea?

Is RUNTIME_PM support now mandatory? So that mcp251x_can_suspend() and
mcp251x_can_resume() are now always called, does the driver break if
those functions are not compiled into the kernel?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



--a4kffyuiczafciuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA9HU0ACgkQqclaivrt
76ndCQf8DQ1fu/O+Q15piYA1ifswQR/9fOmi6qWwHnATzA5zMwYBtNfuPB626npZ
Kwa6UuVsuXLPfFzievXdZNzVZfCOBKBQdsdQdXqURPGdhTU4XRGWL4qTbKOccf9J
2ulnulfeKXs9Qlev/sBPE1e0/W2aTt+eR02dRJ1LTiGl1IungJRidVqZt4Rfm6jC
saRI7vl9w0Ny5R5W5pS1nmsRbKsk1AxBvXc3jw8bWtn4iKtmaFYKjSWbHY8eR51T
V8lyOH+0BTr3G+o2CFFlSbots9HrbLzO0znbXOISky6tQtd5wCHN9+ag81QjP9hv
7QPwARZd1JFbkdAVl2DksNAtT9cICQ==
=2EYt
-----END PGP SIGNATURE-----

--a4kffyuiczafciuw--
