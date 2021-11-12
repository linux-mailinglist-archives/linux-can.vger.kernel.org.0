Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2D44E714
	for <lists+linux-can@lfdr.de>; Fri, 12 Nov 2021 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhKLNKj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Nov 2021 08:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhKLNKj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Nov 2021 08:10:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3E8C061766
        for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021 05:07:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mlWHR-0004WL-QI; Fri, 12 Nov 2021 14:07:45 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-de63-3764-bcb9-a107.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:de63:3764:bcb9:a107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F3C906AABAD;
        Fri, 12 Nov 2021 13:07:44 +0000 (UTC)
Date:   Fri, 12 Nov 2021 14:07:44 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can: m_can: m_can_read_fifo, can_fd_dlc2len returns sometimes
 cf->len=0
Message-ID: <20211112130744.gqnnkn67oxwumczq@pengutronix.de>
References: <5215c43f-d208-4bc6-5bd3-3425bc4f107a@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i2vrx7m4vzlw4fli"
Content-Disposition: inline
In-Reply-To: <5215c43f-d208-4bc6-5bd3-3425bc4f107a@photo-meter.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--i2vrx7m4vzlw4fli
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.11.2021 13:11:06, Michael Anochin wrote:
> Hello,
>=20
> I use tcan4x5x over m_can driver with CANFD tcan4450 chip. Sometimes after
> continuous communication I get in dmesg
> tcan4x5x spi4.0 can1: FIFO read returned -22 . After that nothing works.
>=20
> I have followed this behavior up to can_fd_dlc2len and found the followin=
g:
> 1. in m_can.c,=C2=A0 function m_can_read_fifo does
> =C2=A0=C2=A0=C2=A0 cf->len =3D can_fd_dlc2len((fifo_header.dlc >> 16) & 0=
x0F);
> =C2=A0=C2=A0=C2=A0 cf->len =3D 0
> =C2=A0=C2=A0=C2=A0 DIV_ROUND_UP(cf->len, 4)
>=20
> 2. m_can_fifo_read(cdev, fgi, M_CAN_FIFO_DATA, cf->data,
> DIV_ROUND_UP(cf->len, 4)) returns error because val_count=3D0
> 3. Following further chain with val_count=3D0:
> =C2=A0=C2=A0=C2=A0 cdev->ops->read_fifo(cdev, addr_offset, val, val_count=
) ->
> tcan4x5x_read_fifo -> regmap_bulk_read -> ret -EINVAL
>=20
> I can try to look deeper at fifo_header. Perhaps someone has the possible
> cause of this behavior.

It seems the driver break when trying to send CAN frame with 0 length.
First try to reproduce if 'cansend can0 abc#' breaks the driver. Then
check if this patch helps:

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ab4371aa4ff1..4278009c3eea 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -336,6 +336,9 @@ m_can_fifo_read(struct m_can_classdev *cdev,
        u32 addr_offset =3D cdev->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_=
SIZE +
                offset;
=20
+       if (val_count =3D=3D 0)
+               return 0;
+
        return cdev->ops->read_fifo(cdev, addr_offset, val, val_count);
 }
=20
@@ -346,6 +349,9 @@ m_can_fifo_write(struct m_can_classdev *cdev,
        u32 addr_offset =3D cdev->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SI=
ZE +
                offset;
=20
+       if (val_count =3D=3D 0)
+               return 0;
+
        return cdev->ops->write_fifo(cdev, addr_offset, val, val_count);
 }

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--i2vrx7m4vzlw4fli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGOZx0ACgkQqclaivrt
76k1mAf+I8X0q8hwSAgpeVImzNpy9JqIKoVfc78VPm3KD7Dc4yjBwXax49EP1UC0
xg/g69GqYgO5dH0aIOUX/JabyPGfG57fDKRJyNp+fAaMUWAzHPzJI6nP8zBwB1WQ
NnCHT+P5DDH0ESThRvh5PnO85H7dlm65ts50y4RPs8PJsEovYB8bnPNIlak+UhEX
YNwmJYsQFHvNEjggkb6IeAW4IybTrpfSagzlkcJeBf147c/DNeH/VsfbGwpOro0Y
f/wXkf90UPlI6P+CRe1/MNmfH7fZt9WboqjlyOl1RoSqwO2yNOp1CLPLF2T5fWyr
8TgEQHilynk74XK0oK0KBghKDCR9HA==
=ghgh
-----END PGP SIGNATURE-----

--i2vrx7m4vzlw4fli--
