Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189C3D5473
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhGZG6I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 02:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhGZG6H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 02:58:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A970C061760
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 00:38:36 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7vC4-0000Ax-LT; Mon, 26 Jul 2021 09:38:32 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1455:5f5:50a2:3493])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C2C8E657B4F;
        Mon, 26 Jul 2021 07:38:31 +0000 (UTC)
Date:   Mon, 26 Jul 2021 09:38:31 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-can@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v5] can: m_can: Add support for transceiver as phy
Message-ID: <20210726073831.2a52g3qpsvuhdjel@pengutronix.de>
References: <20210724174001.553047-1-mkl@pengutronix.de>
 <0d25c9e4-dcca-a79d-edc6-d638629862ba@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twepfwprm5m4j7cs"
Content-Disposition: inline
In-Reply-To: <0d25c9e4-dcca-a79d-edc6-d638629862ba@ti.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--twepfwprm5m4j7cs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2021 13:00:54, Aswath Govindraju wrote:
> May I know what is the base branch for this patch ? I tried applying it
> on top of linux-next/master but I am getting errors.

It's part of my next pull request:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/=
?h=3Dlinux-can-next-for-5.15-20210725

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--twepfwprm5m4j7cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmD+ZnQACgkQqclaivrt
76lZCwgAgcX1wcr1VWcauXzPIcdi+YQbluDn3oTaUnzTXkJunYuxJeonsquwarzf
36AgAgJ7xXlOjQ1R5NRia5RU30qIfVgXKojBDNBZImo3uoYexNcvtLL3v2JPQbFf
QovFBLXW39SvSkiipCuHQw5Uw1sDltfxf4jH0YGns+1qiKJ7D2c1aaXmtCHYhKGx
LwtrTtp2Wd5B6drtg7FG3THJNg+t1aNoHO+oGl/XrkuzCLYfNYXJskr2RgSd9acG
2YYsP+SIlmCimEZ0Uz4txZe5l+4vWAF+b0Nl+V7qbWhiYrRjr1OPMOrZ+K8h6XZC
GHEmfnYDnunoc8GHXm9hqG+Lo/PBBw==
=x4h5
-----END PGP SIGNATURE-----

--twepfwprm5m4j7cs--
