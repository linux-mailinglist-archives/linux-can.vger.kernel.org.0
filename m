Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8A4F3F09
	for <lists+linux-can@lfdr.de>; Tue,  5 Apr 2022 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236516AbiDEOq3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Apr 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354865AbiDENH2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Apr 2022 09:07:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C747AC7
        for <linux-can@vger.kernel.org>; Tue,  5 Apr 2022 05:10:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nbi0W-0006kQ-GZ; Tue, 05 Apr 2022 14:10:00 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-2c8c-8717-3b83-dd19.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:2c8c:8717:3b83:dd19])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D19D55B5A5;
        Tue,  5 Apr 2022 12:09:59 +0000 (UTC)
Date:   Tue, 5 Apr 2022 14:09:59 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Wouter van Herpen <wouter.van.herpen@prodrive-technologies.com>
Cc:     Marc Kleine-Budde <mkl@blackshift.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: PROBLEM: tcan4x5x nINT stays asserted under high RX/TX interrupt
 load
Message-ID: <20220405120959.qwtmcafby2jjxc26@pengutronix.de>
References: <AM0PR02MB592368F53A7BEA4154D24A87EAE09@AM0PR02MB5923.eurprd02.prod.outlook.com>
 <20220403105730.fnurim5vnnuxb7s5@pengutronix.de>
 <AM0PR02MB59236CF6507DD614F60D078FEAE49@AM0PR02MB5923.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uks4orwnx4b6qbtp"
Content-Disposition: inline
In-Reply-To: <AM0PR02MB59236CF6507DD614F60D078FEAE49@AM0PR02MB5923.eurprd02.prod.outlook.com>
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


--uks4orwnx4b6qbtp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.04.2022 12:02:09, Wouter van Herpen wrote:
> I tested this on a (vendor specific) 5.4.24 kernel, where I know the
> patch is valid.
>=20
> I won't be able to test it on the latest main-line kernel on short
> term, due to board bringup issues with this kernel base/revision
> change.
>=20
> However, the patch itself is quite trivial. What do you advise? Do you
> prefer a tested patch for 5.4.24, an untested patch for 5.18, or
> otherwise?

Feel free to send the patch against v5.4.24, please mention this in the
patch itself to avoid confusion.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--uks4orwnx4b6qbtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJMMZQACgkQrX5LkNig
011dFgf/UnKSbD9R4UxU7ow7Ux2rx0kbqxu6OKcXeZdUt63W2kuo0a+/MjA4DXdU
D8jaus3vLy2NdIytNfm9UPyxKlRi//HkG2BUpYD4pSpRQSP5Me4p2BXQyFzWxSGn
mTEKXzHccYYqUH/sDQCoOQdH902bfpNaSRO3fuBhoGuutFtz7OM8uxTp1tDyAWDA
tmTuecORZ+YwP2N1Fq5fO6f6CPZVF5iI52bIFbDsFUzIzjzm59KDM5fKYAnWKU7A
nUpZvEsawCNVOyyl3i3M3Z5WauV4c9KtUSTb2TExRfuVF0P9+6h3fU/vcb3HjLDx
okIDm9KTcm0QKEIeFhIWCHus0sf7lg==
=0EZg
-----END PGP SIGNATURE-----

--uks4orwnx4b6qbtp--
