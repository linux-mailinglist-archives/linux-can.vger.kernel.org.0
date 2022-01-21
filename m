Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98908495C53
	for <lists+linux-can@lfdr.de>; Fri, 21 Jan 2022 09:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiAUItk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 21 Jan 2022 03:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiAUItk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 21 Jan 2022 03:49:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCC2C061574
        for <linux-can@vger.kernel.org>; Fri, 21 Jan 2022 00:49:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nApc0-0000Va-Ad; Fri, 21 Jan 2022 09:49:36 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 295411EEB7;
        Fri, 21 Jan 2022 08:49:35 +0000 (UTC)
Date:   Fri, 21 Jan 2022 09:49:31 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: mcf5441x: flexcan FIFO and mailbox mode (was: Re: [PATCH v5 5/5]
 can: flexcan: add mcf5441x support)
Message-ID: <20220121084931.llxryhizdaeb4ph4@pengutronix.de>
References: <20220106111847.zjkrghehxr7mrkkt@pengutronix.de>
 <1cf937d1-1e26-e611-c85f-f9e2128c225@kernel-space.org>
 <20220119063837.idsiq72xrv4fvtih@pengutronix.de>
 <9ea16c48-b4bc-0c1-13c8-85e985ab86b1@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tywnvm2cgr5g4hev"
Content-Disposition: inline
In-Reply-To: <9ea16c48-b4bc-0c1-13c8-85e985ab86b1@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--tywnvm2cgr5g4hev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.01.2022 00:35:43, Angelo Dureghello wrote:
> > Please apply appropriate change and check if the driver still works if
> > you RX with full CAN bus load. Please also test if you can still receive
> > RTR frames.
> >=20
>=20
> I tested this patch:
>=20
> -------------------- drivers/net/can/flexcan/flexcan-core.c index
> 0bff1884d5cc..daeeb6250347 100644
> @@ -296,7 +296,10 @@ static_assert(sizeof(struct flexcan_regs) =3D=3D  0x=
4 * 18
> + 0xfb8);
>  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>  		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
> -		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
> +		FLEXCAN_QUIRK_USE_RX_MAILBOX |
> +		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO |
> +		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
> +		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
>  };
>=20
>  static const struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
>=20
> Bus load PC -> mcf5441x tested by
>=20
> ip link set can0 type can bitrate 1000000
> ip link set can0 up
> cangen can0 -g 0
>=20
> On target (mcf54415)
> candump can0
>=20
> It works, even better then FIFO mode.

What's the difference, does it produce less overruns?

> While unfortunately, RTR rx does not work. Tested it by putting
> a trace in flexcan_mailbox_read()
>=20
> 	if (reg_ctrl & FLEXCAN_MB_CNT_RTR) {
> 		printk("%s() RX RTR frame\n", __func__);
> 		cfd->can_id |=3D CAN_RTR_FLAG;
> 	}
>=20
> on host pc i used:
>=20
> cangen can0 -R
>=20
> No sign of RTR in rx. While in FIFO mode i can see it.

Ok, then I enable the mailbox support for the mcf5441x and fix the note
that the IP core doesn't support RTR reception via mailboxes. See the
following patch:

| https://lore.kernel.org/all/20220121084425.3141218-1-mkl@pengutronix.de

If you have time, please test and add your Tested-by.

You can switch to mailbox mode during runtime, if the interface is down:

| ethtool --set-priv-flags can0 rx-rtr off

With ethtool you can query the number of used RX and TX buffers:

| ethtool --show-ring can0

The FIFO mode uses 6 RX buffers, while mailbox mode will probably use
14.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tywnvm2cgr5g4hev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHqc5gACgkQqclaivrt
76m4uAgAjiiSGq36HKijDuq23TwRak0vWlaoSG4J+4+LRpbVWGs5G5+QCdeahtlK
HUfvavApuJmI47DoWjuDR1TSvS1hPmoJ76w/jesel4kcmwZqM/TI16JuTJIg2Z/j
lAz5v7WoAtGGsHVVVsrZ3WnoHvCM8Icqlo2RjZ3k7EB4wF3XiEKCw3+dmoD0vOzF
e+2hAsgQ0GVwsGGeQYwPP92f2q85hAhcay3y63Pzp0qUKf7Q+EhGUcTOkWLJocDe
4uZEACD6RVpaK+jBG8oV8v5Avvq+e4oPsP97A7j/HlHHelB7gOM7g8tbsJM/6jWC
iUFZRczVyLQYeksi/c+ZrINENNFe+w==
=ob2y
-----END PGP SIGNATURE-----

--tywnvm2cgr5g4hev--
