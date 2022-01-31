Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691484A3F9B
	for <lists+linux-can@lfdr.de>; Mon, 31 Jan 2022 10:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbiAaJ64 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 31 Jan 2022 04:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244400AbiAaJ6z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 31 Jan 2022 04:58:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92002C061714
        for <linux-can@vger.kernel.org>; Mon, 31 Jan 2022 01:58:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nETSX-0004Sh-3K; Mon, 31 Jan 2022 10:58:53 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9A6B428389;
        Mon, 31 Jan 2022 09:58:52 +0000 (UTC)
Date:   Mon, 31 Jan 2022 10:58:49 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     petter@ka-long.de
Cc:     linux-can@vger.kernel.org
Subject: Re: MCP2518FD : Failed to detect MCP2518FD (osc=0x00000000)
Message-ID: <20220131095849.5iw4jgeexc3egnb6@pengutronix.de>
References: <20220131083304.122C45B0007E@dd15738.kasserver.com>
 <20220131084205.53otmukeyt2dt4zj@pengutronix.de>
 <20220131093554.505C65B0025F@dd15738.kasserver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j72aytm56jg2y5uh"
Content-Disposition: inline
In-Reply-To: <20220131093554.505C65B0025F@dd15738.kasserver.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--j72aytm56jg2y5uh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.01.2022 10:35:54, petter@ka-long.de wrote:
> I have disabled DMAs in imx7s.dtsi for all ecspis and recompile the
> device tree. Still get the same failure.

You can check if that really works by looking at the used DT:

$ dtc -I fs /proc/device-tree

Next step would be to get a scope and attach it to the MISO/MOSI/CLk/CS
pins.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--j72aytm56jg2y5uh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmH3stYACgkQqclaivrt
76lSKwf+NCyaWaYU6y1mE7g6x50pXGUVzBsYUfqg/VzqbeZsTVT9mVuVYLa8ghJj
Z3+ePoLrcNRdZQxXw0CR6ioBz2x/iKsWAmye5H7vqfgJtDPUdMeuYmPxZDwLwdfC
6maMf0qgUog52GQmExZelLKLBgFuJ1VOFwRYZI+EAsM9I49I5CKu6Crw97xO1N83
YdBpw22vGzs1S9dYfsl3HMTx1WjHTcEbLvMNzXKT986s2Q8eQXkC48IdsstIcqRe
oK/WAlc5mlLCKW2oKnqQMRSFUu2d4kXKOISbgTdIqJ90xb24iNNSPTfzxuo7q3RW
SAH3hKvIN2/iu4R1DHd0pbSx9NKTAw==
=xBsG
-----END PGP SIGNATURE-----

--j72aytm56jg2y5uh--
