Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD753D70D
	for <lists+linux-can@lfdr.de>; Sat,  4 Jun 2022 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiFDNqX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 4 Jun 2022 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiFDNqW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2022 09:46:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C764DA
        for <linux-can@vger.kernel.org>; Sat,  4 Jun 2022 06:46:20 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nxU6c-00055f-B1; Sat, 04 Jun 2022 15:46:18 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 96BE98C377;
        Sat,  4 Jun 2022 13:46:16 +0000 (UTC)
Date:   Sat, 4 Jun 2022 15:46:15 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/7] can: Kconfig: turn menu "CAN Device Drivers" into
 a menuconfig using CAN_DEV
Message-ID: <20220604134615.l7qtyam6kmqboujo@pengutronix.de>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
 <20220603102848.17907-1-mailhol.vincent@wanadoo.fr>
 <20220603102848.17907-3-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvkdbv5sicbki4qw"
Content-Disposition: inline
In-Reply-To: <20220603102848.17907-3-mailhol.vincent@wanadoo.fr>
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


--pvkdbv5sicbki4qw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My previous mail on this was wrong (as you noticed).... so here's the
corrected one (hopefully).

On 03.06.2022 19:28:43, Vincent Mailhol wrote:
> diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
> index 5b4c813c6222..919f87e36eed 100644
> --- a/drivers/net/can/dev/Makefile
> +++ b/drivers/net/can/dev/Makefile
> @@ -1,9 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> -obj-$(CONFIG_CAN_NETLINK) +=3D can-dev.o
> -can-dev-y                    +=3D bittiming.o
> -can-dev-y                    +=3D dev.o
> -can-dev-y                    +=3D length.o
> -can-dev-y                    +=3D netlink.o
> -can-dev-y                    +=3D rx-offload.o
> -can-dev-y                       +=3D skb.o
> +obj-$(CONFIG_CAN_DEV) +=3D can-dev.o
> +
> +can-dev-$(CONFIG_CAN_DEV) +=3D skb.o
           ^^^^^^^^^^^^^^^^

As "skb.o" is always part of "can-dev.o" (if build at all), you can use
"can-dev-y" here.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--pvkdbv5sicbki4qw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKbYiQACgkQrX5LkNig
012l2gf/YsNjl48yYp2YEyLJmGsd69HaA37eYqom1L74OW9JPO9Gx2alg4uULFXL
Y2pcFSHVqKAWefFuIh5MeE3b5+ARJkwEdqggBPSy1Z88LqW+zNp/oA7gIIHtgjGC
AzyEEj8FyHFFAk2lqzGgMenGYxzVxFyba6NtXGWzc/aTT7ltWwFUaKPOSBkInvmf
Y0hAQmOggGxuMKES7H+JBXTYCoewgn2dOkazxBn/8Xllg4porzsCGCBOTijEbYr0
/YHerEoOBecHcf5SsoG1QmLdfBEI7VpqjicPQ1arODIR84j+GvfFym+7TjjtJJfy
ji0E0hivJG2/HzmzsjKrXKZAQDekrw==
=iouw
-----END PGP SIGNATURE-----

--pvkdbv5sicbki4qw--
