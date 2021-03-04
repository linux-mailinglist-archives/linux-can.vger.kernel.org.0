Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167F732D783
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhCDQR5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 11:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhCDQRo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 11:17:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23811C061574
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 08:17:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHqes-0000z7-LY; Thu, 04 Mar 2021 17:17:02 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3b3:61f5:ff65:ce3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BB4E95EDE37;
        Thu,  4 Mar 2021 16:17:01 +0000 (UTC)
Date:   Thu, 4 Mar 2021 17:17:00 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     kernel@pengutronix.de
Subject: Re: [RFC] can: isotp TX-path cleanups
Message-ID: <20210304161700.csap6diwotihtsuy@pengutronix.de>
References: <20210218215434.1708249-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4s4botiawf64y7sv"
Content-Disposition: inline
In-Reply-To: <20210218215434.1708249-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--4s4botiawf64y7sv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.02.2021 22:54:32, Marc Kleine-Budde wrote:
> Hello
>=20
> we've noticed that "candump -x" on normal CAN ISO-TP traffic shows:
>=20
> | (2021-02-18 14:52:51.643904)  ca0  TX B E  713   [8]  20 0D 0E 0F AA AA=
 AA AA
>=20
> Note here the "B" and "E" flags are set. Another possibility is to use
> skb_put_zero() instead of skb_put(), but with a bigger overhead. A 3.
> option is to only memset() the non-data part of the struct canfd_frame.

Oliver, any opinion this?

I think I'll include this in my next pull request to net/master.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--4s4botiawf64y7sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBBB/oACgkQqclaivrt
76lItwgAjJDYLsl+IOWvC76b1J53IIA2aaiigjD8UCZ3qOSY0mVF602UvZKHq5zE
JxtAb3bmEqXCG9Yg6+PwZqR+pp1CQBPn8PIhB/FioJAuenBhYd3FmGlaSCcbkswd
BHmt6z9s+yQ+R2Kcd1tLffDBH5fGYHGxBddQwK/M/AmrMhwI1EZ++moK08gSf1B4
nk1BDVT7pd+KEzOHj68F72hhK5wINEdCKH8Kf5jMJ5Epmq3XfjU5BMqKyXvha0RC
RLePbnIze5MwYRkURP0RAa9xWoTjvNHhPuDNYOkD2KUhc312mXM0RznmMqaauvym
AyGInOwXXaJYFF+696qHLmF5xh3O8Q==
=/9wP
-----END PGP SIGNATURE-----

--4s4botiawf64y7sv--
