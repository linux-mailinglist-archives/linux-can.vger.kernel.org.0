Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC8BB17A19
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfEHNNF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:13:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55631 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfEHNNE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:13:04 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mkl@pengutronix.de>)
        id 1hOMNV-00066X-Cp; Wed, 08 May 2019 15:12:57 +0200
Received: from [192.168.137.87] (nat079013.nat.FH-Koeln.DE [139.6.79.13])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4259D40998E;
        Wed,  8 May 2019 13:12:54 +0000 (UTC)
Subject: Re: [PATCH V7 RESEND 04/10] can: mcp25xxfd: Add Microchip mcp25xxfd
 CAN FD driver
To:     kernel@martin.sperl.org, linux-can@vger.kernel.org,
        devicetree@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20190419051432.13538-1-kernel@martin.sperl.org>
 <20190419051432.13538-5-kernel@martin.sperl.org>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9fe8a9bf-954e-e203-7b81-57b9460046fd@pengutronix.de>
Date:   Wed, 8 May 2019 15:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419051432.13538-5-kernel@martin.sperl.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9AWvklFo50bWruUHCyXyGo0NdmJc7QdPD"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9AWvklFo50bWruUHCyXyGo0NdmJc7QdPD
Content-Type: multipart/mixed; boundary="ds4ILGG6wmir7tnpuOKgh4HNhNjCI4CsP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: kernel@martin.sperl.org, linux-can@vger.kernel.org,
 devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <9fe8a9bf-954e-e203-7b81-57b9460046fd@pengutronix.de>
Subject: Re: [PATCH V7 RESEND 04/10] can: mcp25xxfd: Add Microchip mcp25xxfd
 CAN FD driver
References: <20190419051432.13538-1-kernel@martin.sperl.org>
 <20190419051432.13538-5-kernel@martin.sperl.org>
In-Reply-To: <20190419051432.13538-5-kernel@martin.sperl.org>

--ds4ILGG6wmir7tnpuOKgh4HNhNjCI4CsP
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 4/19/19 7:14 AM, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> Add un-optimized Can2.0 and CanFD support.
>=20
> CAN-Transmission and Optimizations and are separate patches
>=20
> On a Rasperry pi 3 it is already able to process Can2.0 Frames
> with DLC=3D0 on a CAN bus with 1MHz. without losing any packets
> on the SPI side. Packets still get lost inside the network stack.
>=20
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

[..]

> diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c b/drivers/ne=
t/can/spi/mcp25xxfd/mcp25xxfd_can.c
> index f98b02ff057b..eabd7ca50645 100644
> --- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
> +++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can.c
> @@ -38,23 +38,162 @@
>   * for timestamping of RX frames as well as for TEF entries.
>   */
>=20
> -/* Implementation notes:
> - *
> - * Right now we only use the CAN controller block to put us into deep =
sleep
> - * this means that the oscillator clock is turned off.
> - * So this is the only thing that we implement here right now
> - */
> -
> +#include <linux/can/core.h>
> +#include <linux/can/dev.h>
>  #include <linux/device.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>=20
> +#include "mcp25xxfd_base.h"
> +#include "mcp25xxfd_can_debugfs.h"
> +#include "mcp25xxfd_can_fifo.h"
> +#include "mcp25xxfd_can_int.h"
> +#include "mcp25xxfd_can_priv.h"
>  #include "mcp25xxfd_clock.h"
>  #include "mcp25xxfd_cmd.h"
> +#include "mcp25xxfd_int.h"
>  #include "mcp25xxfd_priv.h"
>  #include "mcp25xxfd_regs.h"
>=20
> -static int mcp25xxfd_can_get_mode(struct mcp25xxfd_priv *priv, u32 *re=
g)
> +#include <uapi/linux/can/netlink.h>
> +
> +/* module parameters */
> +unsigned int bw_sharing_log2bits;
> +module_param(bw_sharing_log2bits, uint, 0664);
> +MODULE_PARM_DESC(bw_sharing_log2bits,
> +		 "Delay between 2 transmissions in number of arbitration bit times\n=
");
> +bool enable_edge_filter;
> +module_param(enable_edge_filter, bool, 0664);
> +MODULE_PARM_DESC(enable_edge_filter,
> +		 "Enable ISO11898-1:2015 edge_filtering");
> +unsigned int tdc_mode =3D 2;
> +module_param(tdc_mode, uint, 0664);
> +MODULE_PARM_DESC(tdc_mode,
> +		 "Transmitter Delay Mode - 0 =3D disabled, 1 =3D fixed, 2 =3D auto\n=
");
> +unsigned int tdc_value;
> +module_param(tdc_value, uint, 0664);
> +MODULE_PARM_DESC(tdc_value,
> +		 "Transmission Delay Value - range: [0:63] SCLK");
> +int tdc_offset =3D 64; /* outside of range to use computed values */
> +module_param(tdc_offset, int, 0664);
> +MODULE_PARM_DESC(tdc_offset,
> +		 "Transmission Delay offset - range: [-64:63] SCLK");
> +
> +/* everything related to bit timing */
> +static
> +const struct can_bittiming_const mcp25xxfd_can_nominal_bittiming_const=
 =3D {
> +	.name           =3D DEVICE_NAME,
> +	.tseg1_min      =3D 2,
> +	.tseg1_max      =3D BIT(MCP25XXFD_CAN_NBTCFG_TSEG1_BITS),
> +	.tseg2_min      =3D 1,
> +	.tseg2_max      =3D BIT(MCP25XXFD_CAN_NBTCFG_TSEG2_BITS),
> +	.sjw_max        =3D BIT(MCP25XXFD_CAN_NBTCFG_SJW_BITS),
> +	.brp_min        =3D 1,
> +	.brp_max        =3D BIT(MCP25XXFD_CAN_NBTCFG_BRP_BITS),
> +	.brp_inc        =3D 1,
> +};
> +
> +static
> +const struct can_bittiming_const mcp25xxfd_can_data_bittiming_const =3D=
 {
> +	.name           =3D DEVICE_NAME,
> +	.tseg1_min      =3D 1,
> +	.tseg1_max      =3D BIT(MCP25XXFD_CAN_DBTCFG_TSEG1_BITS),
> +	.tseg2_min      =3D 1,
> +	.tseg2_max      =3D BIT(MCP25XXFD_CAN_DBTCFG_TSEG2_BITS),
> +	.sjw_max        =3D BIT(MCP25XXFD_CAN_DBTCFG_SJW_BITS),
> +	.brp_min        =3D 1,
> +	.brp_max        =3D BIT(MCP25XXFD_CAN_DBTCFG_BRP_BITS),
> +	.brp_inc        =3D 1,
> +};
> +
> +static int mcp25xxfd_can_do_set_nominal_bittiming(struct net_device *n=
et)
> +{
> +	struct mcp25xxfd_can_priv *cpriv =3D netdev_priv(net);
> +	struct can_bittiming *bt =3D &cpriv->can.bittiming;
> +
> +	int sjw =3D bt->sjw;
> +	int pseg2 =3D bt->phase_seg2;
> +	int pseg1 =3D bt->phase_seg1;
> +	int propseg =3D bt->prop_seg;
> +	int brp =3D bt->brp;
> +
> +	int tseg1 =3D propseg + pseg1;
> +	int tseg2 =3D pseg2;
> +
> +	/* calculate nominal bit timing */
> +	cpriv->regs.nbtcfg =3D ((sjw - 1) << MCP25XXFD_CAN_NBTCFG_SJW_SHIFT) =
|
> +		((tseg2 - 1) << MCP25XXFD_CAN_NBTCFG_TSEG2_SHIFT) |
> +		((tseg1 - 1) << MCP25XXFD_CAN_NBTCFG_TSEG1_SHIFT) |
> +		((brp - 1) << MCP25XXFD_CAN_NBTCFG_BRP_SHIFT);
> +
> +	return mcp25xxfd_cmd_write(cpriv->priv->spi, MCP25XXFD_CAN_NBTCFG,
> +				   cpriv->regs.nbtcfg);
> +}
> +
> +static int mcp25xxfd_can_do_set_data_bittiming(struct net_device *net)=

> +{
> +	struct mcp25xxfd_can_priv *cpriv =3D netdev_priv(net);
> +	struct mcp25xxfd_priv *priv =3D cpriv->priv;
> +	struct can_bittiming *bt =3D &cpriv->can.data_bittiming;
> +	struct spi_device *spi =3D priv->spi;
> +
> +	int sjw =3D bt->sjw;
> +	int pseg2 =3D bt->phase_seg2;
> +	int pseg1 =3D bt->phase_seg1;
> +	int propseg =3D bt->prop_seg;
> +	int brp =3D bt->brp;
> +
> +	int tseg1 =3D propseg + pseg1;
> +	int tseg2 =3D pseg2;
> +
> +	int tdco;
> +	int ret;
> +
> +	/* set up Transmitter delay compensation */
> +	cpriv->regs.tdc =3D 0;
> +	/* configure TDC mode */
> +	if (tdc_mode < 4)
> +		cpriv->regs.tdc =3D tdc_mode << MCP25XXFD_CAN_TDC_TDCMOD_SHIFT;
> +	else
> +		cpriv->regs.tdc =3D MCP25XXFD_CAN_TDC_TDCMOD_AUTO <<
> +			MCP25XXFD_CAN_TDC_TDCMOD_SHIFT;
> +
> +	/* configure TDC offsets */
> +	if ((tdc_offset >=3D -64) && tdc_offset < 64)
> +		tdco =3D tdc_offset;
> +	else
> +		tdco =3D clamp_t(int, bt->brp * tseg1, -64, 63);
> +	cpriv->regs.tdc |=3D (tdco << MCP25XXFD_CAN_TDC_TDCO_SHIFT) &
> +		MCP25XXFD_CAN_TDC_TDCO_MASK;
> +
> +	/* configure TDC value */
> +	if (tdc_value < 64)
> +		cpriv->regs.tdc |=3D tdc_value << MCP25XXFD_CAN_TDC_TDCV_SHIFT;
> +
> +	/* enable edge filtering */
> +	if (enable_edge_filter)
> +		cpriv->regs.tdc |=3D MCP25XXFD_CAN_TDC_EDGFLTEN;
> +
> +	/* set TDC */
> +	ret =3D mcp25xxfd_cmd_write(spi, MCP25XXFD_CAN_TDC, cpriv->regs.tdc);=

> +	if (ret)
> +		return ret;
> +
> +	/* calculate data bit timing */
> +	cpriv->regs.dbtcfg =3D ((sjw - 1) << MCP25XXFD_CAN_DBTCFG_SJW_SHIFT) =
|
> +		((tseg2 - 1) << MCP25XXFD_CAN_DBTCFG_TSEG2_SHIFT) |
> +		((tseg1 - 1) << MCP25XXFD_CAN_DBTCFG_TSEG1_SHIFT) |
> +		((brp - 1) << MCP25XXFD_CAN_DBTCFG_BRP_SHIFT);
> +
> +	return mcp25xxfd_cmd_write(spi, MCP25XXFD_CAN_DBTCFG,
> +				   cpriv->regs.dbtcfg);
> +}
> +
> +int mcp25xxfd_can_get_mode(struct mcp25xxfd_priv *priv, u32 *reg)
>  {
>  	int ret;
>=20
> @@ -66,11 +205,11 @@ static int mcp25xxfd_can_get_mode(struct mcp25xxfd=
_priv *priv, u32 *reg)
>  		MCP25XXFD_CAN_CON_OPMOD_SHIFT;
>  }
>=20
> -static int mcp25xxfd_can_switch_mode(struct mcp25xxfd_priv *priv,
> -				     u32 *reg, int mode)
> +int mcp25xxfd_can_switch_mode_no_wait(struct mcp25xxfd_priv *priv,
> +				      u32 *reg, int mode)
>  {
>  	u32 dummy;
> -	int ret, i;
> +	int ret;
>=20
>  	/* get the current mode/register - if reg is NULL
>  	 * when the can controller is not setup yet
> @@ -78,9 +217,11 @@ static int mcp25xxfd_can_switch_mode(struct mcp25xx=
fd_priv *priv,
>  	 * (this only happens during initialization phase)
>  	 */
>  	if (reg) {
> -		ret =3D mcp25xxfd_can_get_mode(priv, reg);
> -		if (ret < 0)
> -			return ret;
> +		if (!reg) {
> +			ret =3D mcp25xxfd_can_get_mode(priv, reg);
> +			if (ret < 0)
> +				return ret;
> +		}

After this patch the function reads:

> static int mcp25xxfd_can_switch_mode_no_wait(struct mcp25xxfd_priv *pri=
v,
> 					     u32 *reg, int mode)
> {
> 	u32 dummy;
> 	int ret;
>=20
> 	/* get the current mode/register - if reg is NULL
> 	 * when the can controller is not setup yet
> 	 * typically by calling mcp25xxfd_can_sleep_mode
> 	 * (this only happens during initialization phase)
> 	 */
> 	if (reg) {
> 		if (!reg) {

This looks wrong.

> 			ret =3D mcp25xxfd_can_get_mode(priv, reg);
> 			if (ret < 0)
> 				return ret;
> 		}
> 	} else {
> 		/* alternatively use dummy */
> 		dummy =3D 0;
> 		reg =3D &dummy;
> 	}
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ds4ILGG6wmir7tnpuOKgh4HNhNjCI4CsP--

--9AWvklFo50bWruUHCyXyGo0NdmJc7QdPD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlzS1dEACgkQWsYho5Hk
nSCDyAgAsuFM0m3Y5vshjetwsmxPMq7F3ALb1CuXSblkItda+S3XF8veJiWUW8ZH
P0NhJ71AkD53LG7Wg/VOFdRTYqfQIXpapQrP724qzyrriyn+CzxBtrdgTcM+D/2o
nMQCT9wWiYr5p2Sja+a6ZY9Fa/c+9aNvjV76O2Oz8/X/FVuhSODaWoEFOHS4G+fw
r12D/xVmAoTDHzS9FVUY7GDSupFm0KED8TySCdGc/IduDFW/aS9UIGTaexWyWOAv
YsAgE/NFQL1YmE4sxtrCdbdBObSSTm+k7x9gjrborTW7UUtwN4VHOsx284WyprrW
RKn9pPFV5ZpWRW5d+RZzKDp0jdpS5A==
=dRB+
-----END PGP SIGNATURE-----

--9AWvklFo50bWruUHCyXyGo0NdmJc7QdPD--
