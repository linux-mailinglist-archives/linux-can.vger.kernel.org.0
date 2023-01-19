Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204AB673A49
	for <lists+linux-can@lfdr.de>; Thu, 19 Jan 2023 14:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjASNca (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Jan 2023 08:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjASNc2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Jan 2023 08:32:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162657A523
        for <linux-can@vger.kernel.org>; Thu, 19 Jan 2023 05:32:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIV1j-0008F6-NT; Thu, 19 Jan 2023 14:32:23 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7961:17f5:9ae5:1a41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0512D15D414;
        Thu, 19 Jan 2023 13:32:23 +0000 (UTC)
Date:   Thu, 19 Jan 2023 14:32:14 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas.Kopp@microchip.com
Cc:     Stefan.Althoefer@janztec.com, linux-can@vger.kernel.org
Subject: Re: RE: mcp251xfd: rx frame truncation (1/2)
Message-ID: <20230119133214.ofapvfc2rzi3gvn4@pengutronix.de>
References: <FR0P281MB1966C774C1ED0752CCD6B80497C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB1966F32AD422DDD867F8C53A97C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB6484911640CCC738ED799E6FFBC79@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19663A60B0F7CE7F684A7A6297C79@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB64842584529FAEF279F7B137FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
 <FR0P281MB19669083201C1B9C2DFB9E5497C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <FR0P281MB196633E4F8E1195086E2402B97C49@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfolhsfxhcwcbt3s"
Content-Disposition: inline
In-Reply-To: <BL3PR11MB648434F2B7DE7F75E291E159FBC49@BL3PR11MB6484.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--rfolhsfxhcwcbt3s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.01.2023 13:05:02, Thomas.Kopp@microchip.com wrote:
> Are you interrested in analyzing what's going on at those times?

Sure.

> If so, what to do in the driver to stop operation after the message
> has been issued so I can stop the analyzer and sample the chip
> registers?

If you return with an error value, the driver will dump the registers
with devcoredump and disable the IRQs and timestamping:

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/ca=
n/spi/mcp251xfd/mcp251xfd-tef.c
index 0c89e4f33976..8f821ecde69b 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -79,6 +79,8 @@ mcp251xfd_handle_tefif_recover(const struct mcp251xfd_pri=
v *priv, const u32 seq)
                     "not empty" : "empty",
                     seq, priv->tef->tail, priv->tef->head, tx_ring->head);
=20
+        return -EINVAL;
+
         /* The Sequence Number in the TEF doesn't match our tef_tail. */
         return -EAGAIN;
 }

Copy
https://github.com/linux-can/can-utils/blob/master/mcp251xfd/99-devcoredump=
=2Erules
to /etc/udev/rules.d and
https://github.com/linux-can/can-utils/blob/master/mcp251xfd/devcoredump
to /usr/sbin/

You'll find a coredump in /var/log/

> Absolutely interested, yes. I see the not empty cases pretty often as
> well and they shouldn't be an issue. I still can't reproduce the
> buffer full though. I pretty much only look at the raw SPI
> communication when analyzing this. So whatever you can capture on the
> SPI traces for SPI6 would be interesting for me to look at. If
> possible it would be great to capture either CANL or CANH as well.
> Yes, a full dump of the chip registers and RAM help to correlate
> things but in the end it's the pure SPI traces that help find
> problematic timings.
>
> Not sure how much you can log at a time but maybe it's possible to
> check the dmesg log and then kill your testscript and set a GPIO on
> the pi to trigger your logic analyzer to stop acquiring data? That
> would work if the analyzer can keep a couple seconds in a Ringbuffer
> or something.

If you don't want the devcoredump (which reads all chip registers)
comment it out in
https://elixir.bootlin.com/linux/v6.1.7/source/drivers/net/can/spi/mcp251xf=
d/mcp251xfd-core.c#L1578

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--rfolhsfxhcwcbt3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPJRlsACgkQrX5LkNig
011k3AgAhhhyzjNYTHVQMxneEEldaE9EjvzBhkIi25J8u3jM81t03ARVH6UNuuvx
fgJGr6xbTK70vMjEv/c2AW7MVa9eeKKDQWt1qN2kx3ktR9nSZmNRVoulkGR/NxJE
k/KyzynnHnmJjf/hTMmHGUveL/wFYZPx7dGzu0VOz+I8kPHwsI9ANpKe3ey3cviA
8zlYI7bR4LnXRbuvt3RcOHv9HOhVV+W/U6doVTIMWyw9y0e2cHfUmkWHrL07pwy0
mrD4idikYgXP5wFYW/VJdJ7nfmg53F6qwtHfcAlkjpBkMJsykZzuTGwfDSsv/V8d
ouG1B1M1DWVPB0EjE3u+2+f7G+3khA==
=m4SU
-----END PGP SIGNATURE-----

--rfolhsfxhcwcbt3s--
