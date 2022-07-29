Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC74584D44
	for <lists+linux-can@lfdr.de>; Fri, 29 Jul 2022 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiG2IPn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 29 Jul 2022 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiG2IPa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 29 Jul 2022 04:15:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1DDFDA
        for <linux-can@vger.kernel.org>; Fri, 29 Jul 2022 01:15:27 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oHL9Z-0006d4-E3; Fri, 29 Jul 2022 10:15:25 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id A6B3BBDAAD;
        Fri, 29 Jul 2022 08:15:24 +0000 (UTC)
Date:   Fri, 29 Jul 2022 10:15:24 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: etas_es58x: remove useless calls to
 usb_fill_bulk_urb()
Message-ID: <20220729081524.7swxlp4fjwz55foh@pengutronix.de>
References: <20220729080902.25839-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hz3rwhgwwitpghrn"
Content-Disposition: inline
In-Reply-To: <20220729080902.25839-1-mailhol.vincent@wanadoo.fr>
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


--hz3rwhgwwitpghrn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.07.2022 17:09:02, Vincent Mailhol wrote:
> Aside of urb->transfer_buffer_length and urb->context which might
> change in the TX path, all the other URB parameters remains constant
> during runtime. So, there is no reasons to call usb_fill_bulk_urb()
> each time before submitting an URB.
>=20
> Make sure to initialize all the fields of the URB at allocation
> time. For the TX branch, replace the call usb_fill_bulk_urb() by an
> assignment of urb->context. urb->urb->transfer_buffer_length is
> already set by the caller functions, no need to set it again. For the
> RX branch, because all parameters are unchanged, simply remove the
> call to usb_fill_bulk_urb().
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Applied to linux-can-next/master

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--hz3rwhgwwitpghrn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmLjlxkACgkQrX5LkNig
012wvgf/esoVAl5e2BFTHgVw8PtVpBNRgTo3KVNhOsQ4YPuF/JRfXQSydANFgpqW
hkAbF7p9FJ4VlPDwDYShqdpM3HfubJH6Hidgn8fUHhAWdP9v7JGpMgDx3+GFsHoW
5ffyPYuvE+zk2tacQ08ZHkgpMQWvui2OpQGH3atMmR/pkLnj+GNm7zzwzQRmxVip
U+J42ViDRntYkee9MjJcYVpmGetiHasKxnzpLt16zVquE0Ll+N7HXHD1bp3LhXyN
ssf0WMIKMP9Ut/KKzAxN1b1a1mB0nb4VjP4F4jwbxihPkilF3W/if+0ObAFtA34v
YMFwHOMWDxq3yQwAIkKO9J9QYFU9IA==
=ADzu
-----END PGP SIGNATURE-----

--hz3rwhgwwitpghrn--
