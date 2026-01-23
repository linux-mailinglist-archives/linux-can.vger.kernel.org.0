Return-Path: <linux-can+bounces-6281-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJkkIiF9c2mGwwAAu9opvQ
	(envelope-from <linux-can+bounces-6281-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:52:33 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA1E767B3
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 14:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE149301982A
	for <lists+linux-can@lfdr.de>; Fri, 23 Jan 2026 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936F21CAA68;
	Fri, 23 Jan 2026 13:52:31 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBF267B89
	for <linux-can@vger.kernel.org>; Fri, 23 Jan 2026 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176351; cv=none; b=hz0/4+BOVbkEkc32COzG6199zjQx/Q9+fy3mKCgC4xTWwvUtX+a3FenqjX/023B5h/8nJEp4dQR1MmBdDj/AJESrkXNaLi8nt++3IQCESPgVJXr0YFwk6ZH64/8kRcdU99Y+k3bbz7jfk6T0L2iXlKn3x3SEkcLlqayHt6Mu62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176351; c=relaxed/simple;
	bh=rjzhPXRMCfLLYJnFst69yx1mkRr/XdxD866So/nWmQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHMcFKuE/Lwd0/Jmn19BJCqrj6KeF5aQQaa/GWw6Lknrp5SAlPxz5Itt0IcKXaTthoWsFufoiBHY22oTrcDZm8JebFjKEoudQcuGbsmexF5avP9PEW21dXagKSW6KlqVyPvkehBQt/s8F6cPL5MIFTtrSWDY8QhxMGbXZq7S7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHaG-0007rZ-KO; Fri, 23 Jan 2026 14:52:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vjHaH-0026K9-07;
	Fri, 23 Jan 2026 14:52:20 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0FD794D6F2F;
	Fri, 23 Jan 2026 13:52:20 +0000 (UTC)
Date: Fri, 23 Jan 2026 14:52:19 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mailhol@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, Daniel Hellstrom <daniel@gaisler.com>
Subject: Re: [PATCH v3 07/15] can: grcan: add FD capability detection and
 nominal bit-timing
Message-ID: <20260123-lush-cryptic-parrot-ea322c-mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-8-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbgyz4hxgvrjdl5m"
Content-Disposition: inline
In-Reply-To: <20260122121038.7910-8-arun.muthusamy@gaisler.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6281-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:url,pengutronix.de:mid]
X-Rspamd-Queue-Id: EAA1E767B3
X-Rspamd-Action: no action


--nbgyz4hxgvrjdl5m
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 07/15] can: grcan: add FD capability detection and
 nominal bit-timing
MIME-Version: 1.0

On 22.01.2026 13:10:30, Arun Muthusamy wrote:
> Add capability for the driver to detect CAN FD support
> and adjust accordingly. Introduce structures and functions
> for setting nominal bit-timing for standard CAN FD.
> The `grcan_hwcap` structure defines hardware capabilities like
> CAN FD support and baud-rate options. Additionally, improved
> device tree compatibility by updating the `of_device_id` table
> for better matching of GRCAN and GRCANFD devices. Also update
> Kconfig to mention GRCANFD support.
>
> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
> ---
>  drivers/net/can/Kconfig |   6 +-
>  drivers/net/can/grcan.c | 142 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 130 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index d43d56694667..96f61b40a898 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -133,10 +133,12 @@ config CAN_FLEXCAN
>  	  Say Y here if you want to support for Freescale FlexCAN.
>
>  config CAN_GRCAN
> -	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
> +	tristate "Aeroflex Gaisler GRCAN(FD) and GRHCAN CAN devices"
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
> index 5a63d0a0365f..5d09f61a153c 100644
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
> @@ -51,7 +52,11 @@ struct grcan_registers {
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
> @@ -203,6 +208,39 @@ struct grcan_registers {
>  #error "Invalid default buffer size"
>  #endif
>
> +#define GRCANFD_NBTR_SCALER     GENMASK(23, 16)
> +#define GRCANFD_NBTR_PS1        GENMASK(17, 10)
> +#define GRCANFD_NBTR_PS2        GENMASK(9, 5)
> +#define GRCANFD_NBTR_SJW        GENMASK(4, 0)
> +#define GRCANFD_NBTR_TIMING						\
> +	(GRCANFD_NBTR_SCALER | GRCANFD_NBTR_PS1 | GRCANFD_NBTR_PS2 |	\
> +	 GRCANFD_NBTR_SJW)
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
> +	const struct can_bittiming_const *bt_const;
> +	int (*set_bittiming)(struct net_device *dev);
> +	bool txbug_possible;
> +	bool fd;
> +};
> +
>  struct grcan_dma_buffer {
>  	size_t size;
>  	void *buf;
> @@ -245,6 +283,7 @@ struct grcan_priv {
>  	struct napi_struct napi;
>
>  	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
> +	const struct grcan_hwcap *hwcap;
>  	struct grcan_device_config config;
>  	struct grcan_dma dma;
>
> @@ -295,6 +334,7 @@ struct grcan_priv {
>  	 */
>  	bool resetting;
>  	bool closing;
> +

Please remove this change

>  };
>
>  /* Wait time for a short wait for ongoing to clear */
> @@ -393,6 +433,19 @@ static const struct can_bittiming_const grcan_bittim=
ing_const =3D {
>  	.brp_inc	=3D 1,
>  };
>
> +/* GRCANFD nominal boundaries for baud-rate parameters */
> +static const struct can_bittiming_const grcanfd_bittiming_const =3D {
> +	.name		=3D DRV_NAME,
> +	.tseg1_min	=3D 2,
> +	.tseg1_max	=3D 63,
> +	.tseg2_min	=3D 2,
> +	.tseg2_max	=3D 16,
> +	.sjw_max	=3D 16,
> +	.brp_min	=3D 1,
> +	.brp_max	=3D 256,
> +	.brp_inc	=3D 1,
> +};
> +
>  static int grcan_set_bittiming(struct net_device *dev)
>  {
>  	struct grcan_priv *priv =3D netdev_priv(dev);
> @@ -421,6 +474,32 @@ static int grcan_set_bittiming(struct net_device *de=
v)
>  	return 0;
>  }
>
> +static int grcanfd_set_bittiming(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs;
> +	int sjw, ps1, ps2, scaler;
> +	struct can_bittiming *bt;
> +	u32 timing =3D 0;
> +
> +	regs =3D priv->regs;
> +	bt =3D &priv->can.bittiming;
> +
> +	sjw =3D bt->sjw;
> +	ps1 =3D (bt->prop_seg + bt->phase_seg1);
> +	ps2 =3D bt->phase_seg2;
> +	scaler =3D bt->brp - 1;
> +
> +	timing |=3D FIELD_PREP(GRCANFD_NBTR_SJW, sjw);
> +	timing |=3D FIELD_PREP(GRCANFD_NBTR_PS1, ps1);
> +	timing |=3D FIELD_PREP(GRCANFD_NBTR_PS2, ps2);
> +	timing |=3D FIELD_PREP(GRCANFD_NBTR_SCALER, scaler);
> +	netdev_info(dev, "setting timing=3D0x%x\n", timing);

make it debug or remove

> +	grcan_write_bits(&regs->nbtr, timing, GRCANFD_NBTR_TIMING);
> +
> +	return 0;
> +}
> +
>  static int grcan_get_berr_counter(const struct net_device *dev,
>  				  struct can_berr_counter *bec)
>  {
> @@ -1545,7 +1624,8 @@ static const struct ethtool_ops grcan_ethtool_ops =
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
> @@ -1568,14 +1648,14 @@ static int grcan_setup_netdev(struct platform_dev=
ice *ofdev,
>  	priv->dev =3D dev;
>  	priv->ofdev_dev =3D &ofdev->dev;
>  	priv->regs =3D base;
> -	priv->can.bittiming_const =3D &grcan_bittiming_const;
> -	priv->can.do_set_bittiming =3D grcan_set_bittiming;
> +	priv->can.bittiming_const =3D hwcap->bt_const;
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
> @@ -1620,22 +1700,33 @@ static int grcan_probe(struct platform_device *of=
dev)
>  {
>  	struct device_node *np =3D ofdev->dev.of_node;
>  	struct device_node *sysid_parent;
> +	const struct grcan_hwcap *hwcap;
>  	struct clk *clk;
>  	u32 sysid, ambafreq;
>  	int irq, err;
>  	void __iomem *base;
>  	bool txbug =3D true;
>
> +	hwcap =3D device_get_match_data(&ofdev->dev);
> +	if (!hwcap) {
> +		dev_err(&ofdev->dev, "Platform data not provided!\n");
> +		return -ENODEV;
> +	}
> +

All entries in grcan_match have a corresponding data member, so I think
you can remove this check.

[...]

>  static const struct of_device_id grcan_match[] =3D {
> -	{.name =3D "GAISLER_GRCAN"},
> -	{.name =3D "01_03d"},
> -	{.name =3D "GAISLER_GRHCAN"},
> -	{.name =3D "01_034"},
> +	{.name =3D "GAISLER_GRCAN", .data =3D &grcan_hwcap},
> +	{.name =3D "01_03d", .data =3D &grcan_hwcap},
> +	{.name =3D "GAISLER_GRHCAN", .data =3D &grcan_hwcap},
> +	{.name =3D "01_034", .data =3D &grcan_hwcap},
> +	{.compatible =3D "gaisler,grcan", .data =3D &grcan_hwcap},
> +	/* GRCANFD */
> +	{.compatible =3D "gaisler,grcanfd", .data =3D &grcanfd_hwcap},
> +	{.name =3D "GAISLER_GRCANFD", .data =3D &grcanfd_hwcap},
> +	{.name =3D "01_0b5", .data =3D &grcanfd_hwcap},
>  	{},
>  };
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nbgyz4hxgvrjdl5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmlzfREACgkQDHRl3/mQ
kZy+sAf/VXwWH262dCUcu/YlV57EjcPV0hkdEmT5P6FGh2lBSnEPeNPTKULazVE6
bW26iC3J2hLbgtMS8YDkq41i14opyijRvZvNsgxs1pnv5L7atef/BVXUL+HArr0/
A2kCnJStF/A/knqiVUp0z9os3nazLcgMCskPH+/jZaArglH8pj/KhzqUAkLxKSlK
9LklqZvXCidLz+5hoAgETKYmS5qck4JQ0DuyExC2c5/v6UGE+0XrmTuMlQYAXXo2
bYIVhFRhlxsI7DurV/blCpLNVS3C43TvXImsDbL6lgGaIHSwNJSGtopki2gvoiBL
P/0BDHLRwGrMyB7azcyY3wi+WxshZA==
=jmyG
-----END PGP SIGNATURE-----

--nbgyz4hxgvrjdl5m--

