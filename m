Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A3649D09
	for <lists+linux-can@lfdr.de>; Mon, 12 Dec 2022 12:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiLLLHd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 12 Dec 2022 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiLLLG6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Dec 2022 06:06:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECC51181A
        for <linux-can@vger.kernel.org>; Mon, 12 Dec 2022 02:54:11 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1p4gRc-0002jk-Ps; Mon, 12 Dec 2022 11:54:00 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 62AFC13CAB4;
        Mon, 12 Dec 2022 10:53:57 +0000 (UTC)
Date:   Mon, 12 Dec 2022 11:53:56 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: can: renesas,rcar-canfd: Fix number of
 channels for R-Car V3U
Message-ID: <20221212105356.zkxb2h3ddowq5j3m@pengutronix.de>
References: <7d41d72cd7db2e90bae069ce57dbb672f17500ae.1670431681.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a5xjlq2pmlq6cfrf"
Content-Disposition: inline
In-Reply-To: <7d41d72cd7db2e90bae069ce57dbb672f17500ae.1670431681.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--a5xjlq2pmlq6cfrf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.12.2022 17:50:21, Geert Uytterhoeven wrote:
> According to the bindings, only two channels are supported.
> However, R-Car V3U supports eight, leading to "make dtbs" failures:
>=20
>         arch/arm64/boot/dts/renesas/r8a779a0-falcon.dtb: can@e6660000: Un=
evaluated properties are not allowed ('channel2', 'channel3', 'channel4', '=
channel5', 'channel6', 'channel7' were unexpected)
>=20
> Update the number of channels to 8 on R-Car V3U.
> While at it, prevent adding more properties to the channel nodes, as
> they must contain no other properties than a status property.
>=20
> Fixes: d6254d52d70de530 ("dt-bindings: can: renesas,rcar-canfd: Document =
r8a779a0 support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--a5xjlq2pmlq6cfrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOXCEEACgkQrX5LkNig
013jqgf/Sb3taUYXyF+M/vI10KCKU224fR9rV5Nu2paKi80cgc3QQxr+/CnHFf7v
19n42SiHmpiu1akc5e7i732OJi8m2w32i0WCyy5qkQfPNIYmlzaoCd45jVyZ80wO
9m3IpJHIODzpZRL0TLYfgg+XHMc1p0J1aEBY5Py5jPD0B/y3JEtbewsDw4oBMIah
tLMrANKjc8D1giBm2IG/OCR0Sq7iSXMHP4APbc07KWmGkls059JBKoEQv1XX0IYT
5JIwngQ5f+agO3HZV0h5XrVVtLijIOIGakQLRQXfzB6Q0rIqiaW+uRz+i6OFj8aF
L0naaAFQoAwz1zrwg6HH6q29hWEaFg==
=pXnD
-----END PGP SIGNATURE-----

--a5xjlq2pmlq6cfrf--
