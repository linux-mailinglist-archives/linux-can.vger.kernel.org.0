Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7774F08E5
	for <lists+linux-can@lfdr.de>; Sun,  3 Apr 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241092AbiDCLHD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 3 Apr 2022 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiDCLHC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 3 Apr 2022 07:07:02 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Apr 2022 04:05:07 PDT
Received: from glittertind.blackshift.org (glittertind.blackshift.org [IPv6:2a01:4f8:1c1c:29e9::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5376933A13
        for <linux-can@vger.kernel.org>; Sun,  3 Apr 2022 04:05:06 -0700 (PDT)
Received: from bjornoya.blackshift.org (unknown [IPv6:2a03:f580:87bc:d400:dea6:32ff:feb1:177a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "bjornoya.blackshift.org", Issuer "R3" (verified OK))
        by glittertind.blackshift.org (Postfix) with ESMTPS id 4D8F64E1401;
        Sun,  3 Apr 2022 10:57:31 +0000 (UTC)
Received: from pengutronix.de (2a03-f580-87bc-d400-26f0-2eea-19ae-c646.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:26f0:2eea:19ae:c646])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B5B3A592CE;
        Sun,  3 Apr 2022 10:57:30 +0000 (UTC)
Date:   Sun, 3 Apr 2022 12:57:30 +0200
From:   Marc Kleine-Budde <mkl@blackshift.org>
To:     Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Message-ID: <20220403105730.fnurim5vnnuxb7s5@pengutronix.de>
References: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="povyccbvnqehycyq"
Content-Disposition: inline
In-Reply-To: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--povyccbvnqehycyq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wouter,

On 01.04.2022 13:23:43, Wouter van Herpen wrote:
> When using the tcan4x5x under high load of both RX/TX interrupts, at
> some point the nINT signal stays asserted, causing the socket to block
> in user space.
>=20
> This reproduces very reliably (in my system) when both reading/writing
> at 1ms intervals at CAN bus speed 1Mbps. When it occurs, M_CAN_IR is
> set to 0x580d and never recovers (causing nINT to stay asserted). The
> problem does not occur when only reading or only writing.
>=20
> After checking the m_can_isr() function from
> drivers/net/can/m_can/m_can.c, I noticed that MCAN interrupts are
> disabled while processing the IR_RF0N flag, but not while processing
> IR_TEFN. I'm not sure why, aren't both handlers running from the same
> interrupt context and communicating to MRAM via SPI?

Thanks for your analysis. Without looking deeper into it, that sounds
reasonable.

> I'm running kernel version 5.4.24 but I can see that in e.g. 5.17.0
> this still applies. When I disable interrupts during IR_TEFN handling,
> the blocking socket / nINT issue is gone.

Can you send a patch fixing the problem? Please include a patch
description and your Signed-off-by:

https://elixir.bootlin.com/linux/v5.12/source/Documentation/process/submitt=
ing-patches.rst#L356

regards,
Marc

--povyccbvnqehycyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJJfZcACgkQrX5LkNig
013UYQf/dngThF4sY5aXnpvt+H73GnmtabKyAOyTmv3x++ZQaXk0bdYVAGY9KE4Z
0XW6GWP+E+CmCm68KKnfIBU0RaybDGr3IbruR3y1pEtH1xFo8dsf5XlT7XNUXTZu
PanQDRtAJph8siSR1vWj7lZqc5/K/Rx/7BDHe6KqEj174yOHxVrhQUkkFGPu8xnp
DbFByWLY7zx38B6Neg8OYpgtBChr9jQOrUP+31cxQZxHUN2PjPNw4OJIROk10b6Y
2oHTwW8ghUnBqpxZWPkmIl6Su1agADhBIBSEzIPns1MilJX/QbXGZd+FpQQ60ntz
50iQlXn0ruzTuzpWyQEJAIsizkZcoA==
=4yCi
-----END PGP SIGNATURE-----

--povyccbvnqehycyq--
