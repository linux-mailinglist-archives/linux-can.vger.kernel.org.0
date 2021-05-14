Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555C9380976
	for <lists+linux-can@lfdr.de>; Fri, 14 May 2021 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhENM1Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 May 2021 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhENM1Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 May 2021 08:27:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0306C061574
        for <linux-can@vger.kernel.org>; Fri, 14 May 2021 05:26:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lhWtQ-0005iU-Gq; Fri, 14 May 2021 14:26:12 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:ab9e:cb46:9dda:16ff])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 84C85624325;
        Fri, 14 May 2021 12:26:11 +0000 (UTC)
Date:   Fri, 14 May 2021 14:26:10 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH RFC can-next 1/3] can: m_can: add handle_dev_interrupts
 callback to m_can_ops
Message-ID: <20210514122610.q7mhf3frapxig5xg@pengutronix.de>
References: <20210514121946.2344901-1-torin@maxiluxsystems.com>
 <20210514121946.2344901-2-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oluhljw7kkfo6b7"
Content-Disposition: inline
In-Reply-To: <20210514121946.2344901-2-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--5oluhljw7kkfo6b7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14.05.2021 13:19:44, Torin Cooper-Bennun wrote:
> This callback will allow M_CAN-based devices, e.g. TI TCAN4550, to
> handle device-specific interrupts which are not part of the M_CAN core,
> but are signaled on the same interrupt pin.
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>

Another option would be to register a 2nd threaded interrupt handler in
the tcan4x5x driver....But this is much simpler.

> ---
>  drivers/net/can/m_can/m_can.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index ace071c3e58c..99203a37f9cc 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -28,6 +28,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/can/dev.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/irqreturn.h>
> =20
>  /* m_can lec values */
>  enum m_can_lec_type {
> @@ -62,6 +63,7 @@ struct m_can_classdev;
>  struct m_can_ops {
>  	/* Device specific call backs */
>  	int (*clear_interrupts)(struct m_can_classdev *cdev);
> +	irqreturn_t (*handle_dev_interrupts)(struct m_can_classdev *cdev);
>  	u32 (*read_reg)(struct m_can_classdev *cdev, int reg);
>  	int (*write_reg)(struct m_can_classdev *cdev, int reg, int val);
>  	u32 (*read_fifo)(struct m_can_classdev *cdev, int addr_offset);
> --=20
> 2.30.2

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5oluhljw7kkfo6b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCebF4ACgkQqclaivrt
76lDSQf8CoUhxvF5bLleMiVJY99zNQ7SkH/2kaduXWfgwm0UtHQ9A79aQFgczhIk
ebCpTiuGGKZhC6UUAn/rPa7h/S5lGrRhqHsAL6cGS2Mf2ZjJ+wV+KrJ60IUyp+3K
bNvArge2lgJi1zGzn5rK4K5BDoqm1R7z6PDUZR4emBeaP0VM1f3MEmUMKbTUnfai
KXa/OybeWmISinMmItVLXdL+pT+5RwlaTQpm9iDAt4WWCcbKRI9fvJJkqky1oUWo
I3H3DEQKuGKZmq28UtLxl3hCaTP0kf+TU/7KmLzY3flJmP6ALWeM0YbqdCnNctao
i8SF6KBtw5bf8dGtzhxQyn82rv1AQQ==
=Kkz5
-----END PGP SIGNATURE-----

--5oluhljw7kkfo6b7--
