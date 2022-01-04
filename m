Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD84844FC
	for <lists+linux-can@lfdr.de>; Tue,  4 Jan 2022 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiADPoZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Jan 2022 10:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiADPoZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Jan 2022 10:44:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA8C061761
        for <linux-can@vger.kernel.org>; Tue,  4 Jan 2022 07:44:25 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n4lz5-0001Md-KE; Tue, 04 Jan 2022 16:44:23 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-b248-f0ee-7a95-76a1.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:b248:f0ee:7a95:76a1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id F2F576D105B;
        Tue,  4 Jan 2022 15:44:22 +0000 (UTC)
Date:   Tue, 4 Jan 2022 16:44:22 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     dario.binacchi@amarulasolutions.com
Subject: Re: [PATCH v2 1/3] can: flexcan: change RX-FIFO feature at runtime
Message-ID: <20220104154422.qs5g5guggx3e4x3l@pengutronix.de>
References: <20220104154133.848784-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bbukhiqhkro4yy2u"
Content-Disposition: inline
In-Reply-To: <20220104154133.848784-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--bbukhiqhkro4yy2u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.01.2022 16:41:30, Marc Kleine-Budde wrote:

Forgot to list some changes:

> Changes since RFC:
> - move driver into subdir
- replaced memcpy() by direct assignment, do this earlier
- use priv->devtype_data.quirks where possible
> - rename flexcan_main.c -> flexcan-core.c
>   (mcp251xfd and tcan4x5x driver have the same naming scheme)
> - use copyright notice from flexcan.c in flexcan.h
> - add private flag support to set rx-fifo
> - remove drvinfo, the kernel will fall back to the default implementation

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bbukhiqhkro4yy2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHUa1MACgkQqclaivrt
76nqawf+IRiN10DnmBf2iohV61hRf+7tz9Crj+/oB4f8Q4mIbfJBhv90ytefzkSo
LKM3sIX+JIoi/h4BpA8Pyzb+aSPgBiwUPC5KFrDJ8ISyKfSZcua+qgHRO11s3fRc
+zOL9Td+nV7T/+IoCjwNsSXzwfUhYBs9pGv1/bZqsBYMQIJoxovX9+w5/bMTqBeH
FOmx19GX3SeaQlSLfYbgQE11T11UfhZAm7PwMKLzQwv2SDZlpsWpk1QzSXQXXXU1
aWhYm/fOPmZkMyWlOcDdCTCH7YiycEUvMv94MyyWg3iBunOdbgYc0sySNNzLtt9r
h8SyKNRaNyIK//cX3JduCxxPgfoKew==
=dP1S
-----END PGP SIGNATURE-----

--bbukhiqhkro4yy2u--
