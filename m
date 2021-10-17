Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EFE430C15
	for <lists+linux-can@lfdr.de>; Sun, 17 Oct 2021 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhJQUwd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 17 Oct 2021 16:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhJQUwd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 17 Oct 2021 16:52:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D007C06161C
        for <linux-can@vger.kernel.org>; Sun, 17 Oct 2021 13:50:23 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mcD6r-0007ff-9s; Sun, 17 Oct 2021 22:50:21 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-c215-888e-54eb-c2bc.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:c215:888e:54eb:c2bc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id CA0FA695EA4;
        Sun, 17 Oct 2021 20:50:19 +0000 (UTC)
Date:   Sun, 17 Oct 2021 22:50:18 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 1/2] can: peak_usb: always ask for BERR reporting for
 PCAN-USB devices
Message-ID: <20211017205018.4dngil53gtdsphm4@pengutronix.de>
References: <20210929141421.55580-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="du6oo5kxewjkfpdl"
Content-Disposition: inline
In-Reply-To: <20210929141421.55580-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--du6oo5kxewjkfpdl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.09.2021 16:14:20, Stephane Grosjean wrote:
> Since for the PCAN-USB, the management of the transition to the
> ERROR_WARNING or ERROR_PASSIVE state is done according to the error
> counters, these must be requested unconditionally.

If you switch on bus error reporting unconditionally, please remove
CAN_CTRLMODE_BERR_REPORTING from ctrlmode_supported.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--du6oo5kxewjkfpdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmFsjIgACgkQqclaivrt
76knbAf/cdy+D7/YGe2NLJMbdfPtp+ddiwwsaYW6oLj+VdasfZYXt91YK8DLtkoL
+mWTmZWAY1ZugG37F21odA0sb2FqvxvkMDZKxY5eRoJHnEHpRcyJeCEsGwNIlpXS
uGxYhH8V6uvwAfiu5tMvaPlBRrGwMc6HpAkqqTh9cnePnrVfaUUkKE4d9mrH6OYa
qWJ9sY5DKt+mWnKXMjAmWgsrnLeomkjhnY/VASEXs134dyoBKiuN81qvvGnOVJ6P
X6OsFGbJd9otqVKsI5ErThKVpZo3vXs83XpVdMGLR8SukNEVxEIAPYhpqbHocb08
IBsDMlw6qyUS5xu2tkaPr/82wSf1Qg==
=nKsM
-----END PGP SIGNATURE-----

--du6oo5kxewjkfpdl--
