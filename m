Return-Path: <linux-can+bounces-5563-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715EC78938
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 11:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2DBDD2D037
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B9F338918;
	Fri, 21 Nov 2025 10:52:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2156E342531
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722354; cv=none; b=g/Lj1TsOunkhHzmdi2TsVqdKGr67pNS9hvCvMA7J6LalWAS21RBTviRiT+/mIk+xjCFCdxr+7JrP90+VLpBjyWdnXO+CPObeKoW9/qH/W/3CwgkrMZEdnQfS+/ElVbKnyMsy20bYSmCm/dbf98IbevZxlPfE1IXLAYPcO6W07jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722354; c=relaxed/simple;
	bh=4a6SvdWjNizHRmfd7CBXFgrBcmtl6JVCdVvIoUeUow4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSa/sih6CR1hbsSifJLohVlQAPSdN6VPEoescZht7LVG5vHa34n8y4ESo2z/CvKntaUciaPm822VS6S8wHu9MPrHml9W3vQSxBLeqM4QbADsIRM0cGm8AgUdaXtR+p4mer/LzhLLyP8bhWLOU1IP0+GRHzeKg8Qz1iIQs84v5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMOkX-0004pf-Kb; Fri, 21 Nov 2025 11:52:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMOkX-001ZON-0X;
	Fri, 21 Nov 2025 11:52:21 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D47D94A46CD;
	Fri, 21 Nov 2025 10:52:20 +0000 (UTC)
Date: Fri, 21 Nov 2025 11:52:20 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH 05/10] can: grcan: add FD capability detection and
 nominal bit-timing
Message-ID: <20251121-ancient-flamingo-of-cubism-cda563-mkl@pengutronix.de>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-6-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aldfdquxivinbn3p"
Content-Disposition: inline
In-Reply-To: <20251118092115.3455-6-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--aldfdquxivinbn3p
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 05/10] can: grcan: add FD capability detection and
 nominal bit-timing
MIME-Version: 1.0

On 18.11.2025 10:21:10, Arun Muthusamy wrote:
> From: Daniel Hellstrom <daniel@gaisler.com>
>
> Add capability for the driver to detect CAN FD support
> and adjust accordingly. Introduce structures and functions
> for setting nominal bit-timing for standard CAN and CAN FD.
> The `grcan_hwcap` structure defines hardware capabilities like
> CAN FD support and baud-rate options. Additionally, improved
> device tree compatibility by updating the `of_device_id` table
> for better matching of GRCAN and GRCANFD devices. Also update
> Kconfig to mention GRCANFD support.
>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>

Your S-o-b must come last.

> ---
>  drivers/net/can/Kconfig |   6 +-
>  drivers/net/can/grcan.c | 189 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 176 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index d43d56694667..816b6e71a990 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -133,10 +133,12 @@ config CAN_FLEXCAN
>  	  Say Y here if you want to support for Freescale FlexCAN.
>
>  config CAN_GRCAN
> -	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
> +	tristate "Aeroflex Gaisler GRCAN, GRCANFD and GRHCAN CAN devices"
>  	depends on OF && HAS_DMA && HAS_IOMEM
>  	help
> -	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
> +	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRCANFD
> +	  or GRHCAN.
> +
>  	  Note that the driver supports little endian, even though little
>  	  endian syntheses of the cores would need some modifications on
>  	  the hardware level to work.
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> index 538a9b4f82ab..b9b0dd7d53f6 100644
> --- a/drivers/net/can/grcan.c
> +++ b/drivers/net/can/grcan.c
> @@ -33,6 +33,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> @@ -50,7 +51,11 @@ struct grcan_registers {
>  	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
>  	u32 smask;	/* 0x18 - CanMASK */
>  	u32 scode;	/* 0x1c - CanCODE */
> -	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x100)];
> +	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x40)];
> +	u32 nbtr;	/* 0x40 */
> +	u32 fdbtr;	/* 0x44 */
> +	u32 tdelay;	/* 0x48 */
> +	u32 __reserved2_[GRCAN_RESERVE_SIZE(0x48, 0x100)];
>  	u32 pimsr;	/* 0x100 */
>  	u32 pimr;	/* 0x104 */
>  	u32 pisr;	/* 0x108 */
> @@ -212,6 +217,67 @@ struct grcan_registers {
>  #error "Invalid default buffer size"
>  #endif
>
> +#define GRCANFD_NOMCONF_SJW_MIN	1
> +#define GRCANFD_NOMCONF_SJW_MAX	16
> +#define GRCANFD_NOMCONF_PS1_MIN	2
> +#define GRCANFD_NOMCONF_PS1_MAX	63
> +#define GRCANFD_NOMCONF_PS2_MIN	2
> +#define GRCANFD_NOMCONF_PS2_MAX	16
> +#define GRCANFD_NOMCONF_SCALER_MIN	0
> +#define GRCANFD_NOMCONF_SCALER_MAX	255
> +#define GRCANFD_NOMCONF_SCALER_INC	1

Please directly add the values to the struct can_bittiming_const.

> +
> +#define GRCANFD_NBTR_SCALER 0x00ff0000
> +#define GRCANFD_NBTR_PS1 0x0000fc00
> +#define GRCANFD_NBTR_PS2 0x000003e0
> +#define GRCANFD_NBTR_SJW 0x0000001f

Please use GEN_MASK() for these

> +#define GRCANFD_NBTR_TIMING						\
> +	(GRCANFD_NBTR_SCALER | GRCANFD_NBTR_PS1 | GRCANFD_NBTR_PS2 |	\
> +	 GRCANFD_NBTR_SJW)
> +
> +#define GRCANFD_NBTR_SCALER_BIT 16
> +#define GRCANFD_NBTR_PS1_BIT 10
> +#define GRCANFD_NBTR_PS2_BIT 5
> +#define GRCANFD_NBTR_SJW_BIT 0

These can be removed, if you use FIELD_PREP()...see below

Same comments apply to the FD defines...

> +
> +#define GRCANFD_FDCONF_SJW_MIN	1
> +#define GRCANFD_FDCONF_SJW_MAX	8
> +#define GRCANFD_FDCONF_PS1_MIN	1
> +#define GRCANFD_FDCONF_PS1_MAX	15
> +#define GRCANFD_FDCONF_PS2_MIN	2
> +#define GRCANFD_FDCONF_PS2_MAX	8
> +#define GRCANFD_FDCONF_SCALER_MIN	0
> +#define GRCANFD_FDCONF_SCALER_MAX	255
> +#define GRCANFD_FDCONF_SCALER_INC	1
> +
> +#define GRCANFD_FDBTR_SCALER 0x00ff0000
> +#define GRCANFD_FDBTR_PS1 0x00003c00
> +#define GRCANFD_FDBTR_PS2 0x000001e0
> +#define GRCANFD_FDBTR_SJW 0x0000000f
> +#define GRCANFD_FDBTR_TIMING						\
> +	(GRCANFD_FDBTR_SCALER | GRCANFD_FDBTR_PS1 | GRCANFD_FDBTR_PS2 |	\
> +	 GRCANFD_FDBTR_SJW)
> +
> +#define GRCANFD_FDBTR_SCALER_BIT 16
> +#define GRCANFD_FDBTR_PS1_BIT 10
> +#define GRCANFD_FDBTR_PS2_BIT 5
> +#define GRCANFD_FDBTR_SJW_BIT 0
> +
> +/* Hardware capabilities */
> +struct grcan_hwcap {
> +	/* CAN-FD capable, indicates GRCANFD IP.
> +	 * The GRCANFD has different baud-rate registers and extended DMA
> +	 * format to also describe FD-frames.
> +	 */
> +	bool fd;
> +	bool txbug_possible;

Please move the bools the end of the struct for better packing.

> +	const struct can_bittiming_const *bt_const;
> +	int (*set_bittiming)(struct net_device *dev);
> +};
> +
> +static const struct grcan_hwcap grcan_hwcap;
> +static const struct of_device_id grcan_match[];

can you avoid forward declaration by re-arranging you code?

> +
>  struct grcan_dma_buffer {
>  	size_t size;
>  	void *buf;
> @@ -304,6 +370,8 @@ struct grcan_priv {
>  	 */
>  	bool resetting;
>  	bool closing;
> +
> +	const struct grcan_hwcap *hwcap;

Same here, move the pointer in front of the bools. You can check the
struct packing with "pahole -a /path/to/driver.o"

>  };
>
>  /* Wait time for a short wait for ongoing to clear */
> @@ -402,6 +470,19 @@ static const struct can_bittiming_const grcan_bittim=
ing_const =3D {
>  	.brp_inc	=3D GRCAN_CONF_SCALER_INC,
>  };
>
> +/* GRCANFD nominal boundaries for baud-rate parameters */
> +static const struct can_bittiming_const grcanfd_bittiming_const =3D {
> +	.name		=3D DRV_NAME,
> +	.tseg1_min	=3D GRCANFD_NOMCONF_PS1_MIN,
> +	.tseg1_max	=3D GRCANFD_NOMCONF_PS1_MAX,
> +	.tseg2_min	=3D GRCANFD_NOMCONF_PS2_MIN,
> +	.tseg2_max	=3D GRCANFD_NOMCONF_PS2_MAX,
> +	.sjw_max	=3D GRCANFD_NOMCONF_SJW_MAX,
> +	.brp_min	=3D GRCANFD_NOMCONF_SCALER_MIN + 1,
> +	.brp_max	=3D GRCANFD_NOMCONF_SCALER_MAX + 1,
> +	.brp_inc	=3D GRCANFD_NOMCONF_SCALER_INC,
> +};
> +
>  static int grcan_set_bittiming(struct net_device *dev)
>  {
>  	struct grcan_priv *priv =3D netdev_priv(dev);
> @@ -439,12 +520,55 @@ static int grcan_set_bittiming(struct net_device *d=
ev)
>  	timing |=3D (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
>  	timing |=3D (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
>  	timing |=3D (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
> -	netdev_info(dev, "setting timing=3D0x%x\n", timing);
> +	netdev_dbg(dev, "setting timing=3D0x%x\n", timing);

nice!

>  	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
>
>  	return 0;
>  }
>
> +static int grcanfd_set_bittiming(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct can_bittiming *bt =3D &priv->can.bittiming;
> +	const char *msg;
> +	u32 timing =3D 0;
> +	int sjw, ps1, ps2, scaler;
> +
> +	/* Should never happen - function will not be called when
> +	 * device is up
> +	 */
> +	if (grcan_read_bits(&regs->ctrl, GRCAN_CTRL_ENABLE))
> +		return -EBUSY;

The framework will take care of this

> +
> +	sjw =3D bt->sjw;
> +	ps1 =3D (bt->prop_seg + bt->phase_seg1); /* tseg1 */

nitpick:
I think the comment can be removed, it's obvious.

> +	ps2 =3D bt->phase_seg2;
> +	scaler =3D (bt->brp - 1);

please remove the ( )

> +	netdev_dbg(dev, "Request for SJW=3D%d, PS1=3D%d, PS2=3D%d, SCALER=3D%d",
> +		   sjw, ps1, ps2, scaler);

I think the debug can be removed

> +	if (sjw > min(ps1, ps2)) {
> +		msg =3D "SJW <=3D MIN(PS1,PS2) must hold: PS1=3D%d, PS2=3D%d, SJW=3D%d=
\n";
> +		netdev_err(dev, msg, ps1, ps2, sjw);
> +		return -EINVAL;
> +	}
> +	if (ps2 < sjw) {
> +		netdev_err(dev, "PS2 >=3D SJW must hold: PS2=3D%d, SJW=3D%d\n",
> +			   ps2, sjw);
> +		return -EINVAL;
> +	}

The framework already does these checks for you:

https://elixir.bootlin.com/linux/v6.17.8/source/drivers/net/can/dev/bittimi=
ng.c#L18

> +
> +	timing |=3D (sjw << GRCANFD_NBTR_SJW_BIT) & GRCANFD_NBTR_SJW;
> +	timing |=3D (ps1 << GRCANFD_NBTR_PS1_BIT) & GRCANFD_NBTR_PS1;
> +	timing |=3D (ps2 << GRCANFD_NBTR_PS2_BIT) & GRCANFD_NBTR_PS2;
> +	timing |=3D (scaler << GRCANFD_NBTR_SCALER_BIT) &
> +		  GRCANFD_NBTR_SCALER;

Please use FIELD_PREP() instead of doing the shifting yourself.

> +	netdev_info(dev, "setting timing=3D0x%x\n", timing);
> +	grcan_write_bits(&regs->nbtr, timing, GRCANFD_NBTR_TIMING);
> +
> +	return 0;
> +}
> +
>  static int grcan_get_berr_counter(const struct net_device *dev,
>  				  struct can_berr_counter *bec)
>  {
> @@ -1569,7 +1693,8 @@ static const struct ethtool_ops grcan_ethtool_ops =
=3D {
>
>  static int grcan_setup_netdev(struct platform_device *ofdev,
>  			      void __iomem *base,
> -			      int irq, u32 ambafreq, bool txbug)
> +			      int irq, u32 ambafreq, bool txbug,
> +			      const struct grcan_hwcap *hwcap)
>  {
>  	struct net_device *dev;
>  	struct grcan_priv *priv;
> @@ -1592,14 +1717,15 @@ static int grcan_setup_netdev(struct platform_dev=
ice *ofdev,
>  	priv->dev =3D dev;
>  	priv->ofdev_dev =3D &ofdev->dev;
>  	priv->regs =3D base;
> -	priv->can.bittiming_const =3D &grcan_bittiming_const;
> -	priv->can.do_set_bittiming =3D grcan_set_bittiming;
> +	priv->can.bittiming_const =3D hwcap->bt_const;
> +	priv->can.do_set_bittiming =3D hwcap->set_bittiming;
>  	priv->can.do_set_mode =3D grcan_set_mode;
>  	priv->can.do_get_berr_counter =3D grcan_get_berr_counter;
>  	priv->can.clock.freq =3D ambafreq;
>  	priv->can.ctrlmode_supported =3D
>  		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
>  	priv->need_txbug_workaround =3D txbug;
> +	priv->hwcap =3D hwcap;
>
>  	/* Discover if triple sampling is supported by hardware */
>  	regs =3D priv->regs;
> @@ -1644,22 +1770,32 @@ static int grcan_probe(struct platform_device *of=
dev)
>  {
>  	struct device_node *np =3D ofdev->dev.of_node;
>  	struct device_node *sysid_parent;
> +	const struct of_device_id *of_id;
> +	const struct grcan_hwcap *hwcap =3D &grcan_hwcap;
                                          ^^^^^^^^^^^^^

Why do you initialize this variable?

The networking subsystem thinks that the variables should be placed in
reverse-christmas-tree style. Here it should be possible to arrange it
like this:

>  {
> +	const struct grcan_hwcap *hwcap =3D &grcan_hwcap;
>  	struct device_node *np =3D ofdev->dev.of_node;
>  	struct device_node *sysid_parent;
> +	const struct of_device_id *of_id;


>  	struct clk *clk;
>  	u32 sysid, ambafreq;
>  	int irq, err;
>  	void __iomem *base;
>  	bool txbug =3D true;
>
> +	of_id =3D of_match_device(grcan_match, &ofdev->dev);
> +	if (of_id && of_id->data)
> +		hwcap =3D (struct grcan_hwcap *)of_id->data;
> +

please use device_get_match_data(&ofdev->dev);

regards,
Marc

--
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--aldfdquxivinbn3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgRGIACgkQDHRl3/mQ
kZxzEgf+L9c4I3DLIRHnVP8mMZSa50YID2Gn0IHVjFlCudGtbHYiUiUzdOV4LfcN
tyq3gbM91b8igscPlNV7LOCGf2L0RnArlPpklZVL6ue8QTeJOCiiDd9B79pUieNp
oX0GlMPcrxLWxtcjPTWSM7prJiVp4sSyE4xA/dLFRjMa5xrwyNZYu9ah7gFWJ6V7
IbykcKnj9S0IcQGayZJRJOPMxtmKDpnPEDwEgKDN9CqDS2HihlzTDrK2FlIDEUbb
RU4kSfZZHMyuMVB8cOzcmFMDVO4/8vpf+efPb2T5tinDi8NlTwfPS1y01ETShhmH
GXsH7JBgCPShA5h11pH5EnNmPkI2YQ==
=B1Wb
-----END PGP SIGNATURE-----

--aldfdquxivinbn3p--

