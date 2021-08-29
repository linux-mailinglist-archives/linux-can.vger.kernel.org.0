Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB63FAE6D
	for <lists+linux-can@lfdr.de>; Sun, 29 Aug 2021 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhH2U3T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 29 Aug 2021 16:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhH2U3S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 29 Aug 2021 16:29:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174EEC061575
        for <linux-can@vger.kernel.org>; Sun, 29 Aug 2021 13:28:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mKRPh-0008PR-Hp; Sun, 29 Aug 2021 22:28:21 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-50d5-102f-5e46-82bb.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:50d5:102f:5e46:82bb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4E70E671B46;
        Sun, 29 Aug 2021 20:28:20 +0000 (UTC)
Date:   Sun, 29 Aug 2021 22:28:19 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Sven Schuchmann <schuchmann@schleissheimer.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can: isotp: omit unintended hrtimer restart on socket
 release
Message-ID: <20210829202819.tdjkhihpewglytn5@pengutronix.de>
References: <20210618173713.2296-1-socketcan@hartkopp.net>
 <DB8P190MB06343614CAD6B48C3EA0EF00D9C99@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <abc23fd0-9bb1-1cc7-fc67-0a3298673b86@hartkopp.net>
 <DB8P190MB0634E1A09E060C9A5A539073D9CA9@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
 <fa1cac52-73aa-b092-0137-2b1ed734f0ee@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="weezsnv3gebq6be4"
Content-Disposition: inline
In-Reply-To: <fa1cac52-73aa-b092-0137-2b1ed734f0ee@hartkopp.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--weezsnv3gebq6be4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.08.2021 22:14:41, Oliver Hartkopp wrote:
> > > IMO the issue arises with the use of isotpsend and isotprecv.
> > > These tools are intended to get a hands-on impression how the isotp
> > > stack works.
> > >=20
> > > This kind of use in a script leads to the creation and (now delayed)
> > > *removal* of isotp sockets for *each* single PDU transfer.
> >=20
> > Maybe I am wrong but I see something different.
> > e.g. without this patch:
> >   (000.000240)  canfd0  714   [8]  2B 01 01 01 01 01 01 01
> >   (000.000261)  canfd0  77E   [8]  30 0F 00 AA AA AA AA AA
> >   (000.000496)  canfd0  714   [8]  2C 01 01 01 01 01 01 01
> >=20
> > and with this patch:
> >   (000.000414)  canfd0  714   [8]  2B 01 01 01 01 01 01 01
> >   (000.000262)  canfd0  77E   [8]  30 0F 00 AA AA AA AA AA
> >   (000.001536)  canfd0  714   [8]  2C 01 01 01 01 01 01 01
> >=20
>=20
> I'm running a 5.14.0-rc7-00011-g6e764bcd1cf7 kernel here and see this:
>=20
>  (000.000001)  vcan0  714   [8]  2B 01 01 01 01 01 01 01
>  (000.000015)  vcan0  77E   [8]  30 0F 00 AA AA AA AA AA
>  (000.000005)  vcan0  714   [8]  2C 01 01 01 01 01 01 01
>=20
> Test iso-tp with 1000 byte frames on vcan0 (data:01)
>     1 / curr:   40 / min:   40 / max:   40 / avg:   40.0
>     2 / curr:   30 / min:   30 / max:   40 / avg:   35.0
>     3 / curr:   35 / min:   30 / max:   40 / avg:   35.0
>     4 / curr:   52 / min:   30 / max:   52 / avg:   39.2
>     5 / curr:   40 / min:   30 / max:   52 / avg:   39.4
> (..)
>=20
> when running your scripts from the initial post.
>=20
> Is you canfd0 interface a real hardware?

I can reproduce the issue here, on an embedded system with a real
hardware CAN interface.

In j1939 we make use of rcu so that we don't need the synchronize_net().
Is it possible to use this is ISOTP, too?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--weezsnv3gebq6be4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEr7eAACgkQqclaivrt
76l/HQf/ah48f0ixX5yWz2+VhkHk+lM6IOiDbEaJgNnhMYu7U2fSdzZMXFTgPfOV
9JU4Aeu/CvFr9zC+CM5gH1hEiFmm062xev38wh9Cnn0HhgTkfV0glgxAJ4h9dySp
3ocpLJ9cFO902DNcWRb8ulf8JLMjxkaQmCrp0WJ1DWmcYG6SgNplv03PBvPb2BpO
ehO+PTFkclGpQqI1G8wiYJjyVQM7AON/G2/WdEXaRzqRVHS3PmTDqFbePj4gHnjo
SvEREgnDB8CdThfSGkl8XiZ0jnCLsKMo7K38mtg2+/8n0BOkgB7usQbseXnVy6Z4
A2m1UVMgqnwMPmTqDy3S95KbuLFtZw==
=SV9F
-----END PGP SIGNATURE-----

--weezsnv3gebq6be4--
