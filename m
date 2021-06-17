Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8663AB1B1
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhFQK6d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 06:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhFQK6d (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Jun 2021 06:58:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF135C061574
        for <linux-can@vger.kernel.org>; Thu, 17 Jun 2021 03:56:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltphA-0007lY-0L; Thu, 17 Jun 2021 12:56:24 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:653d:6f2f:e25e:5f2e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D5F9863DFEE;
        Thu, 17 Jun 2021 10:56:22 +0000 (UTC)
Date:   Thu, 17 Jun 2021 12:56:22 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH] can: bittiming: fix two grammar mistakes in
 documentation for struct can_tdc
Message-ID: <20210617105622.x3lvuljqaju24tda@pengutronix.de>
References: <20210616124057.60723-1-mailhol.vincent@wanadoo.fr>
 <20210616133304.txu6tt7v3ezfgvvi@pengutronix.de>
 <CAMZ6RqKF=TkE9099ip2Ac_t+kcC1Ztba6+hzAuTi3-_qLk+Aaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="43uqa6swksfatvbe"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKF=TkE9099ip2Ac_t+kcC1Ztba6+hzAuTi3-_qLk+Aaw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--43uqa6swksfatvbe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.06.2021 01:18:00, Vincent MAILHOL wrote:
> > |     can: bittiming: fix documentation for struct can_tdc::tdcv
>=20
> One nitpick: the title should become
> |     can: bittiming: fix documentation for struct can_tdc
> (without the ::tdcv) because the last fix is on tdco.

updated.

Tnx,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--43uqa6swksfatvbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDLKlMACgkQqclaivrt
76mFDwf+Ke91tNMhGQFeTFWGppkvtlWM3uThb8GukVkqPbMGbgFv/v0aQTTV4r3z
Rep13Qu2dJbJx7MpRw1K541aiHq0SuX4H7MsyBTIPyEG83/lpy+NAaOi6gWaBWkj
3cRMWRcslP9kij4zoI8rtdsh+wXqeh5R8l+zYbveoO3r/jHC+G3nh6h3afg1aFxc
F8U94s21EB6K0drcHpR5nXE2S0mrzD7bMakv5H2Lgh6j2qSMdGMWPKFuIq8pYUt9
pVTs3lQgGkJ9qckkPzLJCtfpK3jZuOGrF0pK++Q/jEzlw7gLhZoeyGbKR+sCRd36
MXNui1WbU0gMa29bsGXB10zNvykuWg==
=Etfp
-----END PGP SIGNATURE-----

--43uqa6swksfatvbe--
