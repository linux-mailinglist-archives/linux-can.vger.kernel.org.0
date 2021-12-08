Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA6846D39E
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 13:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhLHMvq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 07:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhLHMvq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 07:51:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D68C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 04:48:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1muwMm-0002jr-DX; Wed, 08 Dec 2021 13:48:12 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-e45e-c028-b01c-c307.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:e45e:c028:b01c:c307])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 6A6106BFBBB;
        Wed,  8 Dec 2021 12:48:11 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:48:10 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v3 4/4] can: kvaser_usb: Get CAN clock frequency from
 device
Message-ID: <20211208124810.umnfw3f3fvev3rxw@pengutronix.de>
References: <20211208115607.202859-1-extja@kvaser.com>
 <20211208115607.202859-5-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z67st3afbqut6zhk"
Content-Disposition: inline
In-Reply-To: <20211208115607.202859-5-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--z67st3afbqut6zhk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.12.2021 12:56:07, Jimmy Assarsson wrote:
> Get the CAN clock frequency from device, since the various Kvaser Leaf
> products use different CAN clocks.

Help me classify this patch. Is existing hardware that uses this driver
broken without that patch?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--z67st3afbqut6zhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGwqYgACgkQqclaivrt
76keBwf+JzU1hd1xm2qply6Lc1TjxCjA/iOVT8wXogls+62sAz4g8ErsS1eqpgp+
F1k0W9pLxiD/5ArEo2b5KF+AKBTv4whynNqF8oSEEvpWsDIdJ4Gn0uYk19RCASum
UOrB9VOODbdRTYw/uEXsYfd/X3MTiAEJvRKTx4Ln/R1IC6u/hSIt5F0HV8/OO0lZ
OZZHAuhxLRDZnunLoKBsT3Gh+ocoP5LrrzZRL8WxhlymYFD1igNxR8WRsc93ohwp
aV+oVczzthzqyu+YrXzUMBAWL9oWDzIHpC4CDwuy31/jPpT8wdfYuD/LE9z0sI3q
5YVe5/lfUnfQH7wVWPrKBBk3SdGugw==
=EptW
-----END PGP SIGNATURE-----

--z67st3afbqut6zhk--
