Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C623A3AC4C2
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 09:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhFRHTf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhFRHTf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 03:19:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9CC06175F
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 00:17:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lu8kj-0003gW-O1; Fri, 18 Jun 2021 09:17:21 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e7d0:b47e:7728:2b24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6CF1263EA2A;
        Fri, 18 Jun 2021 06:57:35 +0000 (UTC)
Date:   Fri, 18 Jun 2021 08:57:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Angelo Dureghello <angelo@kernel-space.org>
Cc:     gerg@linux-m68k.org, wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 5/5] can: flexcan: add mcf5441x support
Message-ID: <20210618065734.vsjx6pvnbqdzmfqe@pengutronix.de>
References: <20210616231652.738027-1-angelo@kernel-space.org>
 <20210616231652.738027-5-angelo@kernel-space.org>
 <20210617130053.yovl3b3p5mn2srnd@pengutronix.de>
 <b6b948f4-dcdb-5f75-9fe8-138de0acf1f7@kernel-space.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nfjyqdm2m6eu7ym3"
Content-Disposition: inline
In-Reply-To: <b6b948f4-dcdb-5f75-9fe8-138de0acf1f7@kernel-space.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--nfjyqdm2m6eu7ym3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2021 00:14:32, Angelo Dureghello wrote:
> On 17/06/21 3:00 PM, Marc Kleine-Budde wrote:
> > On 17.06.2021 01:16:52, Angelo Dureghello wrote:
> > > Add flexcan support for NXP ColdFire mcf5441x family.
> > >=20
> > > This flexcan module is quite similar to imx6 flexcan module, but
> > > with some exceptions:
> > >=20
> > > - 3 separate interrupt sources, MB, BOFF and ERR,
> > > - implements 16 mb only,
> > > - m68k architecture is not supporting devicetrees, so a
> > >    platform data check/case has been added,
> > > - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
> > >    module.
> >=20
> > Please add the mcg5441x to the "FLEXCAN hardware feature flags" table in
> > the driver, and add a new column for the number of mailboxes.
>=20
> need a little help here: where can i find IP version and
> FlexCAN version ? I am 90% sure mcf5441x is FlexCAN2 (no FD).
> No trace of IP version in the datasheets.

The normal datasheets don't list the IP version. If you don't work for a
company integrating the flexcan core into a SoC, you probably don't have
access to the "low level" datasheets or the people who can look into
them. So just add a ? for details you don't know.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nfjyqdm2m6eu7ym3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDMQ9wACgkQqclaivrt
76nEOwgAmBG0LF8Sd/bHdfNOEd48Ome4RYnmYV69EoLO576a+LnbJpHdaCzMauMy
ECqujtUX1b04TbZIoM6uNGYYOk1N44sy+XJAqt8Tg8hXSwi5cnS5nVNyW6iLdpmi
JJF0R9KE3Eat+R/SWlNcdCQGQUXnps6vdxnrVHkvMNC8GM2Ku9Xh9AeOZiuRpaj0
jSg6slx8Rqfy3jvmHZJIz7mEVs13gCSu8BRTJx35ehWICatNrj4V2IBZ6iXqAGnD
RlJwbyMakl0RLK6jOhhc47A/rg7zbvcqZq9MRlyahCfN7PHg/51DK2+cKc08P0UI
RK4/YAuia/DvmvOFfRUQRhEapRcttA==
=RTdu
-----END PGP SIGNATURE-----

--nfjyqdm2m6eu7ym3--
