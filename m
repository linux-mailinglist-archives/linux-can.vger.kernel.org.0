Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61DD32F552
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 22:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCEVfQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 16:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCEVeu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 16:34:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B2C06175F
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:34:47 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lII5t-0003Yc-JA; Fri, 05 Mar 2021 22:34:45 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:b538:dfcc:368f:bb27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7AA615EED66;
        Fri,  5 Mar 2021 21:34:43 +0000 (UTC)
Date:   Fri, 5 Mar 2021 22:34:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: [PATCH 2/3] can: m_can: m_can_chip_config(): enable and
 configure internal timestamps
Message-ID: <20210305213442.aiqccxbagl353k3n@pengutronix.de>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
 <20210305172015.1506525-3-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ck3noamhmn4nk6e"
Content-Disposition: inline
In-Reply-To: <20210305172015.1506525-3-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--2ck3noamhmn4nk6e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.03.2021 17:20:14, Torin Cooper-Bennun wrote:
> This is a prerequisite for transitioning the m_can driver to rx-offload,
> which works best with TX and RX timestamps.
>=20
> The timestamps provided by M_CAN are 16-bit, timed according to the
> nominal bit timing, and may be prescaled by a multiplier up to 16. We
> choose the highest prescalar so that the timestamp wraps every 2^20 bit
> times, or 209 ms at a bus speed of 5 Mbit/s. Timestamps will have a
> precision of 16 bit times.
>=20
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> ---
>  drivers/net/can/m_can/m_can.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index ea79cf0640a8..83a673417e7c 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1139,6 +1139,7 @@ static int m_can_set_bittiming(struct net_device *d=
ev)
>   *		- >=3D v3.1.x: TX FIFO is used
>   * - configure mode
>   * - setup bittiming
> + * - configure timestamp generation
>   */
>  static void m_can_chip_config(struct net_device *dev)
>  {
> @@ -1250,6 +1251,11 @@ static void m_can_chip_config(struct net_device *d=
ev)
>  	/* set bittiming params */
>  	m_can_set_bittiming(dev);
> =20
> +	/* enable internal timestamp generation, with a prescalar of 16. The
> +	 * prescalar is applied to the nominal bit timing */
> +	m_can_write(cdev, M_CAN_TSCC,
> +		    (0xf << TSCC_TCP_SHIFT) | TSCC_TSS_INTERNAL);

FIELD_PREP(TSCC_TCP_MASK, 0xf)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--2ck3noamhmn4nk6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBCo/AACgkQqclaivrt
76m1EAf8D30IVulCIEyjfNs8UKQC4L3nVGPiM7LY3w19T2xaXnFKbAR2YzsN/NKg
3GwFCN+QyL1IiYB9gUspzdzBtE3NEy5gRKg6V0umGA/2Q/Po0OqmZTMDQt9974Xm
RKkxb12TvKhjW3IdQIduJFvqNxvdvhCm1pYKKT9YrH7/yKmIxnbu+KnWAhpBx0KD
00k4ZCMo4vPdPBPqJ7XPIjrjRQHPFXxlthwhxj2I7dlzkWfVglrMBsNtxuxVd0cD
VO+GO+5BPIEV1VU8DzTsD7w41keBj/SQod98U3HWAlVccmD6LcW7rs26LmMVHPd0
wZdWv08W/LdLl1mouWHFgs/wDLWXkA==
=6UjS
-----END PGP SIGNATURE-----

--2ck3noamhmn4nk6e--
