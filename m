Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0F33D76D
	for <lists+linux-can@lfdr.de>; Tue, 16 Mar 2021 16:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhCPPaI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 16 Mar 2021 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbhCPP3x (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 Mar 2021 11:29:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D476C06174A
        for <linux-can@vger.kernel.org>; Tue, 16 Mar 2021 08:29:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lMBdm-0005rO-5L; Tue, 16 Mar 2021 16:29:50 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6392:1248:cd55:3bde])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 052B65F6913;
        Tue, 16 Mar 2021 15:29:48 +0000 (UTC)
Date:   Tue, 16 Mar 2021 16:29:48 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
Message-ID: <20210316152948.eqak6slrs2xf5lc4@pengutronix.de>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-5-mailhol.vincent@wanadoo.fr>
 <20210315155900.a6l5l5aeuvsgn55x@pengutronix.de>
 <CAMZ6RqJyMXzog1mu3S62yMAxJorTg0D5VL5OYKALYRoMxN_DdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2krjvrsoqljuz2hh"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJyMXzog1mu3S62yMAxJorTg0D5VL5OYKALYRoMxN_DdQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2krjvrsoqljuz2hh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.03.2021 00:16:01, Vincent MAILHOL wrote:
> > I just had a look at the ethtool-netlink interface:
> >
> > | Documentation/networking/ethtool-netlink.rst
> >
> > this is much better designed than the CAN netlink interface. It was done
> > by the pros and much later than CAN. :D So I'd like to have a similar
> > structure for new CAN netlink stuff.
> >
> > So I think I'll remove this patch for now from can-next-testing. The
> > kernel internal interface to tdc is still OK, we can leave it as is and
> > change it if needed. But netlink is user space and I'd like to have it
> > properly designed.
>=20
> Understood. However, I will need more time to read and understand
> the ethtool-netlink interface. The new patch will come later, I
> do not know when.

No Problem

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2krjvrsoqljuz2hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBQzukACgkQqclaivrt
76m+ywf+IqLQ5uuANF+LAoKFiDi3MTAkwwvcQkElwMPWOxiHtTOglew7CvltZc9F
DqqtGHNbLG/oOQluKXtjNtcXyM69siCV3WmMuzMuZDdPoXn7HsqMHhcVCkXZ0mtR
by1SwFCOCLo41BiyyCaux6kbqU4inJTwluqBSTp/WpV4PCpi6ZdEOdyFKZ7S1gx1
x/ycJ4OdLhy5Tq4IQF3dDDHK/RcUaBgg/lnCL5nsy33pKRCHNd+mPQLIg58IqaLi
b3NdQJJMr2EqDzgLHYOml+lpCTRIJ9+gr8mxArpN30XUT5+0HWcB+a/Jbn/tNn43
v76Sa4NmPrlsJ0LNd8AA6bO5xOSsKQ==
=AMv4
-----END PGP SIGNATURE-----

--2krjvrsoqljuz2hh--
