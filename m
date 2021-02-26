Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FFB326371
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 14:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhBZNkV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 08:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBZNkT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 08:40:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376DC061574
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 05:39:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lFdLG-00009V-3c; Fri, 26 Feb 2021 14:39:38 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:adc1:3ee1:6274:c5d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 41BB25E9BEA;
        Fri, 26 Feb 2021 13:39:37 +0000 (UTC)
Date:   Fri, 26 Feb 2021 14:39:36 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226133936.q3o7hrshyurhj3ke@pengutronix.de>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
 <20210226123144.cwhjberqeyjctc6w@bigthink>
 <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
 <20210226132620.wfuvywkzmhwfmhpc@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76lepmt6nt75pdyp"
Content-Disposition: inline
In-Reply-To: <20210226132620.wfuvywkzmhwfmhpc@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--76lepmt6nt75pdyp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.02.2021 13:26:20, Torin Cooper-Bennun wrote:
> On Fri, Feb 26, 2021 at 01:40:35PM +0100, Marc Kleine-Budde wrote:
> > I think you cannot do (synchronous) SPI from NAPI (which is SoftIRQ con=
text).
>=20
> I see. I now understand why you recommend using mcp251xfd as a template
> for m_can.
>=20
> Am I correct in saying that rx-offload requires RX timestamps to be
> available?

Proper timestamps for RX and TX would be best, but you can use
can_rx_offload_queue_tail() if you don't have any timestamps.

> They can be enabled in M_CAN, but the v3.3 manual states that
> the internal timestamp generation (apparently only option for tcan4x5x)
> cannot be used for CAN-FD.

Can you give me a reference to this?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--76lepmt6nt75pdyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmA4+hUACgkQqclaivrt
76l2TAgAjq4lW5f2piqs+bqADLLi5U2mJwx1l/5Jc8W5c4BxzTURer9+rgNIfF+0
X+aIoHstEXtFHHcs8f17OqCqKFcxwP+OH+veEh03nm1RGABp4shtrfPBjRQHqQR1
Dihyz6zkGNfVKTkm5C3idAmiKTNNqxOg49xIQE/arg1NwHOthl8vcCv780uQHGK2
t0kPFSHhmdv+yejtsnLDhG+u59/k2SSZpn5JpH9HubA3g/e09918+opzKvVwX+Bz
xaJEd5EMtFTZFvSizrmIQm89dP/qADkqvFiYe7l0f0wvltOA1FmD18xxC1b5dZsO
le8nqUCA8a8svbgUB+ZiZIPkohL/DQ==
=L19j
-----END PGP SIGNATURE-----

--76lepmt6nt75pdyp--
