Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD3C446EFF
	for <lists+linux-can@lfdr.de>; Sat,  6 Nov 2021 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhKFQmX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 6 Nov 2021 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhKFQmX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 6 Nov 2021 12:42:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699AC061570
        for <linux-can@vger.kernel.org>; Sat,  6 Nov 2021 09:39:41 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mjOjE-0006ke-CI; Sat, 06 Nov 2021 17:39:40 +0100
Received: from pengutronix.de (dialin-80-228-153-084.ewe-ip-backbone.de [80.228.153.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 407806A5DD5;
        Sat,  6 Nov 2021 16:39:39 +0000 (UTC)
Date:   Sat, 6 Nov 2021 17:39:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 0/2 v2] can: peak_usb: PCAN-USB bus state fix and info
 ordering
Message-ID: <20211106163937.hqvwypigojy5supd@pengutronix.de>
References: <20211021081505.18223-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nxbljo7hssua7vtr"
Content-Disposition: inline
In-Reply-To: <20211021081505.18223-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--nxbljo7hssua7vtr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.10.2021 10:15:03, Stephane Grosjean wrote:
> This bundle of changes:
> - corrects a potential bad transition to ERROR_PASSIVE or ERROR_WARNING
>   state if BERR reporting was not explicitly requested for the can
>   interface associated with the PCAN-USB,
> - reorders the information displayed when the PCAN-USB is detected, when =
it
>   can benefit from a firmware update.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied both to linux-can/testing. Added stable on Cc for the 1st patch.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nxbljo7hssua7vtr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGGr8cACgkQqclaivrt
76kp7gf+K8w2aVm+DwnoD8ObGNKYoQhgV5Knx38lc67z1gUPrqT6IaNvRCxvOuSF
w0pEKON0QO+ywD81bfBWZmFXT2nSnDnDeXvGLyUg+YabIlXuV0qrKxv04lHQ9u72
SY6VvLABtejeNV4QzdTeMK+2wD9tum23wE2fIEcxLTe3EP/S41sP72GLwt0H8t4t
ind2joWyrEtKd8/i5mTBNwpWCLl9GQu6Tjo1qoqvtJ/Cx/T439eAU6bFL3QzNcqX
/N5Qnf99+X9FUmx+3VCxrvax+5Q0r/fmvfEJiMYUIzHPppC7ktbw/oATEON3c7cP
1SdvYElEen5VhE9UpaAP1Reet2RQaA==
=qDwe
-----END PGP SIGNATURE-----

--nxbljo7hssua7vtr--
