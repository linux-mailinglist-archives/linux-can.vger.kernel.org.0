Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C833931DF
	for <lists+linux-can@lfdr.de>; Thu, 27 May 2021 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhE0PK7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 27 May 2021 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbhE0PKQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 May 2021 11:10:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049DC061351
        for <linux-can@vger.kernel.org>; Thu, 27 May 2021 08:08:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lmHc8-0003qf-SW; Thu, 27 May 2021 17:08:00 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:137d:9230:74b5:d207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DE37662DA90;
        Thu, 27 May 2021 15:07:59 +0000 (UTC)
Date:   Thu, 27 May 2021 17:07:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: vxcan RX/TX/echo semantics
Message-ID: <20210527150759.az3lal4vnhivwhlx@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75owzi67lvbgfdu4"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--75owzi67lvbgfdu4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Oliver,

I was wondering what the RX, TX and echo semantics on vxcan interfaces
should be.

I have started a "cangen" in one namespace and a "candump" in other.

The "candump" in the receiving namespace shows the CAN frames as "TX"
and in the sending namespace the CAN frames don't show up in a "candump"
at all. Is this intentional? If so what's the idea behind this and is
this documented?

I'm adding "cangw" to the mix and see what happens....

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--75owzi67lvbgfdu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCvtcwACgkQqclaivrt
76m42ggAmDfU9Jp3erWAxroc7MvnDgWZR/E+lt2dmrMyPEipEvLStgrebZ2e46go
4mCn9OjU/neXdlZ01seSu46RDmhoxC7zZ3x144FHKtD5zirmzGW9qceZ9MehEFsP
5X/ex8NrOjJj4+5rFge31xW3mZT+Rr3I/ZFIKsWF2NZBrwzIrpsKN3DKrYocVBbM
Dj1x45A/yjOPzldpYIUkLvH1NzeGM1ftQb6PbxQaXrH9+LDnWjimqP8iNeQcRyZa
qKTPMkGbxg/vhiWq9Fq+hfKiHSkyRvC/UBp2i/i1aj5MBd5anJw2gIajXArFGKf5
soorgBw17hW6rRqg4DKCwiFOxysSLg==
=GBJG
-----END PGP SIGNATURE-----

--75owzi67lvbgfdu4--
