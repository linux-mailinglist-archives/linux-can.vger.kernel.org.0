Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E4C330A6E
	for <lists+linux-can@lfdr.de>; Mon,  8 Mar 2021 10:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCHJmT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 8 Mar 2021 04:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhCHJmP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 8 Mar 2021 04:42:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD6C06174A
        for <linux-can@vger.kernel.org>; Mon,  8 Mar 2021 01:42:15 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJCOz-0000wS-Ml; Mon, 08 Mar 2021 10:42:13 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:2b48:a475:d90d:3f7e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9184B5F093C;
        Mon,  8 Mar 2021 09:42:12 +0000 (UTC)
Date:   Mon, 8 Mar 2021 10:42:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v1] can: bittiming: add CAN_KBPS, CAN_MBPS and CAN_MHZ
 macros
Message-ID: <20210308094211.r567jiuvppel5hdf@pengutronix.de>
References: <20210306054040.76483-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aqfdr62vthpfghrb"
Content-Disposition: inline
In-Reply-To: <20210306054040.76483-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--aqfdr62vthpfghrb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.03.2021 14:40:40, Vincent Mailhol wrote:
> Add three macro to simplify the readibility of big bittiming numbers:
                                  readability

>   - CAN_KBPS: kilobits per second (one thousand)
>   - CAN_MBPS: megabits per second (one million)
>   - CAN_MHZ: megahertz per second (one million)
>=20
> Example:
> 	u32 bitrate_max =3D 8 * CAN_MBPS;
> 	struct can_clock clock =3D {.freq =3D 80 * CAN_MHZ};
> instead of:
> 	u32 bitrate_max =3D 8000000;
> 	struct can_clock clock =3D {.freq =3D 80000000};
>=20
> Apply the new macro to driver/net/can/dev/bittiming.c.
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Applied with the typo-fix to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--aqfdr62vthpfghrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBF8XAACgkQqclaivrt
76nUAQf/YkIKo8ieMHrmRbSZS4wwDPFNoUUcDMPO0Jbb899zs5ZTzHLY2UGrmguB
DwwfHxwTuxPy9VlsIPlIHIJ/smc0JcMm52qcW1vCvKZKMSftvUhGNuWgWc4fyErx
J/MKqgrEAoihSQdQe9mSHsG/HycdAqK7+rsbFkAufe/0aLLaFXifP4jFXgsSQAUy
s8GLI3N/oMH3xeCNbFH0M65Hmtb6inehvpxgUq5VvGzWlRDWmYHlGmpJvEHdyhIb
+YZ6pmwzYnqne/FwuHBagHpDXUByoOEq5y66BTpdjuBYz431MroQBqLLBj2Js1Il
BgmmLpgKwqNpUfjioLaCVozATxvhXg==
=k6p9
-----END PGP SIGNATURE-----

--aqfdr62vthpfghrb--
