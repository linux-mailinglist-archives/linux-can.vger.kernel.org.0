Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E185A2A39
	for <lists+linux-can@lfdr.de>; Fri, 26 Aug 2022 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiHZPBH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Aug 2022 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHZPA7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Aug 2022 11:00:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E3BD4C3
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 08:00:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oRapN-0000RG-Ew; Fri, 26 Aug 2022 17:00:57 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D31B6D47A1;
        Fri, 26 Aug 2022 15:00:56 +0000 (UTC)
Date:   Fri, 26 Aug 2022 17:00:56 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH 2/2] can: gs_usb: advertise timestamping capabilities and
 add ioctl support
Message-ID: <20220826150056.yjqnch4wfb5anxow@pengutronix.de>
References: <20220826104629.2837024-1-mkl@pengutronix.de>
 <20220826104629.2837024-3-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lkycswnblrqd7e3c"
Content-Disposition: inline
In-Reply-To: <20220826104629.2837024-3-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--lkycswnblrqd7e3c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.08.2022 12:46:29, Marc Kleine-Budde wrote:
> From: John Whittington <git@jbrengineering.co.uk>
>=20
> Following dc0d8e068f837 ("can: gs_usb: hardware timestamp support")
> this correctly advertises the support for RX HW timestamps if the device
> does support it. Similar to bedd94835a352 ("can: peak_usb: advertise
> timestamping capabilities...") since PCAN devices also only support RX
> and not TX HW timestamping.
>=20
> Not-Signed-off-by: John Whittington <git@jbrengineering.co.uk>

Can I get the S-o-b for this patch, too?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lkycswnblrqd7e3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMI4CUACgkQrX5LkNig
011bEggAsX9zvW0X21yYlmjdYskLU1b/h4juzz5UyZb9XaljZ90lhvSx5xJN23rl
lDcYMpo2Nhb02C23DHoKrqkcJHywogR3i0RkHEBTTQcmv2kGrkeS8lJj+22TsTAO
xJn/O8XLLRPrrhYncwwmVb6v8KqV3H6dcGaQTBMwqnGAXolajGtV+afUM6NwhbuM
vd0sJYheIJIM6V8aGkrkn53nJN9F+k4NgaX6g1/253WE1yo0PwLZdJtdxVECIvvG
kzfOlUPC2OwVGJMdgr8WkEip1eLpsCypdfC9C5xwb1bMtgu+Mc65w79bxbo2qdSW
nfevxmuXvo+gXygHy7js/UABtc7llw==
=pead
-----END PGP SIGNATURE-----

--lkycswnblrqd7e3c--
