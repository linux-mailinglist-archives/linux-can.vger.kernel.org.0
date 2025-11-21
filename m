Return-Path: <linux-can+bounces-5551-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C62C78212
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6142C2D5BF
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378AA33F8DA;
	Fri, 21 Nov 2025 09:21:17 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA74309DD8
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716876; cv=none; b=R1I+Q+wmE6KUhpLbbOfSWxLKI9TfaH2Wc0YejTksmfBPKCCzEhQlqVKyOMrgaJZK+RLSPlEoSUIgQ1t6ORV3Z7LW6LahDS4Hugp+MvYjcxxWej1XeNY8sqYz++4rvL+NSBbgdblvTuyTp/Y7RaTDxUVhwD1Spxc7cpHQehhpHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716876; c=relaxed/simple;
	bh=C5BHIMjV3sAokoGvSE3FVXFaPb1llL+HNkAo+d20Liw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BicCYi7SDxS6qSX2pwcJuy9SknZiS3Yv8y0DGHYweWwkWZsnlpzbdCDwtysVzW00VJIwkLM9Ey9llAcdYXBTzub12QN0kK0xoArI2Frhvz1ZbjXDvJdfJhUoI8VaqBXnt5fj/nsSkhGQLrJuCg/Wb1YOzGhzL+kiXuI6SQezwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNKJ-0003V2-N1; Fri, 21 Nov 2025 10:21:11 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vMNKJ-001Yql-1T;
	Fri, 21 Nov 2025 10:21:11 +0100
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1EF474A45FF;
	Fri, 21 Nov 2025 09:21:11 +0000 (UTC)
Date: Fri, 21 Nov 2025 10:21:10 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [canxl v4 14/17] can: add dummy_can driver
Message-ID: <20251121-bald-encouraging-jaguarundi-6688a4-mkl@pengutronix.de>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-15-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7felscdhkinm2jy"
Content-Disposition: inline
In-Reply-To: <20251121083414.3642-15-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--s7felscdhkinm2jy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [canxl v4 14/17] can: add dummy_can driver
MIME-Version: 1.0

On 21.11.2025 09:34:11, Oliver Hartkopp wrote:
> From: Vincent Mailhol <mailhol@kernel.org>
>
> During the development of CAN XL, we found the need of creating a
> dummy CAN XL driver in order to test the new netlink interface. While
> this code was initially intended to be some throwaway, it received
> some positive feedback.
>
> Add the dummy_can driver. This driver acts similarly to the vcan
> interface in the sense that it will echo back any packet it receives.
> The difference is that it exposes a set on bittiming parameters as a
> real device would and thus must be configured as if it was a real
> physical interface.
>
> The driver comes with a debug mode. If debug message are enabled (for
> example by enabling CONFIG_CAN_DEBUG_DEVICES), it will print in the
> kernel log all the bittiming values, similar to what a:
>
>   ip --details link show can0
>
> would do.
>
> This driver is mostly intended for debugging and testing, but some
> developers also may want to look at it as a simple reference
> implementation.
>
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/Kconfig     |  17 +++
>  drivers/net/can/Makefile    |   1 +
>  drivers/net/can/dummy_can.c | 284 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 302 insertions(+)
>  create mode 100644 drivers/net/can/dummy_can.c
>
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index d43d56694667..e15e320db476 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -122,10 +122,27 @@ config CAN_CAN327
>  	  Please refer to the documentation for information on how to use it:
>  	  Documentation/networking/device_drivers/can/can327.rst
>
>  	  If this driver is built as a module, it will be called can327.
>
> +config CAN_DUMMY
> +	tristate "Dummy CAN"
> +	help
> +	  A dummy CAN module supporting Classical CAN, CAN FD and CAN XL. It
> +	  exposes bittiming values which can be configured through the netlink
> +	  interface.
> +
> +	  The module will simply echo any frame sent to it. If debug messages
> +	  are activated, it prints all the CAN bittiming information in the
> +	  kernel log. Aside from that it does nothing.
> +
> +	  This is convenient for testing the CAN netlink interface. Most of the
> +	  users will never need this. If unsure, say NO.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called dummy-can.
> +
>  config CAN_FLEXCAN
>  	tristate "Support for Freescale FLEXCAN based chips"
>  	depends on OF || COLDFIRE || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	select CAN_RX_OFFLOAD
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 56138d8ddfd2..d7bc10a6b8ea 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -19,10 +19,11 @@ obj-$(CONFIG_CAN_AT91)		+=3D at91_can.o
>  obj-$(CONFIG_CAN_BXCAN)		+=3D bxcan.o
>  obj-$(CONFIG_CAN_CAN327)	+=3D can327.o
>  obj-$(CONFIG_CAN_CC770)		+=3D cc770/
>  obj-$(CONFIG_CAN_C_CAN)		+=3D c_can/
>  obj-$(CONFIG_CAN_CTUCANFD)	+=3D ctucanfd/
> +obj-$(CONFIG_CAN_DUMMY)		+=3D dummy_can.o
>  obj-$(CONFIG_CAN_FLEXCAN)	+=3D flexcan/
>  obj-$(CONFIG_CAN_GRCAN)		+=3D grcan.o
>  obj-$(CONFIG_CAN_IFI_CANFD)	+=3D ifi_canfd/
>  obj-$(CONFIG_CAN_JANZ_ICAN3)	+=3D janz-ican3.o
>  obj-$(CONFIG_CAN_KVASER_PCIEFD)	+=3D kvaser_pciefd/
> diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
> new file mode 100644
> index 000000000000..97af0847db00
> --- /dev/null
> +++ b/drivers/net/can/dummy_can.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Copyright (c) 2025 Vincent Mailhol <mailhol@kernel.org> */
> +
> +#include <linux/array_size.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/units.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/bittiming.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/skb.h>
> +
> +struct dummy_can {
> +	struct can_priv can;
> +	struct net_device *dev;
> +};
> +
> +static struct dummy_can *dummy_can;
> +
> +static const struct can_bittiming_const dummy_can_bittiming_const =3D {
> +	.name =3D "dummy_can CC",
> +	.tseg1_min =3D 2,
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 2,
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 512,
> +	.brp_inc =3D 1
> +};
> +
> +static const struct can_bittiming_const dummy_can_fd_databittiming_const=
 =3D {
> +	.name =3D "dummy_can FD",
> +	.tseg1_min =3D 2,
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 2,
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 512,
> +	.brp_inc =3D 1
> +};
> +
> +static const struct can_tdc_const dummy_can_fd_tdc_const =3D {
> +	.tdcv_min =3D 0,
> +	.tdcv_max =3D 0, /* Manual mode not supported. */
> +	.tdco_min =3D 0,
> +	.tdco_max =3D 127,
> +	.tdcf_min =3D 0,
> +	.tdcf_max =3D 127
> +};
> +
> +static const struct can_bittiming_const dummy_can_xl_databittiming_const=
 =3D {
> +	.name =3D "dummy_can XL",
> +	.tseg1_min =3D 2,
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 2,
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 512,
> +	.brp_inc =3D 1
> +};
> +
> +static const struct can_tdc_const dummy_can_xl_tdc_const =3D {
> +	.tdcv_min =3D 0,
> +	.tdcv_max =3D 0, /* Manual mode not supported. */
> +	.tdco_min =3D 0,
> +	.tdco_max =3D 127,
> +	.tdcf_min =3D 0,
> +	.tdcf_max =3D 127
> +};
> +
> +static const struct can_pwm_const dummy_can_pwm_const =3D {
> +	.pwms_min =3D 1,
> +	.pwms_max =3D 8,
> +	.pwml_min =3D 2,
> +	.pwml_max =3D 24,
> +	.pwmo_min =3D 0,
> +	.pwmo_max =3D 16,
> +};
> +
> +static void dummy_can_print_bittiming(struct net_device *dev,
> +				      struct can_bittiming *bt)
> +{
> +	netdev_dbg(dev, "\tbitrate: %u\n", bt->bitrate);
> +	netdev_dbg(dev, "\tsample_point: %u\n", bt->sample_point);
> +	netdev_dbg(dev, "\ttq: %u\n", bt->tq);
> +	netdev_dbg(dev, "\tprop_seg: %u\n", bt->prop_seg);
> +	netdev_dbg(dev, "\tphase_seg1: %u\n", bt->phase_seg1);
> +	netdev_dbg(dev, "\tphase_seg2: %u\n", bt->phase_seg2);
> +	netdev_dbg(dev, "\tsjw: %u\n", bt->sjw);
> +	netdev_dbg(dev, "\tbrp: %u\n", bt->brp);
> +}
> +
> +static void dummy_can_print_tdc(struct net_device *dev, struct can_tdc *=
tdc)
> +{
> +	netdev_dbg(dev, "\t\ttdcv: %u\n", tdc->tdcv);
> +	netdev_dbg(dev, "\t\ttdco: %u\n", tdc->tdco);
> +	netdev_dbg(dev, "\t\ttdcf: %u\n", tdc->tdcf);
> +}
> +
> +static void dummy_can_print_pwm(struct net_device *dev, struct can_pwm *=
pwm,
> +				struct can_bittiming *dbt)
> +{
> +	netdev_dbg(dev, "\t\tpwms: %u\n", pwm->pwms);
> +	netdev_dbg(dev, "\t\tpwml: %u\n", pwm->pwml);
> +	netdev_dbg(dev, "\t\tpwmo: %u\n", pwm->pwmo);
> +}
> +
> +static void dummy_can_print_ctrlmode(struct net_device *dev)
> +{
> +	struct dummy_can *priv =3D netdev_priv(dev);
> +	struct can_priv *can_priv =3D &priv->can;
> +	unsigned long supported =3D can_priv->ctrlmode_supported;
> +	u32 enabled =3D can_priv->ctrlmode;
> +
> +	netdev_dbg(dev, "Control modes:\n");
> +	netdev_dbg(dev, "\tsupported: 0x%08x\n", (u32)supported);
> +	netdev_dbg(dev, "\tenabled: 0x%08x\n", enabled);
> +
> +	if (supported) {
> +		int idx;
> +
> +		netdev_dbg(dev, "\tlist:");
> +		for_each_set_bit(idx, &supported, BITS_PER_TYPE(u32))
> +			netdev_dbg(dev, "\t\t%s: %s\n",
> +				   can_get_ctrlmode_str(BIT(idx)),
> +				   enabled & BIT(idx) ? "on" : "off");
> +	}
> +}
> +
> +static void dummy_can_print_bittiming_info(struct net_device *dev)
> +{
> +	struct dummy_can *priv =3D netdev_priv(dev);
> +	struct can_priv *can_priv =3D &priv->can;
> +
> +	netdev_dbg(dev, "Clock frequency: %u\n", can_priv->clock.freq);
> +	netdev_dbg(dev, "Maximum bitrate: %u\n", can_priv->bitrate_max);
> +	netdev_dbg(dev, "MTU: %u\n", dev->mtu);
> +	netdev_dbg(dev, "\n");
> +
> +	dummy_can_print_ctrlmode(dev);
> +	netdev_dbg(dev, "\n");
> +
> +	netdev_dbg(dev, "Classical CAN nominal bittiming:\n");
> +	dummy_can_print_bittiming(dev, &can_priv->bittiming);
> +	netdev_dbg(dev, "\n");
> +
> +	if (can_priv->ctrlmode & CAN_CTRLMODE_FD) {
> +		netdev_dbg(dev, "CAN FD databittiming:\n");
> +		dummy_can_print_bittiming(dev, &can_priv->fd.data_bittiming);
> +		if (can_fd_tdc_is_enabled(can_priv)) {
> +			netdev_dbg(dev, "\tCAN FD TDC:\n");
> +			dummy_can_print_tdc(dev, &can_priv->fd.tdc);
> +		}
> +	}
> +	netdev_dbg(dev, "\n");
> +
> +	if (can_priv->ctrlmode & CAN_CTRLMODE_XL) {
> +		netdev_dbg(dev, "CAN XL databittiming:\n");
> +		dummy_can_print_bittiming(dev, &can_priv->xl.data_bittiming);
> +		if (can_xl_tdc_is_enabled(can_priv)) {
> +			netdev_dbg(dev, "\tCAN XL TDC:\n");
> +			dummy_can_print_tdc(dev, &can_priv->xl.tdc);
> +		}
> +		if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TMS) {
> +			netdev_dbg(dev, "\tCAN XL PWM:\n");
> +			dummy_can_print_pwm(dev, &can_priv->xl.pwm,
> +					    &can_priv->xl.data_bittiming);
> +		}
> +	}
> +	netdev_dbg(dev, "\n");
> +}
> +
> +static int dummy_can_netdev_open(struct net_device *dev)
> +{
> +	int ret;
> +	struct can_priv *priv =3D netdev_priv(dev);
> +
> +	dummy_can_print_bittiming_info(dev);
> +	netdev_dbg(dev, "error-signalling is %sabled\n",
> +		   can_dev_in_xl_only_mode(priv)?"dis":"en");

please make use of string_choices.h

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s7felscdhkinm2jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkgLwMACgkQDHRl3/mQ
kZyuiAf6A5olJCeUpcHec1/oOaQKE9L7K8cG/eJZLszqCtLLKFbAsXhkQpqogJ8X
6BNWE8cDqTmGtGxx9WdGBTfEJZXhRu6+L64axrcium+8iMwRj/EccwMr0ffYi9Cs
wakD1561Z+cftl+2DRSzmdzliaLDaKo4bjlyXQRNdpES/doLFgm8uOSyNDkIHp5A
JJ1r4tDMIe12UNQivMDDa/6PqCtlNzmUo3uLnR4bMKojp1obdc4WlMlK+/I3qEG9
cDwSIeXYpI9TUQ73tuiz9Mrglu/PUcKPPLih5dANpX9KuenIAEvs9asxz7mOhpLc
kv/cF6Hmccc3LpRXuXhgL/K8DXlp3g==
=jXFQ
-----END PGP SIGNATURE-----

--s7felscdhkinm2jy--

