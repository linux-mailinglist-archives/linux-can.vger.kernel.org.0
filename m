Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B485F77BB
	for <lists+linux-can@lfdr.de>; Fri,  7 Oct 2022 13:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJGL5x (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Oct 2022 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJGL5w (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Oct 2022 07:57:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D5CF85F
        for <linux-can@vger.kernel.org>; Fri,  7 Oct 2022 04:57:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oglzB-0002Sp-4O; Fri, 07 Oct 2022 13:57:49 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 350D3F6E5E;
        Fri,  7 Oct 2022 11:57:48 +0000 (UTC)
Date:   Fri, 7 Oct 2022 13:57:47 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "Daniel S. Trevitz" <dan@sstrev.com>
Cc:     linux-can@vger.kernel.org,
        Daniel Trevitz <daniel.trevitz@wika.com>,
        Ryan Edwards <ryan.edwards@gmail.com>
Subject: Re: [PATCH 1/1 v3] Termination resistor documentation
Message-ID: <20221007115747.wep34wbqftzhr22f@pengutronix.de>
References: <3441354.44csPzL39Z@daniel6430>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbyah5fbut2my46w"
Content-Disposition: inline
In-Reply-To: <3441354.44csPzL39Z@daniel6430>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--zbyah5fbut2my46w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07.10.2022 07:53:02, Daniel S. Trevitz wrote:
> Add documentation for how to use and setup the switchable termination
> resistor support for the can-controllers.
>=20
> Signed-off-by: Daniel Trevitz <dan@sstrev.com>

Applied to linux-can/main

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--zbyah5fbut2my46w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNAFDgACgkQrX5LkNig
010f/Qf/YPC5JqtHVXSMyF/aKVRRftgiC2LtbgBmLH8SQ2G6IDkBzfK/jwNPM+NB
yGvZ1yGyNwOcTfgf4v5RDTzaO98lGm0FXDRM01Jq/ROagoIRaRuzSmssQUESswQG
RgCkeod2BxyFxMB6PEwqUBSQ9ZUihf4gJqJxSWVoOURHycT6h4EZSFw2q8fTr3pX
GYXWSogSyybHGCnlmIvjgTXlqD5IBI0ITPoXW/tujHjethJmVX4wBN+3ElFKqbC+
wcTIk++cyQgQMCijClTmBRNqhq3NbUvbtgRfih2+qcyNmeKmn/G9SMrXtRcJ5SIx
EOxpaQz0aHkdb4VIJHl+Ot1H9T0hjA==
=U7Ru
-----END PGP SIGNATURE-----

--zbyah5fbut2my46w--
