Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0983AC85F
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 12:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhFRKHq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 06:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhFRKHp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 06:07:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C7C061574
        for <linux-can@vger.kernel.org>; Fri, 18 Jun 2021 03:04:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1luBMW-0007YL-ND; Fri, 18 Jun 2021 12:04:32 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:e7d0:b47e:7728:2b24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9428663EC5D;
        Fri, 18 Jun 2021 10:04:31 +0000 (UTC)
Date:   Fri, 18 Jun 2021 12:04:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Thomas Wagner <thwa1@web.de>
Cc:     larssusaas@gmail.com, linux-can@vger.kernel.org
Subject: Re: libsocketcan: Setting CAN FD data bitrate
Message-ID: <20210618100430.jrrahnmczmnd2mc6@pengutronix.de>
References: <002c01d7641b$cd80bda0$688238e0$@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fltp5lnjv76frgue"
Content-Disposition: inline
In-Reply-To: <002c01d7641b$cd80bda0$688238e0$@web.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--fltp5lnjv76frgue
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.06.2021 10:27:40, Thomas Wagner wrote:
> Hello Marc and Lars,
>=20
> I have been searching for a possibility to set the CAN FD data bitrate
> with libsocketcan recently and came across this [1] old thread.
>=20
> It seems like there has never been a final patch?  If this is the case I
> will look into it myself but I wanted to make sure there is no other
> solution already present beforehand.

As far as I know, there isn't any other solution.

> [1] - https://marc.info/?l=3Dlinux-can&m=3D153418949026459&w=3D2

Feel free to pick up the discussion.

For the record: The thread starts at:
https://lore.kernel.org/r/68f4de55-c98a-3081-a2fe-084e01df73b8@gmx.de

regards
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--fltp5lnjv76frgue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDMb6wACgkQqclaivrt
76na5gf+OY4AQeFqMUaFstoY46uFIkaWSnvTyQ0o/F0Jb0YiTGsDT1JlfjZKu4uC
ax1913aholMlj73OnrxsteQu9yO4ptQAO9vuEk7bzVom/SuKfUFlAf9ft+W7MypX
0VCa4q0F9d2izJDNU91iEzzPxRdAh0Ym/sPRSMMEPCjiSknswVWgQjw5Lm/HH237
vJ7n67CXpe3Ugkc0scTe5Zc7MsJ/xyNlg/64va7Oh6CPv/KMyMFnr3XMs9BCHMzx
c6vxDWHoC4kGdlUv8eTcf9xjGs6CTBfLrLFawUCSuQkYgp03BkkHgZpAcn5sDbhi
6D5DEqQJQuqoVeprUd0jLD/l+fKHGA==
=6dkU
-----END PGP SIGNATURE-----

--fltp5lnjv76frgue--
