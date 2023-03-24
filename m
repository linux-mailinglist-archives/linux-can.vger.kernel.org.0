Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC06C835C
	for <lists+linux-can@lfdr.de>; Fri, 24 Mar 2023 18:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCXR35 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Mar 2023 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCXR34 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2023 13:29:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732667EF3
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2023 10:29:55 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pflEf-0007bW-Ty; Fri, 24 Mar 2023 18:29:53 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D682919BAB8;
        Fri, 24 Mar 2023 17:29:52 +0000 (UTC)
Date:   Fri, 24 Mar 2023 18:29:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org
Subject: Re: [RFC PATCH v2] can: isotp: add module parameter for maximum pdu
 size
Message-ID: <20230324172951.3zvcujiof7xnh3u7@pengutronix.de>
References: <20230313172510.3851-1-socketcan@hartkopp.net>
 <20230320162406.5mkbvcmyx7nyqvjc@pengutronix.de>
 <c5451b95-5732-b3ed-38f5-1b09e74c0541@hartkopp.net>
 <20230322085633.zwxip56fyr7qqguu@pengutronix.de>
 <a91369b3-9615-4300-a617-e3edbb2c628c@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5ldsmqkmgfkb3z2"
Content-Disposition: inline
In-Reply-To: <a91369b3-9615-4300-a617-e3edbb2c628c@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--s5ldsmqkmgfkb3z2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.03.2023 18:59:04, Oliver Hartkopp wrote:
=2E> > > I've been thinking about some sendfile() implementation too. But t=
his again
> > > would bloat the code and would not solve the rx side.
> >=20
> > I'm not talking about sendfile. Have a look at j1939's
> > j1939_sk_send_loop();
> >=20
> > | https://elixir.bootlin.com/linux/v6.2/source/net/can/j1939/socket.c#L=
1114
> >=20
>=20
> This does not work for isotp like this as you have to handle different bl=
ock
> sizes in the flow control message.

Let this be a task for future us. :)

> > > > what about: ARRAY_SIZE(so->rx.sbuf)
> > > >=20
> > >=20
> > > Looks good. I was just unsure which macro to use ;-)
> >=20
> > You can also use sizeof(so->rx.sbuf).
> >=20
> > ARRAY_SIZE would cause a compile error if you convert so->rx.sbuf to a
> > pointer to dynamically allocated mem, while sizeof() still compiles.
>=20
> so->rx.sbuf is always a static buffer.

Yes, in the current code. I was showing the difference between
ARRAY_SIZE() and sizeof(). ARRAY_SIZE has a bit of type checking, while
sizeof() doesn't - this becomes important once you change the code.

> Only so->rx.buf can point to either so->rx.sbuf or to a dynamically
> allocated memory.
>=20
> But when sizeof() is always safe it would take this for the v3 patch.

Use ARRAY_SIZE().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--s5ldsmqkmgfkb3z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQd3gwACgkQvlAcSiqK
BOi3LwgAjy0T63FpbRpzeh4WzORXDVQSn1qTq31Joo8/ljUQbYPzS6zqownebuZO
6pEz/jvT56dGpeYNV8otcIXq7SnPJrqVjFjE61TqGQQT677JY3L6T1pYyJXmdJrR
Bj8uz5/CNsyvrGp/TnT8jRgD+lY4E2pdxTi0qLasi/GIlVg7UKVX7EMZiX2u9Lt7
Gut540Ozzl3iLt4zwsQp4Omff3IAUOMG3KVYuwQHuqV+COpzniQN9jpuR0hWvLxM
xh52i1PanS6OAbjTjRHLZ97H3AtKgclKO0QbgAhYLu6FPSKyvlOgL+9SPevDhPvm
+1n5Kmp9vQ0sJJ6Os/WYMxcMIwlWkw==
=RA9U
-----END PGP SIGNATURE-----

--s5ldsmqkmgfkb3z2--
