Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA139DFE6
	for <lists+linux-can@lfdr.de>; Mon,  7 Jun 2021 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFGPDD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 7 Jun 2021 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhFGPDD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Jun 2021 11:03:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC4C061766
        for <linux-can@vger.kernel.org>; Mon,  7 Jun 2021 08:01:12 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lqGkY-0002SP-HS; Mon, 07 Jun 2021 17:01:10 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:c419:f23b:a49d:11f9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 899AF635A39;
        Mon,  7 Jun 2021 15:01:09 +0000 (UTC)
Date:   Mon, 7 Jun 2021 17:01:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: Align the table of comments
Message-ID: <20210607150108.r5idhfnaxdccaduc@pengutronix.de>
References: <20210603142450.2221703-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g2w4db7tfcw5hl5h"
Content-Disposition: inline
In-Reply-To: <20210603142450.2221703-1-festevam@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--g2w4db7tfcw5hl5h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.06.2021 11:24:50, Fabio Estevam wrote:
> Align the table of comments for better readability.

My editor uses 1 tab =3D 8 spaces and it looks correct without the patch.
Have a look at:

| tps://elixir.bootlin.com/linux/v5.12/source/drivers/net/can/spi/mcp251xfd=
/mcp251xfd-core.c#L2915

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--g2w4db7tfcw5hl5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmC+NLAACgkQqclaivrt
76l8dAf+I8LcOAUPS+vPE4f8IFqN2JcTNX1u0ft5MwY19vkCa/k6xkAXc7AjyZic
uotU5wv8/mR/g3hEc6o2sQH/5R1dSiYGVdLYrsGJEMei4QXeGMYDoFoI0EKdvpqh
zRMu1hTeNpWPTr04aarLjF4MBw5Nbr1S3LphQ8Gq+SJG3Lo/BSlV3h1aCED/VeHx
qk13X8+yyLkPmpLm74VW+OL5tShgjiHAkmFO1I3JC5rRNVxj79w8R8nwHdWjGU07
/B6iyX88ZK8pB8Bgqw5SXqUqqb4yHEKBwID3O7jJDb0c96ZWDGyRgIiP8w62qIuX
ZveiHmtrOhYdGqjTVCloY2jKJ009oQ==
=G+nH
-----END PGP SIGNATURE-----

--g2w4db7tfcw5hl5h--
