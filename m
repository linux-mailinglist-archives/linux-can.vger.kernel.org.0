Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743953325E7
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCIM5a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 07:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhCIM5M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 07:57:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD45C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 04:57:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJbvC-0001Fz-GU; Tue, 09 Mar 2021 13:57:10 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 522995F1816;
        Tue,  9 Mar 2021 12:57:09 +0000 (UTC)
Date:   Tue, 9 Mar 2021 13:57:08 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>
Subject: Re: [PATCH v12 1/1] can: usb: etas_es58X: add support for ETAS ES58X
 CAN USB interfaces
Message-ID: <20210309125708.ei75tr5vp2sanfh6@pengutronix.de>
References: <20210308163445.103636-1-mailhol.vincent@wanadoo.fr>
 <20210308163445.103636-2-mailhol.vincent@wanadoo.fr>
 <2b43e72b-c561-d144-c01e-c4ea361cc932@pengutronix.de>
 <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gf6dco2plwpk64c5"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJADCFL_=uv-=hNjiNj+CZkUDNWjLTP3eV010KGj+H49A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gf6dco2plwpk64c5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 21:45:58, Vincent MAILHOL wrote:
> > On 3/8/21 5:34 PM, Vincent Mailhol wrote:
> > > This driver supports the ES581.4, ES582.1 and ES584.1 interfaces from
> > > ETAS GmbH (https://www.etas.com/en/products/es58x.php).
> > >
> > > Co-developed-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosc=
h.com>
> > > Signed-off-by: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.=
com>
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > I'm not sure if you're supposed to change dql.min_limit from the driver.
>=20
> One thing for sure, I am the only one to do it.
>=20
> The reason to do so is because benchmarks show me that values
> below this threshold are not good for this device (and I try to
> be very permissive on the values).
>=20
> USB introduces a lot of latency and the small PDU of CAN does not
> help. The BQL is here to remediate, however, the algorithms can
> take time to adjust, especially if there are small bursts.
> Modifying the dql.min_limit was the only solution I found to make
> sure that packets can be sent in bulk even during small burst
> events.
>=20
> The BQL was not designed for USB nor was it designed for CAN
> which probably explains why I am the first one to ever have
> thought of using dql.min_limit like this.

We can try to sneak it into the kernel or ask on the net-dev list for a
proper interface[1] for setting sensible defaults to the min_limit.

> Using dql.min_limit is a hack and I pledge guilty for it. However,
> because this hack brings performance improvement, I would like to keep
> it if you do not mind.

Your explanation is very good and clear, what about sending new mail
with this problem description to the netdev list? A proper solution
might be something like dql_set_min_limit() with a static inline no-op
of BQL is disabled.

Looking at 114cf5802165 ("bql: Byte queue limits"), you want to include:
- Tom Herbert <therbert@google.com>
- Eric Dumazet <eric.dumazet@gmail.com>

Marc

[1] Having ifdefs to set the value in the driver is clearly a sign of
some misuse :)

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gf6dco2plwpk64c5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHcKAACgkQqclaivrt
76knzAf+LIG7ZwF7ufHcPRU6C0wftUF4XLd++5PR+WSpY/+0saNoki0LjBcOzIH+
ql4ItZ8/pFM8/VS4mCKuN7nGRexjV99+kHYrqJMu3x8QD2J93rjIdXiUMt4IyBBp
kJSCrZZUM1M1rL4mje5cxYCaT7Iu4SCAYlQEVP9sJYXtxchOGIMB/HGOgPjkdaJb
bbIpQu98xqv6OjJCoucVMNYOyIW8+MZPK790PeWH/xkiK1QKvl0eENvO8e9bcmvX
vK+eEVVBDJCGn0B6Ny5dBmfJ2bjmL0VTke1k+8Dp1StxxpcZuq5193szh/pFjJW8
cIGjOuTWnWYIR6PFe8dpYyVp8YURgg==
=tvqS
-----END PGP SIGNATURE-----

--gf6dco2plwpk64c5--
