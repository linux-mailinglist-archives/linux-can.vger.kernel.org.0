Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8112F4886DD
	for <lists+linux-can@lfdr.de>; Sun,  9 Jan 2022 00:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiAHXQ7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Jan 2022 18:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiAHXQ6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Jan 2022 18:16:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C67EC06173F
        for <linux-can@vger.kernel.org>; Sat,  8 Jan 2022 15:16:58 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n6KxE-0005I0-PO; Sun, 09 Jan 2022 00:16:56 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-6624-65e0-1d16-9a67.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6624:65e0:1d16:9a67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 26A756D3B9C;
        Sat,  8 Jan 2022 23:16:56 +0000 (UTC)
Date:   Sun, 9 Jan 2022 00:16:55 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Brian Silverman <bsilver16384@gmail.com>
Cc:     "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can: gs_usb: Zero-initialize flags
Message-ID: <20220108231655.oqzfap5yvh5xdumm@pengutronix.de>
References: <20220106002952.25883-1-brian.silverman@bluerivertech.com>
 <20220108222904.plwxywgmnwrwpvmt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="efkvohdywvv2ha5m"
Content-Disposition: inline
In-Reply-To: <20220108222904.plwxywgmnwrwpvmt@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--efkvohdywvv2ha5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.01.2022 23:29:04, Marc Kleine-Budde wrote:
> On 05.01.2022 16:29:50, Brian Silverman wrote:
> > No information is deliberately sent here in host->device communications,
> > but the open-source candleLight firmware echoes it back, which can
> > result in the GS_CAN_FLAG_OVERFLOW flag being set and generating
> > spurious ERRORFRAMEs.
> >=20
> > Signed-off-by: Brian Silverman <brian.silverman@bluerivertech.com>
>=20
> Applied to linux-can/testing + opened an issue on github:
> https://github.com/candle-usb/candleLight_fw/issues/87

BTW: Your brian.silverman@bluerivertech.com address fails:

| brian.silverman@bluerivertech.com
|  host aspmx.l.google.com [2a00:1450:400c:c0c::1a]
|  SMTP error from remote mail server after RCPT TO:<brian.silverman@blueri=
vertech.com>:
|  550-5.2.1 The email account that you tried to reach is disabled. Learn m=
ore at
|  550 5.2.1  https://support.google.com/mail/?p=3DDisabledUser o10si193022=
3wrh.555 - gsmtp

Should I change the author's email address to your gmail address?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--efkvohdywvv2ha5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHaG2QACgkQqclaivrt
76mc8Qf/dlNYXHHpa4hrtPQXYNHOpYsXH4wZAVHC1Drxszf4THcsoNOeYGIJVYpg
l/WXdqWNkvPqrrwg9byafbqps2NSm9iZh1d51MjQR4xH5zbMR1tjBM/zdAlkrksm
Ni0GBY0KaieCzmdGyyphiWqXhOuGdD9tTpzXO4W63ecE2aWxhNUGJnQYROC6M/bx
nZTynagxY+1G5qxNduRz+rZTxp4ANX8lYTBO7nfuYKSwPDGqIifdfwRcfXt/XeND
I1tKya2S/j3BniZhkbZZkxLFGHw/gqu7I2PaanfJyKWxpQ+9yKm/c9pQQULxbHzn
YznTkq5KM+b8dUvVoXUMn/scf6e/ow==
=ZwS4
-----END PGP SIGNATURE-----

--efkvohdywvv2ha5m--
