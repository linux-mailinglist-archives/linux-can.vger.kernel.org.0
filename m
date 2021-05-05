Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC5373B5F
	for <lists+linux-can@lfdr.de>; Wed,  5 May 2021 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhEEMgE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 5 May 2021 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhEEMgC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 May 2021 08:36:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30CC061574
        for <linux-can@vger.kernel.org>; Wed,  5 May 2021 05:35:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1leGk3-0006bv-Gj; Wed, 05 May 2021 14:35:03 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:96db:da04:b018:e517])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B771061D24C;
        Wed,  5 May 2021 12:35:02 +0000 (UTC)
Date:   Wed, 5 May 2021 14:35:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC] can: m_can: m_can_tx_work_queue(): fix tx_skb race
 condition
Message-ID: <20210505123501.np5f2xbx4jwkalv6@pengutronix.de>
References: <20210505114302.1241971-1-mkl@pengutronix.de>
 <20210505120659.bconnblkp5lhd52t@bigthink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sbl3lrujrt3yy3ag"
Content-Disposition: inline
In-Reply-To: <20210505120659.bconnblkp5lhd52t@bigthink>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--sbl3lrujrt3yy3ag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.05.2021 13:06:59, Torin Cooper-Bennun wrote:
> On Wed, May 05, 2021 at 01:43:02PM +0200, Marc Kleine-Budde wrote:
> > The m_can_start_xmit() function checks if the cdev->tx_skb is NULL and
> > returns with NETDEV_TX_BUSY in case tx_sbk is not NULL.
> >=20
> > There is a race condition in the m_can_tx_work_queue(), where first
> > the skb is send to the driver and then the case tx_sbk is set to NULL.
> > A TX complete IRQ might come in between and wake the queue, which
> > results in tx_skb not being cleared yet.
> >=20
> > Fixes: f524f829b75a ("can: m_can: Create a m_can platform framework")
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> > Hello,
> >=20
> > compile time tested only.
> >=20
> > Marc
>=20
> Thanks a lot for spotting this Marc, after initial testing this is
> working very well. I don't see that error message at all now, even at
> very high transmit rates, and dropped frames are reduced considerably.
>=20
> (Test setup: RPi CM4, TCAN4550, 500 kbit/s CAN-FD.)

Can I add your Tested-by?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sbl3lrujrt3yy3ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCSkPMACgkQqclaivrt
76kpzgf/ewNCUu3ORQGszxA1XNi5fXocPMyGoTYFJE6uwXkg0PrYwvaYKov8LLwf
qV021IeZl6rhNW2/+xxOrRmfvADLEQRWlkArNpfCZ2bVo3JJ1eXmAV091OdiFk/y
A13QVJ36vtvjI4UPGmmIet7IWzNjLSIA6xWZ6RKABVe4MC8dijgEUiSyRy8rQpvq
hAY9/7t+eyONhoAVdDBgpvwluq+sc89Zagn/9wUUUX46Z7jvtVyXubMtFE6WfnOZ
JtERIcMsqFgKOBYA9rmusgtiMc4iFL5RkHdynysSNYDbG+mFa4q4+feM2BN/BdU0
IOiq+ue7GYFeWUVkriQMT5cmekBSnQ==
=8G+q
-----END PGP SIGNATURE-----

--sbl3lrujrt3yy3ag--
