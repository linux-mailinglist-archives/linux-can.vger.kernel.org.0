Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFBD67B2AE
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 13:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjAYMlk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 07:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjAYMlk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 07:41:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA144AD
        for <linux-can@vger.kernel.org>; Wed, 25 Jan 2023 04:41:39 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pKf5u-0003eS-1J; Wed, 25 Jan 2023 13:41:38 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:6554:ecba:20de:b047])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 42DBC16374E;
        Wed, 25 Jan 2023 12:41:37 +0000 (UTC)
Date:   Wed, 25 Jan 2023 13:41:28 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Stefan =?utf-8?B?QWx0aMO2ZmVy?= <Stefan.Althoefer@janztec.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: AW: mcp251xfd diagnostic outputs
Message-ID: <20230125124128.dz7llvxrup4fxzf6@pengutronix.de>
References: <FR0P281MB1966B647014B87F9EA96E77197C19@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
 <20230125120124.yfqwnvg72uk5rbvv@pengutronix.de>
 <FR0P281MB19669E0121CECA3B9C0C7E6497CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhpqi2ko5w4kt3n5"
Content-Disposition: inline
In-Reply-To: <FR0P281MB19669E0121CECA3B9C0C7E6497CE9@FR0P281MB1966.DEUP281.PROD.OUTLOOK.COM>
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


--yhpqi2ko5w4kt3n5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.01.2023 12:23:42, Stefan Alth=C3=B6fer wrote:
> > The networking stack has a proper interface for network interface
> > statistics, better make use of these.
>=20
> You mean those in /sys/class/net/can0/statistics? I was not aware that
> custom errors can be added here.

I think these are fixed.

> By no means I would want the SPI CRC errors appear in rx_crc_errors.

ACK

> The way you used it for the fifo errors is however justified.

This was a quick solution, but proper stats via ethtool interface are
better.

> Or do you talk about the driver statistics reported via the ethtool
> interface?

ACK, I mean the ethtool interface.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--yhpqi2ko5w4kt3n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmPRI3QACgkQrX5LkNig
0114QggAoLhK8j6WNK8AS3d7EDLku2bATSqt0c47wuPIFUP7AMtuC5UF7JEjnIjG
eP4LH+JRkRvk0UNgfDvTxWZg0PKyf74bootMfZKyHECW5RpbOs35q7DfPCq3VRCK
C9vxW1ou/FCPVw3XVg7uA8gjJKMrx4HSokytEURpNU3nJcNB50aIZflr/PJQfWZK
ph4EJ+81ocCC5ZIwOSfkMoLkqQSU2RKIcUs+HMvMyZ4Gm7+ChcYEFrZBoWnL83dr
3PuwQxwozFn50VlrMP9wX3LSO8Sz31bI/FFwhP/pnHd6bXxVBk0jQjg6Pwo9WSNZ
5TXyzazavCwhXzPybu27yW69HNs4aw==
=lwnE
-----END PGP SIGNATURE-----

--yhpqi2ko5w4kt3n5--
