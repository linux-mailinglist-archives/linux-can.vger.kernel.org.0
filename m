Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFD74F1DC9
	for <lists+linux-can@lfdr.de>; Mon,  4 Apr 2022 23:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383012AbiDDVlT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Apr 2022 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380342AbiDDTgG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Apr 2022 15:36:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57413EA3
        for <linux-can@vger.kernel.org>; Mon,  4 Apr 2022 12:34:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nbSSl-0005DZ-JF; Mon, 04 Apr 2022 21:34:07 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-3524-91ca-8473-ba45.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:3524:91ca:8473:ba45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D56DE5A455;
        Mon,  4 Apr 2022 19:34:06 +0000 (UTC)
Date:   Mon, 4 Apr 2022 21:34:06 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mkl@blackshift.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-can@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Document r8a77961
 support
Message-ID: <20220404193406.dxn6m5xl5jcxlxqg@pengutronix.de>
References: <20220401153743.77871-1-wsa+renesas@sang-engineering.com>
 <20220403110534.2k3ojnkkrsdjzimb@pengutronix.de>
 <CAMuHMdX2Ut9A57UkOO4f+q8Awu0K9Oek2Qhujr+TaKNTpkVU=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpphrtucuuhblxqu"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX2Ut9A57UkOO4f+q8Awu0K9Oek2Qhujr+TaKNTpkVU=g@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--wpphrtucuuhblxqu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.04.2022 14:02:52, Geert Uytterhoeven wrote:
> Hi Marc,
>=20
> On Sun, Apr 3, 2022 at 1:05 PM Marc Kleine-Budde <mkl@blackshift.org> wro=
te:
> > On 01.04.2022 17:37:43, Wolfram Sang wrote:
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> > Wolfram, thanks for the patch. I think usually Geert takes the renesas
> > DT binding patches. (If it would go via the CAN and net tree, that patch
>=20
> Usually only for Renesas core patches, unless the I/O maintainers
> are unresponsive...

Ok, I wasn't sure. I'm taking this patch.

> > should get a patch description, my upstream doesn't take patches
> > without.)

I've added a patch description while applying.

> The other usual suspects are the DT people, but they weren't CCed?

I've added them on Cc.

> Of course I can take it, too. Are you willing to provide an Acked-by?
> Thanks!

regard,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wpphrtucuuhblxqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJLSCwACgkQrX5LkNig
011u+Qf/YButwC5LuxJ0EjEWyTxSUsWfcn8Uw5jZf8AQXQQ09WycP2s3Ct4WcRZT
7ruaJh/uShoQ2OYv6s4+wKRC8nR+/KXL0cjJxU15PhPbYHjpUZfUYq4JeZfEILPz
7gbW5QeevJyFAMjyQ2dmdKx9um03oIsWSI2Uu+sEHd9MrBwRy0xfDqHgEuu3yKEB
W/7WrGEj9/DFgDtN7txpahsas6LGbWwkPs/iltDRLjKh9c2Zqtbk9qOE8no7wFXh
l61DNgKLBl3D1U7NdoAK1E+xf8WxelJ0FM7pijD6Opkupxn2XzMw0vinH9KWN4A1
6xMFoAjOPnvfw4A9lKCU+040GU2nCw==
=NL01
-----END PGP SIGNATURE-----

--wpphrtucuuhblxqu--
