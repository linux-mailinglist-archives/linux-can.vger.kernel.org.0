Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B516132652B
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBZQCZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 11:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhBZQCU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 11:02:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84A2C06174A
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 08:01:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lFfYf-0007uj-6K; Fri, 26 Feb 2021 17:01:37 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:adc1:3ee1:6274:c5d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 38DFF5E9D41;
        Fri, 26 Feb 2021 16:01:36 +0000 (UTC)
Date:   Fri, 26 Feb 2021 17:01:35 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226160135.w43onb3z25xhv4re@pengutronix.de>
References: <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
 <20210226123144.cwhjberqeyjctc6w@bigthink>
 <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
 <20210226132620.wfuvywkzmhwfmhpc@bigthink>
 <20210226133936.q3o7hrshyurhj3ke@pengutronix.de>
 <20210226134522.kd3oxtx3u4ltjxos@bigthink>
 <20210226140054.725kihkdgkmtl3xf@pengutronix.de>
 <20210226152633.dkro7ffhye4c72hb@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cueo5eulstfrflre"
Content-Disposition: inline
In-Reply-To: <20210226152633.dkro7ffhye4c72hb@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cueo5eulstfrflre
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.02.2021 15:26:33, Torin Cooper-Bennun wrote:
> On Fri, Feb 26, 2021 at 03:00:54PM +0100, Marc Kleine-Budde wrote:
> > https://github.com/hartkopp/M_CAN-User-Manual-History
>=20
> Great, thanks. I can see this also sits in the linux-can repo which is
> handy.
>=20
> > >     Note: With CAN FD an external counter is required for timestamp
> > >     generation (TSS =3D =E2=80=9C10=E2=80=9D)
> >=20
> > I suggest to check on the tcan hardware, what's really in the register.
>=20
> I've just verified that internal timestamping works on the TCAN4550 (in
> both RX FIFO and TX event FIFO), with FD and BRS both enabled. The
> 16-bit timestamps are generated specifically from the nomimal bit times,
> and you can prescale up to 16x. \o/

NICE! \o/

> Is timestamp-wrapping a concern for rx-offloading?

No, as long as you provide a proper u32 timestamp, which means wrap
around at 0xffffffff to 0x0. As the tcan4x5x has only a 16 bit
timestamp, shift it to full 32 bit, like this:

https://elixir.bootlin.com/linux/v5.11/source/drivers/net/can/flexcan.c#L805

On the mcp with true 32 bit timestamp there's a wraparound every 107
seconds at 40 MHz external clock (0xffffffff / 40000000).

The tcan has the TSS.TCP as a prescaler and increments in bit time,
which is 5MHz max. This results in a wrap around every 13ms (0xffff /
5000000) with a prescaler of 1. With a prescaler of 16, you can increase
this to 209ms (0xffff / 5000000 * 16), which gives an accuracy of 2
bytes.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cueo5eulstfrflre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA5G1wACgkQqclaivrt
76lk1Qf+I4TmC3Rjj3qfsKmaRtJrTnVNiPB7T4V0zoHqBx+VGriavBb57LIUDXnO
qJQxtMe8pfF2vFpm2l53YSyRAwIR1dEs8lRms/ctsv9oOTahnpnYKzgFrVCMdA3J
z+6OQTXWwYV19hD5qObgOhF02n3EGU7Svrbk5OB4xJj0bimze8NdV6WayC7BbUXP
oRQmwjY4vAeqQfSVKaMUG4CFUuG9pG2Ml8nyDFQ2ZmIR5gzx4NjqLPOszsSytzqy
HFsZ7OG8z0Bqjkg/DIxbwBFITiuLb2vD5hvGtv8W0DLFziEyhg0II1ARcCjotgBL
dPj7wzCLH48f+vZEqlulTEOk4GgwCg==
=1A10
-----END PGP SIGNATURE-----

--cueo5eulstfrflre--
