Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE2351055
	for <lists+linux-can@lfdr.de>; Thu,  1 Apr 2021 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhDAHtL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Apr 2021 03:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhDAHtJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Apr 2021 03:49:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6FCC0613E6
        for <linux-can@vger.kernel.org>; Thu,  1 Apr 2021 00:49:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lRs4h-0001zC-3k; Thu, 01 Apr 2021 09:49:07 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3432:3a72:abbc:cd9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6E92160586F;
        Thu,  1 Apr 2021 07:49:05 +0000 (UTC)
Date:   Thu, 1 Apr 2021 09:49:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     coverity-bot <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Subject: Re: Coverity: mcp251xfd_dump_rx_ring(): Memory - illegal accesses
Message-ID: <20210401074904.ucgl4pictqaw6gew@pengutronix.de>
References: <202103311459.93EB7DEBDC@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yqtcshijiunsl7rr"
Content-Disposition: inline
In-Reply-To: <202103311459.93EB7DEBDC@keescook>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--yqtcshijiunsl7rr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.03.2021 14:59:44, coverity-bot wrote:
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20210331 as part of the linux-next scan proj=
ect:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>=20
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>=20
>   None
>     e0ab3dd5f98f ("can: mcp251xfd: add dev coredump support")
>=20
> Coverity reported the following:
>=20
> *** CID 1503585:  Memory - illegal accesses  (OVERRUN)
> /drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c: 190 in mcp251xfd_dump_rx=
_ring()
> 184     static void mcp251xfd_dump_rx_ring(const struct mcp251xfd_priv *p=
riv,
> 185     				   struct mcp251xfd_dump_iter *iter)
> 186     {
> 187     	struct mcp251xfd_rx_ring *rx_ring;
> 188     	unsigned int i;
> 189
> vvv     CID 1503585:  Memory - illegal accesses  (OVERRUN)
> vvv     Overrunning array of 1 8-byte elements at element index 1 (byte o=
ffset 15) by dereferencing pointer "priv->rx + i".
> 190     	mcp251xfd_for_each_rx_ring(priv, rx_ring, i)
> 191     		mcp251xfd_dump_rx_ring_one(priv, iter, rx_ring);

mcp251xfd_for_each_rx_ring is a macro that iterates over all RX rings in
the struct mcp251xfd_priv. It's not pretty (as it uses its arguments
more than once), but it works:

| #define mcp251xfd_for_each_rx_ring(priv, ring, n) \
| 	for ((n) =3D 0, (ring) =3D *((priv)->rx + (n)); \
| 	     (n) < (priv)->rx_ring_num; \
| 	     (n)++, (ring) =3D *((priv)->rx + (n)))

For now there is only one rx ring...

| struct mcp251xfd_priv {
|       [...]
| 	struct mcp251xfd_rx_ring *rx[1];
| 	u8 rx_ring_num;
|       [...]
| }

=2E..and rx_ring_num is initialized as "1".

| 	for (i =3D 0;
| 	     i < ARRAY_SIZE(priv->rx) && ram_free >=3D rx_obj_size;
| 	     i++) {
|               [...]
| 	}
| 	priv->rx_ring_num =3D i;


> 192     }
> 193
> 194     static void mcp251xfd_dump_tx_ring(const struct mcp251xfd_priv *p=
riv,
> 195     				   struct mcp251xfd_dump_iter *iter)
>=20
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):

This looks indeed like a false positive to me.

> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1503585 ("Memory - illegal accesses")
> Fixes: e0ab3dd5f98f ("can: mcp251xfd: add dev coredump support")

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yqtcshijiunsl7rr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBleu0ACgkQqclaivrt
76kzSQf+N/BeFzig+HpeakG1l/24VG7WOzsvlcZ4DVTcBgbopDmuKIHJt+7XcZpT
Qapsc1TAPnNaJx/MdjPELDfjh175QwBqp0Z6Y/5BNIFlkMXA/nBDbYVhT6kcrdLW
ncqda07mr4NqOLw2AOZ/Pp8TRRzLSbtz0u+9BM3KKkGEQ+6YtvvcbklHk9Y0hGfk
B6v6aAw8sSMNNmUxlSBNH2kIElXp9P0AlL527Xo3wIReYlt1tE9Exxcustf3am+u
7LgrBOAT7wEQtJwwRHV7VyEboxLtKzOj7UfrRRRBbgy4EhXgHOjFLBeVDMhuVKSh
rw0IpnhgaaOOp0Lrxur/8PPr0p4S6Q==
=g9ir
-----END PGP SIGNATURE-----

--yqtcshijiunsl7rr--
