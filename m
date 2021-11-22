Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B0458F68
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 14:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhKVNeI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 08:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhKVNeI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 08:34:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139C5C061574
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 05:31:02 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mp9PH-0004SB-Ej; Mon, 22 Nov 2021 14:30:51 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-c7fb-0fe8-e8cb-8e33.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c7fb:fe8:e8cb:8e33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D01366B2D3B;
        Mon, 22 Nov 2021 13:30:49 +0000 (UTC)
Date:   Mon, 22 Nov 2021 14:30:49 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC v2 4/4] phy: phy-can-transceiver: Add support for
 setting mux
Message-ID: <20211122133049.mlbshta6ksck2ngo@pengutronix.de>
References: <20211122125624.6431-1-a-govindraju@ti.com>
 <20211122125624.6431-5-a-govindraju@ti.com>
 <20211122131221.i3djuarw2ae5lbdk@pengutronix.de>
 <47a0f27f-4d44-cc8f-f2ef-0919f38843bf@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="avg66bt642mchbik"
Content-Disposition: inline
In-Reply-To: <47a0f27f-4d44-cc8f-f2ef-0919f38843bf@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--avg66bt642mchbik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.11.2021 18:50:00, Aswath Govindraju wrote:
> > What about adding a devm_mux_control_get_optional(), which doesn't
> > return a -ENODEV but a NULL pointer if the device doesn't exist?
> >=20
>=20
> I tried adding it in the following manner,
>=20
> +/**
> + * devm_mux_control_optional_get() - Optionally get the mux-control for a
> + *                                  device, with resource management.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * This differs from devm_mux_control_get in that if the mux does not
> + * exist, it is not considered an error and -ENODEV will not be
> + * returned. Instead the NULL is returned.
> + *
> + * Return: Pointer to the mux-control, or an ERR_PTR with a negative err=
no.
> + */
> +struct mux_control *devm_mux_control_optional_get(struct device *dev,
> +                                                 const char *mux_name)
> +{
> +       struct mux_control *mux_ctrl;
> +
> +       mux_ctrl =3D devm_mux_control_get(dev, mux_name);
> +       if (PTR_ERR(mux_ctrl) =3D=3D -ENOENT)
> +                mux_ctrl =3D NULL;
> +
> +       return mux_ctrl;
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_control_optional_get);
> +
>=20
> However the issue is that there is a print in mux_control_get()
>  dev_err(dev, "%pOF: failed to get mux-control %s(%i)\n",
>=20
> which is getting printed, whenever mux-controls property is not found.
> Therefore, I was not sure about how to go about this issue and did not
> implement it.

Ok, this would require more tweaking in the mux layer. Then leave it as
is.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--avg66bt642mchbik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGbm4YACgkQqclaivrt
76kInAf4uEpOfpZiBZBlMCXUyEFrjiLrb5O4rk8Maf8VyIaPVEU5rIfaHdk1Xjz8
Ey8c66bHh4J6fuyPv03rz/HjqcwK14M3aiFMWYWkJ5+FpqGOizgCsRAbSR3u9yWg
Aqwdw4wTYy7I2wwxWE09E5klkYwScrsPFOH2Gg0B5PFS8RFDtAU8ubTOehB1aKB+
hf8NE+qeIgixJMbFgSc8pwPOtZt6w9Zsk522+vIZ86MMYEpo+LN6/VTuEtwrkYPI
X9wl1dmD9AeOkyjKqO9gC4Bplr3q7BDi2xAoWF+XvHxSAhW9EsYXNNZQUy8l8bZ1
Zce3ZUXLA7a5hzHvumr5sPUDbn0i
=kEtH
-----END PGP SIGNATURE-----

--avg66bt642mchbik--
