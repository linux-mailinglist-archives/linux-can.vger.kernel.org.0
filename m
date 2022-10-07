Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6099E5F74F9
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJGH4l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJGH4V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 03:56:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69DBC45B1
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 00:56:09 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogiDI-00089W-Ao
        for linux-can@vger.kernel.org; Fri, 07 Oct 2022 09:56:08 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B3AB3F6BF8
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 07:56:07 +0000 (UTC)
Date:   Fri, 7 Oct 2022 09:56:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: gs_usb: gs_make_candev(): set netdev->dev_id
Message-ID: <20221007075603.fx2umvk2i53inyjf@pengutronix.de>
References: <20221007075418.213403-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cm6pssfdk3g5srfr"
Content-Disposition: inline
In-Reply-To: <20221007075418.213403-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--cm6pssfdk3g5srfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.10.2022 09:54:18, Marc Kleine-Budde wrote:
> The gs_usb driver supports USB devices with more than 1 CAN channel.
> Set the "netedev->dev_id" to distinguish between channels in user
              ^

fixed.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cm6pssfdk3g5srfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM/24YACgkQrX5LkNig
010Wewf/b4PPry0a87+6Tiw/mVnE08i9vSX9auPRtCPytyO88+cJ6PbewM9Qwglj
IGSuw07PRTymgEv5ROxDgfNLotonLOj823bM7B4T9Z5xwpbI5Lz4M34094NX/4Yy
FTi00xfqFtRAHKK41RKm/3MXlZrjUbZtgn1C/MrIBfq+NBnTCgd7qMFbrRxQUrls
yTpad84q429vpvCA02t2XgakzAvbk3j4hSZsYHeB1Z/MvgeFvrq+30QQ9VkuI1Pm
7bdfx/nkNp9fEchpTgpkIBPDWWm6r7AYfHRsE7sWnaM6F6JnwaVqyTf42PzYr6K6
9TA/XAPp6qG6l8Fg/XtwKeDo56dobw==
=EYsy
-----END PGP SIGNATURE-----

--cm6pssfdk3g5srfr--
