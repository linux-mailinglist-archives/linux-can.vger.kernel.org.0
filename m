Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75B3492396
	for <lists+linux-can@lfdr.de>; Tue, 18 Jan 2022 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiARKQ1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jan 2022 05:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiARKQZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jan 2022 05:16:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF174C061574
        for <linux-can@vger.kernel.org>; Tue, 18 Jan 2022 02:16:24 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n9lXL-0005te-3K; Tue, 18 Jan 2022 11:16:23 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 30EC01C709;
        Tue, 18 Jan 2022 10:16:22 +0000 (UTC)
Date:   Tue, 18 Jan 2022 11:16:18 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Mirevik <markus.mirevik@dpsolutions.se>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: MCP251xFD runs interrupt handler twice per message.
Message-ID: <20220118101618.5xhgy7psrfjnjmpn@pengutronix.de>
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
        protocol="application/pgp-signature"; boundary="3wsd5dff6f4igchy"
Content-Disposition: inline
In-Reply-To: <20220117150833.d4e4f4dhjvsvmxkt@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--3wsd5dff6f4igchy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.01.2022 16:08:33, Marc Kleine-Budde wrote:
> On 17.01.2022 14:53:46, Markus Mirevik wrote:
> > > That scope picture looks good! Can you include both runs of the IRQ
> > > handler in one scope picture? I'm interested if there is activity or
> > > a glich on IRQ line.
> > =20
> > Both are included. The last (number 7) is the one extra reading of the
> > register!?
>=20
> Doh! Indeed, you'r right, missed that.

Can you take a scope picture with falling edge triggered IRQ?

(Note for the out of context reader: _Always_ use level triggered IRQs
 with the mcp251xfd in production use.)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--3wsd5dff6f4igchy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHmk3AACgkQqclaivrt
76nQaAf/fQzN7NXN4RCfIxVaVdC7rJHSL7SmoVHXM7QnmLFSf9MjACNNemqlI256
PAck9R6gg9yI2ZfOtW9VBjv/V+HN5zTpdaCrleWbGP7ys1KhnHXZrxdFj6ePD4nc
RhzygNFG4uEfeWsv3D6rPNYWi0TpL1yIHWt1Sx0lL40Onk9w3nN1mof1tm39YPkF
o1o+rfVYKL2wXUZmoWpP5HLACaP1AvlLK3HvMj8JvSnXKCX9tc9g8e6NXSChgMHT
PzA7ilrox82C7SpJkOFnV0zc2lx7SVwiw4mmfBUm11jYoBb0rm+Njui6JylzJJsP
pVt1LyC1iUiuMfvqjBaynVCjP5GnIg==
=4nAW
-----END PGP SIGNATURE-----

--3wsd5dff6f4igchy--
