Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18F6672782
	for <lists+linux-can@lfdr.de>; Wed, 18 Jan 2023 19:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjARSzm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 Jan 2023 13:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjARSzl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2023 13:55:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16835957F
        for <linux-can@vger.kernel.org>; Wed, 18 Jan 2023 10:55:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pIDak-0000fm-BE; Wed, 18 Jan 2023 19:55:22 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:edde:b534:8a61:9dbc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B526B15B0E4;
        Wed, 18 Jan 2023 18:55:19 +0000 (UTC)
Date:   Wed, 18 Jan 2023 19:55:11 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/2] phy: Add support for NXP TJR1443 CAN Transceiver
Message-ID: <20230118185511.jepo6sseafg452sk@pengutronix.de>
References: <cover.1674037830.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vankhrwftcwisvsj"
Content-Disposition: inline
In-Reply-To: <cover.1674037830.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--vankhrwftcwisvsj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.01.2023 11:39:22, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> The NXP TJR1443 High-speed CAN transceiver with Sleep mode is a
> pin-compatible alternative for the TI TCAN1043.  Hence this patch series
> adds support for it to the existing TI TCAN1043 DT bindings and to the
> generic CAN Transceiver PHY driver.
>=20
> This has been tested on the Renesas White-Hawk development board.
>=20
> Thanks for your comments!

For both patches:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vankhrwftcwisvsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPIQIwACgkQrX5LkNig
013+TAf9FCnLGd5e/KZG5ygyduglODeGFDaDHkAb8Iks0AB7NzKvx8eMDOqoYnwB
JPPpZMN5KxvE1E+8LSZ1IHygxiCtG9LwySztiQebfIhBLO4JkiIJR8w4x++viN0h
5gKC5/PuBIa1v0znqOH44kRMKCIspJ4c1ALfav3ZRG5CBmJRYAR33CMtyqwrSRUm
YKf1dJPoCBno/ll1j4hz/LWbQO5kBWw6itRVsm+fR66q/tiQtTtWTyq+zxZnfVnk
vxNfuUSOrze5dIhmEVGnDhF+Vj5TDnVV4GfImBAbfD5zkqAaqq3DOuwoFeHMS78m
/H7j72RSD4zA7zdw+Y9kT00/g+nLWA==
=YaNG
-----END PGP SIGNATURE-----

--vankhrwftcwisvsj--
