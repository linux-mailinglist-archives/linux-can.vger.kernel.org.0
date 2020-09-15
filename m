Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2926A1CD
	for <lists+linux-can@lfdr.de>; Tue, 15 Sep 2020 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIOJMt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIOJMi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 05:12:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE737C061788
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 02:12:37 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kI70r-0003Qg-AC; Tue, 15 Sep 2020 11:12:33 +0200
Received: from [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545] (unknown [IPv6:2a03:f580:87bc:d400:8d0c:cfd0:3f99:a545])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "mkl@blackshift.org", Issuer "StartCom Class 1 Client CA" (not verified))
        (Authenticated sender: mkl@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 14537560B14;
        Tue, 15 Sep 2020 09:12:32 +0000 (UTC)
To:     Abhijeet Badurkar <abhijeet.badurkar@duagon.com>, wg@grandegger.com
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        andreas.geissler@duagon.com
References: <20200707153520.22146-1-abhijeet.badurkar@duagon.com>
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Autocrypt: addr=mkl@pengutronix.de; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v3] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
Message-ID: <c6edac61-5dff-8559-6b32-55b21b7679a8@pengutronix.de>
Date:   Tue, 15 Sep 2020 11:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200707153520.22146-1-abhijeet.badurkar@duagon.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aw9RU8CTFkhNUezL2MOq2heZ25T8OI5sr"
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aw9RU8CTFkhNUezL2MOq2heZ25T8OI5sr
Content-Type: multipart/mixed; boundary="LKFEIsAtobeyEEKEomaceGrgicZGSIunw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Abhijeet Badurkar <abhijeet.badurkar@duagon.com>, wg@grandegger.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 andreas.geissler@duagon.com
Message-ID: <c6edac61-5dff-8559-6b32-55b21b7679a8@pengutronix.de>
Subject: Re: [PATCH v3] net: can: Introduce MEN 16Z192-00 CAN controller
 driver
References: <20200707153520.22146-1-abhijeet.badurkar@duagon.com>
In-Reply-To: <20200707153520.22146-1-abhijeet.badurkar@duagon.com>

--LKFEIsAtobeyEEKEomaceGrgicZGSIunw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/7/20 5:35 PM, Abhijeet Badurkar wrote:
> =EF=BB=BF
>     This CAN Controller is found on MEN Chameleon FPGAs.
>=20
>     The driver/device supports the CAN2.0 specification.
>     There are 255 RX and 255 Tx buffer within the IP. The
>     pointer for the buffer are handled by HW to make the
>     access from within the driver as simple as possible.
>=20
>     The driver also supports parameters to configure the
>     buffer level interrupt for RX/TX as well as a RX timeout
>     interrupt.
>=20
>     With this configuration options, the driver/device
>     provides flexibility for different types of usecases.
>=20
>     Changes in version 2:
>     Since the hardware does not have TX-done notification,
>     the local loopback mechanism is implemented using ECHO skbs.
>     The skb is added to echo stack, upon packet reception,
>     received and echo skb are matched.
>=20
>     LED trigger support is added.

Please remove, as this is obsolete. There's generic CONFIG_LEDS_TRIGGER_N=
ETDEV now.

>     The other fixes are related to transmission and reception
>     of remote frame, setting can state on CAN initialization,
>     some minor fixes and code optimizations.
>=20
>     Changes in version 3:
>     Fixed compiler warning.
>=20
> Signed-off-by: Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
> ---
>  drivers/net/can/Kconfig        |   10 +
>  drivers/net/can/Makefile       |    1 +
>  drivers/net/can/men_z192_can.c | 1055 ++++++++++++++++++++++++++++++++=

>  3 files changed, 1066 insertions(+)
>  create mode 100644 drivers/net/can/men_z192_can.c
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index f07012a76c0c..df658ecefddb 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -133,6 +133,16 @@ config CAN_KVASER_PCIEFD
>  	    Kvaser Mini PCI Express HS v2
>  	    Kvaser Mini PCI Express 2xHS v2
> =20
> +config CAN_MEN_Z192
> +	depends on MCB
> +	tristate "MEN 16Z192-00 CAN Controller"
> +	  help
> +	  Driver for MEN 16Z192-00 CAN Controller IP-Core, which
> +	  is connected to the MEN Chameleon Bus.
> +
> +	  This driver can also be built as a module. If so, the module will b=
e
> +	  called men_z192_can.ko.
> +
>  config CAN_SUN4I
>  	tristate "Allwinner A10 CAN controller"
>  	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 22164300122d..d874ab1b9f08 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_CAN_GRCAN)		+=3D grcan.o
>  obj-$(CONFIG_CAN_IFI_CANFD)	+=3D ifi_canfd/
>  obj-$(CONFIG_CAN_JANZ_ICAN3)	+=3D janz-ican3.o
>  obj-$(CONFIG_CAN_KVASER_PCIEFD)	+=3D kvaser_pciefd.o
> +obj-$(CONFIG_CAN_MEN_Z192)	+=3D men_z192_can.o
>  obj-$(CONFIG_CAN_MSCAN)		+=3D mscan/
>  obj-$(CONFIG_CAN_M_CAN)		+=3D m_can/
>  obj-$(CONFIG_CAN_PEAK_PCIEFD)	+=3D peak_canfd/
> diff --git a/drivers/net/can/men_z192_can.c b/drivers/net/can/men_z192_=
can.c
> new file mode 100644
> index 000000000000..a1e8be2dd94c
> --- /dev/null
> +++ b/drivers/net/can/men_z192_can.c
> @@ -0,0 +1,1055 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* MEN 16Z192 CAN Controller driver
> + *
> + * Copyright (C) 2016 MEN Mikroelektronik GmbH (www.men.de)
> + *
> + * Local loopback implementation in this driver is adapted from Janz M=
ODULbus
> + * VMOD-ICAN3 CAN Interface Driver
> + * Copyright (c) 2010 Ira W. Snyder <iws@ovro.caltech.edu>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/err.h>
> +#include <linux/bitops.h>
> +#include <linux/netdevice.h>
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/can/led.h>
> +#include <linux/mcb.h>
> +
> +#define DRV_NAME    "z192_can"
> +
> +#define MEN_Z192_MODE_TOUT_US	40
> +
> +/* CTL/BTR Register Bits */
> +#define MEN_Z192_CTL0_INITRQ	BIT(0)
> +#define MEN_Z192_CTL0_SLPRQ	BIT(1)
> +#define MEN_Z192_CTL1_INITAK	BIT(8)
> +#define MEN_Z192_CTL1_SLPAK	BIT(9)
> +#define MEN_Z192_CTL1_LISTEN	BIT(12)
> +#define MEN_Z192_CTL1_LOOPB	BIT(13)
> +#define MEN_Z192_CTL1_CANE	BIT(15)
> +#define MEN_Z192_BTR0_BRP(x)	(((x) & 0x3f) << 16)
> +#define MEN_Z192_BTR0_SJW(x)	(((x) & 0x03) << 22)
> +#define MEN_Z192_BTR1_TSEG1(x)	(((x) & 0x0f) << 24)
> +#define MEN_Z192_BTR1_TSEG2(x)	(((x) & 0x07) << 28)
> +#define MEN_Z192_BTR1_SAMP	BIT(31)
> +
> +/* IER Interrupt Enable Register bits */
> +#define MEN_Z192_RXIE		BIT(0)
> +#define MEN_Z192_OVRIE		BIT(1)
> +#define MEN_Z192_CSCIE		BIT(6)
> +#define MEN_Z192_TOUTE		BIT(7)
> +#define MEN_Z192_TXIE		BIT(16)
> +#define MEN_Z192_ERRIE		BIT(17)
> +
> +#define MEN_Z192_IRQ_ALL				\
> +		(MEN_Z192_RXIE | MEN_Z192_OVRIE |	\
> +		 MEN_Z192_CSCIE | MEN_Z192_TOUTE     |  \
only one space in front of the '|'

> +		 MEN_Z192_TXIE)
> +
> +/* RX_TX_STAT RX/TX Status status register bits */
> +#define MEN_Z192_RX_BUF_CNT(x)	((x) & 0xff)
> +#define MEN_Z192_TX_BUF_CNT(x)	(((x) & 0xff00) >> 8)
> +#define	MEN_Z192_RFLG_RXIF	BIT(16)
> +#define	MEN_Z192_RFLG_OVRF	BIT(17)
> +#define	MEN_Z192_RFLG_TSTATE	GENMASK(19, 18)
> +#define	MEN_Z192_RFLG_RSTATE	GENMASK(21, 20)
> +#define	MEN_Z192_RFLG_CSCIF	BIT(22)
> +#define	MEN_Z192_RFLG_TOUTF	BIT(23)
> +#define MEN_Z192_TFLG_TXIF	BIT(24)
> +
> +#define MEN_Z192_GET_TSTATE(x)	(((x) & MEN_Z192_RFLG_TSTATE) >> 18)
> +#define MEN_Z192_GET_RSTATE(x)	(((x) & MEN_Z192_RFLG_RSTATE) >> 20)
> +
> +#define MEN_Z192_IRQ_NAPI	(MEN_Z192_RXIE | MEN_Z192_TOUTE)
> +
> +#define MEN_Z192_IRQ_FLAGS_ALL					\
> +		(MEN_Z192_RFLG_RXIF | MEN_Z192_RFLG_OVRF |	\
> +		 MEN_Z192_RFLG_TSTATE | MEN_Z192_RFLG_RSTATE |	\
> +		 MEN_Z192_RFLG_CSCIF | MEN_Z192_RFLG_TOUTF |	\
> +		 MEN_Z192_TFLG_TXIF)
> +
> +/* RX/TX Error counter bits */
> +#define MEN_Z192_GET_RX_ERR_CNT(x)	((x) & 0xff)
> +#define MEN_Z192_GET_TX_ERR_CNT(x)	(((x) & 0x00ff0000) >> 16)

define a MASK using GENMASK and use FIELD_GET() in the code.

> +
> +/* Buffer level register bits */
> +#define MEN_Z192_RX_BUF_LVL	GENMASK(15, 0)
> +#define MEN_Z192_TX_BUF_LVL	GENMASK(31, 16)
> +
> +/* RX/TX Buffer register bits */
> +#define MEN_Z192_CFBUF_LEN	GENMASK(3, 0)
> +#define MEN_Z192_CFBUF_ID1	GENMASK(31, 21)
> +#define MEN_Z192_CFBUF_ID2	GENMASK(18, 1)
> +#define MEN_Z192_CFBUF_TS	GENMASK(31, 8)
> +#define MEN_Z192_CFBUF_E_RTR	BIT(0)
> +#define MEN_Z192_CFBUF_IDE	BIT(19)
> +#define MEN_Z192_CFBUF_SRR	BIT(20)
> +#define MEN_Z192_CFBUF_S_RTR	BIT(20)
> +#define MEN_Z192_CFBUF_ID2_SHIFT	1
> +#define MEN_Z192_CFBUF_ID1_SHIFT	21
> +
> +/* Global register offsets */
> +#define MEN_Z192_RX_BUF_START	0x0000
> +#define MEN_Z192_TX_BUF_START	0x1000
> +#define MEN_Z192_REGS_OFFS	0x2000
> +
> +/* Buffer level control values */
> +#define MEN_Z192_MIN_BUF_LVL	0
> +#define MEN_Z192_MAX_BUF_LVL	254
> +#define MEN_Z192_RX_BUF_LVL_DEF	5
> +#define MEN_Z192_TX_BUF_LVL_DEF	5
> +#define MEN_Z192_RX_TOUT_MIN	0
> +#define MEN_Z192_RX_TOUT_MAX	65535
> +#define MEN_Z192_RX_TOUT_DEF	1000

Please use a consistent indention scheme, I suggest only one space betwee=
n name
and value/expression.
> +
> +static int txlvl =3D MEN_Z192_TX_BUF_LVL_DEF;
> +module_param(txlvl, int, 0444);
> +MODULE_PARM_DESC(txlvl, "TX IRQ trigger level (in frames) 0-254, defau=
lt=3D"
> +		 __MODULE_STRING(MEN_Z192_MIN_BUF_LVL) ")");

Please implement this via ethtool coalesce. See:

https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool=
=2Eh#L389
https://elixir.bootlin.com/linux/latest/source/include/linux/ethtool.h#L3=
92

Use an existing driver to follow, how to implement ethtool:

https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/amd/x=
gbe/xgbe-ethtool.c#L815

> +/* Following parameters related to RX interrupt have impact on latency=
 and
> + * provide the users full control over them.
> + *
> + * rxlvl: Receive buffer level or in other words, the number of frames=
 to
> + * trigger RX interrupt
> + * When number of received valid CAN frames exceeds rxlvl and RX inter=
rupt is
> + * enabled, an interrupt will be generated. For example, if rxlvl is 0=
 and one
> + * frame is received, an interrupt will be generated or if rxlvl is 25=
4 and 255
> + * frames are received, an interrupt will be generated.

This probably correspondes to ETHTOOL_COALESCE_RX_MAX_FRAMES

> + *
> + * rx_timeout: Read timeout for receive buffer
> + * When receive buffer is not empty and it has not been accessed since=

> + * rx_timeout then TOUTF flag is set. If RX interrupt was already enab=
led and
> + * TOUTF flag is set, a RX interrupt will be generated. By defining th=
is
> + * parameter, time of the interrupt generation can be controlled, if t=
he RX
> + * buffer level is not reached within rx_timeout.

This probably correspondes to ETHTOOL_COALESCE_RX_USECS

> + *
> + * When an interrupt is generated for either of these parameters, NAPI=
 poll is
> + * scheduled to read the recived CAN frames.
> + */
> +static int rxlvl =3D MEN_Z192_RX_BUF_LVL_DEF;
> +module_param(rxlvl, int, 0444);
> +MODULE_PARM_DESC(rxlvl, "RX IRQ trigger level (in frames) 0-254, defau=
lt=3D"
> +		 __MODULE_STRING(MEN_Z192_MIN_BUF_LVL) ")");
> +
> +static int rx_timeout =3D MEN_Z192_RX_TOUT_DEF;
> +module_param(rx_timeout, int, 0444);
> +MODULE_PARM_DESC(rx_timeout, "RX IRQ timeout (in 100usec steps), defau=
lt=3D"
> +		 __MODULE_STRING(MEN_Z192_RX_TOUT_DEF) ")");
> +
> +struct men_z192_regs {
> +	u32 ctl_btr;		/* Control and bus timing register */
> +	u32 ier;                /* Interrupt enable register */
> +	u32 buf_lvl;            /* Buffer level register */
> +	u32 rxa;                /* RX Data acknowledge register */
> +	u32 txa;                /* TX data acknowledge register */
> +	u32 rx_tx_sts;          /* RX/TX flags and buffer level */
> +	u32 ovr_ecc_sts;        /* Overrun/ECC status register */
> +	u32 idac_ver;           /* ID acceptance control / version */
> +	u32 rx_tx_err;          /* RX/TX error counter register */
> +	u32 idar_0_to_3;        /* ID acceptance register 0...3 */
> +	u32 idar_4_to_7;        /* ID acceptance register 4...7 */
> +	u32 idmr_0_to_3;        /* ID mask register 0...3 */
> +	u32 idmr_4_to_7;        /* ID mask register 4...7 */
> +	u32 rx_timeout;		/* receive timeout */
> +	u32 timebase;		/* Base frequency for baudrate calculation */
> +};
> +
> +struct men_z192 {
> +	struct can_priv can;
> +	struct napi_struct napi;
> +	struct net_device *ndev;
> +	struct device *dev;
> +
> +	/* Lock for CTL_BTR register access. This register combines bittiming=

> +	 * bits and the operation mode bits. It is also used for bit r/m/w
> +	 * access to all registers.
> +	 */
> +	spinlock_t lock;
> +	struct resource *mem;
> +	struct men_z192_regs __iomem *regs;
> +	void __iomem *dev_base;
> +
> +	/* queue for echo packets */
> +	struct sk_buff_head echoq;
> +};
> +
> +struct men_z192_cf_buf {
> +	u32 can_id;
> +	u32 data[2];
> +	u32 length;
> +};
> +
> +enum men_z192_int_state {
> +	MEN_Z192_CAN_DIS =3D 0,
> +	MEN_Z192_CAN_EN,
> +	MEN_Z192_CAN_NAPI_DIS,
> +	MEN_Z192_CAN_NAPI_EN,
> +};
> +
> +static enum can_state bus_state_map[] =3D {
const
> +	CAN_STATE_ERROR_ACTIVE,
> +	CAN_STATE_ERROR_WARNING,
> +	CAN_STATE_ERROR_PASSIVE,
> +	CAN_STATE_BUS_OFF
> +};
> +
> +static const struct can_bittiming_const men_z192_bittiming_const =3D {=

> +	.name =3D DRV_NAME,
> +	.tseg1_min =3D 4,
> +	.tseg1_max =3D 16,
> +	.tseg2_min =3D 2,
> +	.tseg2_max =3D 8,
> +	.sjw_max =3D 4,
> +	.brp_min =3D 2,
> +	.brp_max =3D 64,
> +	.brp_inc =3D 1,
> +};
> +
> +static inline void men_z192_bit_clr(struct men_z192 *priv, void __iome=
m *addr,
> +				    u32 mask)
> +{
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	val =3D readl(addr);
> +	val &=3D ~mask;
> +	writel(val, addr);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static inline void men_z192_bit_set(struct men_z192 *priv, void __iome=
m *addr,
> +				    u32 mask)
> +{
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	val =3D readl(addr);
> +	val |=3D mask;
> +	writel(val, addr);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static inline void men_z192_ack_rx_pkg(struct men_z192 *priv,
> +				       unsigned int count)
> +{
> +	writel(count, &priv->regs->rxa);
> +}
> +
> +static inline void men_z192_ack_tx_pkg(struct men_z192 *priv,
> +				       unsigned int count)
> +{
> +	writel(count, &priv->regs->txa);
> +}
> +
> +static void men_z192_set_int(struct men_z192 *priv,
> +			     enum men_z192_int_state state)
> +{
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +
> +	switch (state) {
> +	case MEN_Z192_CAN_DIS:
> +		men_z192_bit_clr(priv, &regs->ier, MEN_Z192_IRQ_ALL);
> +		break;
> +
> +	case MEN_Z192_CAN_EN:
> +		men_z192_bit_set(priv, &regs->ier, MEN_Z192_IRQ_ALL);
> +		break;
> +
> +	case MEN_Z192_CAN_NAPI_DIS:
> +		men_z192_bit_clr(priv, &regs->ier, MEN_Z192_IRQ_NAPI);
> +		break;
> +
> +	case MEN_Z192_CAN_NAPI_EN:
> +		men_z192_bit_set(priv, &regs->ier, MEN_Z192_IRQ_NAPI);
> +		break;
> +
> +	default:
> +		netdev_err(priv->ndev, "invalid interrupt state\n");
> +		break;
> +	}
> +}
> +
> +static int men_z192_get_berr_counter(const struct net_device *ndev,
> +				     struct can_berr_counter *bec)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	u32 err_cnt;
> +
> +	err_cnt =3D readl(&regs->rx_tx_err);
> +
> +	bec->txerr =3D MEN_Z192_GET_TX_ERR_CNT(err_cnt);
> +	bec->rxerr =3D MEN_Z192_GET_RX_ERR_CNT(err_cnt);

FIELD_GET()

> +
> +	return 0;
> +}
> +
> +static int men_z192_req_run_mode(struct men_z192 *priv)
> +{
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	u32 val;
> +
> +	men_z192_bit_clr(priv, &regs->ctl_btr, MEN_Z192_CTL0_INITRQ);
> +
> +	return read_poll_timeout(readl, val, !(val & MEN_Z192_CTL1_INITAK), 1=
0,

please use a define for the 10

> +				 MEN_Z192_MODE_TOUT_US, 0, &regs->ctl_btr);
> +}
> +
> +static int men_z192_req_init_mode(struct men_z192 *priv)
> +{
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	u32 val;
> +
> +	men_z192_bit_set(priv, &regs->ctl_btr, MEN_Z192_CTL0_INITRQ);
> +
> +	return read_poll_timeout(readl, val, val & MEN_Z192_CTL1_INITAK, 10,

same here

> +				 MEN_Z192_MODE_TOUT_US, 0, &regs->ctl_btr);
> +}
> +
> +static void z192_put_echo_skb(struct men_z192 *priv, struct sk_buff *s=
kb)
> +{
> +	skb =3D can_create_echo_skb(skb);
> +	if (!skb)
> +		return;
> +
> +	/* save this skb for tx interrupt echo handling */
> +	skb_queue_tail(&priv->echoq, skb);
> +}
> +
> +static unsigned int z192_get_echo_skb(struct men_z192 *priv)
> +{
> +	struct sk_buff *skb =3D skb_dequeue(&priv->echoq);
> +	struct can_frame *cf;
> +	u8 dlc;
> +
> +	/* this should never trigger unless there is a driver bug */
> +	if (!skb) {
> +		netdev_err(priv->ndev, "BUG: echo skb not occupied\n");
> +		return 0;
> +	}
> +
> +	cf =3D (struct can_frame *)skb->data;
> +	dlc =3D cf->can_dlc;
> +
> +	/* check flag whether this packet has to be looped back */
> +	if (skb->pkt_type !=3D PACKET_LOOPBACK) {
> +		kfree_skb(skb);
> +		return dlc;
> +	}
> +
> +	skb->protocol =3D htons(ETH_P_CAN);
> +	skb->pkt_type =3D PACKET_BROADCAST;
> +	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +	skb->dev =3D priv->ndev;
> +	netif_receive_skb(skb);
> +	return dlc;
> +}
> +
> +static bool z192_echo_skb_matches(struct men_z192 *priv, struct sk_buf=
f *skb)
> +{
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct sk_buff *echo_skb =3D skb_peek(&priv->echoq);
> +	struct can_frame *echo_cf;
> +
> +	if (!echo_skb)
> +		return false;
> +
> +	echo_cf =3D (struct can_frame *)echo_skb->data;
> +	if (cf->can_id !=3D echo_cf->can_id)
> +		return false;
> +
> +	if (cf->can_dlc !=3D echo_cf->can_dlc)
> +		return false;
> +
> +	return memcmp(cf->data, echo_cf->data, cf->can_dlc) =3D=3D 0;
> +}
> +
> +static int men_z192_read_frame(struct net_device *ndev, unsigned int f=
rame_nr)
> +{
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_cf_buf __iomem *cf_buf;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u32 cf_offset;
> +	u32 length;
> +	u32 id;
> +
> +	skb =3D alloc_can_skb(ndev, &cf);
> +	if (unlikely(!skb)) {
> +		stats->rx_dropped++;
> +		return 0;
> +	}
> +
> +	cf_offset =3D sizeof(struct men_z192_cf_buf) * frame_nr;
> +
> +	cf_buf =3D priv->dev_base + MEN_Z192_RX_BUF_START + cf_offset;
> +	length =3D readl(&cf_buf->length) & MEN_Z192_CFBUF_LEN;
> +	id =3D readl(&cf_buf->can_id);
> +
> +	if (id & MEN_Z192_CFBUF_IDE) {
> +		/* Extended frame */
> +		cf->can_id |=3D
> +			(id & MEN_Z192_CFBUF_ID1) >> 3 |
> +			((id & MEN_Z192_CFBUF_ID2) >>
> +				MEN_Z192_CFBUF_ID2_SHIFT) |

use FIELD_GET() here

> +			CAN_EFF_FLAG;
> +
> +		if (id & MEN_Z192_CFBUF_E_RTR)
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +	} else {
> +		/* Standard frame */
> +		cf->can_id =3D (id & MEN_Z192_CFBUF_ID1) >>
> +				MEN_Z192_CFBUF_ID1_SHIFT;

same here

> +
> +		if (id & MEN_Z192_CFBUF_S_RTR)
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +	}
> +
> +	cf->can_dlc =3D get_can_dlc(length);
> +
> +	/* remote transmission request frame contains no data field even if t=
he
> +	 * data length is set to a value > 0
> +	 */
> +	if (!(cf->can_id & CAN_RTR_FLAG) && cf->can_dlc) {
> +		*(__be32 *)cf->data =3D cpu_to_be32(readl(&cf_buf->data[0]));
> +		if (cf->can_dlc > 4)
> +			*(__be32 *)(cf->data + 4) =3D
> +			cpu_to_be32(readl(&cf_buf->data[1]));
> +	}
> +
> +	if (z192_echo_skb_matches(priv, skb)) {
> +		stats->tx_packets++;
> +		stats->tx_bytes +=3D z192_get_echo_skb(priv);
> +		kfree_skb(skb);
> +		goto led_event;
> +	}
> +
> +	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_packets++;
> +	netif_receive_skb(skb);
> +
> +led_event:
> +	can_led_event(ndev, CAN_LED_EVENT_RX);
> +
> +	return 1;
> +}
> +
> +static int men_z192_poll(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *ndev =3D napi->dev;
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	int work_done =3D 0;
> +	u32 frame_cnt;
> +	u32 status;
> +
> +	status =3D readl(&regs->rx_tx_sts);
> +
> +	frame_cnt =3D MEN_Z192_RX_BUF_CNT(status);
> +
> +	while (frame_cnt-- && (work_done < quota)) {
> +		work_done +=3D men_z192_read_frame(ndev, 0);
> +		men_z192_ack_rx_pkg(priv, 1);
> +	}
> +
> +	if (work_done < quota) {
> +		napi_complete(napi);
> +		men_z192_set_int(priv, MEN_Z192_CAN_NAPI_EN);
> +	}
> +
> +	return work_done;
> +}
> +
> +static int men_z192_xmit(struct sk_buff *skb, struct net_device *ndev)=

> +{
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	struct men_z192_cf_buf __iomem *cf_buf;
> +	int status;
> +	u32 id;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	status =3D readl(&regs->rx_tx_sts);
> +
> +	if (MEN_Z192_TX_BUF_CNT(status) =3D=3D 254) {

please use a define for the 254

> +		netif_stop_queue(ndev);
> +		netdev_err(ndev, "not enough space in TX buffer\n");
> +
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	cf_buf =3D priv->dev_base + MEN_Z192_TX_BUF_START;
> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
> +		/* Extended frame */
> +		id =3D ((cf->can_id & CAN_EFF_MASK) <<
> +			MEN_Z192_CFBUF_ID2_SHIFT) & MEN_Z192_CFBUF_ID2;
> +
> +		id |=3D (((cf->can_id & CAN_EFF_MASK) >>
> +			(CAN_EFF_ID_BITS - CAN_SFF_ID_BITS)) <<
> +			 MEN_Z192_CFBUF_ID1_SHIFT) & MEN_Z192_CFBUF_ID1;
> +
> +		id |=3D MEN_Z192_CFBUF_IDE | MEN_Z192_CFBUF_SRR;

use FIELD_GET()/FIELD_PREP()
> +
> +		if (cf->can_id & CAN_RTR_FLAG)
> +			id |=3D MEN_Z192_CFBUF_E_RTR;
> +	} else {
> +		/* Standard frame */
> +		id =3D ((cf->can_id & CAN_SFF_MASK) <<
> +		       MEN_Z192_CFBUF_ID1_SHIFT) & MEN_Z192_CFBUF_ID1;

same here

> +
> +		if (cf->can_id & CAN_RTR_FLAG)
> +			id |=3D MEN_Z192_CFBUF_S_RTR;
> +	}
> +
> +	writel(id, &cf_buf->can_id);
> +	writel(cf->can_dlc, &cf_buf->length);
> +
> +	if (!(cf->can_id & CAN_RTR_FLAG) && cf->can_dlc) {
> +		writel(be32_to_cpup((__be32 *)(cf->data)), &cf_buf->data[0]);
> +		if (cf->can_dlc > 4)
> +			writel(be32_to_cpup((__be32 *)(cf->data + 4)),
> +			       &cf_buf->data[1]);
> +	}
> +
> +	/* The 16z192 CAN IP doesn't have TX-done interrupts, so local
> +	 * loopback is emulated using ECHO skbs. Add the skb to the ECHO
> +	 * stack. Upon packet reception, check if the ECHO skb and received
> +	 * skb match, and use that to wake the queue.
> +	 */
> +	z192_put_echo_skb(priv, skb);
> +
> +	/* be sure everything is written to the
> +	 * device before acknowledge the data.

=2E..triggerring the transmission?

You have to stop the queue, if the buffer in the device is full.

> +	 */
> +	wmb();
> +
> +	/* trigger the transmission */
> +	men_z192_ack_tx_pkg(priv, 1);
> +
> +	can_led_event(ndev, CAN_LED_EVENT_TX);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static void men_z192_err_interrupt(struct net_device *ndev, u32 status=
)
> +{
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct can_berr_counter bec;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	enum can_state rx_state =3D 0, tx_state =3D 0;
> +
> +	skb =3D alloc_can_err_skb(ndev, &cf);
> +	if (unlikely(!skb))
> +		return;

please do the stats handling, regardless if the skb was allocated or not.=


> +
> +	/* put the rx/tx error counter to
> +	 * the additional controller specific
> +	 * section of the error frame.
> +	 */
> +	men_z192_get_berr_counter(ndev, &bec);
> +	cf->data[6] =3D bec.txerr;
> +	cf->data[7] =3D bec.rxerr;
> +
> +	/* overrun interrupt */
> +	if (status & MEN_Z192_RFLG_OVRF) {
> +		cf->can_id |=3D CAN_ERR_CRTL;
> +		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +		stats->rx_over_errors++;
> +		stats->rx_errors++;
> +	}
> +
> +	/* bus change interrupt */
> +	if (status & MEN_Z192_RFLG_CSCIF) {
> +		rx_state =3D bus_state_map[MEN_Z192_GET_RSTATE(status)];
> +		tx_state =3D bus_state_map[MEN_Z192_GET_TSTATE(status)];
> +		can_change_state(ndev, cf, tx_state, rx_state);
> +
> +		if (priv->can.state =3D=3D CAN_STATE_BUS_OFF)
> +			can_bus_off(ndev);
> +	}
> +
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cf->can_dlc;
> +	netif_receive_skb(skb);
> +}
> +
> +static irqreturn_t men_z192_isr(int irq, void *dev_id)
> +{
> +	struct net_device *ndev =3D dev_id;
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	bool handled =3D false;
> +	u32 irq_flags;
> +	u32 status;
> +
> +	status =3D readl(&regs->rx_tx_sts);
> +
> +	irq_flags =3D status & MEN_Z192_IRQ_FLAGS_ALL;
> +	if (!irq_flags)
> +		goto out;
> +
> +	/* It is safe to write to RX_TS_STS[15:0] */
> +	writel(irq_flags, &regs->rx_tx_sts);
> +
> +	if (irq_flags & MEN_Z192_TFLG_TXIF) {
> +		netif_wake_queue(ndev);
> +		handled =3D true;
> +	}
> +
> +	/* handle errors */
> +	if ((irq_flags & MEN_Z192_RFLG_OVRF) ||
> +	    (irq_flags & MEN_Z192_RFLG_CSCIF)) {
> +		men_z192_err_interrupt(ndev, status);
> +		handled =3D true;
> +	}
> +
> +	/* schedule NAPI if:
> +	 * - rx IRQ
> +	 * - rx timeout IRQ
> +	 */
> +	if ((irq_flags & MEN_Z192_RFLG_RXIF) ||
> +	    (irq_flags & MEN_Z192_RFLG_TOUTF)) {
> +		men_z192_set_int(priv, MEN_Z192_CAN_NAPI_DIS);
> +		napi_schedule(&priv->napi);
> +		handled =3D true;
> +	}
> +
> +out:
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static int men_z192_set_bittiming(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	const struct can_bittiming *bt =3D &priv->can.bittiming;
> +	unsigned long flags;
> +	u32 ctlbtr;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	ctlbtr =3D readl(&priv->regs->ctl_btr);
> +
> +	if (!(ctlbtr & MEN_Z192_CTL1_INITAK)) {
> +		netdev_alert(ndev,
> +			     "cannot set bittiminig while in running mode\n");
> +		ret =3D -EPERM;
> +		goto out_restore;
> +	}
> +
> +	ctlbtr &=3D ~(MEN_Z192_BTR0_BRP(0x3f) |
> +		    MEN_Z192_BTR0_SJW(0x03) |
> +		    MEN_Z192_BTR1_TSEG1(0x0f) |
> +		    MEN_Z192_BTR1_TSEG2(0x07) |
> +		    MEN_Z192_CTL1_LISTEN |
> +		    MEN_Z192_CTL1_LOOPB |
> +		    MEN_Z192_BTR1_SAMP);
> +
> +	ctlbtr |=3D MEN_Z192_BTR0_BRP(bt->brp - 1) |
> +		  MEN_Z192_BTR0_SJW(bt->sjw - 1) |
> +		  MEN_Z192_BTR1_TSEG1(bt->phase_seg1 + bt->prop_seg - 1) |
> +		  MEN_Z192_BTR1_TSEG2(bt->phase_seg2 - 1);

FIELD_PREP()

> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> +		ctlbtr |=3D MEN_Z192_BTR1_SAMP;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		ctlbtr |=3D MEN_Z192_CTL1_LISTEN;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		ctlbtr |=3D MEN_Z192_CTL1_LOOPB;
> +
> +	netdev_dbg(ndev, "CTL_BTR=3D0x%08x\n", ctlbtr);
> +
> +	writel(ctlbtr, &priv->regs->ctl_btr);
> +
> +out_restore:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return ret;
> +}
> +
> +static void men_z192_init_idac(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +
> +	/* hardware filtering (accept everything) */
> +	writel(0x00000000, &regs->idar_0_to_3);
> +	writel(0x00000000, &regs->idar_4_to_7);
> +	writel(0xffffffff, &regs->idmr_0_to_3);
> +	writel(0xffffffff, &regs->idmr_4_to_7);
> +}
> +
> +static void men_z192_set_can_state(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	enum can_state rx_state, tx_state;
> +	u32 status;
> +
> +	status =3D readl(&regs->rx_tx_sts);
> +
> +	rx_state =3D bus_state_map[MEN_Z192_GET_RSTATE(status)];
> +	tx_state =3D bus_state_map[MEN_Z192_GET_TSTATE(status)];
> +
> +	can_change_state(ndev, NULL, tx_state, rx_state);
> +}
> +
> +static int men_z192_start(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	int ret;
> +
> +	ret =3D men_z192_req_init_mode(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D men_z192_set_bittiming(ndev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D men_z192_req_run_mode(priv);
> +	if (ret)
> +		return ret;
> +
> +	men_z192_init_idac(ndev);
> +
> +	/* The 16z192 CAN IP does not reset the can bus state if we enter the=

> +	 * init mode. There is also no software reset to reset the state
> +	 * machine. We need to read the current state, and inform the upper
> +	 * layer about the current state.
> +	 */
> +	men_z192_set_can_state(ndev);
> +
> +	men_z192_set_int(priv, MEN_Z192_CAN_EN);
> +
> +	return 0;
> +}
> +
> +static int men_z192_open(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	int ret;
> +
> +	ret =3D open_candev(ndev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D request_irq(ndev->irq, men_z192_isr, IRQF_SHARED,
> +			  ndev->name, ndev);
> +	if (ret)
> +		goto out_close;
> +
> +	ret =3D men_z192_start(ndev);
> +	if (ret)
> +		goto out_free_irq;
> +
> +	napi_enable(&priv->napi);
> +	netif_start_queue(ndev);
> +
> +	can_led_event(ndev, CAN_LED_EVENT_OPEN);
> +
> +	return 0;
> +
> +out_free_irq:
> +	free_irq(ndev->irq, ndev);
> +out_close:
> +	close_candev(ndev);
> +	return ret;
> +}
> +
> +static int men_z192_stop(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	int ret;
> +
> +	men_z192_set_int(priv, MEN_Z192_CAN_DIS);
> +
> +	ret =3D men_z192_req_init_mode(priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +
> +	can_led_event(ndev, CAN_LED_EVENT_STOP);
> +
> +	return 0;
> +}
> +
> +static int men_z192_close(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	int ret;
> +
> +	netif_stop_queue(ndev);
> +
> +	napi_disable(&priv->napi);
> +
> +	ret =3D men_z192_stop(ndev);
> +
> +	free_irq(ndev->irq, ndev);
> +
> +	/* drop all outstanding echo skbs */
> +	skb_queue_purge(&priv->echoq);
> +
> +	close_candev(ndev);
> +
> +	return ret;
> +}
> +
> +static int men_z192_set_mode(struct net_device *ndev, enum can_mode mo=
de)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		ret =3D men_z192_start(ndev);
> +		if (ret)
> +			return ret;
> +
> +		netif_wake_queue(ndev);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct net_device_ops men_z192_netdev_ops =3D {
> +	.ndo_open	=3D men_z192_open,
> +	.ndo_stop	=3D men_z192_close,
> +	.ndo_start_xmit	=3D men_z192_xmit,
> +	.ndo_change_mtu	=3D can_change_mtu,
> +};
> +
> +static int men_z192_verify_buf_lvl(int buffer_lvl)
> +{
> +	if (buffer_lvl < MEN_Z192_MIN_BUF_LVL ||
> +	    buffer_lvl > MEN_Z192_MAX_BUF_LVL)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void men_z192_set_buf_lvl_irq(struct net_device *ndev, int rxlv=
l,
> +				     int txlvl)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	int reg_val;
> +
> +	if (men_z192_verify_buf_lvl(rxlvl))
> +		reg_val =3D MEN_Z192_RX_BUF_LVL_DEF & MEN_Z192_RX_BUF_LVL;
> +	else
> +		reg_val =3D rxlvl & MEN_Z192_RX_BUF_LVL;
> +
> +	if (men_z192_verify_buf_lvl(txlvl))
> +		reg_val |=3D (MEN_Z192_TX_BUF_LVL_DEF << 16) &
> +			    MEN_Z192_TX_BUF_LVL;
> +	else
> +		reg_val |=3D (txlvl << 16) & MEN_Z192_TX_BUF_LVL;
> +
> +	dev_info(priv->dev, "RX IRQ Level: %d TX IRQ Level: %d\n",
> +		 rxlvl, txlvl);
> +
> +	writel(reg_val, &regs->buf_lvl);
> +}
> +
> +static void men_z192_set_rx_tout(struct net_device *ndev, int tout)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	int reg_val;
> +
> +	if (tout < MEN_Z192_RX_TOUT_MIN || tout > MEN_Z192_RX_TOUT_MAX)
> +		reg_val =3D MEN_Z192_RX_TOUT_MAX;
> +	else
> +		reg_val =3D tout;
> +
> +	dev_info(priv->dev, "RX IRQ timeout set to: %d\n", reg_val);
> +
> +	writel(reg_val, &regs->rx_timeout);
> +}
> +
> +static int men_z192_register(struct net_device *ndev)
> +{
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +	struct men_z192_regs __iomem *regs =3D priv->regs;
> +	u32 ctl_btr;
> +	int ret;
> +
> +	/* The CAN controller should be always enabled.
> +	 * There is no way to enable it if disabled.
> +	 */
> +	ctl_btr =3D readl(&regs->ctl_btr);
> +	if (!(ctl_btr & MEN_Z192_CTL1_CANE))
> +		return -ENODEV;
> +
> +	men_z192_set_buf_lvl_irq(ndev, rxlvl, txlvl);
> +	men_z192_set_rx_tout(ndev, rx_timeout);
> +
> +	ret =3D men_z192_req_init_mode(priv);
> +	if (ret) {
> +		dev_err(priv->dev, "failed to request init mode\n");
> +		return ret;
> +	}
> +
> +	return register_candev(ndev);
> +}
> +
> +static int men_z192_probe(struct mcb_device *mdev,
> +			  const struct mcb_device_id *id)
> +{
> +	struct device *dev =3D &mdev->dev;
> +	struct men_z192 *priv;
> +	struct net_device *ndev;
> +	void __iomem *dev_base;
> +	struct resource *mem;
> +	u32 timebase;
> +	int ret =3D 0;
> +	int irq;
> +
> +	mem =3D mcb_request_mem(mdev, dev_name(dev));
> +	if (IS_ERR(mem)) {
> +		dev_err(dev, "failed to request device memory");
> +		return PTR_ERR(mem);
> +	}
> +
> +	dev_base =3D ioremap(mem->start, resource_size(mem));
> +	if (!dev_base) {
> +		dev_err(dev, "failed to ioremap device memory");
> +		ret =3D -ENXIO;
> +		goto out_release;
> +	}
> +
> +	irq =3D mcb_get_irq(mdev);
> +	if (irq <=3D 0) {
> +		ret =3D -ENODEV;
> +		goto out_unmap;
> +	}
> +
> +	ndev =3D alloc_candev(sizeof(struct men_z192), 0);
> +	if (!ndev) {
> +		dev_err(dev, "failed to allocat the can device");
> +		ret =3D -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	ndev->netdev_ops =3D &men_z192_netdev_ops;
> +	ndev->irq =3D irq;
> +	ndev->flags |=3D IFF_ECHO;
> +
> +	priv =3D netdev_priv(ndev);
> +	priv->ndev =3D ndev;
> +	priv->dev =3D dev;
> +
> +	priv->mem =3D mem;
> +	priv->dev_base =3D dev_base;
> +	priv->regs =3D priv->dev_base + MEN_Z192_REGS_OFFS;
> +
> +	timebase =3D readl(&priv->regs->timebase);
> +	if (!timebase) {
> +		dev_err(dev, "invalid timebase configured (timebase=3D%d)\n",
> +			timebase);
> +		ret =3D -EINVAL;
> +		goto out_free_candev;
> +	}
> +
> +	priv->can.clock.freq =3D timebase;
> +	priv->can.bittiming_const =3D &men_z192_bittiming_const;
> +	priv->can.do_set_mode =3D men_z192_set_mode;
> +	priv->can.do_get_berr_counter =3D men_z192_get_berr_counter;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY |
> +				       CAN_CTRLMODE_3_SAMPLES |
> +				       CAN_CTRLMODE_LOOPBACK;
> +
> +	spin_lock_init(&priv->lock);
> +
> +	netif_napi_add(ndev, &priv->napi, men_z192_poll,
> +		       NAPI_POLL_WEIGHT);
> +
> +	skb_queue_head_init(&priv->echoq);
> +
> +	mcb_set_drvdata(mdev, ndev);
> +	SET_NETDEV_DEV(ndev, dev);
> +
> +	ret =3D men_z192_register(ndev);
> +	if (ret) {
> +		dev_err(dev, "failed to register CAN device");
> +		goto out_free_candev;
> +	}
> +
> +	devm_can_led_init(ndev);
> +
> +	dev_info(dev, "MEN 16z192 CAN driver successfully registered\n");
> +
> +	return 0;
> +
> +out_free_candev:
> +	netif_napi_del(&priv->napi);
> +	free_candev(ndev);
> +out_unmap:
> +	iounmap(dev_base);
> +out_release:
> +	mcb_release_mem(mem);
> +	return ret;
> +}
> +
> +static void men_z192_remove(struct mcb_device *mdev)
> +{
> +	struct net_device *ndev =3D mcb_get_drvdata(mdev);
> +	struct men_z192 *priv =3D netdev_priv(ndev);
> +
> +	unregister_candev(ndev);
> +	netif_napi_del(&priv->napi);
> +
> +	iounmap(priv->dev_base);
> +	mcb_release_mem(priv->mem);
> +
> +	free_candev(ndev);
> +}
> +
> +static const struct mcb_device_id men_z192_ids[] =3D {
> +	{ .device =3D 0xc0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(mcb, men_z192_ids);
> +
> +static struct mcb_driver men_z192_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +		.owner =3D THIS_MODULE,
> +	},
> +	.probe =3D men_z192_probe,
> +	.remove =3D men_z192_remove,
> +	.id_table =3D men_z192_ids,
> +};
> +module_mcb_driver(men_z192_driver);
> +
> +MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
> +MODULE_DESCRIPTION("MEN 16z192 CAN Controller");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("mcb:16z192");
> +MODULE_IMPORT_NS(MCB);
>=20
> base-commit: dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--LKFEIsAtobeyEEKEomaceGrgicZGSIunw--

--aw9RU8CTFkhNUezL2MOq2heZ25T8OI5sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAl9ghXsACgkQqclaivrt
76mHPwgAoxrq453xz1CeHq3IpKZw7JB/DHt4dp7T+hKaWzpneUXgzrK13DlA2dpP
Twb8ARNZvoj8YaSUtP5CVWYCVbtFS5dNSG5y+eB1u/cFbvack39DFLLcqwJ8JnDz
0J225+tef50QHmvJQ71yjTaL07BlsTGFedeW0b0IOJvB4nyZjFM/hXiXzs+0st+A
o6vJL9zzACjrnqZ+p7rJ5/gO7EqXptTUUfKTrT0yk7FQ1OTAsiHWp5Thk++FT74Z
8k4hXGON1vFBwmYe9SRKVsh1frF1GqKPDqh94A/nRKqnRB7Q/afETpeBqXcFgn7H
1G81gtVYpezjFn6Uo4cFFDgKjyhAOg==
=LRjw
-----END PGP SIGNATURE-----

--aw9RU8CTFkhNUezL2MOq2heZ25T8OI5sr--
