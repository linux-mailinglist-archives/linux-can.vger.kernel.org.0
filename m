Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B967D3B275D
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 08:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFXG2O (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 02:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFXG2O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 02:28:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5BC061574
        for <linux-can@vger.kernel.org>; Wed, 23 Jun 2021 23:25:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwIoD-0006pq-Lz; Thu, 24 Jun 2021 08:25:53 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 93EA464278D;
        Thu, 24 Jun 2021 06:25:52 +0000 (UTC)
Date:   Thu, 24 Jun 2021 08:25:51 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 2/2] canbusload: count databitrate seperately
Message-ID: <20210624062551.3pqnx7tn3u55ucmc@pengutronix.de>
References: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
 <20210624032111.26272-2-dev.kurt@vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gdxcacg232st2xzo"
Content-Disposition: inline
In-Reply-To: <20210624032111.26272-2-dev.kurt@vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--gdxcacg232st2xzo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 05:21:11, Kurt Van Dijck wrote:
> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

For the whole file, please add the usual spaces around operators.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gdxcacg232st2xzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUJW0ACgkQqclaivrt
76nt7wgAnP9s6TNO+bGimxEN7bR+z+pk4flHS4zZZjpC0Yh5CeXJ37NwUF/5HSsL
CG9NbcQiHOQ2vJqyLED2UHU0nsEpuMKruoQkbwkMfCXvEU86y/JAOOK6l6Q82Hag
BT1t1mqERyOQtnsOQPPNSqCUGONBGXcJ+PqMaKLZfCRYjkqwHWCqbiuz2VTVosVF
IYiHahAe6PeyyGlK10mwFONXkVln7/cp/ybpL3nLn3ZNbEuB+CiDnwtSlfQFhDeJ
ITgIVZ0+J+++Ng7/4Mf2+iNhPno6sOrVMJ7znY6QBJs1i2N2/7X360B1+3ORZOVF
ms1m3/C3zgYbqtBK7YXh2udmcRxCqA==
=1/ua
-----END PGP SIGNATURE-----

--gdxcacg232st2xzo--
