Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC4136FC2C
	for <lists+linux-can@lfdr.de>; Fri, 30 Apr 2021 16:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhD3OV4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Apr 2021 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhD3OVr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Apr 2021 10:21:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D9EC06138C
        for <linux-can@vger.kernel.org>; Fri, 30 Apr 2021 07:20:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lcU0m-0004vk-3R; Fri, 30 Apr 2021 16:20:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:454b:889d:aa6e:bca6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1584B619D4B;
        Fri, 30 Apr 2021 14:20:55 +0000 (UTC)
Date:   Fri, 30 Apr 2021 16:20:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH 1/2] can: kvaser_usb: Rename define
 USB_HYBRID_{,PRO_}CANLIN_PRODUCT_ID
Message-ID: <20210430142054.3jerntllpxjc5uhb@pengutronix.de>
References: <20210429093730.499263-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w5jw7zslllpvk3jq"
Content-Disposition: inline
In-Reply-To: <20210429093730.499263-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--w5jw7zslllpvk3jq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.04.2021 11:37:29, Jimmy Assarsson wrote:
> Rename define USB_HYBRID_{,PRO_}CANLIN_PRODUCT_ID to
> USB_HYBRID_{,PRO_}2CANLIN_PRODUCT_ID, to reflect the channel count.
>=20
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>

Applied to linux-can-next/testing.

tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--w5jw7zslllpvk3jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCMEkMACgkQqclaivrt
76muXgf/Zk9fUXmXpOTPByjYgFTkIW1jxvId//yg4OfBSlNkhChW5wC/kxRM4H3D
u0CA1AJ08IM1BnTSSxfL13E/uukCxCPUg9sozDyaopAhgtwnek/Gi6BSKkgafI93
OXGTQOddJ+3KLFGIeX23ksE3Nt3epky987vNl7hGTZYiH2jWL01K2fF3s53dIM6K
XFAU31r0wGZMN2TfYMuqlCiviRV+wWgoBPL+tmjYA2jxfpmb8cfjp3iAZf3QIFDl
EBhBgnZA2GKyXu67XPsLtQ/fJBeEM6EhnTNoMqpPIdz29jyxZZ/oG5atJ5HDTfqV
RNpJYRV+mEF+F4+7UBPw0LfDjAOD4w==
=Ovi8
-----END PGP SIGNATURE-----

--w5jw7zslllpvk3jq--
