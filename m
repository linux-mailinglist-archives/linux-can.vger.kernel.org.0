Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08E83B5949
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhF1Gye (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 02:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1Gye (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 02:54:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DE0C061574
        for <linux-can@vger.kernel.org>; Sun, 27 Jun 2021 23:52:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lxl7n-0004wj-JP; Mon, 28 Jun 2021 08:52:07 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:5559:217e:8326:2717])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 757AE644A52;
        Mon, 28 Jun 2021 06:52:06 +0000 (UTC)
Date:   Mon, 28 Jun 2021 08:52:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 3/5] can: peak_usb: pcan_usb_handle_bus_evt(): fix
 reading rxerr/txerr values
Message-ID: <20210628065204.kliez5lpjfy5uapt@pengutronix.de>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
 <20210625130931.27438-4-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wf5wyesqrrdruxpj"
Content-Disposition: inline
In-Reply-To: <20210625130931.27438-4-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wf5wyesqrrdruxpj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.06.2021 15:09:29, Stephane Grosjean wrote:
> This patch fixes an incorrect way of reading error counters in messages
> received for this purpose from the PCAN-USB interface. These messages
> inform about the increase or decrease of the error counters, whose values
> are placed in bytes 1 and 2 of the message data (not 0 and 1).
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Added to linux-can/testing, added a fixes tag and stable on Cc.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wf5wyesqrrdruxpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDZcZAACgkQqclaivrt
76k2Cwf+MBb2jH2y6WextoTHWgkHVY81UQu0lMmT9kQwj+fyZmH5LHaKGMkrKg4h
klWiwS2Br0mBKTjkACixT7ZGGP+JCx6LCASjwfm949s8gzeFmkBcgVETTOtJBfVR
n8j4Zu7unvpS/RfYNPTL89upYTZil3Iv+UYoEnxaGIj86vIhS5yEdqhvYJSM41q6
dwF4iWOea0Qx2Hgp6k6a8VgZta6DoqlwpVa/DVY/h1Isi1xQclc8t2zeWoNl4FHr
wZscdUzna5SCuC1X6rYYMO36FnNsWH3km5RrrApFFNxzrTQUDKnfG0Dsimy5q1B0
1548HpVouiV8NjcfpJmKjTQN5MndNg==
=ilZx
-----END PGP SIGNATURE-----

--wf5wyesqrrdruxpj--
