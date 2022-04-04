Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD94F1DCC
	for <lists+linux-can@lfdr.de>; Mon,  4 Apr 2022 23:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383107AbiDDVlZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Apr 2022 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380323AbiDDTdE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Apr 2022 15:33:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593E20F41
        for <linux-can@vger.kernel.org>; Mon,  4 Apr 2022 12:31:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nbSPn-0004qD-18; Mon, 04 Apr 2022 21:31:03 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-3524-91ca-8473-ba45.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:3524:91ca:8473:ba45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 42D935A452;
        Mon,  4 Apr 2022 19:31:02 +0000 (UTC)
Date:   Mon, 4 Apr 2022 21:31:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Document r8a77961
 support
Message-ID: <20220404193101.nqe2s4rin3bzp6vx@pengutronix.de>
References: <20220401153743.77871-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fugieqbaghi4eddp"
Content-Disposition: inline
In-Reply-To: <20220401153743.77871-1-wsa+renesas@sang-engineering.com>
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


--fugieqbaghi4eddp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Cc +=3D Rob, devicetree

On 01.04.2022 17:37:43, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd=
=2Eyaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> index f98c53dc1894..648740270731 100644
> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -23,6 +23,7 @@ properties:
>                - renesas,r8a774e1-canfd     # RZ/G2H
>                - renesas,r8a7795-canfd      # R-Car H3
>                - renesas,r8a7796-canfd      # R-Car M3-W
> +              - renesas,r8a77961-canfd     # R-Car M3-W+
>                - renesas,r8a77965-canfd     # R-Car M3-N
>                - renesas,r8a77970-canfd     # R-Car V3M
>                - renesas,r8a77980-canfd     # R-Car V3H
> --=20
> 2.30.2
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--fugieqbaghi4eddp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJLR3MACgkQrX5LkNig
011X+AgAiCJkEoJcNFDfdclM7aFsnahPjO0F6AZyf9JxWe6wwRhyLxCQOcI56foc
sK4h7uU2EmkFQQRSHXgkZvbAZwooe1kT+lqh6MQy8Lbu1L++oLF7rYjkfhDh4sOr
lmK2hS/Gmz+SSQQ9o4Re2FI0soVPL8td1nQV+EtXP/qkeWyl7p3jKKoV36CfcGXU
C0R6Aw+PLzRY+5PxARcYh+2fEtf44t/be/OziTKQX60cZVVSvHA8FKfqrj9uyX2R
sQUMtkIyyZndFGCCvgxl9GWh/oIgQab3wV5DewePPjEaQ5R1CSSOAqX9J8TP+v3V
CPiJdjrtYSIjJOZNPdLoxLfBb2B3rA==
=8ytH
-----END PGP SIGNATURE-----

--fugieqbaghi4eddp--
