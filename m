Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1517139702C
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 11:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhFAJUc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhFAJUc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 05:20:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B55C061574
        for <linux-can@vger.kernel.org>; Tue,  1 Jun 2021 02:18:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lo0Xx-0002Be-G5; Tue, 01 Jun 2021 11:18:49 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:f875:cb52:3051:44e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 88DFF6307B7;
        Tue,  1 Jun 2021 09:18:48 +0000 (UTC)
Date:   Tue, 1 Jun 2021 11:18:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 0/5] m_can, tcan4x5x: device-specific interrupt
 handling
Message-ID: <20210601091847.ixsbe4gz4jk7eeeb@pengutronix.de>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526152045.j3efhxqpytixa7tt@pengutronix.de>
 <20210601082107.g6rfrtfpfnjfe43s@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n4usy6k3oh7n6mot"
Content-Disposition: inline
In-Reply-To: <20210601082107.g6rfrtfpfnjfe43s@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--n4usy6k3oh7n6mot
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.06.2021 09:21:07, Torin Cooper-Bennun wrote:
> On Wed, May 26, 2021 at 05:20:45PM +0200, Marc Kleine-Budde wrote:
> > On 26.05.2021 13:47:42, Torin Cooper-Bennun wrote:
> > > TCAN4550 shutdown is attempted by setting the device into standby mod=
e.
> > > There is probably a better way, but I understand we are limited by be=
ing
> > > in the ISR context.
> >=20
> > Not exactly. The tcan's ISR runs in a threaded context, so you can
> > basically do normal SPI or regmap transactions, shut down clocks and
> > regulators, etc...
>=20
> Got you. I keep forgetting that detail!
>=20
> Would it be sufficient to change the CAN state as follows?
>=20
> |	if (handled =3D=3D IRQ_HANDLED) {
> |		netdev_err(cdev->net,
> |			   "Device is disabled by driver.\n");
> |
> |		cdev->can.state =3D CAN_STATE_STOPPED;
> |
> |		err =3D regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> |					 TCAN4X5X_MODE_SEL_MASK,
> |					 TCAN4X5X_MODE_STANDBY);
> |		if (err)
> |			goto exit_regmap_failure;
> |	}

I think there already is a function to stop the m-can core:

| m_can_stop(struct net_device *dev)

You have remove the static to use it from the tcan4x5x, though. If this
function doesn't stop the tcan properly, you might have to add another
callback.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--n4usy6k3oh7n6mot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmC1+3UACgkQqclaivrt
76kupAgArUebbD2UM/HpRjOo1XVH3XDhBBX1D2IXIVQHh/d/xOG5lNzK31HNjJ+4
ztIHNGQZS4vXE7CrSnsM5lnrMC1fhP7WNjSt15F+wjluy8ZXASo+jSqbDaf2DTB/
6/WBBfR+R6qaNeSlyhu9TqYW+cHSFT2v4yX3nomlvYhAN/9u66UmNdxzC3CbnqL3
C4pORXP1RhMeX+hRrNl52hK0dk6RGPhSkID8zAyvlXSjmO0i1u75NluzlzIhMWJk
kkBLGlfBbQD9XdQmlwMYQV7jWpkMSNqPWiAqjb2mWdHKu+92u2OWuiut+QO+S0lC
EaVtfQQIBUlEfEfAWPYhMgwLoNeXFQ==
=6WfT
-----END PGP SIGNATURE-----

--n4usy6k3oh7n6mot--
