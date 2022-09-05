Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929AF5AD717
	for <lists+linux-can@lfdr.de>; Mon,  5 Sep 2022 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiIEQIQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 5 Sep 2022 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiIEQIO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Sep 2022 12:08:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FA52FC2
        for <linux-can@vger.kernel.org>; Mon,  5 Sep 2022 09:08:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVEdn-0006Zz-5X; Mon, 05 Sep 2022 18:08:03 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:b4c0:a600:5e68:1e31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7D5E1DAE49;
        Mon,  5 Sep 2022 16:07:59 +0000 (UTC)
Date:   Mon, 5 Sep 2022 18:07:58 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add RZ/N1 CAN support
Message-ID: <20220905160758.ieo673gvaejjjfuk@pengutronix.de>
References: <20220830164518.1381632-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nsjn2kvc26marjpe"
Content-Disposition: inline
In-Reply-To: <20220830164518.1381632-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--nsjn2kvc26marjpe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 30.08.2022 17:45:15, Biju Das wrote:
> This patch series supports CAN{0,1} populated on RZ/N1D-DB board.
>=20
> v2->v3:
>  * Documented power-domains support.
>  * Dropped clock-names property from CAN nodes.
>  * Added power-domains property to the CAN nodes.
> v1->v2:
>  * Added RZ/N1 specific compatible string.
>  * Added clock-names property.
>=20
> This patch series depend upon [1]
> [1] https://lore.kernel.org/linux-renesas-soc/20220819084532.ywtziogd7ycu=
ozxx@pengutronix.de/
>=20
> Biju Das (3):
>   dt-bindings: can: nxp,sja1000: Document RZ/N1 power-domains support
>   ARM: dts: r9a06g032: Add CAN{0,1} nodes
>   ARM: dts: r9a06g032-rzn1d400-db: Enable CAN{0,1}

Who will take this series (once it's ready)?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--nsjn2kvc26marjpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmMWHtsACgkQrX5LkNig
010tEQf/c6wxsAtkk9juo78qnWJ/Zz4LeBRai7FsC1dZ9fBkI4rjUgi0LRkw6Ntj
TTKkaqnGWa9kGuenTGlNl/QJyfusNbVtjPWksSQTEhBp2hi1qtvSASC4PMTDxdDS
IzKttNWms2+xRbGuk5QGIQKAvmSfmKgZ2DcSGyHD9bPGx60BoGSDZj7jSd2qIkZN
fIVyU9WNcgpUfDBJxlE26XcvLCt6CbfMtd/dWawUEZrB9AHYdguLLquAwY71z8N+
6SIpkzsiQlTWV/PIKl8h8aVGjSVYVY8ydD4diYDOdIIm6P94Mv3WjU6CGzXTOF/s
ln5j/uFTn78JRHD9gDKZ7PqUOt30bw==
=iypP
-----END PGP SIGNATURE-----

--nsjn2kvc26marjpe--
