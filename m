Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233DD32639F
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 15:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhBZOBl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 09:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZOBj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 09:01:39 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04327C06174A
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 06:00:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lFdft-00022R-Lt; Fri, 26 Feb 2021 15:00:57 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:adc1:3ee1:6274:c5d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 03D7C5E9C0F;
        Fri, 26 Feb 2021 14:00:55 +0000 (UTC)
Date:   Fri, 26 Feb 2021 15:00:54 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226140054.725kihkdgkmtl3xf@pengutronix.de>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
 <20210226123144.cwhjberqeyjctc6w@bigthink>
 <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
 <20210226132620.wfuvywkzmhwfmhpc@bigthink>
 <20210226133936.q3o7hrshyurhj3ke@pengutronix.de>
 <20210226134522.kd3oxtx3u4ltjxos@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qu6tfvxxvfrnwma2"
Content-Disposition: inline
In-Reply-To: <20210226134522.kd3oxtx3u4ltjxos@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qu6tfvxxvfrnwma2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.02.2021 13:45:22, Torin Cooper-Bennun wrote:
> > Can you give me a reference to this?
>=20
> Here's the manual for 3.3 (annoyingly, I can't find corresponding
> documents for earlier M_CAN versions, and TCAN4550 uses 3.2...)

https://github.com/hartkopp/M_CAN-User-Manual-History

> http://www.bosch-semiconductors.com/media/ip_modules/pdf_2/m_can/mcan_use=
rs_manual_v330.pdf
>=20
> See Section 2.3.9, "Timestamp Counter Configuration (TSCC)". Quote:
>=20
>     Note: With CAN FD an external counter is required for timestamp
>     generation (TSS =3D =E2=80=9C10=E2=80=9D)

I suggest to check on the tcan hardware, what's really in the register.

Marc=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qu6tfvxxvfrnwma2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA4/xQACgkQqclaivrt
76kOgAf/cKl9HqyMVS4aukOitHfCD1P6jgzlYm3wVTksjSt55UvRfOaHWLrYH1sk
rclpNPPsXS39Ode9kHt30lIgSoJ4QKjBPLXXkm+CLlxoAzXPmmg16tu2MVEB6yxs
bTpO6qBlxVLehtOF+5BP7tUX9f7T0dOxv2lV0IQlSKWf6C8zp7KPMJXUyTFZGxRX
oAtEcVoa5336uKHKJZO7t4LLgMlLzyNc54WG6d/21vq4y61WBMutiS+uwNa3dzhN
CG/APvYYaxQ3O2dAUkQY+QuWa+FJ3BmmFLdYLD9EsbBs/e3kj5AgM68MHTyWY3FR
gQ7U0ph5kza/2733n40Hm+g4GgZACw==
=Z9Rr
-----END PGP SIGNATURE-----

--qu6tfvxxvfrnwma2--
