Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3883B2D11
	for <lists+linux-can@lfdr.de>; Thu, 24 Jun 2021 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhFXK6w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Jun 2021 06:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhFXK6u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 06:58:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439EC061574
        for <linux-can@vger.kernel.org>; Thu, 24 Jun 2021 03:56:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lwN25-0002B7-P9; Thu, 24 Jun 2021 12:56:29 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:47f5:be86:773e:3d3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8D771642AF2;
        Thu, 24 Jun 2021 10:56:28 +0000 (UTC)
Date:   Thu, 24 Jun 2021 12:56:27 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 2/2] canbusload: count databitrate seperately
Message-ID: <20210624105627.bbvwpb72yglkyvtw@pengutronix.de>
References: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
 <20210624032111.26272-2-dev.kurt@vandijck-laurijssen.be>
 <20210624062551.3pqnx7tn3u55ucmc@pengutronix.de>
 <20210624104840.GA21224@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyg4g22h3ribkgow"
Content-Disposition: inline
In-Reply-To: <20210624104840.GA21224@x1.vandijck-laurijssen.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--lyg4g22h3ribkgow
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.06.2021 12:48:40, Kurt Van Dijck wrote:
> On Thu, 24 Jun 2021 08:25:51 +0200, Marc Kleine-Budde wrote:
> > On 24.06.2021 05:21:11, Kurt Van Dijck wrote:
> > > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> >=20
> > For the whole file, please add the usual spaces around operators.
>=20
> only the ones I introduced, I suppose?

Yes, don't introduce new style problem and in every line you touch also
fix them.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--lyg4g22h3ribkgow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmDUZNkACgkQqclaivrt
76kCDwf/buCUus0FrWjs8PIFEomw5IO5I7p/kZlVDZp/OKPJ7hZrQyKU0AMAw7ts
HPgC8+xXA4z6X5X9YBd9hSZjnWjiV3mU/AlZFaLi2IhT5qkvyuqjmrEgPVc5Ydr7
jI1NGnJx9/O5QMs1aPcS7XHv4aLQtQJ1gScz3K11krz+8dWnDMTQX5M5xspVRI5C
bxIh5z9RUA21RaUA+zFRk8cdgsvhx2vWK1YxyFM03Cv/6mvaDvTfYaWKadyPo4/A
YG3ofR4CKHaqemlTYwNlRl7DrOe3LT9w81ngmJA4RCw0pFSlpjA0pzNtEqHnX/MT
UI8eagqetuiYUE+KP3j2U4lOhaQDlA==
=LMHR
-----END PGP SIGNATURE-----

--lyg4g22h3ribkgow--
