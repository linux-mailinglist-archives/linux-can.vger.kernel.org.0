Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4327060DB
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 09:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEQHJt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 03:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjEQHJp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 03:09:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D80D1AD
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 00:09:44 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzBI5-000432-JO; Wed, 17 May 2023 09:09:41 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 8EA171C6CE6;
        Wed, 17 May 2023 07:09:40 +0000 (UTC)
Date:   Wed, 17 May 2023 09:09:40 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Jimmy Assarsson <extja@kvaser.com>
Cc:     linux-can@vger.kernel.org,
        Carsten Schmidt <carsten.schmidt-achim@t-online.de>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH v2] can: kvaser_usb: Add len8_dlc support
Message-ID: <20230517-repeated-snowboard-ab82d61d3060-mkl@pengutronix.de>
References: <20230516125332.82894-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xmbaeaqek4vaxlfk"
Content-Disposition: inline
In-Reply-To: <20230516125332.82894-1-extja@kvaser.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--xmbaeaqek4vaxlfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.05.2023 14:53:32, Jimmy Assarsson wrote:
> From: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
>=20
> Add support for the Classical CAN raw DLC functionality to send and recei=
ve
> DLC values from 9 .. 15.
>=20
> Signed-off-by: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
> Tested-by: Jimmy Assarsson <extja@kvaser.com>
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xmbaeaqek4vaxlfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRkfbEACgkQvlAcSiqK
BOgIvwf/YHmB7weMR9/e2BY+etJBbXdLCNRBqGj08qDEuzUccghgh+BhslpYEavy
Pcj2dyCLt98Vr0IiSVxPHFsp7WEXsL0+aupKri32/F55myewiOmfLUTkMPgV194L
uY1abGVXWwcsgnnxgbVwHTm6XSmga043vvyk3OWStkQBODgIq+C7vmEtHNek7bfK
AOFrYaGWOI3DK2tD0oXi7Z8wEFLL9oVxoIZFOtFiWNyJRpMH1TC952W63TsT+OF+
Vvu5hniE6+XgGzbY5L08TCpR4wemvjyF5urIArP0+DLAdkZXZzCdcmPy18RfwG6E
XFRvahTOGT5yHnRxxROwHsfJJ0/WlQ==
=TBvX
-----END PGP SIGNATURE-----

--xmbaeaqek4vaxlfk--
