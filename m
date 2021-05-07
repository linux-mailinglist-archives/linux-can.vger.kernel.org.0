Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043E4376586
	for <lists+linux-can@lfdr.de>; Fri,  7 May 2021 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhEGMvV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 May 2021 08:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhEGMvV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 May 2021 08:51:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91297C061574
        for <linux-can@vger.kernel.org>; Fri,  7 May 2021 05:50:21 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lezvv-0000xi-8M; Fri, 07 May 2021 14:50:19 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:1c71:1fb7:6204:3618])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 20D4961ECDD;
        Fri,  7 May 2021 12:50:18 +0000 (UTC)
Date:   Fri, 7 May 2021 14:50:17 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC] can: isotp: isotp_sendmsg(): return error on FC
 timeout on TX path
Message-ID: <20210507125017.hu3rcilzcw4rknof@pengutronix.de>
References: <e9ebf4ab4b1a431eac24a21ab8379894@liebherr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2pmmuqwrwvexrc3e"
Content-Disposition: inline
In-Reply-To: <e9ebf4ab4b1a431eac24a21ab8379894@liebherr.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2pmmuqwrwvexrc3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.05.2021 12:29:33, Sottas Guillaume (LMB) wrote:
> Indeed the first version (with positive value) does not work, but I
> just tested the V2 of the patch, and work like a charm. Let me know if
> I can help to get it integrated

You can send you Tested-by to that v2 patch, like Oliver did to the v1.
The patch will be part of my next pull request to net/master.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2pmmuqwrwvexrc3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCVN4YACgkQqclaivrt
76mhqwf/TxzCzMcDp6oBL2gXcJ3C/eU6A2Wwa/vNsdoDii0TXIvXTFvNEMpBiTJM
YxHKHM5fXvBe+7JVEqAhjBQDxmGTxdL944afBXpAhJXyJsf9YFsZspVZQXBI37fQ
uw+W14BMPcuzEAErC8c/W6tp3j9VOukIM//AraFADcayLKa+sNHL7SbCdJC8hhso
9odePf+IlN5AtGvhcM/y9m5ebCwEeaDjHtIFWTDCz6d17YkMJ3HFwPl/WjMIPZzL
+izQNYNXIHo9JbdM3H8ZHteYuHdW6H1mihY5w6UFXsmbtXR0CU0Mpt7IaAl+0l9O
TNRVNnfio2ceM5x0RTHpzTM5KCU09w==
=1rXF
-----END PGP SIGNATURE-----

--2pmmuqwrwvexrc3e--
