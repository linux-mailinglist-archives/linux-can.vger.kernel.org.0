Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7783300208
	for <lists+linux-can@lfdr.de>; Fri, 22 Jan 2021 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbhAVLxj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 22 Jan 2021 06:53:39 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:11313 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728203AbhAVLJS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jan 2021 06:09:18 -0500
Received: from [100.113.6.248] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id 00/53-50748-881BA006; Fri, 22 Jan 2021 11:05:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRWlGSWpSXmKPExsUS8J9tom7HRq4
  Eg1t/uSxWfZ/KbLF+0RQWi6X3drI6MHt8vHSb0aP/r4HH501yAcxRrJl5SfkVCawZTy7uZSyY
  08lUsefUG8YGxov3GbsYuTiEBBoYJX4cO8fSxcjJISHgJ7F13lFGEFtIYA2jRO9mY4iie4wS8
  6e/ZAJJsAmYSax/8YwZxBYR0JX4sWke2CRmgYmMEt2Nv8ESwgLeEm+uLwVq4OBgEVCV+H5QAy
  TMK+Ag8bXvECPEMnmJ1RsOMEMs05RYc2oNM0RcQWLSrKdgrRICcRJf7phCtApKnJz5hAUkzAx
  Uvn6XPkiYWUBbYtnC18wQ1dYSEzcnQgxRk5i/uAtqEafE+w8fmCYwisxCMmgWwqBZSAYtYGRe
  xWiZVJSZnlGSm5iZo2toYKBraGisa6ZrZGKgl1ilm6SXWqqbnJpXUpQIlNVLLC/WK67MTc5J0
  ctLLdnECIyhlEK2DzsYp7z5oHeIUZKDSUmU9/0MrgQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKEr
  yXNwDlBItS01Mr0jJzgPEMk5bg4FES4b0NkuYtLkjMLc5Mh0idYrTkuL1hySJmjpvvQeTmuUs
  XMQux5OXnpUqJ89qCNAiANGSU5sGNg6WcS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEebtA
  pvBk5pXAbX0FdBAT0EH3H7GBHFSSiJCSamAK5TvtVTDtgFnmrMoFi4yPn3gyr4ZZaGvcw5dt4
  jaNb9JL5bfuj5LMZZAoZbqW+GXtu5Kcv87xZvNe3bjmdJnxutuuOufC+0emxBU5rAve+v3jqb
  Ne1T4dzmEXa+KVvtWkvzVrX6LLoPCmSDIjt6VPbT7vKvElKT+8MisefkrauEpkRpHFfK+gGe1
  H3pw3W7hspaHvqhte6zQOtP2Yqtr1Y1Gq3oSZPZKKacK3t8heK9SU2L7qV+D7fdnzn5asfc/s
  ufG4nuT+5XOV1/l8uxsqWTZpy/alrSmR1UIqgR2M3vd67jY5N0vf8zzm17zrxsUP4ud49m08I
  qO/2O/yjrlmlX37bJxPS/Bcz8p1vtOuxFKckWioxVxUnAgAtxFx5LQDAAA=
X-Env-Sender: Abhijeet.Badurkar@duagon.com
X-Msg-Ref: server-7.tower-246.messagelabs.com!1611313543!1518040!1
X-Originating-IP: [80.255.6.145]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14800 invoked from network); 22 Jan 2021 11:05:44 -0000
Received: from unknown (HELO keys.men.de) (80.255.6.145)
  by server-7.tower-246.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 22 Jan 2021 11:05:44 -0000
Received: from MEN-EX01.intra.men.de ([192.168.1.1])
  by keys.men.de (PGP Universal service);
  Fri, 22 Jan 2021 12:05:44 +0100
X-PGP-Universal: processed;
        by keys.men.de on Fri, 22 Jan 2021 12:05:44 +0100
Received: from MEN-EX01.intra.men.de (192.168.1.1) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Jan
 2021 12:05:42 +0100
Received: from abadurkar-HP-Z2-Tower-G4-Workstation.dev.men.de (10.64.14.204)
 by MEN-EX01.intra.men.de (192.168.1.1) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Jan 2021 12:05:42 +0100
From:   Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <andreas.geissler@duagon.com>,
        <stefan.schlosser@duagon.com>,
        Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
Subject: [PATCH v6] net: can: Introduce MEN 16Z192-00 CAN controller driver
Date:   Fri, 22 Jan 2021 12:05:33 +0100
Message-ID: <20210122110533.2728-1-abhijeet.badurkar@duagon.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [10.64.14.204]
X-ClientProxiedBy: MEN-EX01.intra.men.de (192.168.1.1) To
 MEN-EX01.intra.men.de (192.168.1.1)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-EXCLAIMER-MD-CONFIG: e4841e51-7998-49c0-ba41-8b8a0e2d8962
X-EXCLAIMER-MD-BIFURCATION-INSTANCE: 0
X-Loop: 2
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

﻿
	This CAN Controller is found on MEN Chameleon FPGAs.

	The driver/device supports the CAN2.0 specification.
	There are 255 RX and 255 Tx buffer within the IP. The
	pointer for the buffer are handled by HW to make the
	access from within the driver as simple as possible.

	The driver also supports parameters to configure the
	buffer level interrupt for RX/TX as well as a RX timeout
	interrupt using ethtool.

	With this configuration options, the driver/device
	provides flexibility for different types of usecases.

	Changes in version 2:
	Since the hardware does not have TX-done notification,
	the local loopback mechanism is implemented using ECHO skbs.
	The skb is added to echo stack, upon packet reception,
	received and echo skb are matched.

	LED trigger support is added.

	Changes in version 3:
	Fixed compiler warning.

	Changes in version 4:
	Implemented the module parameters using ethtool coalesce.
	Removed LED trigger implementation. Used FIELD_GET and
	FIELD_PREP for setting and getting register values. Replaced
	some hard-coded values with macros.

	Changes in version 5:
	Fixed compiler warning.

	Changes in version 6:
	Implemented polling mode and added parameter for polling interval.
	Note: Previous version of this path had sparse warning regarding
	iounmap function of openrisc architecture. Since this function is now
	fixed in mainline, sparse warning is removed.

Signed-off-by: Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
---
 drivers/net/can/Kconfig        |   10 +
 drivers/net/can/Makefile       |    1 +
 drivers/net/can/men_z192_can.c | 1150 ++++++++++++++++++++++++++++++++
 3 files changed, 1161 insertions(+)
 create mode 100644 drivers/net/can/men_z192_can.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 1c28eade6bec..bbf6e19e4797 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -134,6 +134,16 @@ config CAN_KVASER_PCIEFD
 	    Kvaser Mini PCI Express HS v2
 	    Kvaser Mini PCI Express 2xHS v2

+config CAN_MEN_Z192
+	depends on MCB
+	tristate "MEN 16Z192-00 CAN Controller"
+	  help
+	  Driver for MEN 16Z192-00 CAN Controller IP-Core, which
+	  is connected to the MEN Chameleon Bus.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called men_z192_can.ko.
+
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
 	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 22164300122d..d874ab1b9f08 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
 obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd.o
+obj-$(CONFIG_CAN_MEN_Z192)	+= men_z192_can.o
 obj-$(CONFIG_CAN_MSCAN)		+= mscan/
 obj-$(CONFIG_CAN_M_CAN)		+= m_can/
 obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
diff --git a/drivers/net/can/men_z192_can.c b/drivers/net/can/men_z192_can.c
new file mode 100644
index 000000000000..8a72ffc39508
--- /dev/null
+++ b/drivers/net/can/men_z192_can.c
@@ -0,0 +1,1150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* MEN 16Z192 CAN Controller driver
+ *
+ * Copyright (C) 2016 MEN Mikroelektronik GmbH (www.men.de)
+ *
+ * Local loopback implementation in this driver is adapted from Janz MODULbus
+ * VMOD-ICAN3 CAN Interface Driver
+ * Copyright (c) 2010 Ira W. Snyder <iws@ovro.caltech.edu>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/err.h>
+#include <linux/bitops.h>
+#include <linux/ethtool.h>
+#include <linux/netdevice.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+#include <linux/can/led.h>
+#include <linux/mcb.h>
+#include <linux/bitfield.h>
+
+#define DRV_NAME    "z192_can"
+
+#define MEN_Z192_MODE_TOUT_US		40
+#define MEN_Z192_READ_POLL_TIMEOUT	10
+
+/* CTL/BTR Register Bits */
+#define MEN_Z192_CTL0_INITRQ		BIT(0)
+#define MEN_Z192_CTL0_SLPRQ		BIT(1)
+#define MEN_Z192_CTL1_INITAK		BIT(8)
+#define MEN_Z192_CTL1_SLPAK		BIT(9)
+#define MEN_Z192_CTL1_LISTEN		BIT(12)
+#define MEN_Z192_CTL1_LOOPB		BIT(13)
+#define MEN_Z192_CTL1_CANE		BIT(15)
+#define MEN_Z192_BTR0_BRP		GENMASK(21, 16)
+#define MEN_Z192_BTR0_SJW		GENMASK(23, 22)
+#define MEN_Z192_BTR1_TSEG1		GENMASK(27, 24)
+#define MEN_Z192_BTR1_TSEG2		GENMASK(30, 28)
+#define MEN_Z192_BTR1_SAMP		BIT(31)
+
+/* IER Interrupt Enable Register bits */
+#define MEN_Z192_RXIE			BIT(0)
+#define MEN_Z192_OVRIE			BIT(1)
+#define MEN_Z192_CSCIE			BIT(6)
+#define MEN_Z192_TOUTE			BIT(7)
+#define MEN_Z192_TXIE			BIT(16)
+#define MEN_Z192_ERRIE			BIT(17)
+
+#define MEN_Z192_INTE_ALL		(MEN_Z192_RXIE |	\
+					 MEN_Z192_OVRIE |	\
+					 MEN_Z192_CSCIE |	\
+					 MEN_Z192_TOUTE |	\
+					 MEN_Z192_TXIE)
+
+#define MEN_Z192_INTE_NAPI		(MEN_Z192_RXIE | MEN_Z192_TOUTE)
+
+/* RX_TX_STAT RX/TX status register bits */
+#define MEN_Z192_RX_BUF_CNT		GENMASK(7, 0)
+#define MEN_Z192_TX_BUF_CNT		GENMASK(15, 8)
+#define	MEN_Z192_RFLG_RXIF		BIT(16)
+#define	MEN_Z192_RFLG_OVRF		BIT(17)
+#define	MEN_Z192_RFLG_TSTATE		GENMASK(19, 18)
+#define	MEN_Z192_RFLG_RSTATE		GENMASK(21, 20)
+#define	MEN_Z192_RFLG_CSCIF		BIT(22)
+#define	MEN_Z192_RFLG_TOUTF		BIT(23)
+#define MEN_Z192_TFLG_TXIF		BIT(24)
+
+#define MEN_Z192_GET_TSTATE(x)		FIELD_GET(MEN_Z192_RFLG_TSTATE, x)
+#define MEN_Z192_GET_RSTATE(x)		FIELD_GET(MEN_Z192_RFLG_RSTATE, x)
+
+#define MEN_Z192_RFLG_ALL		(MEN_Z192_RFLG_RXIF |	\
+					MEN_Z192_RFLG_OVRF |	\
+					MEN_Z192_RFLG_TSTATE |	\
+					MEN_Z192_RFLG_RSTATE |	\
+					MEN_Z192_RFLG_CSCIF |	\
+					MEN_Z192_RFLG_TOUTF |	\
+					MEN_Z192_TFLG_TXIF)
+
+/* RX/TX Error counter bits */
+#define MEN_Z192_GET_RX_ERR_CNT		GENMASK(7, 0)
+#define MEN_Z192_GET_TX_ERR_CNT		GENMASK(23, 16)
+
+/* Buffer level register bits */
+#define MEN_Z192_RX_BUF_LVL		GENMASK(15, 0)
+#define MEN_Z192_TX_BUF_LVL		GENMASK(31, 16)
+
+/* RX/TX Buffer register bits */
+#define MEN_Z192_CFBUF_LEN		GENMASK(3, 0)
+#define MEN_Z192_CFBUF_ID_11_BITS	GENMASK(31, 21)
+#define MEN_Z192_CFBUF_ID_18_BITS	GENMASK(18, 1)
+#define MEN_Z192_CFBUF_TS		GENMASK(31, 8)
+#define MEN_Z192_CFBUF_E_RTR		BIT(0)
+#define MEN_Z192_CFBUF_IDE		BIT(19)
+#define MEN_Z192_CFBUF_SRR		BIT(20)
+#define MEN_Z192_CFBUF_S_RTR		BIT(20)
+
+/* Global register offsets */
+#define MEN_Z192_RX_BUF_START		0x0000
+#define MEN_Z192_TX_BUF_START		0x1000
+#define MEN_Z192_REGS_OFFS		0x2000
+
+/* Buffer level control values */
+#define MEN_Z192_MIN_BUF_LVL		0
+#define MEN_Z192_MAX_BUF_LVL		254
+#define MEN_Z192_RX_BUF_LVL_DEF		5
+#define MEN_Z192_TX_BUF_LVL_DEF		5
+#define MEN_Z192_RX_TOUT_MIN		0
+#define MEN_Z192_RX_TOUT_MAX		65535
+#define MEN_Z192_RX_TOUT_DEF		1000
+
+#define MEN_Z192_CAN_ID_11_BITS		GENMASK(28, 18)
+#define MEN_Z192_CAN_ID_18_BITS		GENMASK(17, 0)
+
+/* Polling interval */
+#define MEN_Z192_POLL_INTERVAL_DEF	0
+
+static int poll_interval = MEN_Z192_POLL_INTERVAL_DEF;
+module_param(poll_interval, int, 0444);
+MODULE_PARM_DESC(poll_interval, "Poll interval (msec), default="
+		 __MODULE_STRING(MEN_Z192_POLL_INTERVAL_DEF) ")");
+
+struct men_z192_regs {
+	u32 ctl_btr;		/* Control and bus timing register */
+	u32 ier;                /* Interrupt enable register */
+	u32 buf_lvl;            /* Buffer level register */
+	u32 rxa;                /* RX Data acknowledge register */
+	u32 txa;                /* TX data acknowledge register */
+	u32 rx_tx_sts;          /* RX/TX flags and buffer level */
+	u32 ovr_ecc_sts;        /* Overrun/ECC status register */
+	u32 idac_ver;           /* ID acceptance control / version */
+	u32 rx_tx_err;          /* RX/TX error counter register */
+	u32 idar_0_to_3;        /* ID acceptance register 0...3 */
+	u32 idar_4_to_7;        /* ID acceptance register 4...7 */
+	u32 idmr_0_to_3;        /* ID mask register 0...3 */
+	u32 idmr_4_to_7;        /* ID mask register 4...7 */
+	u32 rx_timeout;		/* receive timeout */
+	u32 timebase;		/* Base frequency for baudrate calculation */
+};
+
+struct men_z192 {
+	struct can_priv can;
+	struct napi_struct napi;
+	struct net_device *ndev;
+	struct device *dev;
+
+	/* Lock for CTL_BTR register access. This register combines bittiming
+	 * bits and the operation mode bits. It is also used for bit r/m/w
+	 * access to all registers.
+	 */
+	spinlock_t lock;
+	struct resource *mem;
+	struct men_z192_regs __iomem *regs;
+	void __iomem *dev_base;
+
+	int txlvl;
+
+	/* Following parameters related to RX interrupt have impact on latency
+	 * and provide the users full control over them.
+	 *
+	 * rxlvl: Receive buffer level or in other words, the number of frames
+	 * to trigger RX interrupt
+	 * When number of received valid CAN frames exceeds rxlvl and RX
+	 * interrupt is enabled, an interrupt will be generated. For example,
+	 * if rxlvl is 0 and one frame is received, an interrupt will be
+	 * generated or if rxlvl is 254 and 255 frames are received, an
+	 * interrupt will be generated.
+	 *
+	 * rx_timeout: Read timeout for receive buffer
+	 * When receive buffer is not empty and it has not been accessed since
+	 * rx_timeout then TOUTF flag is set. If RX interrupt was already
+	 * enabled and TOUTF flag is set, a RX interrupt will be generated.
+	 * By defining this parameter, time of the interrupt generation can be
+	 * controlled, if the RX buffer level is not reached within rx_timeout.
+	 *
+	 * When an interrupt is generated for either of these parameters, NAPI
+	 * poll is scheduled to read the recived CAN frames.
+	 */
+	int rxlvl;
+	int rx_timeout;
+
+	/* queue for echo packets */
+	struct sk_buff_head echoq;
+
+	struct hrtimer poll_timer;
+};
+
+struct men_z192_cf_buf {
+	u32 can_id;
+	u32 data[2];
+	u32 length;
+};
+
+enum men_z192_int_state {
+	MEN_Z192_CAN_DIS = 0,
+	MEN_Z192_CAN_EN,
+	MEN_Z192_CAN_NAPI_DIS,
+	MEN_Z192_CAN_NAPI_EN,
+};
+
+static const enum can_state bus_state_map[] = {
+	CAN_STATE_ERROR_ACTIVE,
+	CAN_STATE_ERROR_WARNING,
+	CAN_STATE_ERROR_PASSIVE,
+	CAN_STATE_BUS_OFF
+};
+
+static const struct can_bittiming_const men_z192_bittiming_const = {
+	.name = DRV_NAME,
+	.tseg1_min = 4,
+	.tseg1_max = 16,
+	.tseg2_min = 2,
+	.tseg2_max = 8,
+	.sjw_max = 4,
+	.brp_min = 2,
+	.brp_max = 64,
+	.brp_inc = 1,
+};
+
+static inline void men_z192_bit_clr(struct men_z192 *priv, void __iomem *addr,
+				    u32 mask)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	val = readl(addr);
+	val &= ~mask;
+	writel(val, addr);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static inline void men_z192_bit_set(struct men_z192 *priv, void __iomem *addr,
+				    u32 mask)
+{
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	val = readl(addr);
+	val |= mask;
+	writel(val, addr);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static inline void men_z192_ack_rx_pkg(struct men_z192 *priv,
+				       unsigned int count)
+{
+	writel(count, &priv->regs->rxa);
+}
+
+static inline void men_z192_ack_tx_pkg(struct men_z192 *priv,
+				       unsigned int count)
+{
+	writel(count, &priv->regs->txa);
+}
+
+static void men_z192_set_int(struct men_z192 *priv,
+			     enum men_z192_int_state state)
+{
+	struct men_z192_regs __iomem *regs = priv->regs;
+
+	if (priv->ndev->irq == 0) {
+		/* don't enable any interrupts at all */
+		state = MEN_Z192_CAN_DIS;
+	}
+
+	switch (state) {
+	case MEN_Z192_CAN_DIS:
+		men_z192_bit_clr(priv, &regs->ier, MEN_Z192_INTE_ALL);
+		break;
+
+	case MEN_Z192_CAN_EN:
+		men_z192_bit_set(priv, &regs->ier, MEN_Z192_INTE_ALL);
+		break;
+
+	case MEN_Z192_CAN_NAPI_DIS:
+		men_z192_bit_clr(priv, &regs->ier, MEN_Z192_INTE_NAPI);
+		break;
+
+	case MEN_Z192_CAN_NAPI_EN:
+		men_z192_bit_set(priv, &regs->ier, MEN_Z192_INTE_NAPI);
+		break;
+
+	default:
+		netdev_err(priv->ndev, "invalid interrupt state\n");
+		break;
+	}
+}
+
+static int men_z192_get_berr_counter(const struct net_device *ndev,
+				     struct can_berr_counter *bec)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	u32 err_cnt;
+
+	err_cnt = readl(&regs->rx_tx_err);
+
+	bec->txerr = FIELD_GET(MEN_Z192_GET_TX_ERR_CNT, err_cnt);
+	bec->rxerr = FIELD_GET(MEN_Z192_GET_RX_ERR_CNT, err_cnt);
+
+	return 0;
+}
+
+static int men_z192_req_run_mode(struct men_z192 *priv)
+{
+	struct men_z192_regs __iomem *regs = priv->regs;
+	u32 val;
+
+	men_z192_bit_clr(priv, &regs->ctl_btr, MEN_Z192_CTL0_INITRQ);
+
+	return read_poll_timeout(readl, val, !(val & MEN_Z192_CTL1_INITAK),
+				 MEN_Z192_READ_POLL_TIMEOUT,
+				 MEN_Z192_MODE_TOUT_US, 0, &regs->ctl_btr);
+}
+
+static int men_z192_req_init_mode(struct men_z192 *priv)
+{
+	struct men_z192_regs __iomem *regs = priv->regs;
+	u32 val;
+
+	men_z192_bit_set(priv, &regs->ctl_btr, MEN_Z192_CTL0_INITRQ);
+
+	return read_poll_timeout(readl, val, val & MEN_Z192_CTL1_INITAK,
+				 MEN_Z192_READ_POLL_TIMEOUT,
+				 MEN_Z192_MODE_TOUT_US, 0, &regs->ctl_btr);
+}
+
+static void z192_put_echo_skb(struct men_z192 *priv, struct sk_buff *skb)
+{
+	skb = can_create_echo_skb(skb);
+	if (!skb)
+		return;
+
+	/* save this skb for tx interrupt echo handling */
+	skb_queue_tail(&priv->echoq, skb);
+}
+
+static unsigned int z192_get_echo_skb(struct men_z192 *priv)
+{
+	struct sk_buff *skb = skb_dequeue(&priv->echoq);
+	struct can_frame *cf;
+	u8 dlc;
+
+	/* this should never trigger unless there is a driver bug */
+	if (!skb) {
+		netdev_err(priv->ndev, "BUG: echo skb not occupied\n");
+		return 0;
+	}
+
+	cf = (struct can_frame *)skb->data;
+	dlc = cf->can_dlc;
+
+	/* check flag whether this packet has to be looped back */
+	if (skb->pkt_type != PACKET_LOOPBACK) {
+		kfree_skb(skb);
+		return dlc;
+	}
+
+	skb->protocol = htons(ETH_P_CAN);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	skb->dev = priv->ndev;
+	netif_receive_skb(skb);
+	return dlc;
+}
+
+static bool z192_echo_skb_matches(struct men_z192 *priv, struct sk_buff *skb)
+{
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct sk_buff *echo_skb = skb_peek(&priv->echoq);
+	struct can_frame *echo_cf;
+
+	if (!echo_skb)
+		return false;
+
+	echo_cf = (struct can_frame *)echo_skb->data;
+	if (cf->can_id != echo_cf->can_id)
+		return false;
+
+	if (cf->can_dlc != echo_cf->can_dlc)
+		return false;
+
+	return memcmp(cf->data, echo_cf->data, cf->can_dlc) == 0;
+}
+
+static int men_z192_read_frame(struct net_device *ndev, unsigned int frame_nr)
+{
+	struct net_device_stats *stats = &ndev->stats;
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_cf_buf __iomem *cf_buf;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	u32 cf_offset;
+	u32 length;
+	u32 id;
+	u16 id_11_bits;
+	u32 id_18_bits;
+
+	skb = alloc_can_skb(ndev, &cf);
+	if (unlikely(!skb)) {
+		stats->rx_dropped++;
+		return 0;
+	}
+
+	cf_offset = sizeof(struct men_z192_cf_buf) * frame_nr;
+
+	cf_buf = priv->dev_base + MEN_Z192_RX_BUF_START + cf_offset;
+	length = readl(&cf_buf->length) & MEN_Z192_CFBUF_LEN;
+	id = readl(&cf_buf->can_id);
+
+	if (id & MEN_Z192_CFBUF_IDE) {
+		/* Extended frame */
+		id_11_bits = FIELD_GET(MEN_Z192_CFBUF_ID_11_BITS, id);
+		id_18_bits = FIELD_GET(MEN_Z192_CFBUF_ID_18_BITS, id);
+
+		cf->can_id = FIELD_PREP(MEN_Z192_CAN_ID_11_BITS, id_11_bits) |
+			     FIELD_PREP(MEN_Z192_CAN_ID_18_BITS, id_18_bits) |
+			     CAN_EFF_FLAG;
+
+		if (id & MEN_Z192_CFBUF_E_RTR)
+			cf->can_id |= CAN_RTR_FLAG;
+	} else {
+		/* Standard frame */
+		cf->can_id = FIELD_GET(MEN_Z192_CFBUF_ID_11_BITS, id);
+
+		if (id & MEN_Z192_CFBUF_S_RTR)
+			cf->can_id |= CAN_RTR_FLAG;
+	}
+
+	cf->can_dlc = can_cc_dlc2len(length);
+
+	/* remote transmission request frame contains no data field even if the
+	 * data length is set to a value > 0
+	 */
+	if (!(cf->can_id & CAN_RTR_FLAG) && cf->can_dlc) {
+		*(__be32 *)cf->data = cpu_to_be32(readl(&cf_buf->data[0]));
+		if (cf->can_dlc > 4)
+			*(__be32 *)(cf->data + 4) =
+			cpu_to_be32(readl(&cf_buf->data[1]));
+	}
+
+	if (z192_echo_skb_matches(priv, skb)) {
+		stats->tx_packets++;
+		stats->tx_bytes += z192_get_echo_skb(priv);
+		kfree_skb(skb);
+		return 1;
+	}
+
+	stats->rx_bytes += cf->can_dlc;
+	stats->rx_packets++;
+	netif_receive_skb(skb);
+
+	return 1;
+}
+
+static int men_z192_poll(struct napi_struct *napi, int quota)
+{
+	struct net_device *ndev = napi->dev;
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	int work_done = 0;
+	u32 frame_cnt;
+	u32 status;
+
+	status = readl(&regs->rx_tx_sts);
+
+	frame_cnt = FIELD_GET(MEN_Z192_RX_BUF_CNT, status);
+
+	while (frame_cnt-- && (work_done < quota)) {
+		work_done += men_z192_read_frame(ndev, 0);
+		men_z192_ack_rx_pkg(priv, 1);
+	}
+
+	if (work_done < quota) {
+		napi_complete(napi);
+		men_z192_set_int(priv, MEN_Z192_CAN_NAPI_EN);
+	}
+
+	return work_done;
+}
+
+static int men_z192_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	struct men_z192_cf_buf __iomem *cf_buf;
+	int status;
+	u32 id;
+	u16 id_11_bits;
+	u32 id_18_bits;
+
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
+	status = readl(&regs->rx_tx_sts);
+
+	if (FIELD_GET(MEN_Z192_TX_BUF_CNT, status) == MEN_Z192_MAX_BUF_LVL) {
+		netif_stop_queue(ndev);
+		netdev_err(ndev, "not enough space in TX buffer\n");
+
+		return NETDEV_TX_BUSY;
+	}
+
+	cf_buf = priv->dev_base + MEN_Z192_TX_BUF_START;
+
+	if (cf->can_id & CAN_EFF_FLAG) {
+		/* Extended frame */
+		id = cf->can_id & CAN_EFF_MASK;
+		id_11_bits = FIELD_GET(MEN_Z192_CAN_ID_11_BITS, id);
+		id_18_bits = FIELD_GET(MEN_Z192_CAN_ID_18_BITS, id);
+
+		id = FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, id_11_bits) |
+		     MEN_Z192_CFBUF_SRR |
+		     MEN_Z192_CFBUF_IDE |
+		     FIELD_PREP(MEN_Z192_CFBUF_ID_18_BITS, id_18_bits);
+
+		if (cf->can_id & CAN_RTR_FLAG)
+			id |= MEN_Z192_CFBUF_E_RTR;
+	} else {
+		/* Standard frame */
+		id = FIELD_PREP(MEN_Z192_CFBUF_ID_11_BITS, cf->can_id);
+
+		if (cf->can_id & CAN_RTR_FLAG)
+			id |= MEN_Z192_CFBUF_S_RTR;
+	}
+
+	writel(id, &cf_buf->can_id);
+	writel(cf->can_dlc, &cf_buf->length);
+
+	if (!(cf->can_id & CAN_RTR_FLAG) && cf->can_dlc) {
+		writel(be32_to_cpup((__be32 *)(cf->data)), &cf_buf->data[0]);
+		if (cf->can_dlc > 4)
+			writel(be32_to_cpup((__be32 *)(cf->data + 4)),
+			       &cf_buf->data[1]);
+	}
+
+	/* The 16z192 CAN IP doesn't have TX-done interrupts, so local
+	 * loopback is emulated using ECHO skbs. Add the skb to the ECHO
+	 * stack. Upon packet reception, check if the ECHO skb and received
+	 * skb match, and use that to wake the queue.
+	 */
+	z192_put_echo_skb(priv, skb);
+
+	/* be sure everything is written to the
+	 * device before acknowledge the data.
+	 */
+	wmb();
+
+	/* Acknowldege the written data in TXBUF by writing to TXA
+	 * i.e. transmit data acknowledge register.
+	 */
+	men_z192_ack_tx_pkg(priv, 1);
+
+	return NETDEV_TX_OK;
+}
+
+static void men_z192_handle_err(struct net_device *ndev, u32 status)
+{
+	struct net_device_stats *stats = &ndev->stats;
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct can_berr_counter bec;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	enum can_state rx_state = 0, tx_state = 0;
+
+	skb = alloc_can_err_skb(ndev, &cf);
+	if (unlikely(!skb)) {
+		stats->rx_dropped++;
+		return;
+	}
+
+	/* put the rx/tx error counter to
+	 * the additional controller specific
+	 * section of the error frame.
+	 */
+	men_z192_get_berr_counter(ndev, &bec);
+	cf->data[6] = bec.txerr;
+	cf->data[7] = bec.rxerr;
+
+	/* overrun interrupt */
+	if (status & MEN_Z192_RFLG_OVRF) {
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+	}
+
+	/* bus change interrupt */
+	if (status & MEN_Z192_RFLG_CSCIF) {
+		rx_state = bus_state_map[MEN_Z192_GET_RSTATE(status)];
+		tx_state = bus_state_map[MEN_Z192_GET_TSTATE(status)];
+
+		can_change_state(ndev, cf, tx_state, rx_state);
+
+		if (priv->can.state == CAN_STATE_BUS_OFF)
+			can_bus_off(ndev);
+	}
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+	netif_receive_skb(skb);
+}
+
+static bool men_z192_handle(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	bool handled = false;
+	u32 flags;
+	u32 status;
+
+	status = readl(&regs->rx_tx_sts);
+	flags = status & MEN_Z192_RFLG_ALL;
+	if (!flags)
+		goto out;
+
+	/* It is safe to write to RX_TS_STS[15:0] */
+	writel(flags, &regs->rx_tx_sts);
+
+	if (flags & MEN_Z192_TFLG_TXIF) {
+		netif_wake_queue(ndev);
+		handled = true;
+	}
+
+	/* handle errors */
+	if ((flags & MEN_Z192_RFLG_OVRF) ||
+	    (flags & MEN_Z192_RFLG_CSCIF)) {
+		men_z192_handle_err(ndev, status);
+		handled = true;
+	}
+
+	/* schedule NAPI if:
+	 * - rx IRQ
+	 * - rx timeout IRQ
+	 */
+	if ((flags & MEN_Z192_RFLG_RXIF) ||
+	    (flags & MEN_Z192_RFLG_TOUTF)) {
+		men_z192_set_int(priv, MEN_Z192_CAN_NAPI_DIS);
+		napi_schedule(&priv->napi);
+		handled = true;
+	}
+
+out:
+	return handled;
+}
+
+static irqreturn_t men_z192_isr(int irq, void *dev_id)
+{
+	struct net_device *ndev = dev_id;
+	bool handled;
+
+	handled = men_z192_handle(ndev);
+
+	return IRQ_RETVAL(handled);
+}
+
+static int men_z192_set_bittiming(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	unsigned long flags;
+	u32 ctlbtr;
+	int ret = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	ctlbtr = readl(&priv->regs->ctl_btr);
+
+	if (!(ctlbtr & MEN_Z192_CTL1_INITAK)) {
+		netdev_alert(ndev,
+			     "cannot set bittiminig while in running mode\n");
+		ret = -EPERM;
+		goto out_restore;
+	}
+
+	ctlbtr &= ~(MEN_Z192_BTR0_BRP |
+		    MEN_Z192_BTR0_SJW |
+		    MEN_Z192_BTR1_TSEG1 |
+		    MEN_Z192_BTR1_TSEG2 |
+		    MEN_Z192_CTL1_LISTEN |
+		    MEN_Z192_CTL1_LOOPB |
+		    MEN_Z192_BTR1_SAMP);
+
+	ctlbtr |= FIELD_PREP(MEN_Z192_BTR0_BRP, bt->brp - 1) |
+		  FIELD_PREP(MEN_Z192_BTR0_SJW, bt->sjw - 1) |
+		  FIELD_PREP(MEN_Z192_BTR1_TSEG1,
+			     bt->phase_seg1 + bt->prop_seg - 1) |
+		  FIELD_PREP(MEN_Z192_BTR1_TSEG2, bt->phase_seg2 - 1);
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		ctlbtr |= MEN_Z192_BTR1_SAMP;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		ctlbtr |= MEN_Z192_CTL1_LISTEN;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		ctlbtr |= MEN_Z192_CTL1_LOOPB;
+
+	writel(ctlbtr, &priv->regs->ctl_btr);
+
+out_restore:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
+static void men_z192_init_idac(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+
+	/* hardware filtering (accept everything) */
+	writel(0x00000000, &regs->idar_0_to_3);
+	writel(0x00000000, &regs->idar_4_to_7);
+	writel(0xffffffff, &regs->idmr_0_to_3);
+	writel(0xffffffff, &regs->idmr_4_to_7);
+}
+
+static void men_z192_set_can_state(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	enum can_state rx_state, tx_state;
+	u32 status;
+
+	status = readl(&regs->rx_tx_sts);
+
+	rx_state = bus_state_map[MEN_Z192_GET_RSTATE(status)];
+	tx_state = bus_state_map[MEN_Z192_GET_TSTATE(status)];
+
+	can_change_state(ndev, NULL, tx_state, rx_state);
+}
+
+static enum hrtimer_restart men_z192_timer_poll(struct hrtimer *timer)
+{
+	struct men_z192 *priv = container_of(timer, struct men_z192,
+					     poll_timer);
+
+	men_z192_handle(priv->ndev);
+
+	hrtimer_forward_now(timer, poll_interval * 1000);
+	return HRTIMER_RESTART;
+}
+
+static int men_z192_start(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	int ret;
+
+	ret = men_z192_req_init_mode(priv);
+	if (ret)
+		return ret;
+
+	ret = men_z192_set_bittiming(ndev);
+	if (ret)
+		return ret;
+
+	ret = men_z192_req_run_mode(priv);
+	if (ret)
+		return ret;
+
+	men_z192_init_idac(ndev);
+
+	/* The 16z192 CAN IP does not reset the can bus state if we enter the
+	 * init mode. There is also no software reset to reset the state
+	 * machine. We need to read the current state, and inform the upper
+	 * layer about the current state.
+	 */
+	men_z192_set_can_state(ndev);
+
+	men_z192_set_int(priv, MEN_Z192_CAN_EN);
+
+	hrtimer_init(&priv->poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	priv->poll_timer.function = men_z192_timer_poll;
+
+	if (ndev->irq == 0)
+		hrtimer_start(&priv->poll_timer, poll_interval * 1000,
+			      HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static int men_z192_open(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	bool got_irq = false;
+	int ret;
+
+	ret = open_candev(ndev);
+	if (ret)
+		return ret;
+
+	if (ndev->irq > 0) {
+		ret = request_irq(ndev->irq, men_z192_isr, IRQF_SHARED,
+				  ndev->name, ndev);
+		if (ret)
+			goto out;
+		got_irq = true;
+	}
+
+	ret = men_z192_start(ndev);
+	if (ret)
+		goto out;
+
+	napi_enable(&priv->napi);
+	netif_start_queue(ndev);
+
+	return 0;
+out:
+	if (got_irq)
+		free_irq(ndev->irq, ndev);
+
+	close_candev(ndev);
+	return ret;
+}
+
+static int men_z192_stop(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	int ret;
+
+	hrtimer_cancel(&priv->poll_timer);
+
+	men_z192_set_int(priv, MEN_Z192_CAN_DIS);
+
+	ret = men_z192_req_init_mode(priv);
+	if (ret)
+		return ret;
+
+	priv->can.state = CAN_STATE_STOPPED;
+
+	return 0;
+}
+
+static int men_z192_close(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	int ret;
+
+	netif_stop_queue(ndev);
+
+	napi_disable(&priv->napi);
+
+	ret = men_z192_stop(ndev);
+
+	if (ndev->irq > 0)
+		free_irq(ndev->irq, ndev);
+
+	/* drop all outstanding echo skbs */
+	skb_queue_purge(&priv->echoq);
+
+	close_candev(ndev);
+
+	return ret;
+}
+
+static int men_z192_set_mode(struct net_device *ndev, enum can_mode mode)
+{
+	int ret;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		ret = men_z192_start(ndev);
+		if (ret)
+			return ret;
+
+		netif_wake_queue(ndev);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct net_device_ops men_z192_netdev_ops = {
+	.ndo_open	= men_z192_open,
+	.ndo_stop	= men_z192_close,
+	.ndo_start_xmit	= men_z192_xmit,
+	.ndo_change_mtu	= can_change_mtu,
+};
+
+static int men_z192_verify_buf_lvl(int buffer_lvl)
+{
+	if (buffer_lvl < MEN_Z192_MIN_BUF_LVL ||
+	    buffer_lvl > MEN_Z192_MAX_BUF_LVL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void men_z192_set_buf_lvl_irq(struct net_device *ndev, int rxlvl,
+				     int txlvl)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	int reg_val;
+
+	if (men_z192_verify_buf_lvl(rxlvl))
+		reg_val = MEN_Z192_RX_BUF_LVL_DEF & MEN_Z192_RX_BUF_LVL;
+	else
+		reg_val = rxlvl & MEN_Z192_RX_BUF_LVL;
+
+	if (men_z192_verify_buf_lvl(txlvl))
+		reg_val |= (MEN_Z192_TX_BUF_LVL_DEF << 16) &
+			    MEN_Z192_TX_BUF_LVL;
+	else
+		reg_val |= (txlvl << 16) & MEN_Z192_TX_BUF_LVL;
+
+	dev_info(priv->dev, "RX IRQ Level: %d TX IRQ Level: %d\n",
+		 rxlvl, txlvl);
+
+	writel(reg_val, &regs->buf_lvl);
+
+	priv->txlvl = txlvl;
+	priv->rxlvl = rxlvl;
+}
+
+static void men_z192_set_rx_tout(struct net_device *ndev, int tout)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	int reg_val;
+
+	if (tout < MEN_Z192_RX_TOUT_MIN || tout > MEN_Z192_RX_TOUT_MAX)
+		reg_val = MEN_Z192_RX_TOUT_MAX;
+	else
+		reg_val = tout;
+
+	dev_info(priv->dev, "RX IRQ timeout set to: %d\n", reg_val);
+
+	writel(reg_val, &regs->rx_timeout);
+
+	priv->rx_timeout = reg_val;
+}
+
+static int men_z192_get_coalesce(struct net_device *ndev,
+				 struct ethtool_coalesce *ec)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+
+	memset(ec, 0, sizeof(struct ethtool_coalesce));
+
+	ec->tx_max_coalesced_frames = priv->txlvl;
+	ec->rx_max_coalesced_frames = priv->rxlvl;
+	ec->rx_coalesce_usecs = priv->rx_timeout;
+
+	return 0;
+}
+
+static int men_z192_set_coalesce(struct net_device *ndev,
+				 struct ethtool_coalesce *ec)
+{
+	men_z192_set_buf_lvl_irq(ndev, ec->rx_max_coalesced_frames,
+				 ec->tx_max_coalesced_frames);
+
+	men_z192_set_rx_tout(ndev, ec->rx_coalesce_usecs);
+
+	return 0;
+}
+
+static void men_z192_init_coalesce(struct net_device *ndev)
+{
+	men_z192_set_buf_lvl_irq(ndev, MEN_Z192_MIN_BUF_LVL,
+				 MEN_Z192_MIN_BUF_LVL);
+	men_z192_set_rx_tout(ndev, MEN_Z192_RX_TOUT_DEF);
+}
+
+static int men_z192_register(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	u32 ctl_btr;
+	int ret;
+
+	/* The CAN controller should be always enabled.
+	 * There is no way to enable it if disabled.
+	 */
+	ctl_btr = readl(&regs->ctl_btr);
+	if (!(ctl_btr & MEN_Z192_CTL1_CANE))
+		return -ENODEV;
+
+	men_z192_init_coalesce(ndev);
+
+	ret = men_z192_req_init_mode(priv);
+	if (ret) {
+		dev_err(priv->dev, "failed to request init mode\n");
+		return ret;
+	}
+
+	return register_candev(ndev);
+}
+
+static const struct ethtool_ops men_z192_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES,
+	.get_coalesce = men_z192_get_coalesce,
+	.set_coalesce = men_z192_set_coalesce,
+};
+
+static int men_z192_probe(struct mcb_device *mdev,
+			  const struct mcb_device_id *id)
+{
+	struct device *dev = &mdev->dev;
+	struct men_z192 *priv;
+	struct net_device *ndev;
+	void __iomem *dev_base;
+	struct resource *mem;
+	u32 timebase;
+	int ret = 0;
+
+	mem = mcb_request_mem(mdev, dev_name(dev));
+	if (IS_ERR(mem)) {
+		dev_err(dev, "failed to request device memory\n");
+		return PTR_ERR(mem);
+	}
+
+	dev_base = ioremap(mem->start, resource_size(mem));
+	if (!dev_base) {
+		dev_err(dev, "failed to ioremap device memory\n");
+		ret = -ENXIO;
+		goto out_release;
+	}
+
+	ndev = alloc_candev(sizeof(struct men_z192), 0);
+	if (!ndev) {
+		dev_err(dev, "failed to allocate can device\n");
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	if (poll_interval > 0) {
+		ndev->irq = 0;
+	} else {
+		ndev->irq = mcb_get_irq(mdev);
+		if (ndev->irq <= 0) {
+			ret = -ENODEV;
+			goto out_free_candev;
+		}
+	}
+
+	ndev->netdev_ops = &men_z192_netdev_ops;
+	ndev->flags |= IFF_ECHO;
+
+	priv = netdev_priv(ndev);
+	priv->ndev = ndev;
+	priv->dev = dev;
+
+	priv->mem = mem;
+	priv->dev_base = dev_base;
+	priv->regs = priv->dev_base + MEN_Z192_REGS_OFFS;
+
+	timebase = readl(&priv->regs->timebase);
+	if (!timebase) {
+		dev_err(dev, "invalid timebase configured (timebase=%d)\n",
+			timebase);
+		ret = -EINVAL;
+		goto out_free_candev;
+	}
+
+	priv->can.clock.freq = timebase;
+	priv->can.bittiming_const = &men_z192_bittiming_const;
+	priv->can.do_set_mode = men_z192_set_mode;
+	priv->can.do_get_berr_counter = men_z192_get_berr_counter;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+				       CAN_CTRLMODE_3_SAMPLES |
+				       CAN_CTRLMODE_LOOPBACK;
+
+	spin_lock_init(&priv->lock);
+
+	netif_napi_add(ndev, &priv->napi, men_z192_poll,
+		       NAPI_POLL_WEIGHT);
+
+	skb_queue_head_init(&priv->echoq);
+
+	mcb_set_drvdata(mdev, ndev);
+	SET_NETDEV_DEV(ndev, dev);
+
+	ndev->ethtool_ops = &men_z192_ethtool_ops;
+
+	ret = men_z192_register(ndev);
+	if (ret) {
+		dev_err(dev, "failed to register CAN device\n");
+		goto out_napi_del;
+	}
+
+	devm_can_led_init(ndev);
+
+	dev_info(dev, "MEN 16z192 CAN driver registered (%s mode)\n",
+		 ndev->irq ? "interrupt" : "polling");
+
+	return 0;
+
+out_napi_del:
+	netif_napi_del(&priv->napi);
+out_free_candev:
+	free_candev(ndev);
+out_unmap:
+	iounmap(dev_base);
+out_release:
+	mcb_release_mem(mem);
+	return ret;
+}
+
+static void men_z192_remove(struct mcb_device *mdev)
+{
+	struct net_device *ndev = mcb_get_drvdata(mdev);
+	struct men_z192 *priv = netdev_priv(ndev);
+
+	unregister_candev(ndev);
+	netif_napi_del(&priv->napi);
+
+	iounmap(priv->dev_base);
+	mcb_release_mem(priv->mem);
+
+	free_candev(ndev);
+}
+
+static const struct mcb_device_id men_z192_ids[] = {
+	{ .device = 0xc0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(mcb, men_z192_ids);
+
+static struct mcb_driver men_z192_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = men_z192_probe,
+	.remove = men_z192_remove,
+	.id_table = men_z192_ids,
+};
+module_mcb_driver(men_z192_driver);
+
+MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
+MODULE_DESCRIPTION("MEN 16z192 CAN Controller");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("mcb:16z192");
+MODULE_IMPORT_NS(MCB);

base-commit: 83d09ad4b950651a95d37697f1493c00d888d0db
--
2.17.1


M. Sc.
Abhijeet Badurkar
Software Engineering 
Business Unit Computing Systems, duagon

duagon Germany GmbH
Neuwieder Straße 1-7
90411 Nürnberg
Deutschland
Phone		+49 911 99 33 5 - 219
www.duagon.com


duagon Germany GmbH - Geschäftsführer: Dr. Michael Goldbach - Mathias Kamolz - Kalina Scott - Handelsregister/Trade Register AG Nürnberg HRB 5540

This message and/or attachments may be privileged or confidential. If you are not the intended recipient, you are hereby notified that you have received this transmittal in error; any review, dissemination, or copying is strictly prohibited. If you received this transmittal in error, please notify us immediately by reply and immediately delete this message and all its attachments. Thank you.
 
