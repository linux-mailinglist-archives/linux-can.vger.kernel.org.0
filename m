Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB16E5EB
	for <lists+linux-can@lfdr.de>; Fri, 19 Jul 2019 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGSMwr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Jul 2019 08:52:47 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSMwr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Jul 2019 08:52:47 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1hoSNP-0000eA-RZ; Fri, 19 Jul 2019 14:52:44 +0200
Received: from [IPv6:2a03:f580:87bc:d400:c9d4:83d5:b99:4f4d] (unknown [IPv6:2a03:f580:87bc:d400:c9d4:83d5:b99:4f4d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id B1A4043482E;
        Fri, 19 Jul 2019 12:52:41 +0000 (UTC)
Subject: Re: [PATCH resend] can/ifi_canfd: Added API for IFI-CANFD
 functionalities
To:     marcel.schmidt@schulz-soluware.com, linux-can@vger.kernel.org,
        wg@grandegger.com, Marek Vasut <marex@denx.de>
References: <20190712095150.29446-1-marcel.schmidt@schulz-soluware.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Openpgp: preference=signencrypt
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e9a85767-c9a2-06a9-c355-e43d0e507c10@pengutronix.de>
Date:   Fri, 19 Jul 2019 14:52:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190712095150.29446-1-marcel.schmidt@schulz-soluware.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vAUsD05QAELZL2lieEDsZTxW3504VZMsC"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vAUsD05QAELZL2lieEDsZTxW3504VZMsC
Content-Type: multipart/mixed; boundary="pMZ1Qx9EtPYwstqbcyEMQVPv3gKgljDz1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: marcel.schmidt@schulz-soluware.com, linux-can@vger.kernel.org,
 wg@grandegger.com, Marek Vasut <marex@denx.de>
Message-ID: <e9a85767-c9a2-06a9-c355-e43d0e507c10@pengutronix.de>
Subject: Re: [PATCH resend] can/ifi_canfd: Added API for IFI-CANFD
 functionalities
References: <20190712095150.29446-1-marcel.schmidt@schulz-soluware.com>
In-Reply-To: <20190712095150.29446-1-marcel.schmidt@schulz-soluware.com>

--pMZ1Qx9EtPYwstqbcyEMQVPv3gKgljDz1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Marek,

can I have you Acked-by for this?

Marc

On 7/12/19 11:51 AM, marcel.schmidt@schulz-soluware.com wrote:
> From: Marcel Schmidt <marcel.schmidt@schulz-soluware.com>
>=20
> Updates the ifi_canfd platform driver and adds an universal
> interface that enables the usage of its functionalities outside of
> this platform driver.
>=20
> It was implemented with respect to role models like SJA1000 or C_Can.
> Therefore the driver is split into three files.
> ifi_canfd_platform.c contains the platform specific implementations
> and remains functional the same. ifi_canfd.c+h enables common IFI-CANFD=

> functionalities usable for other drivers.
>=20
> Signed-off-by: Marcel Schmidt <marcel.schmidt@schulz-soluware.com>
> ---
>  drivers/net/can/ifi_canfd/Kconfig             |  10 +-
>  drivers/net/can/ifi_canfd/Makefile            |   3 +-
>  drivers/net/can/ifi_canfd/ifi_canfd.c         | 554 ++++++------------=

>  drivers/net/can/ifi_canfd/ifi_canfd.h         | 341 +++++++++++
>  .../net/can/ifi_canfd/ifi_canfd_platform.c    | 121 ++++
>  5 files changed, 639 insertions(+), 390 deletions(-)
>  create mode 100644 drivers/net/can/ifi_canfd/ifi_canfd.h
>  create mode 100644 drivers/net/can/ifi_canfd/ifi_canfd_platform.c
>=20
> diff --git a/drivers/net/can/ifi_canfd/Kconfig b/drivers/net/can/ifi_ca=
nfd/Kconfig
> index ce0197641a59..22f5d8322a2e 100644
> --- a/drivers/net/can/ifi_canfd/Kconfig
> +++ b/drivers/net/can/ifi_canfd/Kconfig
> @@ -1,9 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -config CAN_IFI_CANFD
> +menuconfig CAN_IFI_CANFD
> +	tristate "IFI_CAN_FD devices"
>  	depends on HAS_IOMEM
> -	tristate "IFI CAN_FD IP"
> +
> +if CAN_IFI_CANFD
> +
> +config CAN_IFI_CANFD_PLATFORM
> +	tristate "Generic Platform Bus based IFI CAN_FD driver"
>  	---help---
>  	  This driver adds support for the I/F/I CAN_FD soft IP block
>  	  connected to the "platform bus" (Linux abstraction for directly
>  	  to the processor attached devices). The CAN_FD is most often
>  	  synthesised into an FPGA or CPLD.
> +endif
> diff --git a/drivers/net/can/ifi_canfd/Makefile b/drivers/net/can/ifi_c=
anfd/Makefile
> index 0cd724f10d1e..8d58c38975a5 100644
> --- a/drivers/net/can/ifi_canfd/Makefile
> +++ b/drivers/net/can/ifi_canfd/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
> -#  Makefile for the IFI CANFD controller driver.
> +#  Makefile for the IFI CANFD controller drivers.
>  #
> =20
>  obj-$(CONFIG_CAN_IFI_CANFD) +=3D ifi_canfd.o
> +obj-$(CONFIG_CAN_IFI_CANFD_PLATFORM) +=3D ifi_canfd_platform.o
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/if=
i_canfd/ifi_canfd.c
> index fedd927ba6ed..706e0c267c1e 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -23,207 +23,36 @@
>  #include <linux/platform_device.h>
> =20
>  #include <linux/can/dev.h>
> +#include "ifi_canfd.h"
> =20
> -#define IFI_CANFD_STCMD				0x0
> -#define IFI_CANFD_STCMD_HARDRESET		0xDEADCAFD
> -#define IFI_CANFD_STCMD_ENABLE			BIT(0)
> -#define IFI_CANFD_STCMD_ERROR_ACTIVE		BIT(2)
> -#define IFI_CANFD_STCMD_ERROR_PASSIVE		BIT(3)
> -#define IFI_CANFD_STCMD_BUSOFF			BIT(4)
> -#define IFI_CANFD_STCMD_ERROR_WARNING		BIT(5)
> -#define IFI_CANFD_STCMD_BUSMONITOR		BIT(16)
> -#define IFI_CANFD_STCMD_LOOPBACK		BIT(18)
> -#define IFI_CANFD_STCMD_DISABLE_CANFD		BIT(24)
> -#define IFI_CANFD_STCMD_ENABLE_ISO		BIT(25)
> -#define IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING	BIT(26)
> -#define IFI_CANFD_STCMD_NORMAL_MODE		((u32)BIT(31))
> -
> -#define IFI_CANFD_RXSTCMD			0x4
> -#define IFI_CANFD_RXSTCMD_REMOVE_MSG		BIT(0)
> -#define IFI_CANFD_RXSTCMD_RESET			BIT(7)
> -#define IFI_CANFD_RXSTCMD_EMPTY			BIT(8)
> -#define IFI_CANFD_RXSTCMD_OVERFLOW		BIT(13)
> -
> -#define IFI_CANFD_TXSTCMD			0x8
> -#define IFI_CANFD_TXSTCMD_ADD_MSG		BIT(0)
> -#define IFI_CANFD_TXSTCMD_HIGH_PRIO		BIT(1)
> -#define IFI_CANFD_TXSTCMD_RESET			BIT(7)
> -#define IFI_CANFD_TXSTCMD_EMPTY			BIT(8)
> -#define IFI_CANFD_TXSTCMD_FULL			BIT(12)
> -#define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
> -
> -#define IFI_CANFD_INTERRUPT			0xc
> -#define IFI_CANFD_INTERRUPT_ERROR_BUSOFF	BIT(0)
> -#define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
> -#define IFI_CANFD_INTERRUPT_ERROR_STATE_CHG	BIT(2)
> -#define IFI_CANFD_INTERRUPT_ERROR_REC_TEC_INC	BIT(3)
> -#define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
> -#define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
> -#define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
> -#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY	BIT(24)
> -#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER	BIT(25)
> -#define IFI_CANFD_INTERRUPT_SET_IRQ		((u32)BIT(31))
> -
> -#define IFI_CANFD_IRQMASK			0x10
> -#define IFI_CANFD_IRQMASK_ERROR_BUSOFF		BIT(0)
> -#define IFI_CANFD_IRQMASK_ERROR_WARNING		BIT(1)
> -#define IFI_CANFD_IRQMASK_ERROR_STATE_CHG	BIT(2)
> -#define IFI_CANFD_IRQMASK_ERROR_REC_TEC_INC	BIT(3)
> -#define IFI_CANFD_IRQMASK_SET_ERR		BIT(7)
> -#define IFI_CANFD_IRQMASK_SET_TS		BIT(15)
> -#define IFI_CANFD_IRQMASK_TXFIFO_EMPTY		BIT(16)
> -#define IFI_CANFD_IRQMASK_SET_TX		BIT(23)
> -#define IFI_CANFD_IRQMASK_RXFIFO_NEMPTY		BIT(24)
> -#define IFI_CANFD_IRQMASK_SET_RX		((u32)BIT(31))
> -
> -#define IFI_CANFD_TIME				0x14
> -#define IFI_CANFD_FTIME				0x18
> -#define IFI_CANFD_TIME_TIMEB_OFF		0
> -#define IFI_CANFD_TIME_TIMEA_OFF		8
> -#define IFI_CANFD_TIME_PRESCALE_OFF		16
> -#define IFI_CANFD_TIME_SJW_OFF_7_9_8_8		25
> -#define IFI_CANFD_TIME_SJW_OFF_4_12_6_6		28
> -#define IFI_CANFD_TIME_SET_SJW_4_12_6_6		BIT(6)
> -#define IFI_CANFD_TIME_SET_TIMEB_4_12_6_6	BIT(7)
> -#define IFI_CANFD_TIME_SET_PRESC_4_12_6_6	BIT(14)
> -#define IFI_CANFD_TIME_SET_TIMEA_4_12_6_6	BIT(15)
> -
> -#define IFI_CANFD_TDELAY			0x1c
> -#define IFI_CANFD_TDELAY_DEFAULT		0xb
> -#define IFI_CANFD_TDELAY_MASK			0x3fff
> -#define IFI_CANFD_TDELAY_ABS			BIT(14)
> -#define IFI_CANFD_TDELAY_EN			BIT(15)
> -
> -#define IFI_CANFD_ERROR				0x20
> -#define IFI_CANFD_ERROR_TX_OFFSET		0
> -#define IFI_CANFD_ERROR_TX_MASK			0xff
> -#define IFI_CANFD_ERROR_RX_OFFSET		16
> -#define IFI_CANFD_ERROR_RX_MASK			0xff
> -
> -#define IFI_CANFD_ERRCNT			0x24
> -
> -#define IFI_CANFD_SUSPEND			0x28
> -
> -#define IFI_CANFD_REPEAT			0x2c
> -
> -#define IFI_CANFD_TRAFFIC			0x30
> -
> -#define IFI_CANFD_TSCONTROL			0x34
> -
> -#define IFI_CANFD_TSC				0x38
> -
> -#define IFI_CANFD_TST				0x3c
> -
> -#define IFI_CANFD_RES1				0x40
> -
> -#define IFI_CANFD_ERROR_CTR			0x44
> -#define IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC	0x21302899
> -#define IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST	BIT(0)
> -#define IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST	BIT(1)
> -#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST	BIT(2)
> -#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST	BIT(3)
> -#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST	BIT(4)
> -#define IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST	BIT(5)
> -#define IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST	BIT(6)
> -#define IFI_CANFD_ERROR_CTR_OVERLOAD_ALL	BIT(8)
> -#define IFI_CANFD_ERROR_CTR_ACK_ERROR_ALL	BIT(9)
> -#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_ALL	BIT(10)
> -#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_ALL	BIT(11)
> -#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_ALL	BIT(12)
> -#define IFI_CANFD_ERROR_CTR_CRC_ERROR_ALL	BIT(13)
> -#define IFI_CANFD_ERROR_CTR_FORM_ERROR_ALL	BIT(14)
> -#define IFI_CANFD_ERROR_CTR_BITPOSITION_OFFSET	16
> -#define IFI_CANFD_ERROR_CTR_BITPOSITION_MASK	0xff
> -#define IFI_CANFD_ERROR_CTR_ER_RESET		BIT(30)
> -#define IFI_CANFD_ERROR_CTR_ER_ENABLE		((u32)BIT(31))
> -
> -#define IFI_CANFD_PAR				0x48
> -
> -#define IFI_CANFD_CANCLOCK			0x4c
> -
> -#define IFI_CANFD_SYSCLOCK			0x50
> -
> -#define IFI_CANFD_VER				0x54
> -#define IFI_CANFD_VER_REV_MASK			0xff
> -#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
> -
> -#define IFI_CANFD_IP_ID				0x58
> -#define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
> -
> -#define IFI_CANFD_TEST				0x5c
> -
> -#define IFI_CANFD_RXFIFO_TS_63_32		0x60
> -
> -#define IFI_CANFD_RXFIFO_TS_31_0		0x64
> -
> -#define IFI_CANFD_RXFIFO_DLC			0x68
> -#define IFI_CANFD_RXFIFO_DLC_DLC_OFFSET		0
> -#define IFI_CANFD_RXFIFO_DLC_DLC_MASK		0xf
> -#define IFI_CANFD_RXFIFO_DLC_RTR		BIT(4)
> -#define IFI_CANFD_RXFIFO_DLC_EDL		BIT(5)
> -#define IFI_CANFD_RXFIFO_DLC_BRS		BIT(6)
> -#define IFI_CANFD_RXFIFO_DLC_ESI		BIT(7)
> -#define IFI_CANFD_RXFIFO_DLC_OBJ_OFFSET		8
> -#define IFI_CANFD_RXFIFO_DLC_OBJ_MASK		0x1ff
> -#define IFI_CANFD_RXFIFO_DLC_FNR_OFFSET		24
> -#define IFI_CANFD_RXFIFO_DLC_FNR_MASK		0xff
> -
> -#define IFI_CANFD_RXFIFO_ID			0x6c
> -#define IFI_CANFD_RXFIFO_ID_ID_OFFSET		0
> -#define IFI_CANFD_RXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
> -#define IFI_CANFD_RXFIFO_ID_ID_STD_OFFSET	0
> -#define IFI_CANFD_RXFIFO_ID_ID_STD_WIDTH	10
> -#define IFI_CANFD_RXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
> -#define IFI_CANFD_RXFIFO_ID_ID_XTD_OFFSET	11
> -#define IFI_CANFD_RXFIFO_ID_ID_XTD_WIDTH	18
> -#define IFI_CANFD_RXFIFO_ID_IDE			BIT(29)
> -
> -#define IFI_CANFD_RXFIFO_DATA			0x70	/* 0x70..0xac */
> -
> -#define IFI_CANFD_TXFIFO_SUSPEND_US		0xb0
> -
> -#define IFI_CANFD_TXFIFO_REPEATCOUNT		0xb4
> -
> -#define IFI_CANFD_TXFIFO_DLC			0xb8
> -#define IFI_CANFD_TXFIFO_DLC_DLC_OFFSET		0
> -#define IFI_CANFD_TXFIFO_DLC_DLC_MASK		0xf
> -#define IFI_CANFD_TXFIFO_DLC_RTR		BIT(4)
> -#define IFI_CANFD_TXFIFO_DLC_EDL		BIT(5)
> -#define IFI_CANFD_TXFIFO_DLC_BRS		BIT(6)
> -#define IFI_CANFD_TXFIFO_DLC_FNR_OFFSET		24
> -#define IFI_CANFD_TXFIFO_DLC_FNR_MASK		0xff
> -
> -#define IFI_CANFD_TXFIFO_ID			0xbc
> -#define IFI_CANFD_TXFIFO_ID_ID_OFFSET		0
> -#define IFI_CANFD_TXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
> -#define IFI_CANFD_TXFIFO_ID_ID_STD_OFFSET	0
> -#define IFI_CANFD_TXFIFO_ID_ID_STD_WIDTH	10
> -#define IFI_CANFD_TXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
> -#define IFI_CANFD_TXFIFO_ID_ID_XTD_OFFSET	11
> -#define IFI_CANFD_TXFIFO_ID_ID_XTD_WIDTH	18
> -#define IFI_CANFD_TXFIFO_ID_IDE			BIT(29)
> -
> -#define IFI_CANFD_TXFIFO_DATA			0xc0	/* 0xb0..0xfc */
> -
> -#define IFI_CANFD_FILTER_MASK(n)		(0x800 + ((n) * 8) + 0)
> -#define IFI_CANFD_FILTER_MASK_EXT		BIT(29)
> -#define IFI_CANFD_FILTER_MASK_EDL		BIT(30)
> -#define IFI_CANFD_FILTER_MASK_VALID		((u32)BIT(31))
> -
> -#define IFI_CANFD_FILTER_IDENT(n)		(0x800 + ((n) * 8) + 4)
> -#define IFI_CANFD_FILTER_IDENT_IDE		BIT(29)
> -#define IFI_CANFD_FILTER_IDENT_CANFD		BIT(30)
> -#define IFI_CANFD_FILTER_IDENT_VALID		((u32)BIT(31))
> -
> -/* IFI CANFD private data structure */
> -struct ifi_canfd_priv {
> -	struct can_priv		can;	/* must be the first member */
> -	struct napi_struct	napi;
> -	struct net_device	*ndev;
> -	void __iomem		*base;
> +static const struct can_bittiming_const ifi_canfd_bittiming_const =3D =
{
> +	.name		=3D KBUILD_MODNAME,
> +	.tseg1_min	=3D 1,	/* Time segment 1 =3D prop_seg + phase_seg1 */
> +	.tseg1_max	=3D 256,
> +	.tseg2_min	=3D 2,	/* Time segment 2 =3D phase_seg2 */
> +	.tseg2_max	=3D 256,
> +	.sjw_max	=3D 128,
> +	.brp_min	=3D 2,
> +	.brp_max	=3D 512,
> +	.brp_inc	=3D 1,
>  };
> =20
> -static void ifi_canfd_irq_enable(struct net_device *ndev, bool enable)=

> +static void ifi_canfd_irq_clear(struct net_device *ndev)
> +{
> +	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 ifi_reg_status =3D readl(priv->base + IFI_CANFD_INTERRUPT);
> +
> +	/* Clear pending IFI CAN controller interrupts */
> +	writel(ifi_reg_status, priv->base + IFI_CANFD_INTERRUPT);
> +
> +	/* Unlock, reset and enable the error counter. */
> +	writel(IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC,
> +	       priv->base + IFI_CANFD_ERROR_CTR);
> +	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR=
);
> +	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CT=
R);
> +}
> +
> +void ifi_canfd_irq_enable(struct net_device *ndev, bool enable, u8 cle=
ar)
>  {
>  	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
>  	u32 enirq =3D 0;
> @@ -243,8 +72,87 @@ static void ifi_canfd_irq_enable(struct net_device =
*ndev, bool enable)
>  	       IFI_CANFD_IRQMASK_SET_TX |
>  	       IFI_CANFD_IRQMASK_SET_RX | enirq,
>  	       priv->base + IFI_CANFD_IRQMASK);
> +
> +	if (clear)
> +		ifi_canfd_irq_clear(ndev);
> +}
> +EXPORT_SYMBOL_GPL(ifi_canfd_irq_enable);
> +
> +static void ifi_canfd_set_bittiming(struct net_device *ndev)
> +{
> +	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> +	const struct can_bittiming *bt =3D &priv->can.bittiming;
> +	const struct can_bittiming *dbt =3D &priv->can.data_bittiming;
> +	u16 brp, sjw, tseg1, tseg2, tdc;
> +
> +	/* Configure bit timing */
> +	brp =3D bt->brp - 2;
> +	sjw =3D bt->sjw - 1;
> +	tseg1 =3D bt->prop_seg + bt->phase_seg1 - 1;
> +	tseg2 =3D bt->phase_seg2 - 2;
> +	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
> +	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
> +	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
> +	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
> +	       priv->base + IFI_CANFD_TIME);
> +
> +	/* Configure data bit timing */
> +	brp =3D dbt->brp - 2;
> +	sjw =3D dbt->sjw - 1;
> +	tseg1 =3D dbt->prop_seg + dbt->phase_seg1 - 1;
> +	tseg2 =3D dbt->phase_seg2 - 2;
> +	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
> +	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
> +	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
> +	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
> +	       priv->base + IFI_CANFD_FTIME);
> +
> +	/* Configure transmitter delay */
> +	tdc =3D dbt->brp * (dbt->prop_seg + dbt->phase_seg1);
> +	tdc &=3D IFI_CANFD_TDELAY_MASK;
> +	writel(IFI_CANFD_TDELAY_EN | tdc, priv->base + IFI_CANFD_TDELAY);
>  }
> =20
> +static void ifi_canfd_set_filter(struct net_device *ndev, const u32 id=
,
> +				 bool enable, u32 mask, u32 ident)
> +{
> +	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	if (!enable) {
> +		mask =3D 0;
> +		ident =3D 0;
> +	}
> +
> +	writel(mask, priv->base + IFI_CANFD_FILTER_MASK(id));
> +	writel(ident, priv->base + IFI_CANFD_FILTER_IDENT(id));
> +}
> +
> +void ifi_canfd_set_filters(struct net_device *ndev, bool enable)
> +{
> +	/* Receive all CAN frames (standard ID) */
> +	ifi_canfd_set_filter(ndev, 0, enable,
> +			     IFI_CANFD_FILTER_MASK_VALID |
> +			     IFI_CANFD_FILTER_MASK_EXT,
> +			     IFI_CANFD_FILTER_IDENT_VALID);
> +
> +	/* Receive all CAN frames (extended ID) */
> +	ifi_canfd_set_filter(ndev, 1, enable,
> +			     IFI_CANFD_FILTER_MASK_VALID |
> +			     IFI_CANFD_FILTER_MASK_EXT,
> +			     IFI_CANFD_FILTER_IDENT_VALID |
> +			     IFI_CANFD_FILTER_IDENT_IDE);
> +
> +	/* Receive all CANFD frames */
> +	ifi_canfd_set_filter(ndev, 2, enable,
> +			     IFI_CANFD_FILTER_MASK_VALID |
> +			     IFI_CANFD_FILTER_MASK_EDL |
> +			     IFI_CANFD_FILTER_MASK_EXT,
> +			     IFI_CANFD_FILTER_IDENT_VALID |
> +			     IFI_CANFD_FILTER_IDENT_CANFD |
> +			     IFI_CANFD_FILTER_IDENT_IDE);
> +}
> +EXPORT_SYMBOL_GPL(ifi_canfd_set_filters);
> +
>  static void ifi_canfd_read_fifo(struct net_device *ndev)
>  {
>  	struct net_device_stats *stats =3D &ndev->stats;
> @@ -480,7 +388,7 @@ static int ifi_canfd_handle_state_change(struct net=
_device *ndev,
>  	case CAN_STATE_BUS_OFF:
>  		/* bus-off state */
>  		priv->can.state =3D CAN_STATE_BUS_OFF;
> -		ifi_canfd_irq_enable(ndev, 0);
> +		ifi_canfd_irq_enable(ndev, 0, 0);
>  		priv->can.can_stats.bus_off++;
>  		can_bus_off(ndev);
>  		break;
> @@ -566,7 +474,7 @@ static int ifi_canfd_handle_state_errors(struct net=
_device *ndev)
>  	return work_done;
>  }
> =20
> -static int ifi_canfd_poll(struct napi_struct *napi, int quota)
> +int ifi_canfd_poll(struct napi_struct *napi, int quota)
>  {
>  	struct net_device *ndev =3D napi->dev;
>  	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> @@ -590,13 +498,14 @@ static int ifi_canfd_poll(struct napi_struct *nap=
i, int quota)
> =20
>  	if (work_done < quota) {
>  		napi_complete_done(napi, work_done);
> -		ifi_canfd_irq_enable(ndev, 1);
> +		ifi_canfd_irq_enable(ndev, 1, 0);
>  	}
> =20
>  	return work_done;
>  }
> +EXPORT_SYMBOL_GPL(ifi_canfd_poll);
> =20
> -static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
> +irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
>  {
>  	struct net_device *ndev =3D (struct net_device *)dev_id;
>  	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> @@ -612,6 +521,9 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev=
_id)
>  	const u32 clr_irq_mask =3D ~((u32)IFI_CANFD_INTERRUPT_SET_IRQ);
>  	u32 isr;
> =20
> +	if (priv->pre_irq)
> +		priv->pre_irq(priv);
> +
>  	isr =3D readl(priv->base + IFI_CANFD_INTERRUPT);
> =20
>  	/* No interrupt */
> @@ -623,7 +535,7 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev=
_id)
> =20
>  	/* RX IRQ or bus warning, start NAPI */
>  	if (isr & rx_irq_mask) {
> -		ifi_canfd_irq_enable(ndev, 0);
> +		ifi_canfd_irq_enable(ndev, 0, 0);
>  		napi_schedule(&priv->napi);
>  	}
> =20
> @@ -637,88 +549,10 @@ static irqreturn_t ifi_canfd_isr(int irq, void *d=
ev_id)
>  	if (isr & tx_irq_mask)
>  		netif_wake_queue(ndev);
> =20
> -	return IRQ_HANDLED;
> -}
> -
> -static const struct can_bittiming_const ifi_canfd_bittiming_const =3D =
{
> -	.name		=3D KBUILD_MODNAME,
> -	.tseg1_min	=3D 1,	/* Time segment 1 =3D prop_seg + phase_seg1 */
> -	.tseg1_max	=3D 256,
> -	.tseg2_min	=3D 2,	/* Time segment 2 =3D phase_seg2 */
> -	.tseg2_max	=3D 256,
> -	.sjw_max	=3D 128,
> -	.brp_min	=3D 2,
> -	.brp_max	=3D 512,
> -	.brp_inc	=3D 1,
> -};
> -
> -static void ifi_canfd_set_bittiming(struct net_device *ndev)
> -{
> -	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> -	const struct can_bittiming *bt =3D &priv->can.bittiming;
> -	const struct can_bittiming *dbt =3D &priv->can.data_bittiming;
> -	u16 brp, sjw, tseg1, tseg2, tdc;
> +	if (priv->post_irq)
> +		priv->post_irq(priv);
> =20
> -	/* Configure bit timing */
> -	brp =3D bt->brp - 2;
> -	sjw =3D bt->sjw - 1;
> -	tseg1 =3D bt->prop_seg + bt->phase_seg1 - 1;
> -	tseg2 =3D bt->phase_seg2 - 2;
> -	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
> -	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
> -	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
> -	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
> -	       priv->base + IFI_CANFD_TIME);
> -
> -	/* Configure data bit timing */
> -	brp =3D dbt->brp - 2;
> -	sjw =3D dbt->sjw - 1;
> -	tseg1 =3D dbt->prop_seg + dbt->phase_seg1 - 1;
> -	tseg2 =3D dbt->phase_seg2 - 2;
> -	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
> -	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
> -	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
> -	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
> -	       priv->base + IFI_CANFD_FTIME);
> -
> -	/* Configure transmitter delay */
> -	tdc =3D dbt->brp * (dbt->prop_seg + dbt->phase_seg1);
> -	tdc &=3D IFI_CANFD_TDELAY_MASK;
> -	writel(IFI_CANFD_TDELAY_EN | tdc, priv->base + IFI_CANFD_TDELAY);
> -}
> -
> -static void ifi_canfd_set_filter(struct net_device *ndev, const u32 id=
,
> -				 const u32 mask, const u32 ident)
> -{
> -	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> -
> -	writel(mask, priv->base + IFI_CANFD_FILTER_MASK(id));
> -	writel(ident, priv->base + IFI_CANFD_FILTER_IDENT(id));
> -}
> -
> -static void ifi_canfd_set_filters(struct net_device *ndev)
> -{
> -	/* Receive all CAN frames (standard ID) */
> -	ifi_canfd_set_filter(ndev, 0,
> -			     IFI_CANFD_FILTER_MASK_VALID |
> -			     IFI_CANFD_FILTER_MASK_EXT,
> -			     IFI_CANFD_FILTER_IDENT_VALID);
> -
> -	/* Receive all CAN frames (extended ID) */
> -	ifi_canfd_set_filter(ndev, 1,
> -			     IFI_CANFD_FILTER_MASK_VALID |
> -			     IFI_CANFD_FILTER_MASK_EXT,
> -			     IFI_CANFD_FILTER_IDENT_VALID |
> -			     IFI_CANFD_FILTER_IDENT_IDE);
> -
> -	/* Receive all CANFD frames */
> -	ifi_canfd_set_filter(ndev, 2,
> -			     IFI_CANFD_FILTER_MASK_VALID |
> -			     IFI_CANFD_FILTER_MASK_EDL |
> -			     IFI_CANFD_FILTER_MASK_EXT,
> -			     IFI_CANFD_FILTER_IDENT_VALID |
> -			     IFI_CANFD_FILTER_IDENT_CANFD |
> -			     IFI_CANFD_FILTER_IDENT_IDE);
> +	return IRQ_HANDLED;
>  }
> =20
>  static void ifi_canfd_start(struct net_device *ndev)
> @@ -732,7 +566,7 @@ static void ifi_canfd_start(struct net_device *ndev=
)
>  	       priv->base + IFI_CANFD_STCMD);
> =20
>  	ifi_canfd_set_bittiming(ndev);
> -	ifi_canfd_set_filters(ndev);
> +	ifi_canfd_set_filters(ndev, 1);
> =20
>  	/* Reset FIFOs */
>  	writel(IFI_CANFD_RXSTCMD_RESET, priv->base + IFI_CANFD_RXSTCMD);
> @@ -766,13 +600,7 @@ static void ifi_canfd_start(struct net_device *nde=
v)
> =20
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> =20
> -	ifi_canfd_irq_enable(ndev, 1);
> -
> -	/* Unlock, reset and enable the error counter. */
> -	writel(IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC,
> -	       priv->base + IFI_CANFD_ERROR_CTR);
> -	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR=
);
> -	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CT=
R);
> +	ifi_canfd_irq_enable(ndev, 1, 1);
> =20
>  	/* Enable controller */
>  	writel(stcmd, priv->base + IFI_CANFD_STCMD);
> @@ -800,20 +628,6 @@ static void ifi_canfd_stop(struct net_device *ndev=
)
>  	priv->can.state =3D CAN_STATE_STOPPED;
>  }
> =20
> -static int ifi_canfd_set_mode(struct net_device *ndev, enum can_mode m=
ode)
> -{
> -	switch (mode) {
> -	case CAN_MODE_START:
> -		ifi_canfd_start(ndev);
> -		netif_wake_queue(ndev);
> -		break;
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -
> -	return 0;
> -}
> -
>  static int ifi_canfd_open(struct net_device *ndev)
>  {
>  	struct ifi_canfd_priv *priv =3D netdev_priv(ndev);
> @@ -826,11 +640,14 @@ static int ifi_canfd_open(struct net_device *ndev=
)
>  	}
> =20
>  	/* Register interrupt handler */
> -	ret =3D request_irq(ndev->irq, ifi_canfd_isr, IRQF_SHARED,
> -			  ndev->name, ndev);
> -	if (ret < 0) {
> -		netdev_err(ndev, "Failed to request interrupt\n");
> -		goto err_irq;
> +	if (!(priv->flags & IFI_CANFD_CUSTOM_IRQ_HANDLING)) {
> +		ret =3D request_irq(ndev->irq, ifi_canfd_isr, IRQF_SHARED,
> +				  ndev->name, ndev);
> +		if (ret < 0) {
> +			netdev_err(ndev,
> +				   "Failed to request interrupt: %i\n", ret);
> +			goto err_irq;
> +		}
>  	}
> =20
>  	ifi_canfd_start(ndev);
> @@ -854,7 +671,8 @@ static int ifi_canfd_close(struct net_device *ndev)=

> =20
>  	ifi_canfd_stop(ndev);
> =20
> -	free_irq(ndev->irq, ndev);
> +	if (!(priv->flags & IFI_CANFD_CUSTOM_IRQ_HANDLING))
> +		free_irq(ndev->irq, ndev);
> =20
>  	close_candev(ndev);
> =20
> @@ -937,52 +755,32 @@ static const struct net_device_ops ifi_canfd_netd=
ev_ops =3D {
>  	.ndo_change_mtu	=3D can_change_mtu,
>  };
> =20
> -static int ifi_canfd_plat_probe(struct platform_device *pdev)
> +static int ifi_canfd_set_mode(struct net_device *ndev, enum can_mode m=
ode)
>  {
> -	struct device *dev =3D &pdev->dev;
> -	struct net_device *ndev;
> -	struct ifi_canfd_priv *priv;
> -	struct resource *res;
> -	void __iomem *addr;
> -	int irq, ret;
> -	u32 id, rev;
> -
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	addr =3D devm_ioremap_resource(dev, res);
> -	irq =3D platform_get_irq(pdev, 0);
> -	if (IS_ERR(addr) || irq < 0)
> -		return -EINVAL;
> -
> -	id =3D readl(addr + IFI_CANFD_IP_ID);
> -	if (id !=3D IFI_CANFD_IP_ID_VALUE) {
> -		dev_err(dev, "This block is not IFI CANFD, id=3D%08x\n", id);
> -		return -EINVAL;
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		ifi_canfd_start(ndev);
> +		netif_wake_queue(ndev);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
>  	}
> =20
> -	rev =3D readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
> -	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
> -		dev_err(dev, "This block is too old (rev %i), minimum supported is r=
ev %i\n",
> -			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
> -		return -EINVAL;
> -	}
> +	return 0;
> +}
> =20
> -	ndev =3D alloc_candev(sizeof(*priv), 1);
> -	if (!ndev)
> -		return -ENOMEM;
> +struct net_device *alloc_ifi_canfd_dev(int sizeof_priv, int echo_skb_m=
ax)
> +{
> +	struct net_device *ndev;
> +	struct ifi_canfd_priv *priv;
> =20
> -	ndev->irq =3D irq;
> -	ndev->flags |=3D IFF_ECHO;	/* we support local echo */
> -	ndev->netdev_ops =3D &ifi_canfd_netdev_ops;
> +	ndev =3D alloc_candev(sizeof(struct ifi_canfd_priv) + sizeof_priv,
> +			    echo_skb_max);
> +	if (!ndev)
> +		return NULL;
> =20
>  	priv =3D netdev_priv(ndev);
>  	priv->ndev =3D ndev;
> -	priv->base =3D addr;
> -
> -	netif_napi_add(ndev, &priv->napi, ifi_canfd_poll, 64);
> -
> -	priv->can.state =3D CAN_STATE_STOPPED;
> -
> -	priv->can.clock.freq =3D readl(addr + IFI_CANFD_CANCLOCK);
> =20
>  	priv->can.bittiming_const	=3D &ifi_canfd_bittiming_const;
>  	priv->can.data_bittiming_const	=3D &ifi_canfd_bittiming_const;
> @@ -999,54 +797,36 @@ static int ifi_canfd_plat_probe(struct platform_d=
evice *pdev)
>  				       CAN_CTRLMODE_FD_NON_ISO |
>  				       CAN_CTRLMODE_BERR_REPORTING;
> =20
> -	platform_set_drvdata(pdev, ndev);
> -	SET_NETDEV_DEV(ndev, dev);
> +	return ndev;
> +}
> +EXPORT_SYMBOL_GPL(alloc_ifi_canfd_dev);
> =20
> -	ret =3D register_candev(ndev);
> -	if (ret) {
> -		dev_err(dev, "Failed to register (ret=3D%d)\n", ret);
> -		goto err_reg;
> -	}
> +void free_ifi_canfd_dev(struct net_device *ndev)
> +{
> +	free_candev(ndev);
> +}
> +EXPORT_SYMBOL_GPL(free_ifi_canfd_dev);
> =20
> -	devm_can_led_init(ndev);
> +int register_ifi_canfd_dev(struct net_device *ndev)
> +{
> +	int ret;
> =20
> -	dev_info(dev, "Driver registered: regs=3D%p, irq=3D%d, clock=3D%d\n",=

> -		 priv->base, ndev->irq, priv->can.clock.freq);
> +	ndev->netdev_ops =3D &ifi_canfd_netdev_ops;
> +	ndev->flags |=3D IFF_ECHO;
> =20
> -	return 0;
> +	ret =3D  register_candev(ndev);
> +	if (!ret)
> +		devm_can_led_init(ndev);
> =20
> -err_reg:
> -	free_candev(ndev);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(register_ifi_canfd_dev);
> =20
> -static int ifi_canfd_plat_remove(struct platform_device *pdev)
> +void unregister_ifi_canfd_dev(struct net_device *ndev)
>  {
> -	struct net_device *ndev =3D platform_get_drvdata(pdev);
> -
>  	unregister_candev(ndev);
> -	platform_set_drvdata(pdev, NULL);
> -	free_candev(ndev);
> -
> -	return 0;
>  }
> -
> -static const struct of_device_id ifi_canfd_of_table[] =3D {
> -	{ .compatible =3D "ifi,canfd-1.0", .data =3D NULL },
> -	{ /* sentinel */ },
> -};
> -MODULE_DEVICE_TABLE(of, ifi_canfd_of_table);
> -
> -static struct platform_driver ifi_canfd_plat_driver =3D {
> -	.driver =3D {
> -		.name		=3D KBUILD_MODNAME,
> -		.of_match_table	=3D ifi_canfd_of_table,
> -	},
> -	.probe	=3D ifi_canfd_plat_probe,
> -	.remove	=3D ifi_canfd_plat_remove,
> -};
> -
> -module_platform_driver(ifi_canfd_plat_driver);
> +EXPORT_SYMBOL_GPL(unregister_ifi_canfd_dev);
> =20
>  MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.h b/drivers/net/can/if=
i_canfd/ifi_canfd.h
> new file mode 100644
> index 000000000000..1954157615d8
> --- /dev/null
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.h
> @@ -0,0 +1,341 @@
> +/*
> + * CAN bus driver for IFI CANFD controller
> + *
> + * Copyright (C) 2016 Marek Vasut <marex@denx.de>
> + *
> + * Details about this controller can be found at
> + * http://www.ifi-pld.de/IP/CANFD/canfd.html
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#ifndef IFI_CANFD_H_
> +#define IFI_CANFD_H_
> +
> +#define IFI_CANFD_STCMD				0x0
> +#define IFI_CANFD_STCMD_HARDRESET		0xDEADCAFD
> +#define IFI_CANFD_STCMD_ENABLE			BIT(0)
> +#define IFI_CANFD_STCMD_ERROR_ACTIVE		BIT(2)
> +#define IFI_CANFD_STCMD_ERROR_PASSIVE		BIT(3)
> +#define IFI_CANFD_STCMD_BUSOFF			BIT(4)
> +#define IFI_CANFD_STCMD_ERROR_WARNING		BIT(5)
> +#define IFI_CANFD_STCMD_BUSMONITOR		BIT(16)
> +#define IFI_CANFD_STCMD_LOOPBACK		BIT(18)
> +#define IFI_CANFD_STCMD_DISABLE_CANFD		BIT(24)
> +#define IFI_CANFD_STCMD_ENABLE_ISO		BIT(25)
> +#define IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING	BIT(26)
> +#define IFI_CANFD_STCMD_NORMAL_MODE		((u32)BIT(31))
> +
> +#define IFI_CANFD_RXSTCMD			0x4
> +#define IFI_CANFD_RXSTCMD_REMOVE_MSG		BIT(0)
> +#define IFI_CANFD_RXSTCMD_RESET			BIT(7)
> +#define IFI_CANFD_RXSTCMD_EMPTY			BIT(8)
> +#define IFI_CANFD_RXSTCMD_OVERFLOW		BIT(13)
> +#define IFI_CANFD_RXSTCMD_FIFO_NUMBER		0xFFFF0000
> +#define IFI_CANFD_RXSTCMD_FIFO_NUMBER_OFF	16
> +
> +#define IFI_CANFD_TXSTCMD			0x8
> +#define IFI_CANFD_TXSTCMD_ADD_MSG		BIT(0)
> +#define IFI_CANFD_TXSTCMD_HIGH_PRIO		BIT(1)
> +#define IFI_CANFD_TXSTCMD_REMOVE_PEND_MSG	BIT(6)
> +#define IFI_CANFD_TXSTCMD_RESET			BIT(7)
> +#define IFI_CANFD_TXSTCMD_EMPTY			BIT(8)
> +#define IFI_CANFD_TXSTCMD_FULL			BIT(12)
> +#define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
> +
> +#define IFI_CANFD_INTERRUPT			0xc
> +#define IFI_CANFD_INTERRUPT_ERROR_BUSOFF	BIT(0)
> +#define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
> +#define IFI_CANFD_INTERRUPT_ERROR_STATE_CHG	BIT(2)
> +#define IFI_CANFD_INTERRUPT_ERROR_REC_TEC_INC	BIT(3)
> +#define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
> +#define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
> +#define IFI_CANFD_INTERRUPT_TXFIFO_OVERFLOW	BIT(21)
> +#define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
> +#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY	BIT(24)
> +#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER	BIT(25)
> +#define IFI_CANFD_INTERRUPT_RXFIFO_OVERFLOW	BIT(30)
> +#define IFI_CANFD_INTERRUPT_SET_IRQ		((u32)BIT(31))
> +
> +#define IFI_CANFD_IRQMASK			0x10
> +#define IFI_CANFD_IRQMASK_ERROR_BUSOFF		BIT(0)
> +#define IFI_CANFD_IRQMASK_ERROR_WARNING		BIT(1)
> +#define IFI_CANFD_IRQMASK_ERROR_STATE_CHG	BIT(2)
> +#define IFI_CANFD_IRQMASK_ERROR_REC_TEC_INC	BIT(3)
> +#define IFI_CANFD_IRQMASK_SET_ERR		BIT(7)
> +#define IFI_CANFD_IRQMASK_SET_TS		BIT(15)
> +#define IFI_CANFD_IRQMASK_TXFIFO_EMPTY		BIT(16)
> +#define IFI_CANFD_IRQMASK_SET_TX		BIT(23)
> +#define IFI_CANFD_IRQMASK_RXFIFO_NEMPTY		BIT(24)
> +#define IFI_CANFD_IRQMASK_RXFIFO_OVERFLOW	BIT(30)
> +#define IFI_CANFD_IRQMASK_SET_RX		((u32)BIT(31))
> +
> +#define IFI_CANFD_TIME				0x14
> +#define IFI_CANFD_FTIME				0x18
> +#define IFI_CANFD_TIME_TIMEB_OFF		0
> +#define IFI_CANFD_TIME_TIMEA_OFF		8
> +#define IFI_CANFD_TIME_PRESCALE_OFF		16
> +#define IFI_CANFD_TIME_SJW_OFF_7_9_8_8		25
> +#define IFI_CANFD_TIME_SJW_OFF_4_12_6_6		28
> +#define IFI_CANFD_TIME_SET_SJW_4_12_6_6		BIT(6)
> +#define IFI_CANFD_TIME_SET_TIMEB_4_12_6_6	BIT(7)
> +#define IFI_CANFD_TIME_SET_PRESC_4_12_6_6	BIT(14)
> +#define IFI_CANFD_TIME_SET_TIMEA_4_12_6_6	BIT(15)
> +
> +#define IFI_CANFD_TDELAY			0x1c
> +#define IFI_CANFD_TDELAY_DEFAULT		0xb
> +#define IFI_CANFD_TDELAY_MASK			0x3fff
> +#define IFI_CANFD_TDELAY_ABS			BIT(14)
> +#define IFI_CANFD_TDELAY_EN			BIT(15)
> +
> +#define IFI_CANFD_ERROR				0x20
> +#define IFI_CANFD_ERROR_TX_OFFSET		0
> +#define IFI_CANFD_ERROR_TX_MASK			0xff
> +#define IFI_CANFD_ERROR_RX_OFFSET		16
> +#define IFI_CANFD_ERROR_RX_MASK			0xff
> +
> +#define IFI_CANFD_ERRCNT			0x24
> +
> +#define IFI_CANFD_SUSPEND			0x28
> +
> +#define IFI_CANFD_REPEAT			0x2c
> +
> +#define IFI_CANFD_TRAFFIC			0x30
> +
> +#define IFI_CANFD_TSCONTROL			0x34
> +
> +#define IFI_CANFD_TSC				0x38
> +
> +#define IFI_CANFD_TST				0x3c
> +
> +#define IFI_CANFD_RES1				0x40
> +
> +#define IFI_CANFD_ERROR_CTR			0x44
> +#define IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC	0x21302899
> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST	BIT(0)
> +#define IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST	BIT(1)
> +#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST	BIT(2)
> +#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST	BIT(3)
> +#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST	BIT(4)
> +#define IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST	BIT(5)
> +#define IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST	BIT(6)
> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_ALL	BIT(8)
> +#define IFI_CANFD_ERROR_CTR_ACK_ERROR_ALL	BIT(9)
> +#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_ALL	BIT(10)
> +#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_ALL	BIT(11)
> +#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_ALL	BIT(12)
> +#define IFI_CANFD_ERROR_CTR_CRC_ERROR_ALL	BIT(13)
> +#define IFI_CANFD_ERROR_CTR_FORM_ERROR_ALL	BIT(14)
> +#define IFI_CANFD_ERROR_CTR_BITPOSITION_OFFSET	16
> +#define IFI_CANFD_ERROR_CTR_ERROR_FIRST_MASK	0x000000FF
> +#define IFI_CANFD_ERROR_CTR_ERROR_ALL_MASK	0x00007F00
> +#define IFI_CANFD_ERROR_CTR_BITPOSITION_MASK	0x03ff0000
> +#define IFI_CANFD_ERROR_CTR_ERRORFRAME_RESET	BIT(26)
> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_RESET	BIT(27)
> +#define IFI_CANFD_ERROR_CTR_ERRORFRAME_PEND	BIT(28)
> +#define IFI_CANFD_ERROR_CTR_OVERLOAD_PEND	BIT(29)
> +#define IFI_CANFD_ERROR_CTR_ER_RESET		BIT(30)
> +#define IFI_CANFD_ERROR_CTR_ER_ENABLE		((u32)BIT(31))
> +
> +#define IFI_CANFD_PAR				0x48
> +#define IFI_CANFD_PAR_TX_SIZE			0x000000FF
> +#define IFI_CANFD_PAR_RX_SIZE			0x0000FF00
> +#define IFI_CANFD_PAR_SINGLE_CLOCK		BIT(16)
> +#define IFI_CANFD_PAR_NO_TSTAMP			BIT(17)
> +#define IFI_CANFD_PAR_NO_FILTER			BIT(18)
> +#define IFI_CANFD_PAR_NO_BUSSTAT		BIT(19)
> +
> +#define IFI_CANFD_CANCLOCK			0x4c
> +
> +#define IFI_CANFD_SYSCLOCK			0x50
> +
> +#define IFI_CANFD_VER				0x54
> +#define IFI_CANFD_VER_REV_MASK			0xff
> +#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
> +
> +#define IFI_CANFD_IP_ID				0x58
> +#define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
> +
> +#define IFI_CANFD_TEST				0x5c
> +
> +#define IFI_CANFD_RXFIFO_TS_63_32		0x60
> +
> +#define IFI_CANFD_RXFIFO_TS_31_0		0x64
> +
> +#define IFI_CANFD_RXFIFO_DLC			0x68
> +#define IFI_CANFD_RXFIFO_DLC_DLC_OFFSET		0
> +#define IFI_CANFD_RXFIFO_DLC_DLC_MASK		0xf
> +#define IFI_CANFD_RXFIFO_DLC_RTR		BIT(4)
> +#define IFI_CANFD_RXFIFO_DLC_EDL		BIT(5)
> +#define IFI_CANFD_RXFIFO_DLC_BRS		BIT(6)
> +#define IFI_CANFD_RXFIFO_DLC_ESI		BIT(7)
> +#define IFI_CANFD_RXFIFO_DLC_OBJ_OFFSET		8
> +#define IFI_CANFD_RXFIFO_DLC_OBJ_MASK		0x0001ff00
> +#define IFI_CANFD_RXFIFO_DLC_FNR_OFFSET		24
> +#define IFI_CANFD_RXFIFO_DLC_FNR_MASK		0xff000000
> +
> +#define IFI_CANFD_RXFIFO_ID			0x6c
> +#define IFI_CANFD_RXFIFO_ID_ID_OFFSET		0
> +#define IFI_CANFD_RXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
> +#define IFI_CANFD_RXFIFO_ID_ID_STD_OFFSET	0
> +#define IFI_CANFD_RXFIFO_ID_ID_STD_WIDTH	10
> +#define IFI_CANFD_RXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
> +#define IFI_CANFD_RXFIFO_ID_ID_XTD_OFFSET	11
> +#define IFI_CANFD_RXFIFO_ID_ID_XTD_WIDTH	18
> +#define IFI_CANFD_RXFIFO_ID_IDE			BIT(29)
> +
> +#define IFI_CANFD_RXFIFO_DATA			0x70
> +
> +#define IFI_CANFD_TXFIFO_SUSPEND_US		0xb0
> +
> +#define IFI_CANFD_TXFIFO_REPEATCOUNT		0xb4
> +
> +#define IFI_CANFD_TXFIFO_DLC			0xb8
> +#define IFI_CANFD_TXFIFO_DLC_DLC_OFFSET		0
> +#define IFI_CANFD_TXFIFO_DLC_DLC_MASK		0xf
> +#define IFI_CANFD_TXFIFO_DLC_RTR		BIT(4)
> +#define IFI_CANFD_TXFIFO_DLC_EDL		BIT(5)
> +#define IFI_CANFD_TXFIFO_DLC_BRS		BIT(6)
> +#define IFI_CANFD_TXFIFO_DLC_FNR_OFFSET		24
> +#define IFI_CANFD_TXFIFO_DLC_FNR_MASK		0xff
> +
> +#define IFI_CANFD_TXFIFO_ID			0xbc
> +#define IFI_CANFD_TXFIFO_ID_ID_OFFSET		0
> +#define IFI_CANFD_TXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
> +#define IFI_CANFD_TXFIFO_ID_ID_STD_OFFSET	0
> +#define IFI_CANFD_TXFIFO_ID_ID_STD_WIDTH	10
> +#define IFI_CANFD_TXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
> +#define IFI_CANFD_TXFIFO_ID_ID_XTD_OFFSET	11
> +#define IFI_CANFD_TXFIFO_ID_ID_XTD_WIDTH	18
> +#define IFI_CANFD_TXFIFO_ID_IDE			BIT(29)
> +
> +#define IFI_CANFD_TXFIFO_DATA			0xc0
> +
> +#define IFI_CANFD_FILTER_MASK(n)		(0x800 + ((n) * 8) + 0)
> +#define IFI_CANFD_FILTER_MASK_EXT		BIT(29)
> +#define IFI_CANFD_FILTER_MASK_EDL		BIT(30)
> +#define IFI_CANFD_FILTER_MASK_VALID		((u32)BIT(31))
> +
> +#define IFI_CANFD_FILTER_IDENT(n)		(0x800 + ((n) * 8) + 4)
> +#define IFI_CANFD_FILTER_IDENT_IDE		BIT(29)
> +#define IFI_CANFD_FILTER_IDENT_CANFD		BIT(30)
> +#define IFI_CANFD_FILTER_IDENT_VALID		((u32)BIT(31))
> +
> +#define IFI_CANFD_CUSTOM_IRQ_HANDLING		0x1
> +
> +/**
> + * struct ifi_canfd_priv - IFI CANFD device
> + * @can: CAN common private data
> + * @napi: Structure for NAPI scheduling
> + * @ndev: Network Device data
> + * @base: Base address
> + * @priv: additional field for device specific specific programming
> + * @flags: Custom mode flags
> + * @pre_irq: function pointers for custom pre-irq functionality
> + * @post_irq: function pointers for custom post-irq functionality
> + *
> + * Contains common fields of an IFI CANFD device
> + */
> +struct ifi_canfd_priv {
> +	struct can_priv		can;	/* must be the first member */
> +	struct napi_struct	napi;
> +	struct net_device	*ndev;
> +	void __iomem		*base;
> +
> +	void			*priv;	/* custom content */
> +	u16			flags;	/* custom mode flags*/
> +
> +	void (*pre_irq)(const struct ifi_canfd_priv *priv);
> +	void (*post_irq)(const struct ifi_canfd_priv *priv);
> +};
> +
> +/**
> + * ifi_canfd_irq_enable() - Enable/disable interrupt mode
> + * @ndev: Network device (CAN)
> + * @enable: flag 1-enable,0-disable
> + * @clear: flag to clear interrupts when set to 1
> + *
> + * Enables/disables/clears interrupts on request
> + *
> + * Return: None
> + */
> +void ifi_canfd_irq_enable(struct net_device *ndev, bool enable, u8 cle=
ar);
> +
> +/**
> + * ifi_canfd_set_filters() - Set Filter masks and IDs
> + * @ndev: Network device (CAN)
> + * @enable: enable/disable flag
> + *
> + * Sets filter masks and IDs for standard/extended CAN and CANFD frame=
s
> + *
> + * Return: None
> + */
> +void ifi_canfd_set_filters(struct net_device *ndev, bool enable);
> +
> +/**
> + * ifi_canfd_poll() - NAPI polling function
> + * @napi: Structure for NAPI scheduling similar to tasklet but with we=
ighting
> + * @quota: Places a limit on the amount of work the driver may do.
> + *	   If and only if the return value is less than the budget, your dr=
iver
> + *	   must reenable interrupts and turn off polling
> + *
> + * Polls driver to pick up all available packets when interrupt is ser=
viced
> + *
> + * Return: No. of packets processed
> + */
> +int ifi_canfd_poll(struct napi_struct *napi, int quota);
> +
> +/**
> + * ifi_canfd_isr()
> + * @irq: IRQ Number
> + * @dev_id: Device ID
> + *
> + * This function is executed on reception of an interrupt
> + *
> + * Return: Interrupt handling status
> + */
> +irqreturn_t ifi_canfd_isr(int irq, void *dev_id);
> +
> +/**
> + * alloc_ifi_canfd_dev() - Allocate CAN device
> + * @sizeof_priv: size of device interface
> + * @echo_skb_max: max. number of sockets
> + *
> + * Allocates a CAN device
> + *
> + * Return: Network device allocated
> + */
> +struct net_device *alloc_ifi_canfd_dev(int sizeof_priv, int echo_skb_m=
ax);
> +
> +/**
> + * free_ifi_canfd_dev() - Free CAN device
> + * @ndev: Network device (CAN)
> + *
> + * Frees previously allocated CAN device
> + *
> + * Return: None
> + */
> +void free_ifi_canfd_dev(struct net_device *ndev);
> +
> +/**
> + * register_ifi_canfd_dev() - Register CAN device
> + * @ndev: Network device (CAN)
> + *
> + * Registers CAN device and sets netdev_ops structure
> + *
> + * Return: return code register_candev
> + */
> +int register_ifi_canfd_dev(struct net_device *ndev);
> +
> +/**
> + * unregister_ifi_canfd_dev() - Unregister CAN device
> + * @ndev: Network device (CAN)
> + *
> + * Unregisters CAN device
> + *
> + * Return: None
> + */
> +void unregister_ifi_canfd_dev(struct net_device *ndev);
> +
> +#endif /* IFI_CANFD_H_ */
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd_platform.c b/drivers/n=
et/can/ifi_canfd/ifi_canfd_platform.c
> new file mode 100644
> index 000000000000..2bbcfc2d77ce
> --- /dev/null
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd_platform.c
> @@ -0,0 +1,121 @@
> +/*
> + * CAN bus driver for IFI CANFD controller
> + *
> + * Copyright (C) 2016 Marek Vasut <marex@denx.de>
> + *
> + * Details about this controller can be found at
> + * http://www.ifi-pld.de/IP/CANFD/canfd.html
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/can/dev.h>
> +#include "ifi_canfd.h"
> +
> +static int ifi_canfd_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct net_device *ndev;
> +	struct ifi_canfd_priv *priv;
> +	struct resource *res;
> +	void __iomem *addr;
> +	int irq, ret;
> +	u32 id, rev;
> +
> +	dev_err(dev, "IFI-FD Probe start\n");
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	addr =3D devm_ioremap_resource(dev, res);
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (IS_ERR(addr) || irq < 0)
> +		return -EINVAL;
> +
> +	id =3D readl(addr + IFI_CANFD_IP_ID);
> +	if (id !=3D IFI_CANFD_IP_ID_VALUE) {
> +		dev_err(dev, "This block is not IFI CANFD, id=3D%08x\n", id);
> +		return -EINVAL;
> +	}
> +
> +	rev =3D readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
> +	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
> +		dev_err(dev, "This block is too old (rev %i), minimum supported is r=
ev %i\n",
> +			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
> +		return -EINVAL;
> +	}
> +
> +	ndev =3D alloc_ifi_canfd_dev(0, 1);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	priv =3D netdev_priv(ndev);
> +
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +	priv->can.clock.freq =3D readl(addr + IFI_CANFD_CANCLOCK);
> +
> +	ndev->irq =3D irq;
> +	priv->base =3D addr;
> +
> +	netif_napi_add(ndev, &priv->napi, ifi_canfd_poll, 64);
> +
> +	platform_set_drvdata(pdev, ndev);
> +	SET_NETDEV_DEV(ndev, dev);
> +
> +	ret =3D register_ifi_canfd_dev(ndev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register (ret=3D%d)\n", ret);
> +		goto err_reg;
> +	}
> +
> +	dev_info(dev, "Driver registered: regs=3D%p, irq=3D%d, clock=3D%d\n",=

> +		 priv->base, ndev->irq, priv->can.clock.freq);
> +
> +	return 0;
> +
> +err_reg:
> +	free_ifi_canfd_dev(ndev);
> +	return ret;
> +}
> +
> +static int ifi_canfd_plat_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev =3D platform_get_drvdata(pdev);
> +
> +	unregister_ifi_canfd_dev(ndev);
> +	platform_set_drvdata(pdev, NULL);
> +	free_ifi_canfd_dev(ndev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ifi_canfd_of_table[] =3D {
> +	{ .compatible =3D "ifi,canfd-1.0", .data =3D NULL },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, ifi_canfd_of_table);
> +
> +static struct platform_driver ifi_canfd_plat_driver =3D {
> +	.driver =3D {
> +		.name		=3D KBUILD_MODNAME,
> +		.of_match_table	=3D ifi_canfd_of_table,
> +	},
> +	.probe	=3D ifi_canfd_plat_probe,
> +	.remove	=3D ifi_canfd_plat_remove,
> +};
> +
> +module_platform_driver(ifi_canfd_plat_driver);
> +
> +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("CAN bus driver for IFI CANFD controller");
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--pMZ1Qx9EtPYwstqbcyEMQVPv3gKgljDz1--

--vAUsD05QAELZL2lieEDsZTxW3504VZMsC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl0xvRUACgkQWsYho5Hk
nSDyiQf+OMeD1ARpH9AYOl4tSrNDBJenER0tdNCM9g+AqMok2AXwaDFL7Q4xb7J+
Ekh9z9mnFEwXblDfhIZXhfcTjSgH87ZvAJr+n28rdsI6MfOtcM1wsbRT59C9tlWo
ZO/QNTapF+BIZN/qLrS3ZPKSmI3rJduHQ6k2V3+feotgaZtTa6zYGjGAtxhTjQuL
zLINgbohJ/c5DZ228M6Id2D7+tj3kAqHsWf1LS6LR+vcTenqpVLL9OXfv5I3sQe0
WKl/Kj3WuLX/G2kA9mkY28TML1ScFDvAJHyd/crAHPsR09vgo6H1hb8JHdGo1ml6
fsZyZUiwcgYDOkjH5OUrIhSsmx4RhQ==
=kkzN
-----END PGP SIGNATURE-----

--vAUsD05QAELZL2lieEDsZTxW3504VZMsC--
