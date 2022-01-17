Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8230F490B29
	for <lists+linux-can@lfdr.de>; Mon, 17 Jan 2022 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbiAQPIk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jan 2022 10:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiAQPIk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jan 2022 10:08:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD9C06161C
        for <linux-can@vger.kernel.org>; Mon, 17 Jan 2022 07:08:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n9Tcc-0001T2-26; Mon, 17 Jan 2022 16:08:38 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5E0941AA96;
        Mon, 17 Jan 2022 15:08:37 +0000 (UTC)
Date:   Mon, 17 Jan 2022 16:08:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Markus Mirevik <markus.mirevik@dpsolutions.se>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: MCP251xFD runs interrupt handler twice per message.
Message-ID: <20220117150833.d4e4f4dhjvsvmxkt@pengutronix.de>
References: <HE1PR04MB310066D557C9D77FE357D90AE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <87o84e1oj1.fsf@hardanger.blackshift.org>
 <HE1PR04MB3100B7CD240526C06FCA048EE6549@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220116110941.6cqzm3skp57pnvth@pengutronix.de>
 <HE1PR04MB3100E5991C6FB420821F1F54E6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
 <20220117132716.y5q3vuayjgqhwpro@pengutronix.de>
 <HE1PR04MB310040456777CCDE2DF03FEAE6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="52xemgmmhahtvomi"
Content-Disposition: inline
In-Reply-To: <HE1PR04MB310040456777CCDE2DF03FEAE6579@HE1PR04MB3100.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--52xemgmmhahtvomi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.01.2022 14:53:46, Markus Mirevik wrote:
> > That scope picture looks good! Can you include both runs of the IRQ
> > handler in one scope picture? I'm interested if there is activity or
> > a glich on IRQ line.
> =20
> Both are included. The last (number 7) is the one extra reading of the
> register!?

Doh! Indeed, you'r right, missed that.

> > After you've that picture, you can try to catch glitches on the IRQ
> > line. If your scope allows this, setup a trigger on the INT channel
> > that triggers if the channel is low for considerably less then it
> > takes to clear the IRQ.
> >=20
> > Currently it takes about 160=C2=B5s to clear the IRQ, so setup a trigger
> > for less than 50=C2=B5s.
>
> No glitches. The scope can trigger on glitch but no one is to be
> found.

Good.

It looks like this is not a problem of the mcp251xfd driver. I think now
it's time to ask an am335x expert. Maybe one of my coworker knows this
issue.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--52xemgmmhahtvomi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHlhm8ACgkQqclaivrt
76l/1Af/X5oA93VMi1dkafp93Mb6C0q5I5LuZqok0tMefzM8R/pBjpIunwnlw14R
CRZfkSogENAIh/z0OgjdjvpxlDv7mXEM9vAUuyvuyO7NYJdVNEgflk1TnB/vBFuB
dRfb28839TXTBTudutCwecZP1O9t2Cti4TFlOVVSZvqOiELRS81wDpY0a7mn96RG
D4PUmB8RVJvz6X8nWtosC6fDuG1YaJ5m92ZJDEEXV6saaIYMQ7kzTnxwjuP+saYG
pAmfb5zAzw8UNtsTOOT5FvtDzaTS92QM8EGnN2NX9ZHNt87dnkPn+1uSJ4yIv6eo
Iv/Cz8dPPQRFO0sdVOM43F9PxPKgww==
=GG+G
-----END PGP SIGNATURE-----

--52xemgmmhahtvomi--
