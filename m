Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536F6332970
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 16:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCIO7f (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 09:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCIO7E (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 09:59:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F3CC06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 06:59:04 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJdp7-0003el-PS; Tue, 09 Mar 2021 15:59:01 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9D8D65F1A97;
        Tue,  9 Mar 2021 14:59:00 +0000 (UTC)
Date:   Tue, 9 Mar 2021 15:58:59 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Message-ID: <20210309145859.5n62dqchool4i7ji@pengutronix.de>
References: <PA4PR03MB67977F22B9373573ABD62A59D6929@PA4PR03MB6797.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oxpt4ukqg3mb476v"
Content-Disposition: inline
In-Reply-To: <PA4PR03MB67977F22B9373573ABD62A59D6929@PA4PR03MB6797.eurprd03.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--oxpt4ukqg3mb476v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 14:53:36, St=C3=A9phane Grosjean wrote:
> In the usb drivers, the echo skb is always released by the USB write
> complete callback.

This means there will be an echo_skb_get() when the USB write completes,
which is usually before the CAN controller sends the CAN frame.

This means a TX complete or an TX abort due to one shot mode will not be
reported?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--oxpt4ukqg3mb476v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHjSoACgkQqclaivrt
76kLzAf+IDznwBt4RiGsr3PiEigdVo+WtOcntHCyigD+vspabHYZsX9snkPua7Rn
qUaTfVbAsxjyzAHhjwQHTvzQa9Ryz8Kp0g7prIPHmwIngsQZWJ1QJIloiLnOHKa/
BWk4X1uWs4RdL/i/iYhNguz/v+gRdAqIa2uijMCchkULL132UmhYu6RdkA534R1M
x8tQ2DCCtrACHr2FA2vKRBBdClhoDVIx0cMqjKaIgsuX7xPKYLW0lcgeEZcJWkEV
/5a61HYNM8vFYCcGplIs2HUFNDMuLVv5cwixyzhDd8/gBpyju832fkvm1PghduwJ
AuC89xJbFzhiWfbQpjlNIY6PNE/4BA==
=ZAXH
-----END PGP SIGNATURE-----

--oxpt4ukqg3mb476v--
