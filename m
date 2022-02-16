Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E90D4B84EC
	for <lists+linux-can@lfdr.de>; Wed, 16 Feb 2022 10:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiBPJwc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Feb 2022 04:52:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiBPJw1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Feb 2022 04:52:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A007395
        for <linux-can@vger.kernel.org>; Wed, 16 Feb 2022 01:52:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nKGyO-00042z-Tw; Wed, 16 Feb 2022 10:51:44 +0100
Received: from pengutronix.de (unknown [195.138.59.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2FD2B34FC5;
        Wed, 16 Feb 2022 09:51:43 +0000 (UTC)
Date:   Wed, 16 Feb 2022 10:51:39 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     =?utf-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.com>
Cc:     linux-can Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 6/6] can: peak_usb: add ethtool interface to user defined
 flashed device number
Message-ID: <20220216095139.txhiyuvz6ecxmg5b@pengutronix.de>
References: <20220131143103.nmp6fquyidsapw2l@pengutronix.de>
 <PA4PR03MB679736316C8D5CF2079EB794D6309@PA4PR03MB6797.eurprd03.prod.outlook.com>
 <20220215151045.2gsaj5c7b2edck53@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a2jckuzsasnlq65k"
Content-Disposition: inline
In-Reply-To: <20220215151045.2gsaj5c7b2edck53@pengutronix.de>
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


--a2jckuzsasnlq65k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.02.2022 16:10:45, Marc Kleine-Budde wrote:
> On 11.02.2022 10:57:34, St=C3=A9phane Grosjean wrote:
> > endianess is handled by lower level functions (see for ex
> > pcan_usb_fd_get_user_devid()/pcan_usb_fd_set_user_devid() in PATCH
> > 2/6).
> >
> > This data is really a number and must be treated as such.
>=20
> What's the use case for the data/number? What's the big picture?

| Jan 01 05:16:21 DistroKit kernel: peak_usb 1-1:1.0: PEAK-System PCAN-USB =
FD v1 fw v3.2.0 (1 channels)
| Jan 01 05:16:21 DistroKit kernel: peak_usb 1-1:1.0 can0: attached to PCAN=
-USB FD channel 0 (device 1144201745)
                                                                           =
                          ^^^^^^^^^^

But that is something different than the serial number, right?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--a2jckuzsasnlq65k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIMySkACgkQrX5LkNig
0114eQf/aEN6J5HoI1GPcX57Na8Thxauv8CL3f6G9Ue/2hD0TntdJq+LFNtHCxE8
wU0neR6CtWRiWHtKaIBni9VU5hXtkLUsdXi8KZ/AiPLulIxET95pIfYQ7Ew+2o6O
4NQLyPNM9eULYezyfQCAiHzi9nKwU8GnDDaXxvP/7IGR6TgHnBEwfAseTJKeaC3K
563DTvvZ5ZR/hGo2aUh+B37X7ahydUzRBUIUaDKgveKxn9gQRhNSuSrOkb7ga8ZG
GgHz4DnxUGPDoSfZm7MMjapXoF41Ae45xYnmsc0PRohaqAfGUuCBfLbuA7zAJryR
WMxMJUgcScje36Wa7MPxzwfGrPkYcA==
=wudd
-----END PGP SIGNATURE-----

--a2jckuzsasnlq65k--
