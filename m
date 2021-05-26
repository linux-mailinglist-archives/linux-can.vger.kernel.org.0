Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5B391B2F
	for <lists+linux-can@lfdr.de>; Wed, 26 May 2021 17:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhEZPIk (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 May 2021 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbhEZPIk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 May 2021 11:08:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E9C061574
        for <linux-can@vger.kernel.org>; Wed, 26 May 2021 08:07:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1llv7i-0005nt-Qh; Wed, 26 May 2021 17:07:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:cbc5:840b:a05c:ea5c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id DF89C62CAFA;
        Wed, 26 May 2021 15:07:05 +0000 (UTC)
Date:   Wed, 26 May 2021 17:07:05 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 2/5] can: m_can: m_can_isr(): handle
 device-specific interrupts
Message-ID: <20210526150705.s4ms7jhowsuts3yf@pengutronix.de>
References: <20210526124747.674055-1-torin@maxiluxsystems.com>
 <20210526124747.674055-3-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c3m4hliicdao5cdh"
Content-Disposition: inline
In-Reply-To: <20210526124747.674055-3-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--c3m4hliicdao5cdh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.05.2021 13:47:44, Torin Cooper-Bennun wrote:
> Device-specific interrupts are handled, if no M_CAN core interrupts were
> handled in the ISR call.

In case there are both core and device specific interrupts the kernel
IRQ handler will call the ISR a 2nd time - should be OK.

> The patch also improves the flow at the start of m_can_isr(), removing a
> conditional which always evaluates to true, and improves comments.
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> ---
>  drivers/net/can/m_can/m_can.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index fa853201d2c4..3bc957da06f7 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1033,17 +1033,24 @@ static irqreturn_t m_can_isr(int irq, void *dev_i=
d)
>  	struct net_device *dev =3D (struct net_device *)dev_id;
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
>  	u32 ir;
> +	irqreturn_t irq_ret =3D IRQ_NONE;

nitpick: please move before the "u32 ir;"

> =20
>  	if (pm_runtime_suspended(cdev->dev))
>  		return IRQ_NONE;
> +
>  	ir =3D m_can_read(cdev, M_CAN_IR);
> -	if (!ir)
> -		return IRQ_NONE;
> =20
> -	/* ACK all irqs */
> -	if (ir & IR_ALL_INT)
> -		m_can_write(cdev, M_CAN_IR, ir);
> +	if (!ir) {
> +		/* Handle device-specific interrupts */
> +		if (cdev->ops->handle_dev_interrupts)
> +			irq_ret =3D cdev->ops->handle_dev_interrupts(cdev, false);
> +		return irq_ret;
> +	}
> +
> +	/* ACK M_CAN interrupts */
> +	m_can_write(cdev, M_CAN_IR, ir);
> =20
> +	/* ACK device-specific interrupts */
>  	if (cdev->ops->handle_dev_interrupts)
>  		cdev->ops->handle_dev_interrupts(cdev, true);

Why do you call a 2nd time the handle_dev_interrupts() callback?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--c3m4hliicdao5cdh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmCuZBYACgkQqclaivrt
76lC1wgAk+nqdsbA9IXfk4CffBzob6q31XaHcZ1MPT7henkCYttEduvWGBjQVkWm
xhlAG3KEM8ch7qJ3wnz3HXreKywS3QypQa2fTmzRTrIAdH3G28LyuE5Z9eX1EUCW
WS4W961Tfhl8oHtsWPVRpNY3c2D4rX7F843sAB4lVI6nhB97OXr7jO4DuQogyJRL
CYH2/ZDWWn/Bik/G/SfieU5iMjnFPriTlbSLgInVSsvFfo2z400SOT11fr1WakSq
oIap97q+7q9R9EDs+2itKRhSuUNBpraFxdesXy62MtfqPS8AjBLuRJdD+aUK6VGz
M6lKZdHPZ/yzrEZDWcCL7pho0Lyayg==
=8FxF
-----END PGP SIGNATURE-----

--c3m4hliicdao5cdh--
