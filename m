Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0860391B8F
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhEZPWU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhEZPWT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 11:22:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C812C061574
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 08:20:48 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1llvKw-00084D-LR; Wed, 26 May 2021 17:20:46 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:cbc5:840b:a05c:ea5c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id AB58362CB3B;
        Wed, 26 May 2021 15:20:45 +0000 (UTC)
Date:   Wed, 26 May 2021 17:20:45 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 0/5] m_can, tcan4x5x: device-specific interrupt
 handling
Message-ID: <20210526152045.j3efhxqpytixa7tt@pengutronix.de>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulj6hnkwn4iaapyo"
Content-Disposition: inline
In-Reply-To: <20210526124747.674055-1-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ulj6hnkwn4iaapyo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.05.2021 13:47:42, Torin Cooper-Bennun wrote:
> Hi Marc and list,
>=20
> This series is a follow-up to the RFC here:
>   https://lore.kernel.org/linux-can/20210514121946.2344901-1-torin@maxilu=
xsystems.com/
>=20
> In this series we enable M_CAN-based devices to implement their own
> device-specific interrupt handling, and add such handling for tcan4x5x.
>=20
> In 1, we replace the clear_interrupts() m_can_ops callback with
> handle_interrupts(), which returns irqreturn_t and has an extra
> parameter, clear_only, which is used if it isn't necessary to handle
> device interrupts, only clear them.
>=20
> In 2, we use the new infrastructure in m_can_isr(). If M_CAN core
> interrupts are handled, we still only clear device interrupts.
> Otherwise, we try to handle any pending device interrupts.
>=20
> In 3-5, we clean up interrupt enabling and clearing in tcan4x5x, and
> handle device interrupts appropriately. We specifically look for fatal
> errors arising from transceiver or power, and SPI errors, which are not
> necessarily fatal, but are dangerous!
>=20
> TCAN4550 shutdown is attempted by setting the device into standby mode.
> There is probably a better way, but I understand we are limited by being
> in the ISR context.

Not exactly. The tcan's ISR runs in a threaded context, so you can
basically do normal SPI or regmap transactions, shut down clocks and
regulators, etc...

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ulj6hnkwn4iaapyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCuZ0oACgkQqclaivrt
76kRqwf/f+T2YMDBjTV+bzXS3kRYXZRx3JyIxZFUEjrqvi8nqxM8xjXH5A/gKcTi
+zg8UFV+iFYAmkgleriCzYvOU3KV1rj58AvgpIKVmxaCPHZlrUxn2ZWfAfwAcdZp
ICmdszRJMWHCtET5Xnv3HkPxuBAut/kvlWoAeJhO7MgP437ZC9VrhZHWrs9Q7o2F
ekxJEw2Jm1+ZsO0HCLhrl16ghDlKNaigN4rgo2Lo+rUU66p5JjoTkPAUs20j8hGQ
8Y2k8isieQ9fNd/dMuebaLvWGw0KNPU7ZC0HyAW7QrJPgyR6qq+skr/LJ5TZp5oL
n7epsxXznpSuE9TjRNckNXeuRWHZPA==
=WD54
-----END PGP SIGNATURE-----

--ulj6hnkwn4iaapyo--
