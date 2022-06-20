Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200C15515DF
	for <lists+linux-can@lfdr.de>; Mon, 20 Jun 2022 12:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbiFTK3R (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 20 Jun 2022 06:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiFTK1h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2022 06:27:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F5513F8B
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2022 03:27:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o3Ed3-0005DN-Uq; Mon, 20 Jun 2022 12:27:33 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-e9db-b4a8-ed00-0d4b.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e9db:b4a8:ed00:d4b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4002F99DAE;
        Mon, 20 Jun 2022 10:27:33 +0000 (UTC)
Date:   Mon, 20 Jun 2022 12:27:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: ram initialization on mcp2518fd
Message-ID: <20220620102732.uou37hhhbaspgmb3@pengutronix.de>
References: <e3f73c56-1b46-4ee9-357e-40400c746e09@prevas.dk>
 <87wndgyl2l.fsf@hardanger.blackshift.org>
 <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
 <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
 <20220616124056.cnnvlqwwkknjta7w@pengutronix.de>
 <8db56a87-a1c7-1810-ad74-c7a8e268a00d@prevas.dk>
 <20220617141751.ua3emcdaarrnx7si@pengutronix.de>
 <6e01d1e0-4e26-c42f-5d8d-f5aabe0d9d31@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jhkvsny6l2kgt62h"
Content-Disposition: inline
In-Reply-To: <6e01d1e0-4e26-c42f-5d8d-f5aabe0d9d31@prevas.dk>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--jhkvsny6l2kgt62h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.06.2022 09:09:09, Rasmus Villemoes wrote:
> >> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #=
08!!!
> >=20
> > Update to a newer kernel. In v5.15 this problem is fixed.
>=20
> Oh, great, thanks. I'll try to give 5.15 a quick spin, we're mostly on
> 5.10 because this project started when that was the latest LTS.

We usually start with the latest and greatest kernel when starting a new
project, keep updating and settle for the newest LTS as late as
possible. You don't have anything from LTS if you don't update :) But
that's a different story...

> >> when I start the traffic test. And the dev_id reading still doesn't
> >> work (though it's not really used for anything other than an
> >> informative printk).
> >=20
> > What does it read on your board? But still that transfer should work.
>=20
> Depending on whether the miso pin has been configured with a weak
> internal pull-up or pull-down, it reads either 0xff or 0x00 - and
> that's also the case when I expand the read to all six e00 through e14
> registers. So the chip isn't really driving miso, and I think that's
> because CS is released between the two elements of the xfer array.

Can you do a measurement of that MCP251XFD_REG_DEVID transfer?

For testing I read the OSC register instead of the DEVID and print the
value:

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/c=
an/spi/mcp251xfd/mcp251xfd-core.c
index 537335d42d1d..79de59f9c145 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1796,13 +1796,14 @@ mcp251xfd_register_get_dev_id(const struct mcp251xf=
d_priv *priv, u32 *dev_id,
        xfer[1].len =3D sizeof(dev_id);
        xfer[1].speed_hz =3D priv->spi_max_speed_hz_fast;
=20
-       mcp251xfd_spi_cmd_read_nocrc(&buf_tx->cmd, MCP251XFD_REG_DEVID);
+       mcp251xfd_spi_cmd_read_nocrc(&buf_tx->cmd, MCP251XFD_REG_OSC);
=20
        err =3D spi_sync_transfer(priv->spi, xfer, ARRAY_SIZE(xfer));
        if (err)
                goto out_kfree_buf_tx;
=20
        *dev_id =3D be32_to_cpup((__be32 *)buf_rx->data);
+       pr_info("%s: reg_osc=3D0x%08x\n", __func__, *dev_id);
        *effective_speed_hz_slow =3D xfer[0].effective_speed_hz;
        *effective_speed_hz_fast =3D xfer[1].effective_speed_hz;

And it gives me:

| [  171.051636] mcp251xfd_register_get_dev_id: reg_osc=3D0x68040000

I just noticed the register contents isn't big endian, it's little
endian. I'll send a patch. (The address information is big endian, and
mcp251xfd_spi_cmd_read_nocrc is taking care of this.)

> >> But I'll have to get our hardware guys to help me do some soldering to
> >> capture all four channels at once to see just exactly what is going on
> >> there.
> >=20
> > Have a look at these: https://sensepeek.com/pcbite_20
>=20
> Yup, they're excellent :) My desk: https://ibb.co/LRdtt7Q . However I
> can't really manage to get more than two probes directly on the mcp2518fd.

Nice, you already have them! With some balancing I usually get all 4
signals connected, until someone touched my desk :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--jhkvsny6l2kgt62h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKwS5AACgkQrX5LkNig
013KVwgAmE9h9XLRRTu3UYtlWE3+InrJd+RFLiqahD1OVQAdKZW6FVrfUFgwHRaL
tAkHjjFgKnRMQDjpsB46mwU8V4OD8F9xIx7WXf6bjHNcD20twWPmWRr3+MgsPyuO
PoD9ZMu8e+9bZ3ukiyyioTjSTxhObzitg1Lbj1C016eJ7zizg3azRlNprj/IDwx+
RED5hI6QQCobu2XU2ls/7e+gu4lujW5Xfms+uqmZ5HScplvdow8ToItV2zHtMj2r
9jLZDLweCcpAzJag2dOnsBlGOdySWFmSuDw3XO+xnrao90iJ/2lVNlef4W/2Kfvm
9ggAFHFfW7cnjxT1/2xbzcBucQ3lfQ==
=6E0x
-----END PGP SIGNATURE-----

--jhkvsny6l2kgt62h--
