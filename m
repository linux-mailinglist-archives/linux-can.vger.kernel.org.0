Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6370E3A977C
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 12:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhFPKgs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhFPKgK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 06:36:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C93C0611C2
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 03:33:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltSrd-0005yK-En; Wed, 16 Jun 2021 12:33:41 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:27:4a54:dbae:b593])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9A78563D1D3;
        Wed, 16 Jun 2021 10:33:40 +0000 (UTC)
Date:   Wed, 16 Jun 2021 12:33:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stephane Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can/peak_pci: Add name and FW version of the card in
 kernel buffer
Message-ID: <20210616103339.shohdxyak63d4j26@pengutronix.de>
References: <20210607150227.407184-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xb52vmh7lqojw27a"
Content-Disposition: inline
In-Reply-To: <20210607150227.407184-1-s.grosjean@peak-system.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xb52vmh7lqojw27a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.06.2021 17:02:27, Stephane Grosjean wrote:
> This patch adds name and (possibly) firmware version information to the
> kernel about the detected PEAK-System CAN - PCI/PCIe interface card.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Added to linux-can-next/test with the indention changed, See patch
series I've just send around.

https://lore.kernel.org/linux-can/20210616102811.2449426-10-mkl@pengutronix=
=2Ede/

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xb52vmh7lqojw27a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDJ04EACgkQqclaivrt
76nfgQf/fdXqBrFDvFk9MlwiwVjLbTHE1gvbWBtI7ZkdkOgrhTRPM5+xG4w70QSp
QFKL2qA2HE81pGUXiNK4vJRh9J5DDDhsVQuIrTWz9qeyWnNqjKfGnvHzWk609LBU
FnFLznmkxKuyv4DbM6dX1mjg3ZjqFYfbgMDe1lua+K1UAKG6B+DQYcVZxRVtMfkp
JFYZ6EvRxqy7l/hgTUxhuJBPA0lYNngajvn2ZNRyQQvhLG1J6ClNbANOK/i9UFHS
s9hO5f13kd5QGG7EUqeozzwM0HW7gb5aJw+kRlAkLit0v8q10mrnsBvDFzEfBtpW
avA1XDn2WHUb20TNbkhZh5GE1C3u6w==
=hQFz
-----END PGP SIGNATURE-----

--xb52vmh7lqojw27a--
