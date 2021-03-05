Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC38432F547
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 22:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCEV2l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 16:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCEV2l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 16:28:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40FC06175F
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:28:41 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIHzw-00035l-HU; Fri, 05 Mar 2021 22:28:36 +0100
Received: from pengutronix.de (unknown [IPv6:2a03:f580:87bc:d400:b538:dfcc:368f:bb27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B9F1E5EED5D;
        Fri,  5 Mar 2021 21:28:34 +0000 (UTC)
Date:   Fri, 5 Mar 2021 22:28:33 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Torin Cooper-Bennun <torin@maxiluxsystems.com>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: [PATCH 1/3] can: m_can: add infrastructure for internal
 timestamps
Message-ID: <20210305212833.vzo3zobpwdoyvroa@pengutronix.de>
References: <20210305172015.1506525-1-torin@maxiluxsystems.com>
 <20210305172015.1506525-2-torin@maxiluxsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="myrjbmi6fjeuek6n"
Content-Disposition: inline
In-Reply-To: <20210305172015.1506525-2-torin@maxiluxsystems.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--myrjbmi6fjeuek6n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 05.03.2021 17:20:13, Torin Cooper-Bennun wrote:
> Add infrastucture to allow internal timestamps from the M_CAN to be
> configured and retrieved.
>
> Signed-off-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> ---
>  drivers/net/can/m_can/m_can.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 0c8d36bc668c..ea79cf0640a8 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -148,6 +148,19 @@ enum m_can_reg {
>  #define NBTP_NTSEG2_SHIFT	0
>  #define NBTP_NTSEG2_MASK	(0x7f << NBTP_NTSEG2_SHIFT)
>
> +/* Timestamp Counter Configuration Register (TSCC) */
> +#define TSCC_TCP_SHIFT		16
> +#define TSCC_TCP_MASK		(0xf << TSCC_TCP_SHIFT)
> +#define TSCC_TSS_SHIFT		0
> +#define TSCC_TSS_MASK		(0x3 << TSCC_TSS_SHIFT)
> +#define TSCC_TSS_DISABLE	(0x0 << TSCC_TSS_SHIFT)
> +#define TSCC_TSS_INTERNAL	(0x1 << TSCC_TSS_SHIFT)
> +#define TSCC_TSS_EXTERNAL	(0x2 << TSCC_TSS_SHIFT)

Even if the driver doesn't make use of GENMASK(), please add new masks
with GENMASK(), there's no need to define the _SHIFT values.

> +
> +/* Timestamp Counter Value Register (TSCV) */
> +#define TSCV_TSC_SHIFT		0
> +#define TSCV_TSC_MASK		(0xffff << TSCV_TSC_SHIFT)
> +
>  /* Error Counter Register(ECR) */
>  #define ECR_RP			BIT(15)
>  #define ECR_REC_SHIFT		8
> @@ -302,6 +315,8 @@ enum m_can_reg {
>  #define RX_BUF_ANMF		BIT(31)
>  #define RX_BUF_FDF		BIT(21)
>  #define RX_BUF_BRS		BIT(20)
> +#define RX_BUF_RXTS_SHIFT	0
> +#define RX_BUF_RXTS_MASK	(0xffff << RX_BUF_RXTS_SHIFT)
>
>  /* Tx Buffer Element */
>  /* T0 */
> @@ -319,6 +334,8 @@ enum m_can_reg {
>  /* E1 */
>  #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
>  #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
> +#define TX_EVENT_TXTS_SHIFT	0
> +#define TX_EVENT_TXTS_MASK	(0xffff << TX_EVENT_TXTS_SHIFT)
>
>  static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
>  {
> @@ -413,6 +430,20 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
>  	m_can_write(cdev, M_CAN_ILE, 0x0);
>  }
>
> +/* Retrieve internal timestamp counter from TSCV.TSC, and shift it to 32-bit
> + * width.
> + */
> +static u32 m_can_get_timestamp(struct m_can_classdev *cdev)
> +{
> +	u32 tscv;
> +	u32 tsc;
> +
> +	tscv = m_can_read(cdev, M_CAN_TSCV);
> +	tsc = (tscv & TSCV_TSC_MASK) >> TSCV_TSC_SHIFT;

Make use of FIELD_GET here:

     tsc = FIELD_GET(TSCV_TSC_MASK, tcsv);

Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--myrjbmi6fjeuek6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmBCon8ACgkQqclaivrt
76nF8ggAgAi6hgl2g6TBgXXGYVpPVd7WHOXswNouhOK3rpXtZ5+U635tQh9eKIF3
y9gMnwFNvqXhFBKOpvox0N9iNmJA7Z33yTFr3KIXCA7SbIruCxbr6/WZSu4ZCM94
0v6AbA0yUZM99pir+0llj+6RAZ53F6U2ieGkF5sbyK7fqFC6wt2qBmvjJTfNVBW7
5ZsrP0wyGRNUCqi1IAMaxbHT/K51tDJnsZ6T3DHLghEwz8Rkra9BC2gB4WqqKqOl
Eh9LDYA/+CCnRGC48hZxEXy5JROfxtyE6Wg4ZhbxIuCGCvwC2ZfgaNTkDd1kP4T1
jrFG1lOWAZLwrhFPirv4A7mjmx06UQ==
=X6XG
-----END PGP SIGNATURE-----

--myrjbmi6fjeuek6n--
