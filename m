Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1A57070C9
	for <lists+linux-can@lfdr.de>; Wed, 17 May 2023 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjEQScq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 May 2023 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQScp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 May 2023 14:32:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C695FC4
        for <linux-can@vger.kernel.org>; Wed, 17 May 2023 11:32:39 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzLwz-0000vL-Me; Wed, 17 May 2023 20:32:37 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 9E2E51C751A;
        Wed, 17 May 2023 18:32:36 +0000 (UTC)
Date:   Wed, 17 May 2023 20:32:36 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-can@vger.kernel.org, Florian Ferg <flfe@hms-networks.de>
Subject: Re: Any update for the IXXAT USB-to-CAN adapters drivers?
Message-ID: <20230517-prefix-animation-aefb320e253a-mkl@pengutronix.de>
References: <20230514151221.049873cb@gmx.net>
 <20230515-repurpose-essential-7f66fdcde4d5-mkl@pengutronix.de>
 <20230515-salon-sherry-cabae5cf7c49-mkl@pengutronix.de>
 <20230516205249.334acea3@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vwbydsehtydn3q7o"
Content-Disposition: inline
In-Reply-To: <20230516205249.334acea3@gmx.net>
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


--vwbydsehtydn3q7o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.05.2023 20:52:49, Peter Seiderer wrote:
> Thanks for investigation, in the meanwhile found all the missing
> references up to v7:
>=20
>   [PATCH] can: usb: IXXAT USB-to-CAN adapters drivers
>   https://marc.info/?l=3Dlinux-can&m=3D152845162427920&q=3Dmbox
>=20
>   [PATCH v2] can: usb: IXXAT USB-to-CAN adapters drivers
>   https://marc.info/?l=3Dlinux-can&m=3D152996258423265&q=3Dmbox
>=20
>   [PATCH v3] can: usb: IXXAT USB-to-CAN adapters drivers
>   https://marc.info/?l=3Dlinux-can&m=3D153019414431266&q=3Dmbox
>=20
>   [PATCH v4] can: usb: IXXAT USB-to-CAN adapters drivers
>   https://marc.info/?l=3Dlinux-can&m=3D153113773029121&q=3Dmbox
>=20
>   [PATCH v5] can: usb: IXXAT USB-to-CAN adapters drivers
>   https://marc.info/?l=3Dlinux-can&m=3D153390928701300&q=3Dmbox
>=20
>   [PATCH v6] can: usb: IXXAT USB-to-CAN adapters drivers
>   https://marc.info/?l=3Dlinux-can&m=3D153596357327489&q=3Dmbox
>=20
>   [PATCH v7] can: usb: IXXAT USB-to-CAN adapters drivers
>   https://marc.info/?l=3Dlinux-can&m=3D153805714622658&q=3Dmbox

Really nice archaeology! You should definitely link to the README.md of
your codeberg repo:

| https://codeberg.org/psreport/socketcan-linux-ix-usb-can

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vwbydsehtydn3q7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRlHcEACgkQvlAcSiqK
BOi1fgf/UCW6ypwzeu1RV87PoaomYnFXASCK9no8J5734oxWn8FAbQLpcugwuwfT
DsUrCfbl8NdfWTSxWZdUMl6kxHwltch2T9b+SQpEr9DIn2bPHhjSeRoXi+rb/wQE
yhiwBZTbhiOM3ChNQrSPpF3HW2w/G6XgSDXNUuCsxT2j8j8SB7P1s8utAGme7BWL
TG90tboFy/gOVIIWWwwfLM1OnUPSGMrGMrTEhbfFlNzDdX1BJTKMnQz5xartjFV3
pYw42tcaGxLU4WBg5ZuttwGjDWLV0MznmhUtobz1tPX56PIOtq8mjB2VupQgonil
Keodag3QqNvQqOI9kfgXqs4ple+j1w==
=gxi1
-----END PGP SIGNATURE-----

--vwbydsehtydn3q7o--
