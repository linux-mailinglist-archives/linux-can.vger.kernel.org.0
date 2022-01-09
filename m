Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE44888C0
	for <lists+linux-can@lfdr.de>; Sun,  9 Jan 2022 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiAIKj0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 9 Jan 2022 05:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiAIKj0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 Jan 2022 05:39:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08400C06173F
        for <linux-can@vger.kernel.org>; Sun,  9 Jan 2022 02:39:26 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n6Vbg-0004ol-DH; Sun, 09 Jan 2022 11:39:24 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-a4a9-3301-a0d2-087c.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:a4a9:3301:a0d2:87c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7FBB86D3E2C;
        Sun,  9 Jan 2022 10:39:23 +0000 (UTC)
Date:   Sun, 9 Jan 2022 11:39:22 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Brian Silverman <bsilver16384@gmail.com>
Cc:     "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can: gs_usb: Zero-initialize flags
Message-ID: <20220109103922.db5km3dhy6wjaq5i@pengutronix.de>
References: <20220106002952.25883-1-brian.silverman@bluerivertech.com>
 <20220108222904.plwxywgmnwrwpvmt@pengutronix.de>
 <20220108231655.oqzfap5yvh5xdumm@pengutronix.de>
 <CAP01z6Khm+s=HsdYh0+wUF6H3=mVYkvBE0x_g_Qw745VtNayYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z4wolbdqiu3tp2v4"
Content-Disposition: inline
In-Reply-To: <CAP01z6Khm+s=HsdYh0+wUF6H3=mVYkvBE0x_g_Qw745VtNayYQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--z4wolbdqiu3tp2v4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.01.2022 15:41:57, Brian Silverman wrote:
> On Sat, Jan 8, 2022 at 3:16 PM Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
> > BTW: Your brian.silverman@bluerivertech.com address fails:
> >
> > | brian.silverman@bluerivertech.com
> > |  host aspmx.l.google.com [2a00:1450:400c:c0c::1a]
> > |  SMTP error from remote mail server after RCPT TO:<brian.silverman@bl=
uerivertech.com>:
> > |  550-5.2.1 The email account that you tried to reach is disabled. Lea=
rn more at
> > |  550 5.2.1  https://support.google.com/mail/?p=3DDisabledUser o10si19=
30223wrh.555 - gsmtp
> >
> > Should I change the author's email address to your gmail address?
>=20
> I wrote it as part of my employment by Blue River, but am currently
> moving on to another job. The policy was to have my work email on the
> patch. Seems like the same situation whenever somebody uses a work
> email and then leaves that job, just in this case the timing is
> tighter than common. I think leaving it is best.
>=20
> To be clear, contributing this was definitely authorized by the
> company, I just didn't get around to sending out the patch until
> almost my last day.

Ok. We should map that non working email address to working one, having
non working email addresses in quite annoying when sending patches.

Basically there are two options:

1. Map your old bluerivertech.com address to a new address of yours,
   e.g. your gmail address.
2. Map the bluerivertech.com address to someone else (i.e. a real
   person) or a role account (e.g. kernel@bluerivertech.com).

What do you prefer?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--z4wolbdqiu3tp2v4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHau1cACgkQqclaivrt
76nRoAgAsyGUqCYhtnoP++IYJN1NREGNL/KAbrixVrT+uEsW+pybPF09qlfpmIIy
1LmSqcv5J3XAesxb9wbU838ru8trPZPtT5dwVGXdy402KY8wLTZkzXpb5uM3+egN
9A3ntsSqNcauA1rZnLcfYJ9i5GcX669tLlaeGOBD/n9PpqnMZQynCdgr/GLTqmh9
sXicfEDsJjFDAMBwq+E1JeA9HZZxYQ2xplqLJHr0JMZ/vQ6u+WMJNfjAHFO5pwT8
gE3tydv6fPqauCQxpkbF6g5n5Rhm1uMy4o9wGrqfQ20WJPhvo1dlMApDdrKmmZZm
+FMRmc4kR0Vfhj5xUZd33XK6tua4MQ==
=+wgH
-----END PGP SIGNATURE-----

--z4wolbdqiu3tp2v4--
