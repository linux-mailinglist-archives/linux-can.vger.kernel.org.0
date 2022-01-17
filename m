Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF5A490BD0
	for <lists+linux-can@lfdr.de>; Mon, 17 Jan 2022 16:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiAQP4S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jan 2022 10:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbiAQP4R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jan 2022 10:56:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE570C061574
        for <linux-can@vger.kernel.org>; Mon, 17 Jan 2022 07:56:16 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n9UMh-0007iW-Cg; Mon, 17 Jan 2022 16:56:15 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8ED2A1AB2B;
        Mon, 17 Jan 2022 15:56:14 +0000 (UTC)
Date:   Mon, 17 Jan 2022 16:56:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Mirevik <markus.mirevik@dpsolutions.se>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: MCP251xFD runs interrupt handler twice per message.
Message-ID: <20220117155611.i7cdxcg4av2m6nzw@pengutronix.de>
References: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <87o84e1oj1.fsf@hardanger.blackshift.org>
 <HE1PR04MB3100B7CD240526C06FCA048EE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220116110941.6cqzm3skp57pnvth@pengutronix.de>
 <HE1PR04MB3100E5991C6FB420821F1F54E6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220117132716.y5q3vuayjgqhwpro@pengutronix.de>
 <HE1PR04MB310040456777CCDE2DF03FEAE6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220117150833.d4e4f4dhjvsvmxkt@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vpsziiqsokbtkk6r"
Content-Disposition: inline
In-Reply-To: <20220117150833.d4e4f4dhjvsvmxkt@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vpsziiqsokbtkk6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.01.2022 16:08:33, Marc Kleine-Budde wrote:
> It looks like this is not a problem of the mcp251xfd driver. I think now
> it's time to ask an am335x expert. Maybe one of my coworker knows this
> issue.

Doesn't ring any bell.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vpsziiqsokbtkk6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHlkZgACgkQqclaivrt
76lnLggAhDFeT1dVG1yxjVqyLipgk9N6uzRKziMvIXZESSppcjQgDhq3icNuQyAi
u6Hw4Gnh9UHOvDCeIr9d8jkbQKi9gwbBFUdF8cmufJSzz0wvizurgurrEax4xXxq
Mlx4frRiLYdsGD9f3G2+SJOCS79cajRLItumD0B3UCLcwb9jJG82auWCxVUoWF68
iJ/WeTcPvo4hY0vGMvbV/V7LZd/7yi1XOHXcL93TwPH4Mkrowf+201teFSmyOEIB
YMZ2UvYhzP/5r2BLYV/6s8976h+hsqFdwDWcjmQ/R6W64LXZ6Pdc1JTZZj23zYgi
sjJ+3/xmNsl/3YoBNxcThhq5DgD8kw==
=zxIo
-----END PGP SIGNATURE-----

--vpsziiqsokbtkk6r--
