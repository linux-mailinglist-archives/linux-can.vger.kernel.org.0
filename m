Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5F76E2BE
	for <lists+linux-can@lfdr.de>; Thu,  3 Aug 2023 10:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjHCIQz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Aug 2023 04:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjHCIQZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Aug 2023 04:16:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5444A6
        for <linux-can@vger.kernel.org>; Thu,  3 Aug 2023 01:10:08 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qRTPK-0001FS-6M; Thu, 03 Aug 2023 10:10:06 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 449F92022B4;
        Thu,  3 Aug 2023 08:10:05 +0000 (UTC)
Date:   Thu, 3 Aug 2023 10:10:04 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Frank Jungclaus <frank.jungclaus@esd.eu>
Cc:     linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] can: esd_usb: Add support for esd CAN-USB/3
Message-ID: <20230803-champion-shrewdly-2eb7dfa82f84-mkl@pengutronix.de>
References: <20230728150857.2374886-1-frank.jungclaus@esd.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mnl7qleuvjby3bph"
Content-Disposition: inline
In-Reply-To: <20230728150857.2374886-1-frank.jungclaus@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--mnl7qleuvjby3bph
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 28.07.2023 17:08:56, Frank Jungclaus wrote:
> After having applied a vast number of improvements to the existing
> CAN-USB/2 driver here now is a new attempt to add support for the esd
> CAN-USB/3 CAN FD interface.
>=20
> Beside this patch there are the following to-do's left for follow-up
> patches:
>=20
> * In principle, the esd CAN-USB/3 supports Transmitter Delay
> Compensation (TDC), but currently only the automatic TDC mode is
> supported by this driver. An implementation for manual TDC
> configuration will follow.
>=20
> * Rework the code to no longer switch directly on the USB product IDs
> to handle different device setting for each supported USB
> device. Instead use the driver_info member within struct usb_device_id
> to hold / point to specific properties for each supported device.
>=20
> * Try to switch from synchronous send usb_bulk_msg() to asynchronous
> communication by means of usb_submit_urb() where it is feasible.

Added to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mnl7qleuvjby3bph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTLYNkACgkQvlAcSiqK
BOh2sggAnAGz1M4KfiRrh9tkmgT2qgWFsGhBI7h/PW4bjdefDIfGw6VJPttbmZ/0
pHOsTJFtd835y6W3jJ+IMgegM0aNzDN06bGv/dUCYRk6EFZi/vJ2LhqrMYTll0KQ
VpaHl2LC2T0BFsHA/811MsPPGMpcJbmNlga87RTAuy0xeYb+piKfhp75a71X7fWC
nUCT5OBXA/M6g6ZsO1EfBGFLST75ESTfGPHPQXwun0ZVG/qCerjunHRulMujSAwf
iGXQZUscjKkptQ/dOCUx3kpV1aOib0I3AGX7/Bvebq+0ZNOikNmhy/A80dOu5+XP
ZNXpQeoWVZessXBd6Ny61dxCDpECtw==
=hic3
-----END PGP SIGNATURE-----

--mnl7qleuvjby3bph--
