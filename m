Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3E2832C4
	for <lists+linux-can@lfdr.de>; Mon,  5 Oct 2020 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgJEJHJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 5 Oct 2020 05:07:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:13675 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgJEJHI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 5 Oct 2020 05:07:08 -0400
Received: from [100.112.196.208] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 88/2E-29177-432EA7F5; Mon, 05 Oct 2020 09:07:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRWlGSWpSXmKPExsUS8J9toq7Jo6p
  4g3fT+SxWfZ/KbHF51xw2i/WLprBYLL23k9WBxePjpduMHv1/DTw+b5ILYI5izcxLyq9IYM14
  0TSTueDUX8aK3Q+OMTcw7rrK2MXIxSEk0MAocfj8JuYuRk4OCQE/iVlzD7NDJFYzSjxtb2GFc
  O4ySixbep8VpIpNwExi/YtnYB0iAroSPzbNAxvFLDCJUeLgs/lgCWEBb4mZ/9qYQGwWARWJtj
  2X2EFsXgFHia0fG1gg1slLrN5wAKxeSEBTYs2pNVBnKEhMmvUUqJcDyI6T+HLHFKJVUOLkzCc
  sIGFmoPL1u/RBwswC2hLLFr5mhqi2lpi4ORFiiJrE/MVdjBA2p8T7Dx+YJjCKzEIyaBbCoFlI
  Bi1gZF7FaJ5UlJmeUZKbmJmja2hgoGtoaKRraGmha2ygl1ilm6SXWqpbnlpcomuol1herFdcm
  Zuck6KXl1qyiREYTSkFx+R2MPa++aB3iFGSg0lJlNfzSlW8EF9SfkplRmJxRnxRaU5q8SFGGQ
  4OJQle4QdAOcGi1PTUirTMHGBkw6QlOHiURHgP3wdK8xYXJOYWZ6ZDpE4xWnLc3rBkETPHzfc
  gcvPcpYuYhVjy8vNSpcR52R4CNQiANGSU5sGNgyWfS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5
  GJWEeb+AXMWTmVcCt/UV0EFMQAfdPloBclBJIkJKqoFpH/8rIdaDH60ep88t+rSMXVy9+daam
  WcWPuhc+tJj6tMk5uCzTt6Xu23u60v/Wvln8t2sKFUxHm7e+1Vc4ZMjy67Njs32aElmj2fi9P
  /+SkC73JRdZl5uno/n5omKE8KcPtnbX+FTCRT3dco/d1GqYe7a5L5LXtGPzb+sXh3+dc5alrw
  FO+Onb234rxuWva1bxerFGa1lJ4tbEjZ1NpflM509+Cxc0VJZ07nn8zZdq76rPMbSD+48mPbr
  tUvePGu/yK2CDnO7Psyor8n01dfkyHpY7nk8Nfx4qmhwRa3OIZczG+1UmH8FvFNN3DRpRurEa
  omE27vr/9jN7JLU4Y7jrP19VYZTeVaq34odukosxRmJhlrMRcWJAB4xrkm5AwAA
X-Env-Sender: Abhijeet.Badurkar@duagon.com
X-Msg-Ref: server-21.tower-288.messagelabs.com!1601888819!1476873!1
X-Originating-IP: [80.255.6.145]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17738 invoked from network); 5 Oct 2020 09:07:00 -0000
Received: from unknown (HELO keys.men.de) (80.255.6.145)
  by server-21.tower-288.messagelabs.com with DHE-RSA-AES256-SHA encrypted SMTP; 5 Oct 2020 09:07:00 -0000
Received: from MEN-EX01.intra.men.de ([192.168.1.1])
  by keys.men.de (PGP Universal service);
  Mon, 05 Oct 2020 11:07:00 +0200
X-PGP-Universal: processed;
        by keys.men.de on Mon, 05 Oct 2020 11:07:00 +0200
Received: from MEN-EX01.intra.men.de (192.168.1.1) by MEN-EX01.intra.men.de
 (192.168.1.1) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Oct
 2020 11:06:58 +0200
Received: from abadurkar-HP-Z2-Tower-G4-Workstation.dev.men.de (10.64.14.204)
 by MEN-EX01.intra.men.de (192.168.1.1) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 5 Oct 2020 11:06:58 +0200
From:   Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <andreas.geissler@duagon.com>,
        Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
Subject: [PATCH v4] net: can: Introduce MEN 16Z192-00 CAN controller driver
Date:   Mon, 5 Oct 2020 11:06:32 +0200
Message-ID: <20201005090632.20870-1-abhijeet.badurkar@duagon.com>
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

Signed-off-by: Abhijeet Badurkar <abhijeet.badurkar@duagon.com>
---
 drivers/net/can/Kconfig        |   10 +
 drivers/net/can/Makefile       |    1 +
 drivers/net/can/men_z192_can.c | 1098 ++++++++++++++++++++++++++++++++
 3 files changed, 1109 insertions(+)
 create mode 100644 drivers/net/can/men_z192_can.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index f07012a76c0c..df658ecefddb 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -133,6 +133,16 @@ config CAN_KVASER_PCIEFD
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
index 000000000000..5bb4e68331c3
--- /dev/null
+++ b/drivers/net/can/men_z192_can.c
@@ -0,0 +1,1098 @@
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
+#define MEN_Z192_IRQ_ALL		(MEN_Z192_RXIE | \
+					 MEN_Z192_OVRIE | \
+					 MEN_Z192_CSCIE | \
+					 MEN_Z192_TOUTE | \
+					 MEN_Z192_TXIE)
+
+/* RX_TX_STAT RX/TX Status status register bits */
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
+#define MEN_Z192_IRQ_NAPI		(MEN_Z192_RXIE | MEN_Z192_TOUTE)
+
+#define MEN_Z192_IRQ_FLAGS_ALL		(MEN_Z192_RFLG_RXIF | \
+					MEN_Z192_RFLG_OVRF | \
+					MEN_Z192_RFLG_TSTATE | \
+					MEN_Z192_RFLG_RSTATE | \
+					MEN_Z192_RFLG_CSCIF | \
+					MEN_Z192_RFLG_TOUTF | \
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
+	switch (state) {
+	case MEN_Z192_CAN_DIS:
+		men_z192_bit_clr(priv, &regs->ier, MEN_Z192_IRQ_ALL);
+		break;
+
+	case MEN_Z192_CAN_EN:
+		men_z192_bit_set(priv, &regs->ier, MEN_Z192_IRQ_ALL);
+		break;
+
+	case MEN_Z192_CAN_NAPI_DIS:
+		men_z192_bit_clr(priv, &regs->ier, MEN_Z192_IRQ_NAPI);
+		break;
+
+	case MEN_Z192_CAN_NAPI_EN:
+		men_z192_bit_set(priv, &regs->ier, MEN_Z192_IRQ_NAPI);
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
+	cf->can_dlc = get_can_dlc(length);
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
+static void men_z192_err_interrupt(struct net_device *ndev, u32 status)
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
+static irqreturn_t men_z192_isr(int irq, void *dev_id)
+{
+	struct net_device *ndev = dev_id;
+	struct men_z192 *priv = netdev_priv(ndev);
+	struct men_z192_regs __iomem *regs = priv->regs;
+	bool handled = false;
+	u32 irq_flags;
+	u32 status;
+
+	status = readl(&regs->rx_tx_sts);
+
+	irq_flags = status & MEN_Z192_IRQ_FLAGS_ALL;
+	if (!irq_flags)
+		goto out;
+
+	/* It is safe to write to RX_TS_STS[15:0] */
+	writel(irq_flags, &regs->rx_tx_sts);
+
+	if (irq_flags & MEN_Z192_TFLG_TXIF) {
+		netif_wake_queue(ndev);
+		handled = true;
+	}
+
+	/* handle errors */
+	if ((irq_flags & MEN_Z192_RFLG_OVRF) ||
+	    (irq_flags & MEN_Z192_RFLG_CSCIF)) {
+		men_z192_err_interrupt(ndev, status);
+		handled = true;
+	}
+
+	/* schedule NAPI if:
+	 * - rx IRQ
+	 * - rx timeout IRQ
+	 */
+	if ((irq_flags & MEN_Z192_RFLG_RXIF) ||
+	    (irq_flags & MEN_Z192_RFLG_TOUTF)) {
+		men_z192_set_int(priv, MEN_Z192_CAN_NAPI_DIS);
+		napi_schedule(&priv->napi);
+		handled = true;
+	}
+
+out:
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
+	netdev_dbg(ndev, "CTL_BTR=0x%08x\n", ctlbtr);
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
+	return 0;
+}
+
+static int men_z192_open(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	int ret;
+
+	ret = open_candev(ndev);
+	if (ret)
+		return ret;
+
+	ret = request_irq(ndev->irq, men_z192_isr, IRQF_SHARED,
+			  ndev->name, ndev);
+	if (ret)
+		goto out_close;
+
+	ret = men_z192_start(ndev);
+	if (ret)
+		goto out_free_irq;
+
+	napi_enable(&priv->napi);
+	netif_start_queue(ndev);
+
+	return 0;
+
+out_free_irq:
+	free_irq(ndev->irq, ndev);
+out_close:
+	close_candev(ndev);
+	return ret;
+}
+
+static int men_z192_stop(struct net_device *ndev)
+{
+	struct men_z192 *priv = netdev_priv(ndev);
+	int ret;
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
+	free_irq(ndev->irq, ndev);
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
+void men_z192_init_coalesce(struct net_device *ndev)
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
+	int irq;
+
+	mem = mcb_request_mem(mdev, dev_name(dev));
+	if (IS_ERR(mem)) {
+		dev_err(dev, "failed to request device memory");
+		return PTR_ERR(mem);
+	}
+
+	dev_base = ioremap(mem->start, resource_size(mem));
+	if (!dev_base) {
+		dev_err(dev, "failed to ioremap device memory");
+		ret = -ENXIO;
+		goto out_release;
+	}
+
+	irq = mcb_get_irq(mdev);
+	if (irq <= 0) {
+		ret = -ENODEV;
+		goto out_unmap;
+	}
+
+	ndev = alloc_candev(sizeof(struct men_z192), 0);
+	if (!ndev) {
+		dev_err(dev, "failed to allocat the can device");
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	ndev->netdev_ops = &men_z192_netdev_ops;
+	ndev->irq = irq;
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
+		dev_err(dev, "failed to register CAN device");
+		goto out_free_candev;
+	}
+
+	devm_can_led_init(ndev);
+
+	dev_info(dev, "MEN 16z192 CAN driver successfully registered\n");
+
+	return 0;
+
+out_free_candev:
+	netif_napi_del(&priv->napi);
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

base-commit: 549738f15da0e5a00275977623be199fbbf7df50
-- 
2.17.1


M. Sc.
Abhijeet Badurkar
Software Engineering 
Business Unit Computing Systems, duagon

MEN Mikro Elektronik GmbH
Neuwieder Straße 1-7
90411 Nürnberg
Deutschland
Phone		+49 911 99 33 5 - 219
www.duagon.com


MEN Mikro Elektronik GmbH - Geschäftsführer: Dr. Michael Goldbach - Mathias Kamolz - Kalina Scott - Handelsregister/Trade Register AG Nürnberg HRB 5540

This message and/or attachments may be privileged or confidential. If you are not the intended recipient, you are hereby notified that you have received this transmittal in error; any review, dissemination, or copying is strictly prohibited. If you received this transmittal in error, please notify us immediately by reply and immediately delete this message and all its attachments. Thank you.
 
