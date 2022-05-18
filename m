Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695EE52C435
	for <lists+linux-can@lfdr.de>; Wed, 18 May 2022 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbiERUVl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 18 May 2022 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbiERUVk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 May 2022 16:21:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3D192D31
        for <linux-can@vger.kernel.org>; Wed, 18 May 2022 13:21:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nrQAr-0007rn-Hx; Wed, 18 May 2022 22:21:37 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 886E7818A7;
        Wed, 18 May 2022 20:21:36 +0000 (UTC)
Date:   Wed, 18 May 2022 22:21:34 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: Re: [PATCH can-next] can: can-dev: remove obsolete CAN LED support
Message-ID: <20220518202134.77ir3bohv2tl6vi6@pengutronix.de>
References: <20220518154527.29046-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wncxtr4w2aex3s3l"
Content-Disposition: inline
In-Reply-To: <20220518154527.29046-1-socketcan@hartkopp.net>
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


--wncxtr4w2aex3s3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.05.2022 17:45:27, Oliver Hartkopp wrote:
> Since commit 30f3b42147ba6f ("can: mark led trigger as broken") the
> CAN specific LED support was disabled and marked as BROKEN. As the common
> LED support with CONFIG_LEDS_TRIGGER_NETDEV should to this work now the
> code can be removed as preparation for a CAN netdevice Kconfig rework.
>=20
> Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/Kconfig                  |  17 ---
>  drivers/net/can/at91_can.c               |  10 --
>  drivers/net/can/c_can/c_can_main.c       |  12 +-
>  drivers/net/can/ctucanfd/ctucanfd_base.c |  10 --
>  drivers/net/can/dev/Makefile             |   2 -
>  drivers/net/can/dev/dev.c                |   5 -
>  drivers/net/can/dev/rx-offload.c         |   2 -
>  drivers/net/can/flexcan/flexcan-core.c   |   7 --
>  drivers/net/can/ifi_canfd/ifi_canfd.c    |   9 --
>  drivers/net/can/led.c                    | 140 -----------------------
>  drivers/net/can/m_can/m_can.c            |  11 --
>  drivers/net/can/m_can/m_can.h            |   1 -
>  drivers/net/can/rcar/rcar_can.c          |   8 --
>  drivers/net/can/rcar/rcar_canfd.c        |   7 --
>  drivers/net/can/sja1000/sja1000.c        |  11 --
>  drivers/net/can/spi/hi311x.c             |   8 --
>  drivers/net/can/spi/mcp251x.c            |  10 --
>  drivers/net/can/sun4i_can.c              |   7 --
>  drivers/net/can/ti_hecc.c                |   8 --
>  drivers/net/can/usb/mcba_usb.c           |   8 --
>  drivers/net/can/usb/usb_8dev.c           |  11 --
>  drivers/net/can/xilinx_can.c             |  10 +-
>  include/linux/can/dev.h                  |  10 --
>  include/linux/can/led.h                  |  51 ---------
>  24 files changed, 2 insertions(+), 373 deletions(-)
>  delete mode 100644 drivers/net/can/led.c
>  delete mode 100644 include/linux/can/led.h

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--wncxtr4w2aex3s3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKFVUsACgkQrX5LkNig
013F8Af9HBQYHZwym0Aanf/AFHqbin3C+buubyxl1u3cKF9WSDmBoKTk29OneByd
7k7GYpULHLR6ZhlFOjDM5OpwUloKK+h/tXzUKgcL4juuEs8uImN2aNVvy0IvmA/b
+xgPBg9+IkXke+c0WqibKM0edks/C22UUWjy8NTffSZQSqNnW8MALpnUnRWkQ6rL
RqzubyCuvPMYC9q/NMKyOqkgVVtni38itXA733DvkZPXtZOK6cFQovdFNrI+re4i
oc0XfmFG2yZ7o8wxNNx8j/EDo92yadwDEjk1/RL2gARJfHUhENphB2tM7AfrR/rr
cCsE5y308xED7gkrhyOnj3D51KrReA==
=QInh
-----END PGP SIGNATURE-----

--wncxtr4w2aex3s3l--
