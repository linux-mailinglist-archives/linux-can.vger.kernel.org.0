Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE03E534D
	for <lists+linux-can@lfdr.de>; Tue, 10 Aug 2021 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhHJGOc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 10 Aug 2021 02:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhHJGOb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Aug 2021 02:14:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F525C0613D3
        for <linux-can@vger.kernel.org>; Mon,  9 Aug 2021 23:14:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mDL1Y-0003Mo-4C; Tue, 10 Aug 2021 08:14:04 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:7cab:1919:e0d9:f7cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 86619663BC1;
        Tue, 10 Aug 2021 06:14:02 +0000 (UTC)
Date:   Tue, 10 Aug 2021 08:14:00 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Hussein Alasadi <alasadi@arecs.eu>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: [PATCH] m_can: fixed typo in m_can_set_bittiming() causing
 corrupt DBTP register content
Message-ID: <20210810061400.vns465s4ptkh3bfh@pengutronix.de>
References: <FRYP281MB06140984ABD9994C0AAF7433D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
 <20210809181051.5a7vckphc5mizv2f@pengutronix.de>
 <FRYP281MB06149A25C5C0F55E9AC1B635D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ks5duhwalsgau6nl"
Content-Disposition: inline
In-Reply-To: <FRYP281MB06149A25C5C0F55E9AC1B635D1F69@FRYP281MB0614.DEUP281.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ks5duhwalsgau6nl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.08.2021 20:25:16, Hussein Alasadi wrote:
> Hello Marc,
>=20
> I hope it's in the correct format now.

Thanks for the patch, looks better. However your mailer converts tabs to
spaces. For further contributions try to use "git send-email". I've
applied the patch to linux-can/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ks5duhwalsgau6nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmESGSYACgkQqclaivrt
76myLQf/dJg0k583Wu5cBMs8rOZXHvhcXA6hWrLCM1HkckgwdZY1G/5dUhxIr2HA
PnAItZXN8Iz0Yfxba6Qk2odshldJT7zB4S+WDaE9HeSawF+FXzsmRN3/qiF5ipDT
ZOnESrky3P019RYIbf10ORzyxwGX+/9y0nGYZraZ0AO/BNU8Ho0njgiA3iFOnIva
KJZO8FjCELSphr8s9dNyTOFgAfjrtDyhrkX2g/6Notu4TZ0TQLxiE+iX4xmQWBEy
Iq4YywEjiJp14q11LSvagJgRGElxFdBMWFqp/ymqJWzL8ObLqg7pAxFOKsRgpBXp
wtFZH5t9vHD1K0kYVtyZg/LQk4FYww==
=G4dS
-----END PGP SIGNATURE-----

--ks5duhwalsgau6nl--
