Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256823A9C09
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFPNfO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 09:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFPNfN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 09:35:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747AC061574
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 06:33:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltVfF-00044J-W3; Wed, 16 Jun 2021 15:33:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:27:4a54:dbae:b593])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 16CE263D490;
        Wed, 16 Jun 2021 13:33:05 +0000 (UTC)
Date:   Wed, 16 Jun 2021 15:33:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: bittiming: fix two grammar mistakes in
 documentation for struct can_tdc
Message-ID: <20210616133304.txu6tt7v3ezfgvvi@pengutronix.de>
References: <20210616124057.60723-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uiexeids3bprc5zy"
Content-Disposition: inline
In-Reply-To: <20210616124057.60723-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--uiexeids3bprc5zy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.06.2021 21:40:57, Vincent Mailhol wrote:
> This patch fixes two grammar errors in the documentation for struct
> can_tdc.
>=20
> First grammar error: add a missing third person 's'.
>=20
> Second grammar error: replace "such as" by "such that". The intent is
> to give a condition, not an example.
>=20
> Fixes: 289ea9e4ae59 ("can: add new CAN FD bittiming parameters: Transmitt=
er Delay Compensation (TDC)")
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
> Hi Marc,
>=20
> If that makes sense to you, feel free to squash this in your other
> patch.

Makes sense. I've added you as Co-developed-by:

|     can: bittiming: fix documentation for struct can_tdc::tdcv
|    =20
|     This patch fixes a typo in the documentation for struct can_tdc::tdcv.
|     The number "0" refers to automatic mode not the letter "O".
|    =20
|     Further two grammar errors in the documentation for struct can_tdc are
|     fixed.
|    =20
|     First grammar error: add a missing third person 's'.
|    =20
|     Second grammar error: replace "such as" by "such that". The intent is
|     to give a condition, not an example.
|    =20
|     Fixes: 289ea9e4ae59 ("can: add new CAN FD bittiming parameters: Trans=
mitter Delay Compensation (TDC)")
|     Link: https://lore.kernel.org/r/20210616095922.2430415-1-mkl@pengutro=
nix.de
|     Link: https://lore.kernel.org/r/20210616124057.60723-1-mailhol.vincen=
t@wanadoo.fr
|     Co-developed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
|     Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
|     Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
|     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uiexeids3bprc5zy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDJ/X0ACgkQqclaivrt
76mnDQgAtxz2QuDwbAUmbxoNf66uj2Lk2IW4CJPNHpvvgfkb0JTeO3qtFBLHRbUF
aIzFfwTp17w76cJKFLFjqFXIryIc8pGtcktf2pyd0ffXQXmgW8XamQhTXlJeWoeS
RONKO6Tp2qqxrMj6IBVm374wlejp1fdyUYlQgM/ZxDScHH2rr7XFS1+o5Mz+MWoJ
Ei0dH03bMbjkpC2ijDnhQ28nuxwK2eGZyyrDYm2ySYWvd9wUbVSct6q3UzyyRat0
NVVMx0mRzBQEUBwRT78GBwNY5mVd6yxDevAaWcNaanuzI7rhSbDOaXQY8LV2+DUR
HFaDltUXvgGVwRjWDjWL1PBFP0H/Sg==
=11DW
-----END PGP SIGNATURE-----

--uiexeids3bprc5zy--
