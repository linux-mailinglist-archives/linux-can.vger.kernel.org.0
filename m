Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C218D52DE1C
	for <lists+linux-can@lfdr.de>; Thu, 19 May 2022 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiESULG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 May 2022 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiESULE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 May 2022 16:11:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8F37A10
        for <linux-can@vger.kernel.org>; Thu, 19 May 2022 13:11:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nrmU8-0003zm-IH; Thu, 19 May 2022 22:11:00 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id C363482602;
        Thu, 19 May 2022 20:10:59 +0000 (UTC)
Date:   Thu, 19 May 2022 22:10:58 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michael Anochin <anochin@photo-meter.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, m_can, tcan4x5x : big jitter between the packets by sending
Message-ID: <20220519201058.dx7b2apkmuggdv3h@pengutronix.de>
References: <9e431f19-897e-7bff-68bb-7ac7bb9fd757@photo-meter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ai4wp7vajjsyul52"
Content-Disposition: inline
In-Reply-To: <9e431f19-897e-7bff-68bb-7ac7bb9fd757@photo-meter.com>
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


--ai4wp7vajjsyul52
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.05.2022 17:52:36, Michael Anochin wrote:
> my application continuously sends 64 bytes CANFD packets with 1MBit/s at =
the
> 10ms interval. I use tcan4450 on the RPI4 with 5.10.103 Kernel and raspbi=
an.
> No other significant processes load the CPU.
>=20
> When I monitor the traffic with a PCAN adapter on a Windows PC, I notice
> that the packets sometimes arrive with a delay of 5-9ms. But the next
> following packet arrive faster as 10ms. My desired interval of 10ms is ke=
pt
> at the jitter of +/- 9ms.
>=20
> Running the App on only one CPU core using tasksel improve the jitter
> somewhat.
>=20
> Am I the only one who observes such large jitter or is the m_can
> implementation at Perepherie (spi) not so fast from the throughput and is
> completely normal.
>=20
> Maybe I should switch to 5.17 kernel? On 5.17 there are bulk read/write
> function for spi regmap.

The tcan4x5x driver is not really optimized. Don't expect great
performance with it. At least the newer kernel have some kind of
optimization. There are a lot of further optimization opportunities
which are already implemented in the mcp251xfd driver.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ai4wp7vajjsyul52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKGpE8ACgkQrX5LkNig
013IoAf5AQN020S1nlBQ7RSp+62x9LY09QpndA8NTKg/RbpaifJvfaPXFlgan4sp
euA0WpGE1JM56/u6xNwxQ0o9GJ4MlQSHKKHDoenAbJ6eVEFH8Tkq6FcVYShj+5EY
dlh+Z99dJqraN2x17ceIwukzVnEtadOaieagRlar0UrAYe7dMd7iXdHGCVKiEXY7
V4/AzngmNA/RfucyqmiYciLEK3MXh9p1EvM+QccNBpBmAuBDftKue7qBKd83sood
tolTQMAy/SfrqK18Gx63wQTQLpm8FsdPtVLaWpjJ+K2ewXJ+RRtCjcQBb0LAcpSb
E9wTbsPcLZXSy5KQ48hQGMkvCrXG/g==
=7bui
-----END PGP SIGNATURE-----

--ai4wp7vajjsyul52--
