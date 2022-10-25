Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B960CFA8
	for <lists+linux-can@lfdr.de>; Tue, 25 Oct 2022 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiJYOzI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Oct 2022 10:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiJYOzB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Oct 2022 10:55:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29C14707F
        for <linux-can@vger.kernel.org>; Tue, 25 Oct 2022 07:54:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onLKR-00054a-9g; Tue, 25 Oct 2022 16:54:55 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id EA82110991D;
        Tue, 25 Oct 2022 14:54:53 +0000 (UTC)
Date:   Tue, 25 Oct 2022 16:54:50 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Lukas Magel <lukas.magel@posteo.net>
Cc:     linux-can@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 5/7] can: peak_usb: add ethtool interface to user defined
 flashed device number
Message-ID: <20221025145450.oqyouag6sw2l76ii@pengutronix.de>
References: <20221022213535.8495-1-lukas.magel@posteo.net>
 <20221022213535.8495-6-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sn7rtr2fok7fj7ag"
Content-Disposition: inline
In-Reply-To: <20221022213535.8495-6-lukas.magel@posteo.net>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--sn7rtr2fok7fj7ag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.10.2022 21:35:33, Lukas Magel wrote:
> From: Stephane Grosjean <s.grosjean@peak-system.com>
>=20
> This patch introduces 3 new functions implementing support for eeprom
> access of USB - CAN network interfaces managed by the driver, through the
> ethtool interface. All of them (except the PCAN-USB interface) interpret
> the 4 data bytes as a 32-bit value to be read/write in the non-volatile
> memory of the device. The PCAN-USB only manages a single byte value.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Signed-off-by: Lukas Magel <lukas.magel@posteo.net>

If you compile with "C=3D1" sparse complains about:

| drivers/net/can/usb/peak_usb/pcan_usb_core.c:861:18: warning: incorrect t=
ype in assignment (different base types)
| drivers/net/can/usb/peak_usb/pcan_usb_core.c:861:18:    expected unsigned=
 int [usertype] devid_le
| drivers/net/can/usb/peak_usb/pcan_usb_core.c:861:18:    got restricted __=
le32 [usertype]
| drivers/net/can/usb/peak_usb/pcan_usb_core.c:894:18: warning: incorrect t=
ype in assignment (different base types)
| drivers/net/can/usb/peak_usb/pcan_usb_core.c:894:18:    expected unsigned=
 int [usertype] devid_le
| drivers/net/can/usb/peak_usb/pcan_usb_core.c:894:18:    got restricted __=
le32 [usertype]
| drivers/net/can/usb/peak_usb/pcan_usb_core.c:896:17: warning: cast to res=
tricted __le32

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--sn7rtr2fok7fj7ag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmNX+LcACgkQrX5LkNig
012wMgf9EexTGmQurM/ElO3kSdaP05ujkQFO8w3zhlP/9a7QLt9eUquNwkanhi3c
4oTYaR6vgejp24BKNwB1r1DGRyIqOxmvZZYR27FUoNv37lRMyx01EzzDRpC7b2Dl
h+2R51aL0dgUNjit6upRjI/26m+OZpAM4nm3fBWIypbjltMmXZJMJCZnMaoag2p3
kRLSwOYyRXMWTfReCnDxRXwrZXhzpwMJA7lBt8ZXD6rLu4SxU/ERTxIZQG6wNPLm
pfsVTXnrMC8z8JiSInrojmXlNW9z0mD0usE+t0EmOsn2rmO+gAWPn/X6+jxEo2T3
NBv+0I5zb3uyglSeRhEETJ/RqiWyCw==
=gHRZ
-----END PGP SIGNATURE-----

--sn7rtr2fok7fj7ag--
