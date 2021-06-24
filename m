Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234BB3B2D65
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhFXLO5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 07:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhFXLO5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 07:14:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6507AC061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 04:12:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwNHg-0004Rb-Sx
        for linux-can@vger.kernel.org; Thu, 24 Jun 2021 13:12:36 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 3E4B2642B31
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 11:12:36 +0000 (UTC)
Date:   Thu, 24 Jun 2021 13:12:35 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Subject: Re: [PATCH 3/3] can-calc-bittiming: add mcan
Message-ID: <20210624111235.i5fjrpca2ivmt4dh@pengutronix.de>
References: <20210624031954.26195-1-dev.kurt@vandijck-laurijssen.be>
 <20210624031954.26195-3-dev.kurt@vandijck-laurijssen.be>
 <20210624105005.2kgj6o5hwskl6rqo@pengutronix.de>
 <20210624105731.GB21224@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xk2dbqw3fnbvs7g2"
Content-Disposition: inline
In-Reply-To: <20210624105731.GB21224@x1.vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xk2dbqw3fnbvs7g2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 12:57:31, Kurt Van Dijck wrote:
> btw, I just noticed I already have can-utils in my github account, I'll
> create a Merge-Request for this V2 too, if you like.

Go ahead, I've already reviewed the other changes there.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--xk2dbqw3fnbvs7g2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUaKEACgkQqclaivrt
76lPIAf/XrxS2CAiF77zuWDR5YZV35Oh0C6e5qWxG6Tm0PNnpbHMigoMHFnMFL09
szzjjUFCXVYjx9MadTt5pYG00H5CX0KUybZsWprwNsgWRBktY+FgCw8jGUKqeuxQ
KXjHRR/BjWd1yIhsfYYq2gVnOM6sUUJ66ffi8btw3eP4CBhMxMaadivBuaJEaLVI
wdgLwDtKFpLiAqjEJcayV+P23LD0LtxtYNM8PAUSfEnmo/RTjetww+xD7Hl48INy
wvMh2Ht1W7ZJXtO/7HUpbU4pz3st1KPKtNLN6T0ahbqeWvgfysHJtFy3dmECqlN6
kAx7E3GKqJmJyshkz1wnV2GJiPIvZw==
=0Vmp
-----END PGP SIGNATURE-----

--xk2dbqw3fnbvs7g2--
