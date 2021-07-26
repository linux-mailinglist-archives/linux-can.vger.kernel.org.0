Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282083D56AD
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 11:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhGZIwl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 04:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhGZIwk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 04:52:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C79C061757
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 02:33:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7wyy-0000FW-Ge; Mon, 26 Jul 2021 11:33:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1455:5f5:50a2:3493])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A0149657E1C;
        Mon, 26 Jul 2021 09:33:07 +0000 (UTC)
Date:   Mon, 26 Jul 2021 11:33:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Remigiusz =?utf-8?B?S2/FgsWCxIV0YWo=?= 
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH] MAINTAINERS: add Yasushi SHOJI as reviewer for the
 Microchip CAN BUS Analyzer Tool driver
Message-ID: <20210726093306.z3to7o6rz5r4jod2@pengutronix.de>
References: <20210726092945.1017567-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i7qlte4yqeyyfp4s"
Content-Disposition: inline
In-Reply-To: <20210726092945.1017567-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--i7qlte4yqeyyfp4s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Remigiusz,

On 26.07.2021 11:29:45, Marc Kleine-Budde wrote:
> This patch adds Yasushi SHOJI as a reviewer for the Microchip CAN BUS
> Analyzer Tool driver.

are you (or someone else at Mobica) is willing to be listed as the
maintainer of this driver in the Linux kernel's MAINTAINERs file?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--i7qlte4yqeyyfp4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD+gVAACgkQqclaivrt
76lR5gf/TRoGmBAc96m8WECOOrGzR69PM3s3gkWO6i3RFSONyiMI/rFH1+gRpFf4
VkPFwkNrCDtRkS0t2EIYSyFEHiW8cVLOtt8NpJSSjRpdh5sx3dkd0+rlU0yTMKjy
qVLSKmhTG1vJafGXif8Nf/o4qiuPkPLrhrH76h2zghAfW4RzXoLchqokqk8ZZTxz
jcclaDR+Tu+aemkiPQ40KOYDHPD1yADxZEx7CDBj18k7x4GmSrg5QEzH6eE64f4s
k9lJA5f5rourixtgz4xPU/PAXt42nh5xFKV9decE/CXZmR6FNiivq6AQIIEsRpEa
goTaiKjFUkdeuZ2Bnx0gmLLTOD37bg==
=/zn6
-----END PGP SIGNATURE-----

--i7qlte4yqeyyfp4s--
