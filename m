Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D789E5A2C46
	for <lists+linux-can@lfdr.de>; Fri, 26 Aug 2022 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiHZQ0a (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Aug 2022 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHZQ0a (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Aug 2022 12:26:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CABDF4EB
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 09:26:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oRcA6-0002jB-6c; Fri, 26 Aug 2022 18:26:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4C687D4863;
        Fri, 26 Aug 2022 16:26:25 +0000 (UTC)
Date:   Fri, 26 Aug 2022 18:26:23 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>
Subject: Re: [PATCH 2/2] can: gs_usb: advertise timestamping capabilities and
 add ioctl support
Message-ID: <20220826162623.j6zvxtx6nzwtlkjr@pengutronix.de>
References: <20220826104629.2837024-1-mkl@pengutronix.de>
 <20220826104629.2837024-3-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tssfphukfsjdpyij"
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


--tssfphukfsjdpyij
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

While all peak_usb devices support RX HW timestamps, not all gs_usb
devices do. Please adjust the gs_can_eth_ioctl() accordingly.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--tssfphukfsjdpyij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMI9C0ACgkQrX5LkNig
013y8Af/fpIY4paqR4mT+CyO6OPBWNFu6dDKKogcRb8r4BoY9BMlzzF4QDK/IvUI
Yccg1rB8a0y8fYDe0H8qdRFRZbRPST9oeksTvh459CjNtMuO84nw9ChlmdQBe6zd
AwnXcE4XLXVw2kiJG876Wrh92dyz8JAvNqch/3TQxyHRM5CsctclZPbNSSRSEBCI
wzwMWrOToacKIHBMqeNNFtZCzHeWJK3nvsgSmNxiApV9mJ8uhRFw5C/RCBw0FWkK
KqdjcT8ltwkcoRH9UFHuehZIAHHd919+37E4lPkDpj9qjdW/wRsUEFNzHkRz/2tm
cFyGhiqWSd0GLtrl6r1DNh+g/PMspg==
=F+ZN
-----END PGP SIGNATURE-----

--tssfphukfsjdpyij--
