Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF13C8BAE
	for <lists+linux-can@lfdr.de>; Wed, 14 Jul 2021 21:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhGNTd6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 14 Jul 2021 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhGNTd6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Jul 2021 15:33:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1873C06175F
        for <linux-can@vger.kernel.org>; Wed, 14 Jul 2021 12:31:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m3kb3-0002z4-9L; Wed, 14 Jul 2021 21:31:05 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1d5a:f852:d9c2:1ad3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 38BC464F573;
        Wed, 14 Jul 2021 19:31:04 +0000 (UTC)
Date:   Wed, 14 Jul 2021 21:31:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 0/6] Miscellaneous small fix and improvements on driver
 etas_es58x
Message-ID: <20210714193103.vhnmir4dognftwng@pengutronix.de>
References: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m66mzz4x7ouqs7wy"
Content-Disposition: inline
In-Reply-To: <20210628155420.1176217-1-mailhol.vincent@wanadoo.fr>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--m66mzz4x7ouqs7wy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 29.06.2021 00:54:14, Vincent Mailhol wrote:
> This series fixes some issues on etas_es58x and add a few improvement,
> mostly on the code readability (i.e. no new features nor functional
> changes in this series).
>=20
> Vincent Mailhol (6):
>   can: etas_es58x: fix three typos in author name and documentation
>   can: etas_es58x: use error pointer during device probing
>   can: etas_es58x: use devm_kzalloc() to allocate device resources
>   can: etas_es58x: add es58x_free_netdevs() to factorize code
>   can: etas_es58x: use sizeof and sizeof_field macros instead of
>     constant values
>   can: etas_es58x: rewrite the message cast in es58{1,_fd}_tx_can_msg to
>     increase readability

Added to linux-can-next/testing

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--m66mzz4x7ouqs7wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDvO3QACgkQqclaivrt
76kRTAf+OjwB6pzwMSkQIAnHNWhimNRC8ALHsysw35J3qYKQagMeipFfMlwu+oIg
lZtculQyDOJFAcvUi22oxt2lGAMtWLxMzB3d12B4KEx8g0cCL6nx4uRsnyzCuw0K
b/CrEvbkiEpiKthKdhyMyvTT/Gp02TRtx1xj18q77kHnYJked/O+XKiP9ihp1RM+
mo52tkEuLmwvmCf+fnlIJrrr3yRmWg/88BedLzTF8ge6NypJGtsNy8MxVTDHV1yb
Sh+AGhRvxVMEbobwn4EiI2CLk54WYaeRSuEYmpF/ezu1Gv9EJmFmUKYlpn6B8YeW
glPAMTxPiBPSk6nxKzw4OOXj8Qy/rg==
=8plR
-----END PGP SIGNATURE-----

--m66mzz4x7ouqs7wy--
