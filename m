Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860203B4127
	for <lists+linux-can@lfdr.de>; Fri, 25 Jun 2021 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFYKMV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 25 Jun 2021 06:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhFYKMV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Jun 2021 06:12:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBBBC061574
        for <linux-can@vger.kernel.org>; Fri, 25 Jun 2021 03:10:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwimX-0002V9-1t; Fri, 25 Jun 2021 12:09:53 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6633:1401:6bbf:57ef])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 168F1643744;
        Fri, 25 Jun 2021 10:09:51 +0000 (UTC)
Date:   Fri, 25 Jun 2021 12:09:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Moriis Ku <saumah@gmail.com>
Cc:     wg@grandegger.com, linux-can@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com
Subject: Re: [PATCH] SUNIX SDC CAN controller driver
Message-ID: <20210625100950.4zzmu3c4nkprhrpi@pengutronix.de>
References: <20210625094520.13283-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6t7zq2zyqicsbk56"
Content-Disposition: inline
In-Reply-To: <20210625094520.13283-1-saumah@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--6t7zq2zyqicsbk56
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.06.2021 17:45:20, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
>=20
> Add support for SUNIX SDC CAN controller

How is your hardware attached? Looks a bit like SPI. You should write a
SPI host driver first.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--6t7zq2zyqicsbk56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDVq2sACgkQqclaivrt
76kGhQf+KbwvTLSmatq90I0SKNEi/qeuKV9GZ1n0d7uSu4zTvdFT+tpGQQ9/Hz6m
4cr4m7+xLx+rC+jzA0asPR+2AcVZkw8aqSjjXKvDOOFuVOR05xwfJDYMQqccJaL+
EOFsOUlaYMDCL/u1X3ShOqfcrhAvibItlgFKvnOtzO1jjjhAqhflS+tH6xIIacsb
1Im+6T8HKctNY6ZWNI3n6pWUdwrYuZBdGRA+BdGp4qqUNrYoHmk8fjl0OgignyjT
4eR1wwD8h5N60zyj2xpQWHMacCQyBEBgcdWvBvLffPSQ1NdU2zFBVxkjA4aXBkkY
kgwbfMebJ75FTO2/AC5NpCVx0i8uUg==
=yrPF
-----END PGP SIGNATURE-----

--6t7zq2zyqicsbk56--
