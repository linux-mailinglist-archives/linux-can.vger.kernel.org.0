Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523A53320BB
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 09:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCIIeu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 03:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCIIeo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 03:34:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76544C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 00:34:44 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lJXpB-00053j-Tw; Tue, 09 Mar 2021 09:34:41 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:4699:faa8:8510:ac25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 1D6385F150C;
        Tue,  9 Mar 2021 08:34:40 +0000 (UTC)
Date:   Tue, 9 Mar 2021 09:34:39 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2 1/5] can: add new CAN FD bittiming parameters:
 Transmitter Delay Compensation (TDC)
Message-ID: <20210309083439.ltepbnol3jxp7mey@pengutronix.de>
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-2-mailhol.vincent@wanadoo.fr>
 <20210224073140.vinoopn5zoxvyuq3@pengutronix.de>
 <d0761226-9509-18e1-b36b-ba6318eccb3f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pagoqic3zo33eorh"
Content-Disposition: inline
In-Reply-To: <d0761226-9509-18e1-b36b-ba6318eccb3f@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--pagoqic3zo33eorh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.03.2021 09:30:19, Jimmy Assarsson wrote:
> Can't find this in linux-can-next/testing
> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dtesting

Try again.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pagoqic3zo33eorh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBHMxwACgkQqclaivrt
76l7wwf+KF460IAxB87e9YA/foQR66rZImIFFtPBL+3xSOjvBWl8uydCyPWh/s6R
o5apVHL9/yMBd5rCsI0P7JBP0uZUR9i/q1LeNxq4sHarGFpCnYZpaZGBz1HVDt/h
0M4VWTudae8AIlwAnrJPLMmNFwkVVEwacStEpOPPlZiXwpP7ajGoGkTFkqUGbPXN
7WdbLb5k6UfIxWkfjIKX0V8TCvsk0PPRAQrHAdY12/Nu1zoATv0GRbb7PYStnYbS
frgRKDTa+8smvtx2vMKa7V/Fit65wf/MW37fItYnqSQGYRHfJj82l5t1upVxtb5p
PMT86FLwmxeGBSUc6EPhrCGYZWusCQ==
=zT+5
-----END PGP SIGNATURE-----

--pagoqic3zo33eorh--
