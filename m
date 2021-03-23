Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52383458B9
	for <lists+linux-can@lfdr.de>; Tue, 23 Mar 2021 08:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbhCWHbo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Mar 2021 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCWHbo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Mar 2021 03:31:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3109C061574
        for <linux-can@vger.kernel.org>; Tue, 23 Mar 2021 00:31:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lObVt-0005mf-NJ; Tue, 23 Mar 2021 08:31:41 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:c81e:25b5:b851:4b31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 71DFC5FDBDD;
        Tue, 23 Mar 2021 07:26:07 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:26:06 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>
Subject: Re: CAN performance test
Message-ID: <20210323072606.nara6bctyuj6mpfl@pengutronix.de>
References: <DB8PR04MB6795C0366E4B43B3D12461EDE6649@DB8PR04MB6795.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qsz3rundxy3vrft3"
Content-Disposition: inline
In-Reply-To: <DB8PR04MB6795C0366E4B43B3D12461EDE6649@DB8PR04MB6795.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--qsz3rundxy3vrft3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.03.2021 04:31:41, Joakim Zhang wrote:
> Do you know there is some easy ways for us to test CAN performance? I
> tested it before by hardcode the driver, it's not a good way. Thanks a
> lot!

I usually use cansequence to test TX and RX performance independent of
each other, or canfdtest for a full duplex test.

cansequence sends CAN frames as fast as possible, while canfdtest has
some sleeps to properly interlace the RX and TX path.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--qsz3rundxy3vrft3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBZmAwACgkQqclaivrt
76l0bwf/YoP/Rp5M+BWC78iG12hxTtquKWSsBSL7LQGqyrLuZ2TQ+vMkjQOdEU8x
mpT624IHnIpVOf+js4SARJj4XhTz2iseoA6X8YmRZ7lY4Xer8QZM5F7zdQrg4qEr
p9CVKl9/mU2IJNnaTtwLDgc/d7F4+JrDb+sd+pt5o7Fqy3grHpjAmSDrR0vY4UKF
3HNfARdmeUJppcrSeZZqJ9xqzLzd2ItNa1FlF4GvzOGNqMVtqaH+z//F+arCD787
uQiIvgsNfIrsfJaMHWCKc5NwwiQpF1xxO/qYHwy0dTMV6wu4I9yha2x6auputgY/
/0BGf5E+8CgujDqsEv/KepKwg/Kz1w==
=aBsY
-----END PGP SIGNATURE-----

--qsz3rundxy3vrft3--
