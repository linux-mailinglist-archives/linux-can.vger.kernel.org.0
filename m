Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F291179FE38
	for <lists+linux-can@lfdr.de>; Thu, 14 Sep 2023 10:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjINIX5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Sep 2023 04:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjINIX4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Sep 2023 04:23:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37063CD8
        for <linux-can@vger.kernel.org>; Thu, 14 Sep 2023 01:23:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qghde-0003gP-QX; Thu, 14 Sep 2023 10:23:50 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qghde-006G8Z-AQ; Thu, 14 Sep 2023 10:23:50 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0747B220950;
        Thu, 14 Sep 2023 08:23:50 +0000 (UTC)
Date:   Thu, 14 Sep 2023 10:23:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: etas_es58x warnings with gcc-13
Message-ID: <20230914-carrousel-wrecker-720a08e173e9-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ptmdhnd2kql5wzlh"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--ptmdhnd2kql5wzlh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vincent,

when compiling the etas driver with gcc version 13.2.0 (Debian
13.2.0-2) and W=3D1, it fails with:

| drivers/net/can/usb/etas_es58x/es58x_devlink.c: In function =E2=80=98es58=
x_devlink_info_get=E2=80=99:
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:55: error: =E2=80=98%0=
2u=E2=80=99 directive output may be truncated writing between 2 and 3 bytes=
 into a region of size between 1 and 3 [-Werror=3Dformat-truncation=3D]
|   201 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
|       |                                                       ^~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:44: note: directive ar=
gument in the range [0, 255]
|   201 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
|       |                                            ^~~~~~~~~~~~~~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:201:17: note: =E2=80=98snp=
rintf=E2=80=99 output between 9 and 12 bytes into a destination of size 9
|   201 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
|       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|   202 |                          fw_ver->major, fw_ver->minor, fw_ver->re=
vision);
|       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:55: error: =E2=80=98%0=
2u=E2=80=99 directive output may be truncated writing between 2 and 3 bytes=
 into a region of size between 1 and 3 [-Werror=3Dformat-truncation=3D]
|   211 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
|       |                                                       ^~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:44: note: directive ar=
gument in the range [0, 255]
|   211 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
|       |                                            ^~~~~~~~~~~~~~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:211:17: note: =E2=80=98snp=
rintf=E2=80=99 output between 9 and 12 bytes into a destination of size 9
|   211 |                 snprintf(buf, sizeof(buf), "%02u.%02u.%02u",
|       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|   212 |                          bl_ver->major, bl_ver->minor, bl_ver->re=
vision);
|       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:52: error: =E2=80=98%0=
3u=E2=80=99 directive output may be truncated writing between 3 and 5 bytes=
 into a region of size between 2 and 4 [-Werror=3Dformat-truncation=3D]
|   221 |                 snprintf(buf, sizeof(buf), "%c%03u/%03u",
|       |                                                    ^~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:44: note: directive ar=
gument in the range [0, 65535]
|   221 |                 snprintf(buf, sizeof(buf), "%c%03u/%03u",
|       |                                            ^~~~~~~~~~~~~
| drivers/net/can/usb/etas_es58x/es58x_devlink.c:221:17: note: =E2=80=98snp=
rintf=E2=80=99 output between 9 and 13 bytes into a destination of size 9
|   221 |                 snprintf(buf, sizeof(buf), "%c%03u/%03u",
|       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|   222 |                          hw_rev->letter, hw_rev->major, hw_rev->m=
inor);
|       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
| cc1: all warnings being treated as errors

Can you create a fix?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ptmdhnd2kql5wzlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUCwxMACgkQvlAcSiqK
BOiCigf+JTmAz7W/jJPw8v3MTsHOSTZzzqrimM77gCoMoZhRNa67B13PlUVcxCkk
ytlwWCHjulVKRYimJsVxtjHBkciPfua/B0+O47iUVhl7wRmci/hkuxtX9dFdy/ap
t23/4/yrFv+V++JuD4WMY6VSWGJTPwaO+v6u6rW0bNyAgqfBP8saExQKu0lUokwX
M8+NQwcXp0tCYio04gRlowPVy/wLSYiGE61y2OFA8IOOghOpj7i6upBy9uoYsAQI
gBXZZwniIYoh7ahXJzX2XMiOCMDx9YY74f9h5d7gvOBa82DXFlT/tYxNxyKUo0AK
BVgRA2kZG7/1qOf+eFguhXaS6dtzKQ==
=VWhv
-----END PGP SIGNATURE-----

--ptmdhnd2kql5wzlh--
