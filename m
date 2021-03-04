Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91F32D4BC
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 14:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhCDN6n (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 08:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhCDN6V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 08:58:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C120BC061574
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 05:57:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHoTz-0007fn-D4; Thu, 04 Mar 2021 14:57:39 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:3b3:61f5:ff65:ce3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 78F6E5EDBF1;
        Thu,  4 Mar 2021 13:57:38 +0000 (UTC)
Date:   Thu, 4 Mar 2021 14:57:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: m_can: m_can_rx_peripheral: fix RX being blocked by
 errors
Message-ID: <20210304135737.bmjlj3pmunvd3bbx@pengutronix.de>
References: <20210303144350.4093750-1-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibfpwituxilm2ze6"
Content-Disposition: inline
In-Reply-To: <20210303144350.4093750-1-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ibfpwituxilm2ze6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.03.2021 14:43:51, Torin Cooper-Bennun wrote:
> For M_CAN peripherals, m_can_rx_handler was called with quota =3D 1, which
> caused any error handling to block RX from taking place until the next
> time the IRQ handler is called. This had been observed to cause RX to be
> blocked indefinitely in some cases.
>=20
> This is fixed by calling m_can_rx_handler with a sensibly high quota.
>=20
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>

Applied to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ibfpwituxilm2ze6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBA508ACgkQqclaivrt
76mBiQf/RyFjmPY73JH0VxGkawpaGDjwcjLCa/3I16Uv6wHilDBVYBmmNDFDdy82
ce9zcTv/kfTI0cKxQQwe73D/z7qg36mgXdEQsDYUpodYMIetYRGB38wGTGyxWXaM
yKNwxfjwN03UYYRIDkAZB0dTpk2K1wFWJyAeF1MOAG/9zfUEOPtGNnVzCS5hVRt/
DGmxDhmt0bkRAETPTur2qRmbs4CJWcG17PEHsUKa2WCAruyk9hLkvpjbV9IKVV8P
nf0NKiC4hMuIw2AViTYBdyVxiIAmQQ2OJB5l1M0w2GMoGAUj2DjaOCJz9IVQgjWm
2qz36xWys6mVaYHMeRp3xpl1i3LeAw==
=qd7B
-----END PGP SIGNATURE-----

--ibfpwituxilm2ze6--
