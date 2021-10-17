Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0FD430939
	for <lists+linux-can@lfdr.de>; Sun, 17 Oct 2021 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245679AbhJQNGQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Oct 2021 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbhJQNGQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Oct 2021 09:06:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7558C061765
        for <linux-can@vger.kernel.org>; Sun, 17 Oct 2021 06:04:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mc5pd-0008DU-7g; Sun, 17 Oct 2021 15:04:05 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-7b24-848c-3829-1203.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:7b24:848c:3829:1203])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 60C4F695D28;
        Sun, 17 Oct 2021 13:04:04 +0000 (UTC)
Date:   Sun, 17 Oct 2021 15:04:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/2] can: peak_usb: fix back to ERROR_ACTIVE state
 notification
Message-ID: <20211017130403.djmogzycbxhnyjqh@pengutronix.de>
References: <20210929142111.55757-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xsaaeporc7crhopw"
Content-Disposition: inline
In-Reply-To: <20210929142111.55757-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xsaaeporc7crhopw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.09.2021 16:21:10, Stephane Grosjean wrote:
> This corrects the lack of notification of a return to ERROR_ACTIVE state
> for USB - CANFD devices from PEAK-System.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied both patches to linux-can/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xsaaeporc7crhopw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFsH0AACgkQqclaivrt
76ntfAf+KBXk6vALyo20crV2hZ+iXFIp6tUCeAiUL8SUiExLSA7Lbo/ihDw6X4qT
8xnU5AvtSq3fw0JgHcvSA7Ednowj7LC8TDKAzRcTZM7UZfLZ/2ZxV9YTd428eBdC
qKdGTDgxCahcgSZszJvOUhbEs5A9yHQBfIwx6basv7faaE8hXhOzFO0Fp4PUsOlJ
KOBjjDgvrqfCrtjuDYw+O8Xv4zSMz4iq0p88rBBQXw68as54Bu2Agy4oGU+f976h
TCAJgUH8UXjeFaPhfUO00zLluhNzVnzAatrc2AoPQqrFtRZpUVdKxLAvDKFZLwR8
6LEjy/jB9C1pPMLSSXJ6FEyjaCImSQ==
=j9po
-----END PGP SIGNATURE-----

--xsaaeporc7crhopw--
