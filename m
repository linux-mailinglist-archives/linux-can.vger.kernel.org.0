Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0E3DA2E7
	for <lists+linux-can@lfdr.de>; Thu, 29 Jul 2021 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhG2MOY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Jul 2021 08:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhG2MOX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jul 2021 08:14:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2BAC061765
        for <linux-can@vger.kernel.org>; Thu, 29 Jul 2021 05:14:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m94va-000872-Qb; Thu, 29 Jul 2021 14:14:18 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f664:c769:c9a5:5ced])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0FA9965AE2C;
        Thu, 29 Jul 2021 12:14:18 +0000 (UTC)
Date:   Thu, 29 Jul 2021 14:14:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas Wagner <thomas@the-wagner.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: Write canfd_frame to can interface
Message-ID: <20210729121417.kysljj4636hmhem2@pengutronix.de>
References: <006401d78461$0b868b60$2293a220$@the-wagner.de>
 <20210729105539.ppi7rm6uglwbpyov@pengutronix.de>
 <00a601d78471$9e6f3ca0$db4db5e0$@the-wagner.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnrgxbwa7gq6r3cz"
Content-Disposition: inline
In-Reply-To: <00a601d78471$9e6f3ca0$db4db5e0$@the-wagner.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qnrgxbwa7gq6r3cz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.07.2021 14:02:34, Thomas Wagner wrote:
> Hello Marc,
>=20
> On 2021-07-29 12:55, Marc Kleine-Budde wrote:
> > On 29.07.2021 12:03:56, thomas@the-wagner.de wrote:
> >> Shouldn't the error only be returned if the
> >> canfd_frame I pass has more than 8 bytes when the interface is not in
> >> FD-mode?
> >=20
> > A CAN-2.0 frame with 8 bytes is something different than a CAN-FD frame
> > with 8 bytes. The kernel uses the length of the frame to decide if it is
> > a CAN-2.0 or CAN-FD frame. If your CAN controller has switched CAN-FD
> > off, it cannot send CAN-FD frames, thus you get an error.
> >
> > Does that make sense?
>=20
> Sure!
>=20
> I see how a CAN-2.0 frame with 8 bytes differs from a CAN-FD frame with
> 8-bytes, but when I receive into a canfd_frame I can't differentiate like=
 that
> anymore. In userspace an 8B CAN-2.0 frame and an 8B CAN-FD frame look just
> the same, no matter the interface running with FD on or off.
>=20
> ... which is wrong as I just noticed. Paying attention to the actual byte=
s read
> by the socket I can see the 16 vs. 72B that make up a can_frame vs. a
> canfd_frame respectively. Even when always writing into a canfd_frame.

With the C language the type information of your read buffer doesn't
leave the scope of your function (write() uses a void * for the buffer).
The length information is checked in the kernel, but only if it's large eno=
ugh:

https://elixir.bootlin.com/linux/v5.13/source/net/can/raw.c#L850

> The same differentiation I must make when sending...

ACK - If you an idea how to improve the documentation, let me know!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qnrgxbwa7gq6r3cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmECm5YACgkQqclaivrt
76mJogf+JBJy/U/F9TKUMgMBOifGU0D9MycypsAuBcZiuU4ZGx2LLzdmDjdpGyJ/
EQeKxtJF7hB+e14xDOODGzLzlsG9XcgG2PTqLCqNtPJ/P1lB50hZCIUwCxOuJmIl
PjlHPA3fUdrrgvGer2C3zxexjhtXMRCKoIUv1vAmpztgx/pGSnmEsg1f2Cy7v2nx
QPh/fULVmkrxMTWsuRrct/9aGiwkmTiqBG2j/sFbWUgwy9CrAwvieYZUQbSSSVrf
g039gbAQWq1HrQkvmU+mTga0szbhbseLfqr42NJu1Ye3KkcpFRzjbdcVoDS8CN/G
XfwuSjiMs9Peu1s1DzbJ9CjdRd5kkA==
=5+/e
-----END PGP SIGNATURE-----

--qnrgxbwa7gq6r3cz--
