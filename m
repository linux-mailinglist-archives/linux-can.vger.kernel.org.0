Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B9485104
	for <lists+linux-can@lfdr.de>; Wed,  5 Jan 2022 11:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiAEKTD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 Jan 2022 05:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiAEKTB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Jan 2022 05:19:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9BCC061399
        for <linux-can@vger.kernel.org>; Wed,  5 Jan 2022 02:18:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n53Nd-000533-8p; Wed, 05 Jan 2022 11:18:53 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-7899-4998-133d-b4b9.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7899:4998:133d:b4b9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9A6ED6D1855;
        Wed,  5 Jan 2022 10:18:52 +0000 (UTC)
Date:   Wed, 5 Jan 2022 11:18:51 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: flexcan: add ethtool support to change
 rx-fifo setting during runtime
Message-ID: <20220105101851.ydeziz5idlaqkhkt@pengutronix.de>
References: <20220104154133.848784-1-mkl@pengutronix.de>
 <20220104154133.848784-4-mkl@pengutronix.de>
 <CABGWkvrH2DGx2e9a0jAJycQPCW67vZiOstjt-SK=LcpS0kyd5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eiwjd73642rth65v"
Content-Disposition: inline
In-Reply-To: <CABGWkvrH2DGx2e9a0jAJycQPCW67vZiOstjt-SK=LcpS0kyd5Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--eiwjd73642rth65v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.01.2022 09:22:09, Dario Binacchi wrote:
> > +static u32 flexcan_get_priv_flags(struct net_device *ndev)
> > +{
> > +       const struct flexcan_priv *priv =3D netdev_priv(ndev);
> > +       const u32 quirks =3D priv->devtype_data.quirks;
> > +       u32 priv_flags;
>=20
> u32 priv_flags =3D 0;

Fixed.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--eiwjd73642rth65v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHVcIkACgkQqclaivrt
76mAZwf8CmOK6aRq8oCTP0v+X/zsXvIfKv5BFgWH9xQE+74rV64/TuQIHgfRROi9
9St/jxpzg9uoWjugWMIqhwVpcwva1tE9zqwy2o3k85yi+Fy9Sr9KOB2xGw7YYDk3
Rq9eYzOfK6VcXDag7MkUynf74nW9+/JJfzgUG39Ot1CFOVg06D2ESIT7djNo1HxN
pRsWhxC7dJwn4t/5AM3n04UkUihBYdp5P0hJGUsQrcp6bsmg2e4fddO6OinCP+QS
UXjQhPVYCSiSb43apIxhyn0/Wfsx0SrF/JG3stGo66u8QteG8Dd6oHtPvp7lZDnC
m9lUTILM6IEJE8Fjeur8LTje3lMSlw==
=anJG
-----END PGP SIGNATURE-----

--eiwjd73642rth65v--
