Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D434177A
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 09:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhCSI0g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbhCSI0W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 04:26:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D640C06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 01:26:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNASb-00054l-0J; Fri, 19 Mar 2021 09:26:21 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:7ffa:65dd:d990:c71d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 22A805FA67A;
        Fri, 19 Mar 2021 08:26:20 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:26:19 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: isotp: tx-path: zero initialize outgoing CAN frames
Message-ID: <20210319082619.hssq4yhkjcxmtkqt@pengutronix.de>
References: <20210318100233.1693-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xw67lren2ps4dsla"
Content-Disposition: inline
In-Reply-To: <20210318100233.1693-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xw67lren2ps4dsla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.03.2021 11:02:33, Oliver Hartkopp wrote:
> Commit d4eb538e1f48 ("can: isotp: TX-path: ensure that CAN frame flags are
> initialized") ensured the TX flags to be properly set for outgoing CAN fr=
ames.
>=20
> In fact the root cause of the issue results from a missing initialization=
 of
> outgoing CAN frames created by isotp. This is no problem on the CAN bus a=
s the
> CAN driver only picks the correctly defined content from the struct
> can(fd)_frame. But when the outgoing frames are monitored (e.g. with cand=
ump)
> we potentially leak some bytes in the unused content of struct can(fd)_fr=
ame.
>=20
> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

What about skb_put_zero(), which I mentioned in my initial cover letter:

>> Note here the "B" and "E" flags are set. Another possibility is to use
>> skb_put_zero() instead of skb_put(), but with a bigger overhead. A 3.
>> option is to only memset() the non-data part of the struct canfd_frame.

http://lore.kernel.org/r/20210218215434.1708249-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xw67lren2ps4dsla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBUYCcACgkQqclaivrt
76miuwf/XBHLd1zxPWkw7gh38HNgXfbiF7KeBhmH4u+PgJ2Iml1wfYGfXtyNFoib
UEOK8sjMh3nTnl9C78kqGvIy/6ueCBfiGX3gWEKPq1zgYT9ox7utSMG2l542P/Vf
o2fz+N7nW0ICivaDm3lZ2iS6Cxt56Heqv70n7/jBLR85YhTuMdnEq9Z/A3OerDsE
MILhoFxRikORicz96/wczlR+8Rg4ruwpePAwDbmUp/JsVuoMX4guoVAAMwH0NFAz
hqjoo3gH4OfLNqfSS5Ig40h2Tu7Kl0wkPpczMTeE2MVnTHOhUUy6w1zLrYbNEs2n
gqu6ovpPNwuViWka7M5sNkq6FXHuVg==
=0Bzv
-----END PGP SIGNATURE-----

--xw67lren2ps4dsla--
