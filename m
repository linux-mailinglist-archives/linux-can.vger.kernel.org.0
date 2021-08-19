Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FA03F1874
	for <lists+linux-can@lfdr.de>; Thu, 19 Aug 2021 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhHSLpo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Aug 2021 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbhHSLpo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Aug 2021 07:45:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A3C061575
        for <linux-can@vger.kernel.org>; Thu, 19 Aug 2021 04:45:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mGgTq-0007yb-5g; Thu, 19 Aug 2021 13:45:06 +0200
Received: from pengutronix.de (unknown [IPv6:2a02:810a:8940:aa0:5b60:c5f4:67f4:2e1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 0CE4766A6A4;
        Thu, 19 Aug 2021 11:45:04 +0000 (UTC)
Date:   Thu, 19 Aug 2021 13:45:03 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Matt Kline <matt@bitbashing.io>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH v3 2/3] can: m_can: Batch FIFO reads during CAN receive
Message-ID: <20210819114503.mddh6iycglp5b4gs@pengutronix.de>
References: <20210817050853.14875-1-matt@bitbashing.io>
 <20210817050853.14875-3-matt@bitbashing.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="epq4jw3pcaprckys"
Content-Disposition: inline
In-Reply-To: <20210817050853.14875-3-matt@bitbashing.io>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--epq4jw3pcaprckys
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.08.2021 22:08:52, Matt Kline wrote:
> On peripherals communicating over a relatively slow SPI line
> (e.g. tcan4x5x), individual transfers have high fixed costs.
> This causes the driver to spend most of its time waiting between
> transfers and severely limits throughput.
>=20
> Reduce these overheads by reading more than one word at a time.
> Writing could get a similar treatment in follow-on commits.
>=20
> Signed-off-by: Matt Kline <matt@bitbashing.io>
> ---
>  drivers/net/can/m_can/m_can.c | 51 +++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 83eb5cd51de5..85d6cd03bff1 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -308,6 +308,15 @@ enum m_can_reg {
>  #define TX_EVENT_MM_MASK	GENMASK(31, 24)
>  #define TX_EVENT_TXTS_MASK	GENMASK(15, 0)
> =20
> +/* The ID and DLC registers are adjacent in M_CAN FIFO memory,
> + * and we can save a (potentially slow) bus round trip by combining
> + * reads and writes to them.
> + */
> +struct __packed id_and_dlc {
> +	u32 id;
> +	u32 dlc;
> +};

No need for __packed, removed while applying.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--epq4jw3pcaprckys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmEeRDwACgkQqclaivrt
76n8UAf8CGLUltOhFGOOVck1l24yTP3BR0+LIi7XnuiHI/HmZivagVZjB9je11mu
M2xpLzmD7qwsJNJ198iNeVDpkIsBPaJyA6YtKCjURKYfLmWnsOBir9/2lJjv/IeZ
+QE7JNXeh54QYoJfNhmdRxIW56S9Wqaoav9JFBc3ch/MkqnJriebcAGF5MDFmNHq
21W6K9IyaDpTWFOZgvIMlAERPI9YxeT3vuzTGOPjQOQ31WHp7KNs1lvVm6n+GUlB
xggPOJ2viJh4QSiNGWiDAstnvXO8wH5HqHFX1YAR/2Eb/nV6y5YSHGNOuwtqXZtq
xlUtb7yUxjuo+4VSqqQVmam2r/e2+A==
=BF2Q
-----END PGP SIGNATURE-----

--epq4jw3pcaprckys--
