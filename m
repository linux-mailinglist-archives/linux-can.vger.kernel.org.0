Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6224F66AB8
	for <lists+linux-can@lfdr.de>; Fri, 12 Jul 2019 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfGLKIl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Jul 2019 06:08:41 -0400
Received: from mailhost.rzbo.de ([91.103.116.220]:60510 "EHLO mailhost.rzbo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfGLKIl (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 12 Jul 2019 06:08:41 -0400
X-Greylist: delayed 973 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 06:08:34 EDT
X-ASG-Debug-ID: 1562925138-04bb231e73b09750001-ZXuqFv
Received: from SCG-SWVMS-MEX01.schulz.intra ([10.240.9.15]) by mailhost.rzbo.de with ESMTP id E8jMppOyBniAIm3G (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 12 Jul 2019 11:52:18 +0200 (CEST)
X-Barracuda-Envelope-From: Marcel.Schmidt@schulz-soluware.com
Received: from laptop332.schulz-group.intra (10.2.8.10) by
 SCG-SWVMS-MEX01.schulz.intra (10.240.9.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.845.34; Fri, 12 Jul 2019 11:52:17 +0200
From:   <marcel.schmidt@schulz-soluware.com>
To:     <linux-can@vger.kernel.org>, <mkl@pengutronix.de>,
        <wg@grandegger.com>
CC:     Marcel Schmidt <marcel.schmidt@schulz-soluware.com>
Subject: [PATCH resend] can/ifi_canfd: Added API for IFI-CANFD functionalities
Date:   Fri, 12 Jul 2019 11:51:50 +0200
X-ASG-Orig-Subj: [PATCH resend] can/ifi_canfd: Added API for IFI-CANFD functionalities
Message-ID: <20190712095150.29446-1-marcel.schmidt@schulz-soluware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.2.8.10]
X-ClientProxiedBy: SCG-SWVMS-MEX01.schulz.intra (10.240.9.15) To
 SCG-SWVMS-MEX01.schulz.intra (10.240.9.15)
X-Barracuda-Connect: UNKNOWN[10.240.9.15]
X-Barracuda-Start-Time: 1562925138
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://mailhost.rzbo.de:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at rzbo.de
X-Barracuda-Scan-Msg-Size: 40810
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=NO_REAL_NAME
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73861
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 NO_REAL_NAME           From: does not include a real name
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marcel Schmidt <marcel.schmidt@schulz-soluware.com>

Updates the ifi_canfd platform driver and adds an universal
interface that enables the usage of its functionalities outside of
this platform driver.

It was implemented with respect to role models like SJA1000 or C_Can.
Therefore the driver is split into three files.
ifi_canfd_platform.c contains the platform specific implementations
and remains functional the same. ifi_canfd.c+h enables common IFI-CANFD
functionalities usable for other drivers.

Signed-off-by: Marcel Schmidt <marcel.schmidt@schulz-soluware.com>
---
 drivers/net/can/ifi_canfd/Kconfig             |  10 +-
 drivers/net/can/ifi_canfd/Makefile            |   3 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c         | 554 ++++++------------
 drivers/net/can/ifi_canfd/ifi_canfd.h         | 341 +++++++++++
 .../net/can/ifi_canfd/ifi_canfd_platform.c    | 121 ++++
 5 files changed, 639 insertions(+), 390 deletions(-)
 create mode 100644 drivers/net/can/ifi_canfd/ifi_canfd.h
 create mode 100644 drivers/net/can/ifi_canfd/ifi_canfd_platform.c

diff --git a/drivers/net/can/ifi_canfd/Kconfig b/drivers/net/can/ifi_canfd/Kconfig
index ce0197641a59..22f5d8322a2e 100644
--- a/drivers/net/can/ifi_canfd/Kconfig
+++ b/drivers/net/can/ifi_canfd/Kconfig
@@ -1,9 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config CAN_IFI_CANFD
+menuconfig CAN_IFI_CANFD
+	tristate "IFI_CAN_FD devices"
 	depends on HAS_IOMEM
-	tristate "IFI CAN_FD IP"
+
+if CAN_IFI_CANFD
+
+config CAN_IFI_CANFD_PLATFORM
+	tristate "Generic Platform Bus based IFI CAN_FD driver"
 	---help---
 	  This driver adds support for the I/F/I CAN_FD soft IP block
 	  connected to the "platform bus" (Linux abstraction for directly
 	  to the processor attached devices). The CAN_FD is most often
 	  synthesised into an FPGA or CPLD.
+endif
diff --git a/drivers/net/can/ifi_canfd/Makefile b/drivers/net/can/ifi_canfd/Makefile
index 0cd724f10d1e..8d58c38975a5 100644
--- a/drivers/net/can/ifi_canfd/Makefile
+++ b/drivers/net/can/ifi_canfd/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-#  Makefile for the IFI CANFD controller driver.
+#  Makefile for the IFI CANFD controller drivers.
 #
 
 obj-$(CONFIG_CAN_IFI_CANFD) += ifi_canfd.o
+obj-$(CONFIG_CAN_IFI_CANFD_PLATFORM) += ifi_canfd_platform.o
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index fedd927ba6ed..706e0c267c1e 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -23,207 +23,36 @@
 #include <linux/platform_device.h>
 
 #include <linux/can/dev.h>
+#include "ifi_canfd.h"
 
-#define IFI_CANFD_STCMD				0x0
-#define IFI_CANFD_STCMD_HARDRESET		0xDEADCAFD
-#define IFI_CANFD_STCMD_ENABLE			BIT(0)
-#define IFI_CANFD_STCMD_ERROR_ACTIVE		BIT(2)
-#define IFI_CANFD_STCMD_ERROR_PASSIVE		BIT(3)
-#define IFI_CANFD_STCMD_BUSOFF			BIT(4)
-#define IFI_CANFD_STCMD_ERROR_WARNING		BIT(5)
-#define IFI_CANFD_STCMD_BUSMONITOR		BIT(16)
-#define IFI_CANFD_STCMD_LOOPBACK		BIT(18)
-#define IFI_CANFD_STCMD_DISABLE_CANFD		BIT(24)
-#define IFI_CANFD_STCMD_ENABLE_ISO		BIT(25)
-#define IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING	BIT(26)
-#define IFI_CANFD_STCMD_NORMAL_MODE		((u32)BIT(31))
-
-#define IFI_CANFD_RXSTCMD			0x4
-#define IFI_CANFD_RXSTCMD_REMOVE_MSG		BIT(0)
-#define IFI_CANFD_RXSTCMD_RESET			BIT(7)
-#define IFI_CANFD_RXSTCMD_EMPTY			BIT(8)
-#define IFI_CANFD_RXSTCMD_OVERFLOW		BIT(13)
-
-#define IFI_CANFD_TXSTCMD			0x8
-#define IFI_CANFD_TXSTCMD_ADD_MSG		BIT(0)
-#define IFI_CANFD_TXSTCMD_HIGH_PRIO		BIT(1)
-#define IFI_CANFD_TXSTCMD_RESET			BIT(7)
-#define IFI_CANFD_TXSTCMD_EMPTY			BIT(8)
-#define IFI_CANFD_TXSTCMD_FULL			BIT(12)
-#define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
-
-#define IFI_CANFD_INTERRUPT			0xc
-#define IFI_CANFD_INTERRUPT_ERROR_BUSOFF	BIT(0)
-#define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
-#define IFI_CANFD_INTERRUPT_ERROR_STATE_CHG	BIT(2)
-#define IFI_CANFD_INTERRUPT_ERROR_REC_TEC_INC	BIT(3)
-#define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
-#define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
-#define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
-#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY	BIT(24)
-#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER	BIT(25)
-#define IFI_CANFD_INTERRUPT_SET_IRQ		((u32)BIT(31))
-
-#define IFI_CANFD_IRQMASK			0x10
-#define IFI_CANFD_IRQMASK_ERROR_BUSOFF		BIT(0)
-#define IFI_CANFD_IRQMASK_ERROR_WARNING		BIT(1)
-#define IFI_CANFD_IRQMASK_ERROR_STATE_CHG	BIT(2)
-#define IFI_CANFD_IRQMASK_ERROR_REC_TEC_INC	BIT(3)
-#define IFI_CANFD_IRQMASK_SET_ERR		BIT(7)
-#define IFI_CANFD_IRQMASK_SET_TS		BIT(15)
-#define IFI_CANFD_IRQMASK_TXFIFO_EMPTY		BIT(16)
-#define IFI_CANFD_IRQMASK_SET_TX		BIT(23)
-#define IFI_CANFD_IRQMASK_RXFIFO_NEMPTY		BIT(24)
-#define IFI_CANFD_IRQMASK_SET_RX		((u32)BIT(31))
-
-#define IFI_CANFD_TIME				0x14
-#define IFI_CANFD_FTIME				0x18
-#define IFI_CANFD_TIME_TIMEB_OFF		0
-#define IFI_CANFD_TIME_TIMEA_OFF		8
-#define IFI_CANFD_TIME_PRESCALE_OFF		16
-#define IFI_CANFD_TIME_SJW_OFF_7_9_8_8		25
-#define IFI_CANFD_TIME_SJW_OFF_4_12_6_6		28
-#define IFI_CANFD_TIME_SET_SJW_4_12_6_6		BIT(6)
-#define IFI_CANFD_TIME_SET_TIMEB_4_12_6_6	BIT(7)
-#define IFI_CANFD_TIME_SET_PRESC_4_12_6_6	BIT(14)
-#define IFI_CANFD_TIME_SET_TIMEA_4_12_6_6	BIT(15)
-
-#define IFI_CANFD_TDELAY			0x1c
-#define IFI_CANFD_TDELAY_DEFAULT		0xb
-#define IFI_CANFD_TDELAY_MASK			0x3fff
-#define IFI_CANFD_TDELAY_ABS			BIT(14)
-#define IFI_CANFD_TDELAY_EN			BIT(15)
-
-#define IFI_CANFD_ERROR				0x20
-#define IFI_CANFD_ERROR_TX_OFFSET		0
-#define IFI_CANFD_ERROR_TX_MASK			0xff
-#define IFI_CANFD_ERROR_RX_OFFSET		16
-#define IFI_CANFD_ERROR_RX_MASK			0xff
-
-#define IFI_CANFD_ERRCNT			0x24
-
-#define IFI_CANFD_SUSPEND			0x28
-
-#define IFI_CANFD_REPEAT			0x2c
-
-#define IFI_CANFD_TRAFFIC			0x30
-
-#define IFI_CANFD_TSCONTROL			0x34
-
-#define IFI_CANFD_TSC				0x38
-
-#define IFI_CANFD_TST				0x3c
-
-#define IFI_CANFD_RES1				0x40
-
-#define IFI_CANFD_ERROR_CTR			0x44
-#define IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC	0x21302899
-#define IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST	BIT(0)
-#define IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST	BIT(1)
-#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST	BIT(2)
-#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST	BIT(3)
-#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST	BIT(4)
-#define IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST	BIT(5)
-#define IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST	BIT(6)
-#define IFI_CANFD_ERROR_CTR_OVERLOAD_ALL	BIT(8)
-#define IFI_CANFD_ERROR_CTR_ACK_ERROR_ALL	BIT(9)
-#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_ALL	BIT(10)
-#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_ALL	BIT(11)
-#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_ALL	BIT(12)
-#define IFI_CANFD_ERROR_CTR_CRC_ERROR_ALL	BIT(13)
-#define IFI_CANFD_ERROR_CTR_FORM_ERROR_ALL	BIT(14)
-#define IFI_CANFD_ERROR_CTR_BITPOSITION_OFFSET	16
-#define IFI_CANFD_ERROR_CTR_BITPOSITION_MASK	0xff
-#define IFI_CANFD_ERROR_CTR_ER_RESET		BIT(30)
-#define IFI_CANFD_ERROR_CTR_ER_ENABLE		((u32)BIT(31))
-
-#define IFI_CANFD_PAR				0x48
-
-#define IFI_CANFD_CANCLOCK			0x4c
-
-#define IFI_CANFD_SYSCLOCK			0x50
-
-#define IFI_CANFD_VER				0x54
-#define IFI_CANFD_VER_REV_MASK			0xff
-#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
-
-#define IFI_CANFD_IP_ID				0x58
-#define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
-
-#define IFI_CANFD_TEST				0x5c
-
-#define IFI_CANFD_RXFIFO_TS_63_32		0x60
-
-#define IFI_CANFD_RXFIFO_TS_31_0		0x64
-
-#define IFI_CANFD_RXFIFO_DLC			0x68
-#define IFI_CANFD_RXFIFO_DLC_DLC_OFFSET		0
-#define IFI_CANFD_RXFIFO_DLC_DLC_MASK		0xf
-#define IFI_CANFD_RXFIFO_DLC_RTR		BIT(4)
-#define IFI_CANFD_RXFIFO_DLC_EDL		BIT(5)
-#define IFI_CANFD_RXFIFO_DLC_BRS		BIT(6)
-#define IFI_CANFD_RXFIFO_DLC_ESI		BIT(7)
-#define IFI_CANFD_RXFIFO_DLC_OBJ_OFFSET		8
-#define IFI_CANFD_RXFIFO_DLC_OBJ_MASK		0x1ff
-#define IFI_CANFD_RXFIFO_DLC_FNR_OFFSET		24
-#define IFI_CANFD_RXFIFO_DLC_FNR_MASK		0xff
-
-#define IFI_CANFD_RXFIFO_ID			0x6c
-#define IFI_CANFD_RXFIFO_ID_ID_OFFSET		0
-#define IFI_CANFD_RXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
-#define IFI_CANFD_RXFIFO_ID_ID_STD_OFFSET	0
-#define IFI_CANFD_RXFIFO_ID_ID_STD_WIDTH	10
-#define IFI_CANFD_RXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
-#define IFI_CANFD_RXFIFO_ID_ID_XTD_OFFSET	11
-#define IFI_CANFD_RXFIFO_ID_ID_XTD_WIDTH	18
-#define IFI_CANFD_RXFIFO_ID_IDE			BIT(29)
-
-#define IFI_CANFD_RXFIFO_DATA			0x70	/* 0x70..0xac */
-
-#define IFI_CANFD_TXFIFO_SUSPEND_US		0xb0
-
-#define IFI_CANFD_TXFIFO_REPEATCOUNT		0xb4
-
-#define IFI_CANFD_TXFIFO_DLC			0xb8
-#define IFI_CANFD_TXFIFO_DLC_DLC_OFFSET		0
-#define IFI_CANFD_TXFIFO_DLC_DLC_MASK		0xf
-#define IFI_CANFD_TXFIFO_DLC_RTR		BIT(4)
-#define IFI_CANFD_TXFIFO_DLC_EDL		BIT(5)
-#define IFI_CANFD_TXFIFO_DLC_BRS		BIT(6)
-#define IFI_CANFD_TXFIFO_DLC_FNR_OFFSET		24
-#define IFI_CANFD_TXFIFO_DLC_FNR_MASK		0xff
-
-#define IFI_CANFD_TXFIFO_ID			0xbc
-#define IFI_CANFD_TXFIFO_ID_ID_OFFSET		0
-#define IFI_CANFD_TXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
-#define IFI_CANFD_TXFIFO_ID_ID_STD_OFFSET	0
-#define IFI_CANFD_TXFIFO_ID_ID_STD_WIDTH	10
-#define IFI_CANFD_TXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
-#define IFI_CANFD_TXFIFO_ID_ID_XTD_OFFSET	11
-#define IFI_CANFD_TXFIFO_ID_ID_XTD_WIDTH	18
-#define IFI_CANFD_TXFIFO_ID_IDE			BIT(29)
-
-#define IFI_CANFD_TXFIFO_DATA			0xc0	/* 0xb0..0xfc */
-
-#define IFI_CANFD_FILTER_MASK(n)		(0x800 + ((n) * 8) + 0)
-#define IFI_CANFD_FILTER_MASK_EXT		BIT(29)
-#define IFI_CANFD_FILTER_MASK_EDL		BIT(30)
-#define IFI_CANFD_FILTER_MASK_VALID		((u32)BIT(31))
-
-#define IFI_CANFD_FILTER_IDENT(n)		(0x800 + ((n) * 8) + 4)
-#define IFI_CANFD_FILTER_IDENT_IDE		BIT(29)
-#define IFI_CANFD_FILTER_IDENT_CANFD		BIT(30)
-#define IFI_CANFD_FILTER_IDENT_VALID		((u32)BIT(31))
-
-/* IFI CANFD private data structure */
-struct ifi_canfd_priv {
-	struct can_priv		can;	/* must be the first member */
-	struct napi_struct	napi;
-	struct net_device	*ndev;
-	void __iomem		*base;
+static const struct can_bittiming_const ifi_canfd_bittiming_const = {
+	.name		= KBUILD_MODNAME,
+	.tseg1_min	= 1,	/* Time segment 1 = prop_seg + phase_seg1 */
+	.tseg1_max	= 256,
+	.tseg2_min	= 2,	/* Time segment 2 = phase_seg2 */
+	.tseg2_max	= 256,
+	.sjw_max	= 128,
+	.brp_min	= 2,
+	.brp_max	= 512,
+	.brp_inc	= 1,
 };
 
-static void ifi_canfd_irq_enable(struct net_device *ndev, bool enable)
+static void ifi_canfd_irq_clear(struct net_device *ndev)
+{
+	struct ifi_canfd_priv *priv = netdev_priv(ndev);
+	u32 ifi_reg_status = readl(priv->base + IFI_CANFD_INTERRUPT);
+
+	/* Clear pending IFI CAN controller interrupts */
+	writel(ifi_reg_status, priv->base + IFI_CANFD_INTERRUPT);
+
+	/* Unlock, reset and enable the error counter. */
+	writel(IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC,
+	       priv->base + IFI_CANFD_ERROR_CTR);
+	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
+	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
+}
+
+void ifi_canfd_irq_enable(struct net_device *ndev, bool enable, u8 clear)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 	u32 enirq = 0;
@@ -243,8 +72,87 @@ static void ifi_canfd_irq_enable(struct net_device *ndev, bool enable)
 	       IFI_CANFD_IRQMASK_SET_TX |
 	       IFI_CANFD_IRQMASK_SET_RX | enirq,
 	       priv->base + IFI_CANFD_IRQMASK);
+
+	if (clear)
+		ifi_canfd_irq_clear(ndev);
+}
+EXPORT_SYMBOL_GPL(ifi_canfd_irq_enable);
+
+static void ifi_canfd_set_bittiming(struct net_device *ndev)
+{
+	struct ifi_canfd_priv *priv = netdev_priv(ndev);
+	const struct can_bittiming *bt = &priv->can.bittiming;
+	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	u16 brp, sjw, tseg1, tseg2, tdc;
+
+	/* Configure bit timing */
+	brp = bt->brp - 2;
+	sjw = bt->sjw - 1;
+	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
+	tseg2 = bt->phase_seg2 - 2;
+	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
+	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
+	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
+	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
+	       priv->base + IFI_CANFD_TIME);
+
+	/* Configure data bit timing */
+	brp = dbt->brp - 2;
+	sjw = dbt->sjw - 1;
+	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
+	tseg2 = dbt->phase_seg2 - 2;
+	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
+	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
+	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
+	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
+	       priv->base + IFI_CANFD_FTIME);
+
+	/* Configure transmitter delay */
+	tdc = dbt->brp * (dbt->prop_seg + dbt->phase_seg1);
+	tdc &= IFI_CANFD_TDELAY_MASK;
+	writel(IFI_CANFD_TDELAY_EN | tdc, priv->base + IFI_CANFD_TDELAY);
 }
 
+static void ifi_canfd_set_filter(struct net_device *ndev, const u32 id,
+				 bool enable, u32 mask, u32 ident)
+{
+	struct ifi_canfd_priv *priv = netdev_priv(ndev);
+
+	if (!enable) {
+		mask = 0;
+		ident = 0;
+	}
+
+	writel(mask, priv->base + IFI_CANFD_FILTER_MASK(id));
+	writel(ident, priv->base + IFI_CANFD_FILTER_IDENT(id));
+}
+
+void ifi_canfd_set_filters(struct net_device *ndev, bool enable)
+{
+	/* Receive all CAN frames (standard ID) */
+	ifi_canfd_set_filter(ndev, 0, enable,
+			     IFI_CANFD_FILTER_MASK_VALID |
+			     IFI_CANFD_FILTER_MASK_EXT,
+			     IFI_CANFD_FILTER_IDENT_VALID);
+
+	/* Receive all CAN frames (extended ID) */
+	ifi_canfd_set_filter(ndev, 1, enable,
+			     IFI_CANFD_FILTER_MASK_VALID |
+			     IFI_CANFD_FILTER_MASK_EXT,
+			     IFI_CANFD_FILTER_IDENT_VALID |
+			     IFI_CANFD_FILTER_IDENT_IDE);
+
+	/* Receive all CANFD frames */
+	ifi_canfd_set_filter(ndev, 2, enable,
+			     IFI_CANFD_FILTER_MASK_VALID |
+			     IFI_CANFD_FILTER_MASK_EDL |
+			     IFI_CANFD_FILTER_MASK_EXT,
+			     IFI_CANFD_FILTER_IDENT_VALID |
+			     IFI_CANFD_FILTER_IDENT_CANFD |
+			     IFI_CANFD_FILTER_IDENT_IDE);
+}
+EXPORT_SYMBOL_GPL(ifi_canfd_set_filters);
+
 static void ifi_canfd_read_fifo(struct net_device *ndev)
 {
 	struct net_device_stats *stats = &ndev->stats;
@@ -480,7 +388,7 @@ static int ifi_canfd_handle_state_change(struct net_device *ndev,
 	case CAN_STATE_BUS_OFF:
 		/* bus-off state */
 		priv->can.state = CAN_STATE_BUS_OFF;
-		ifi_canfd_irq_enable(ndev, 0);
+		ifi_canfd_irq_enable(ndev, 0, 0);
 		priv->can.can_stats.bus_off++;
 		can_bus_off(ndev);
 		break;
@@ -566,7 +474,7 @@ static int ifi_canfd_handle_state_errors(struct net_device *ndev)
 	return work_done;
 }
 
-static int ifi_canfd_poll(struct napi_struct *napi, int quota)
+int ifi_canfd_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *ndev = napi->dev;
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
@@ -590,13 +498,14 @@ static int ifi_canfd_poll(struct napi_struct *napi, int quota)
 
 	if (work_done < quota) {
 		napi_complete_done(napi, work_done);
-		ifi_canfd_irq_enable(ndev, 1);
+		ifi_canfd_irq_enable(ndev, 1, 0);
 	}
 
 	return work_done;
 }
+EXPORT_SYMBOL_GPL(ifi_canfd_poll);
 
-static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
+irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 {
 	struct net_device *ndev = (struct net_device *)dev_id;
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
@@ -612,6 +521,9 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 	const u32 clr_irq_mask = ~((u32)IFI_CANFD_INTERRUPT_SET_IRQ);
 	u32 isr;
 
+	if (priv->pre_irq)
+		priv->pre_irq(priv);
+
 	isr = readl(priv->base + IFI_CANFD_INTERRUPT);
 
 	/* No interrupt */
@@ -623,7 +535,7 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 
 	/* RX IRQ or bus warning, start NAPI */
 	if (isr & rx_irq_mask) {
-		ifi_canfd_irq_enable(ndev, 0);
+		ifi_canfd_irq_enable(ndev, 0, 0);
 		napi_schedule(&priv->napi);
 	}
 
@@ -637,88 +549,10 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 	if (isr & tx_irq_mask)
 		netif_wake_queue(ndev);
 
-	return IRQ_HANDLED;
-}
-
-static const struct can_bittiming_const ifi_canfd_bittiming_const = {
-	.name		= KBUILD_MODNAME,
-	.tseg1_min	= 1,	/* Time segment 1 = prop_seg + phase_seg1 */
-	.tseg1_max	= 256,
-	.tseg2_min	= 2,	/* Time segment 2 = phase_seg2 */
-	.tseg2_max	= 256,
-	.sjw_max	= 128,
-	.brp_min	= 2,
-	.brp_max	= 512,
-	.brp_inc	= 1,
-};
-
-static void ifi_canfd_set_bittiming(struct net_device *ndev)
-{
-	struct ifi_canfd_priv *priv = netdev_priv(ndev);
-	const struct can_bittiming *bt = &priv->can.bittiming;
-	const struct can_bittiming *dbt = &priv->can.data_bittiming;
-	u16 brp, sjw, tseg1, tseg2, tdc;
+	if (priv->post_irq)
+		priv->post_irq(priv);
 
-	/* Configure bit timing */
-	brp = bt->brp - 2;
-	sjw = bt->sjw - 1;
-	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
-	tseg2 = bt->phase_seg2 - 2;
-	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
-	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
-	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
-	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
-	       priv->base + IFI_CANFD_TIME);
-
-	/* Configure data bit timing */
-	brp = dbt->brp - 2;
-	sjw = dbt->sjw - 1;
-	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
-	tseg2 = dbt->phase_seg2 - 2;
-	writel((tseg2 << IFI_CANFD_TIME_TIMEB_OFF) |
-	       (tseg1 << IFI_CANFD_TIME_TIMEA_OFF) |
-	       (brp << IFI_CANFD_TIME_PRESCALE_OFF) |
-	       (sjw << IFI_CANFD_TIME_SJW_OFF_7_9_8_8),
-	       priv->base + IFI_CANFD_FTIME);
-
-	/* Configure transmitter delay */
-	tdc = dbt->brp * (dbt->prop_seg + dbt->phase_seg1);
-	tdc &= IFI_CANFD_TDELAY_MASK;
-	writel(IFI_CANFD_TDELAY_EN | tdc, priv->base + IFI_CANFD_TDELAY);
-}
-
-static void ifi_canfd_set_filter(struct net_device *ndev, const u32 id,
-				 const u32 mask, const u32 ident)
-{
-	struct ifi_canfd_priv *priv = netdev_priv(ndev);
-
-	writel(mask, priv->base + IFI_CANFD_FILTER_MASK(id));
-	writel(ident, priv->base + IFI_CANFD_FILTER_IDENT(id));
-}
-
-static void ifi_canfd_set_filters(struct net_device *ndev)
-{
-	/* Receive all CAN frames (standard ID) */
-	ifi_canfd_set_filter(ndev, 0,
-			     IFI_CANFD_FILTER_MASK_VALID |
-			     IFI_CANFD_FILTER_MASK_EXT,
-			     IFI_CANFD_FILTER_IDENT_VALID);
-
-	/* Receive all CAN frames (extended ID) */
-	ifi_canfd_set_filter(ndev, 1,
-			     IFI_CANFD_FILTER_MASK_VALID |
-			     IFI_CANFD_FILTER_MASK_EXT,
-			     IFI_CANFD_FILTER_IDENT_VALID |
-			     IFI_CANFD_FILTER_IDENT_IDE);
-
-	/* Receive all CANFD frames */
-	ifi_canfd_set_filter(ndev, 2,
-			     IFI_CANFD_FILTER_MASK_VALID |
-			     IFI_CANFD_FILTER_MASK_EDL |
-			     IFI_CANFD_FILTER_MASK_EXT,
-			     IFI_CANFD_FILTER_IDENT_VALID |
-			     IFI_CANFD_FILTER_IDENT_CANFD |
-			     IFI_CANFD_FILTER_IDENT_IDE);
+	return IRQ_HANDLED;
 }
 
 static void ifi_canfd_start(struct net_device *ndev)
@@ -732,7 +566,7 @@ static void ifi_canfd_start(struct net_device *ndev)
 	       priv->base + IFI_CANFD_STCMD);
 
 	ifi_canfd_set_bittiming(ndev);
-	ifi_canfd_set_filters(ndev);
+	ifi_canfd_set_filters(ndev, 1);
 
 	/* Reset FIFOs */
 	writel(IFI_CANFD_RXSTCMD_RESET, priv->base + IFI_CANFD_RXSTCMD);
@@ -766,13 +600,7 @@ static void ifi_canfd_start(struct net_device *ndev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	ifi_canfd_irq_enable(ndev, 1);
-
-	/* Unlock, reset and enable the error counter. */
-	writel(IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC,
-	       priv->base + IFI_CANFD_ERROR_CTR);
-	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
-	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
+	ifi_canfd_irq_enable(ndev, 1, 1);
 
 	/* Enable controller */
 	writel(stcmd, priv->base + IFI_CANFD_STCMD);
@@ -800,20 +628,6 @@ static void ifi_canfd_stop(struct net_device *ndev)
 	priv->can.state = CAN_STATE_STOPPED;
 }
 
-static int ifi_canfd_set_mode(struct net_device *ndev, enum can_mode mode)
-{
-	switch (mode) {
-	case CAN_MODE_START:
-		ifi_canfd_start(ndev);
-		netif_wake_queue(ndev);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int ifi_canfd_open(struct net_device *ndev)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
@@ -826,11 +640,14 @@ static int ifi_canfd_open(struct net_device *ndev)
 	}
 
 	/* Register interrupt handler */
-	ret = request_irq(ndev->irq, ifi_canfd_isr, IRQF_SHARED,
-			  ndev->name, ndev);
-	if (ret < 0) {
-		netdev_err(ndev, "Failed to request interrupt\n");
-		goto err_irq;
+	if (!(priv->flags & IFI_CANFD_CUSTOM_IRQ_HANDLING)) {
+		ret = request_irq(ndev->irq, ifi_canfd_isr, IRQF_SHARED,
+				  ndev->name, ndev);
+		if (ret < 0) {
+			netdev_err(ndev,
+				   "Failed to request interrupt: %i\n", ret);
+			goto err_irq;
+		}
 	}
 
 	ifi_canfd_start(ndev);
@@ -854,7 +671,8 @@ static int ifi_canfd_close(struct net_device *ndev)
 
 	ifi_canfd_stop(ndev);
 
-	free_irq(ndev->irq, ndev);
+	if (!(priv->flags & IFI_CANFD_CUSTOM_IRQ_HANDLING))
+		free_irq(ndev->irq, ndev);
 
 	close_candev(ndev);
 
@@ -937,52 +755,32 @@ static const struct net_device_ops ifi_canfd_netdev_ops = {
 	.ndo_change_mtu	= can_change_mtu,
 };
 
-static int ifi_canfd_plat_probe(struct platform_device *pdev)
+static int ifi_canfd_set_mode(struct net_device *ndev, enum can_mode mode)
 {
-	struct device *dev = &pdev->dev;
-	struct net_device *ndev;
-	struct ifi_canfd_priv *priv;
-	struct resource *res;
-	void __iomem *addr;
-	int irq, ret;
-	u32 id, rev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	addr = devm_ioremap_resource(dev, res);
-	irq = platform_get_irq(pdev, 0);
-	if (IS_ERR(addr) || irq < 0)
-		return -EINVAL;
-
-	id = readl(addr + IFI_CANFD_IP_ID);
-	if (id != IFI_CANFD_IP_ID_VALUE) {
-		dev_err(dev, "This block is not IFI CANFD, id=%08x\n", id);
-		return -EINVAL;
+	switch (mode) {
+	case CAN_MODE_START:
+		ifi_canfd_start(ndev);
+		netif_wake_queue(ndev);
+		break;
+	default:
+		return -EOPNOTSUPP;
 	}
 
-	rev = readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
-	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
-		dev_err(dev, "This block is too old (rev %i), minimum supported is rev %i\n",
-			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
-		return -EINVAL;
-	}
+	return 0;
+}
 
-	ndev = alloc_candev(sizeof(*priv), 1);
-	if (!ndev)
-		return -ENOMEM;
+struct net_device *alloc_ifi_canfd_dev(int sizeof_priv, int echo_skb_max)
+{
+	struct net_device *ndev;
+	struct ifi_canfd_priv *priv;
 
-	ndev->irq = irq;
-	ndev->flags |= IFF_ECHO;	/* we support local echo */
-	ndev->netdev_ops = &ifi_canfd_netdev_ops;
+	ndev = alloc_candev(sizeof(struct ifi_canfd_priv) + sizeof_priv,
+			    echo_skb_max);
+	if (!ndev)
+		return NULL;
 
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
-	priv->base = addr;
-
-	netif_napi_add(ndev, &priv->napi, ifi_canfd_poll, 64);
-
-	priv->can.state = CAN_STATE_STOPPED;
-
-	priv->can.clock.freq = readl(addr + IFI_CANFD_CANCLOCK);
 
 	priv->can.bittiming_const	= &ifi_canfd_bittiming_const;
 	priv->can.data_bittiming_const	= &ifi_canfd_bittiming_const;
@@ -999,54 +797,36 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 				       CAN_CTRLMODE_FD_NON_ISO |
 				       CAN_CTRLMODE_BERR_REPORTING;
 
-	platform_set_drvdata(pdev, ndev);
-	SET_NETDEV_DEV(ndev, dev);
+	return ndev;
+}
+EXPORT_SYMBOL_GPL(alloc_ifi_canfd_dev);
 
-	ret = register_candev(ndev);
-	if (ret) {
-		dev_err(dev, "Failed to register (ret=%d)\n", ret);
-		goto err_reg;
-	}
+void free_ifi_canfd_dev(struct net_device *ndev)
+{
+	free_candev(ndev);
+}
+EXPORT_SYMBOL_GPL(free_ifi_canfd_dev);
 
-	devm_can_led_init(ndev);
+int register_ifi_canfd_dev(struct net_device *ndev)
+{
+	int ret;
 
-	dev_info(dev, "Driver registered: regs=%p, irq=%d, clock=%d\n",
-		 priv->base, ndev->irq, priv->can.clock.freq);
+	ndev->netdev_ops = &ifi_canfd_netdev_ops;
+	ndev->flags |= IFF_ECHO;
 
-	return 0;
+	ret =  register_candev(ndev);
+	if (!ret)
+		devm_can_led_init(ndev);
 
-err_reg:
-	free_candev(ndev);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(register_ifi_canfd_dev);
 
-static int ifi_canfd_plat_remove(struct platform_device *pdev)
+void unregister_ifi_canfd_dev(struct net_device *ndev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
-
 	unregister_candev(ndev);
-	platform_set_drvdata(pdev, NULL);
-	free_candev(ndev);
-
-	return 0;
 }
-
-static const struct of_device_id ifi_canfd_of_table[] = {
-	{ .compatible = "ifi,canfd-1.0", .data = NULL },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, ifi_canfd_of_table);
-
-static struct platform_driver ifi_canfd_plat_driver = {
-	.driver = {
-		.name		= KBUILD_MODNAME,
-		.of_match_table	= ifi_canfd_of_table,
-	},
-	.probe	= ifi_canfd_plat_probe,
-	.remove	= ifi_canfd_plat_remove,
-};
-
-module_platform_driver(ifi_canfd_plat_driver);
+EXPORT_SYMBOL_GPL(unregister_ifi_canfd_dev);
 
 MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.h b/drivers/net/can/ifi_canfd/ifi_canfd.h
new file mode 100644
index 000000000000..1954157615d8
--- /dev/null
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.h
@@ -0,0 +1,341 @@
+/*
+ * CAN bus driver for IFI CANFD controller
+ *
+ * Copyright (C) 2016 Marek Vasut <marex@denx.de>
+ *
+ * Details about this controller can be found at
+ * http://www.ifi-pld.de/IP/CANFD/canfd.html
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef IFI_CANFD_H_
+#define IFI_CANFD_H_
+
+#define IFI_CANFD_STCMD				0x0
+#define IFI_CANFD_STCMD_HARDRESET		0xDEADCAFD
+#define IFI_CANFD_STCMD_ENABLE			BIT(0)
+#define IFI_CANFD_STCMD_ERROR_ACTIVE		BIT(2)
+#define IFI_CANFD_STCMD_ERROR_PASSIVE		BIT(3)
+#define IFI_CANFD_STCMD_BUSOFF			BIT(4)
+#define IFI_CANFD_STCMD_ERROR_WARNING		BIT(5)
+#define IFI_CANFD_STCMD_BUSMONITOR		BIT(16)
+#define IFI_CANFD_STCMD_LOOPBACK		BIT(18)
+#define IFI_CANFD_STCMD_DISABLE_CANFD		BIT(24)
+#define IFI_CANFD_STCMD_ENABLE_ISO		BIT(25)
+#define IFI_CANFD_STCMD_ENABLE_7_9_8_8_TIMING	BIT(26)
+#define IFI_CANFD_STCMD_NORMAL_MODE		((u32)BIT(31))
+
+#define IFI_CANFD_RXSTCMD			0x4
+#define IFI_CANFD_RXSTCMD_REMOVE_MSG		BIT(0)
+#define IFI_CANFD_RXSTCMD_RESET			BIT(7)
+#define IFI_CANFD_RXSTCMD_EMPTY			BIT(8)
+#define IFI_CANFD_RXSTCMD_OVERFLOW		BIT(13)
+#define IFI_CANFD_RXSTCMD_FIFO_NUMBER		0xFFFF0000
+#define IFI_CANFD_RXSTCMD_FIFO_NUMBER_OFF	16
+
+#define IFI_CANFD_TXSTCMD			0x8
+#define IFI_CANFD_TXSTCMD_ADD_MSG		BIT(0)
+#define IFI_CANFD_TXSTCMD_HIGH_PRIO		BIT(1)
+#define IFI_CANFD_TXSTCMD_REMOVE_PEND_MSG	BIT(6)
+#define IFI_CANFD_TXSTCMD_RESET			BIT(7)
+#define IFI_CANFD_TXSTCMD_EMPTY			BIT(8)
+#define IFI_CANFD_TXSTCMD_FULL			BIT(12)
+#define IFI_CANFD_TXSTCMD_OVERFLOW		BIT(13)
+
+#define IFI_CANFD_INTERRUPT			0xc
+#define IFI_CANFD_INTERRUPT_ERROR_BUSOFF	BIT(0)
+#define IFI_CANFD_INTERRUPT_ERROR_WARNING	BIT(1)
+#define IFI_CANFD_INTERRUPT_ERROR_STATE_CHG	BIT(2)
+#define IFI_CANFD_INTERRUPT_ERROR_REC_TEC_INC	BIT(3)
+#define IFI_CANFD_INTERRUPT_ERROR_COUNTER	BIT(10)
+#define IFI_CANFD_INTERRUPT_TXFIFO_EMPTY	BIT(16)
+#define IFI_CANFD_INTERRUPT_TXFIFO_OVERFLOW	BIT(21)
+#define IFI_CANFD_INTERRUPT_TXFIFO_REMOVE	BIT(22)
+#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY	BIT(24)
+#define IFI_CANFD_INTERRUPT_RXFIFO_NEMPTY_PER	BIT(25)
+#define IFI_CANFD_INTERRUPT_RXFIFO_OVERFLOW	BIT(30)
+#define IFI_CANFD_INTERRUPT_SET_IRQ		((u32)BIT(31))
+
+#define IFI_CANFD_IRQMASK			0x10
+#define IFI_CANFD_IRQMASK_ERROR_BUSOFF		BIT(0)
+#define IFI_CANFD_IRQMASK_ERROR_WARNING		BIT(1)
+#define IFI_CANFD_IRQMASK_ERROR_STATE_CHG	BIT(2)
+#define IFI_CANFD_IRQMASK_ERROR_REC_TEC_INC	BIT(3)
+#define IFI_CANFD_IRQMASK_SET_ERR		BIT(7)
+#define IFI_CANFD_IRQMASK_SET_TS		BIT(15)
+#define IFI_CANFD_IRQMASK_TXFIFO_EMPTY		BIT(16)
+#define IFI_CANFD_IRQMASK_SET_TX		BIT(23)
+#define IFI_CANFD_IRQMASK_RXFIFO_NEMPTY		BIT(24)
+#define IFI_CANFD_IRQMASK_RXFIFO_OVERFLOW	BIT(30)
+#define IFI_CANFD_IRQMASK_SET_RX		((u32)BIT(31))
+
+#define IFI_CANFD_TIME				0x14
+#define IFI_CANFD_FTIME				0x18
+#define IFI_CANFD_TIME_TIMEB_OFF		0
+#define IFI_CANFD_TIME_TIMEA_OFF		8
+#define IFI_CANFD_TIME_PRESCALE_OFF		16
+#define IFI_CANFD_TIME_SJW_OFF_7_9_8_8		25
+#define IFI_CANFD_TIME_SJW_OFF_4_12_6_6		28
+#define IFI_CANFD_TIME_SET_SJW_4_12_6_6		BIT(6)
+#define IFI_CANFD_TIME_SET_TIMEB_4_12_6_6	BIT(7)
+#define IFI_CANFD_TIME_SET_PRESC_4_12_6_6	BIT(14)
+#define IFI_CANFD_TIME_SET_TIMEA_4_12_6_6	BIT(15)
+
+#define IFI_CANFD_TDELAY			0x1c
+#define IFI_CANFD_TDELAY_DEFAULT		0xb
+#define IFI_CANFD_TDELAY_MASK			0x3fff
+#define IFI_CANFD_TDELAY_ABS			BIT(14)
+#define IFI_CANFD_TDELAY_EN			BIT(15)
+
+#define IFI_CANFD_ERROR				0x20
+#define IFI_CANFD_ERROR_TX_OFFSET		0
+#define IFI_CANFD_ERROR_TX_MASK			0xff
+#define IFI_CANFD_ERROR_RX_OFFSET		16
+#define IFI_CANFD_ERROR_RX_MASK			0xff
+
+#define IFI_CANFD_ERRCNT			0x24
+
+#define IFI_CANFD_SUSPEND			0x28
+
+#define IFI_CANFD_REPEAT			0x2c
+
+#define IFI_CANFD_TRAFFIC			0x30
+
+#define IFI_CANFD_TSCONTROL			0x34
+
+#define IFI_CANFD_TSC				0x38
+
+#define IFI_CANFD_TST				0x3c
+
+#define IFI_CANFD_RES1				0x40
+
+#define IFI_CANFD_ERROR_CTR			0x44
+#define IFI_CANFD_ERROR_CTR_UNLOCK_MAGIC	0x21302899
+#define IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST	BIT(0)
+#define IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST	BIT(1)
+#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST	BIT(2)
+#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST	BIT(3)
+#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST	BIT(4)
+#define IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST	BIT(5)
+#define IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST	BIT(6)
+#define IFI_CANFD_ERROR_CTR_OVERLOAD_ALL	BIT(8)
+#define IFI_CANFD_ERROR_CTR_ACK_ERROR_ALL	BIT(9)
+#define IFI_CANFD_ERROR_CTR_BIT0_ERROR_ALL	BIT(10)
+#define IFI_CANFD_ERROR_CTR_BIT1_ERROR_ALL	BIT(11)
+#define IFI_CANFD_ERROR_CTR_STUFF_ERROR_ALL	BIT(12)
+#define IFI_CANFD_ERROR_CTR_CRC_ERROR_ALL	BIT(13)
+#define IFI_CANFD_ERROR_CTR_FORM_ERROR_ALL	BIT(14)
+#define IFI_CANFD_ERROR_CTR_BITPOSITION_OFFSET	16
+#define IFI_CANFD_ERROR_CTR_ERROR_FIRST_MASK	0x000000FF
+#define IFI_CANFD_ERROR_CTR_ERROR_ALL_MASK	0x00007F00
+#define IFI_CANFD_ERROR_CTR_BITPOSITION_MASK	0x03ff0000
+#define IFI_CANFD_ERROR_CTR_ERRORFRAME_RESET	BIT(26)
+#define IFI_CANFD_ERROR_CTR_OVERLOAD_RESET	BIT(27)
+#define IFI_CANFD_ERROR_CTR_ERRORFRAME_PEND	BIT(28)
+#define IFI_CANFD_ERROR_CTR_OVERLOAD_PEND	BIT(29)
+#define IFI_CANFD_ERROR_CTR_ER_RESET		BIT(30)
+#define IFI_CANFD_ERROR_CTR_ER_ENABLE		((u32)BIT(31))
+
+#define IFI_CANFD_PAR				0x48
+#define IFI_CANFD_PAR_TX_SIZE			0x000000FF
+#define IFI_CANFD_PAR_RX_SIZE			0x0000FF00
+#define IFI_CANFD_PAR_SINGLE_CLOCK		BIT(16)
+#define IFI_CANFD_PAR_NO_TSTAMP			BIT(17)
+#define IFI_CANFD_PAR_NO_FILTER			BIT(18)
+#define IFI_CANFD_PAR_NO_BUSSTAT		BIT(19)
+
+#define IFI_CANFD_CANCLOCK			0x4c
+
+#define IFI_CANFD_SYSCLOCK			0x50
+
+#define IFI_CANFD_VER				0x54
+#define IFI_CANFD_VER_REV_MASK			0xff
+#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
+
+#define IFI_CANFD_IP_ID				0x58
+#define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
+
+#define IFI_CANFD_TEST				0x5c
+
+#define IFI_CANFD_RXFIFO_TS_63_32		0x60
+
+#define IFI_CANFD_RXFIFO_TS_31_0		0x64
+
+#define IFI_CANFD_RXFIFO_DLC			0x68
+#define IFI_CANFD_RXFIFO_DLC_DLC_OFFSET		0
+#define IFI_CANFD_RXFIFO_DLC_DLC_MASK		0xf
+#define IFI_CANFD_RXFIFO_DLC_RTR		BIT(4)
+#define IFI_CANFD_RXFIFO_DLC_EDL		BIT(5)
+#define IFI_CANFD_RXFIFO_DLC_BRS		BIT(6)
+#define IFI_CANFD_RXFIFO_DLC_ESI		BIT(7)
+#define IFI_CANFD_RXFIFO_DLC_OBJ_OFFSET		8
+#define IFI_CANFD_RXFIFO_DLC_OBJ_MASK		0x0001ff00
+#define IFI_CANFD_RXFIFO_DLC_FNR_OFFSET		24
+#define IFI_CANFD_RXFIFO_DLC_FNR_MASK		0xff000000
+
+#define IFI_CANFD_RXFIFO_ID			0x6c
+#define IFI_CANFD_RXFIFO_ID_ID_OFFSET		0
+#define IFI_CANFD_RXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
+#define IFI_CANFD_RXFIFO_ID_ID_STD_OFFSET	0
+#define IFI_CANFD_RXFIFO_ID_ID_STD_WIDTH	10
+#define IFI_CANFD_RXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
+#define IFI_CANFD_RXFIFO_ID_ID_XTD_OFFSET	11
+#define IFI_CANFD_RXFIFO_ID_ID_XTD_WIDTH	18
+#define IFI_CANFD_RXFIFO_ID_IDE			BIT(29)
+
+#define IFI_CANFD_RXFIFO_DATA			0x70
+
+#define IFI_CANFD_TXFIFO_SUSPEND_US		0xb0
+
+#define IFI_CANFD_TXFIFO_REPEATCOUNT		0xb4
+
+#define IFI_CANFD_TXFIFO_DLC			0xb8
+#define IFI_CANFD_TXFIFO_DLC_DLC_OFFSET		0
+#define IFI_CANFD_TXFIFO_DLC_DLC_MASK		0xf
+#define IFI_CANFD_TXFIFO_DLC_RTR		BIT(4)
+#define IFI_CANFD_TXFIFO_DLC_EDL		BIT(5)
+#define IFI_CANFD_TXFIFO_DLC_BRS		BIT(6)
+#define IFI_CANFD_TXFIFO_DLC_FNR_OFFSET		24
+#define IFI_CANFD_TXFIFO_DLC_FNR_MASK		0xff
+
+#define IFI_CANFD_TXFIFO_ID			0xbc
+#define IFI_CANFD_TXFIFO_ID_ID_OFFSET		0
+#define IFI_CANFD_TXFIFO_ID_ID_STD_MASK		CAN_SFF_MASK
+#define IFI_CANFD_TXFIFO_ID_ID_STD_OFFSET	0
+#define IFI_CANFD_TXFIFO_ID_ID_STD_WIDTH	10
+#define IFI_CANFD_TXFIFO_ID_ID_XTD_MASK		CAN_EFF_MASK
+#define IFI_CANFD_TXFIFO_ID_ID_XTD_OFFSET	11
+#define IFI_CANFD_TXFIFO_ID_ID_XTD_WIDTH	18
+#define IFI_CANFD_TXFIFO_ID_IDE			BIT(29)
+
+#define IFI_CANFD_TXFIFO_DATA			0xc0
+
+#define IFI_CANFD_FILTER_MASK(n)		(0x800 + ((n) * 8) + 0)
+#define IFI_CANFD_FILTER_MASK_EXT		BIT(29)
+#define IFI_CANFD_FILTER_MASK_EDL		BIT(30)
+#define IFI_CANFD_FILTER_MASK_VALID		((u32)BIT(31))
+
+#define IFI_CANFD_FILTER_IDENT(n)		(0x800 + ((n) * 8) + 4)
+#define IFI_CANFD_FILTER_IDENT_IDE		BIT(29)
+#define IFI_CANFD_FILTER_IDENT_CANFD		BIT(30)
+#define IFI_CANFD_FILTER_IDENT_VALID		((u32)BIT(31))
+
+#define IFI_CANFD_CUSTOM_IRQ_HANDLING		0x1
+
+/**
+ * struct ifi_canfd_priv - IFI CANFD device
+ * @can: CAN common private data
+ * @napi: Structure for NAPI scheduling
+ * @ndev: Network Device data
+ * @base: Base address
+ * @priv: additional field for device specific specific programming
+ * @flags: Custom mode flags
+ * @pre_irq: function pointers for custom pre-irq functionality
+ * @post_irq: function pointers for custom post-irq functionality
+ *
+ * Contains common fields of an IFI CANFD device
+ */
+struct ifi_canfd_priv {
+	struct can_priv		can;	/* must be the first member */
+	struct napi_struct	napi;
+	struct net_device	*ndev;
+	void __iomem		*base;
+
+	void			*priv;	/* custom content */
+	u16			flags;	/* custom mode flags*/
+
+	void (*pre_irq)(const struct ifi_canfd_priv *priv);
+	void (*post_irq)(const struct ifi_canfd_priv *priv);
+};
+
+/**
+ * ifi_canfd_irq_enable() - Enable/disable interrupt mode
+ * @ndev: Network device (CAN)
+ * @enable: flag 1-enable,0-disable
+ * @clear: flag to clear interrupts when set to 1
+ *
+ * Enables/disables/clears interrupts on request
+ *
+ * Return: None
+ */
+void ifi_canfd_irq_enable(struct net_device *ndev, bool enable, u8 clear);
+
+/**
+ * ifi_canfd_set_filters() - Set Filter masks and IDs
+ * @ndev: Network device (CAN)
+ * @enable: enable/disable flag
+ *
+ * Sets filter masks and IDs for standard/extended CAN and CANFD frames
+ *
+ * Return: None
+ */
+void ifi_canfd_set_filters(struct net_device *ndev, bool enable);
+
+/**
+ * ifi_canfd_poll() - NAPI polling function
+ * @napi: Structure for NAPI scheduling similar to tasklet but with weighting
+ * @quota: Places a limit on the amount of work the driver may do.
+ *	   If and only if the return value is less than the budget, your driver
+ *	   must reenable interrupts and turn off polling
+ *
+ * Polls driver to pick up all available packets when interrupt is serviced
+ *
+ * Return: No. of packets processed
+ */
+int ifi_canfd_poll(struct napi_struct *napi, int quota);
+
+/**
+ * ifi_canfd_isr()
+ * @irq: IRQ Number
+ * @dev_id: Device ID
+ *
+ * This function is executed on reception of an interrupt
+ *
+ * Return: Interrupt handling status
+ */
+irqreturn_t ifi_canfd_isr(int irq, void *dev_id);
+
+/**
+ * alloc_ifi_canfd_dev() - Allocate CAN device
+ * @sizeof_priv: size of device interface
+ * @echo_skb_max: max. number of sockets
+ *
+ * Allocates a CAN device
+ *
+ * Return: Network device allocated
+ */
+struct net_device *alloc_ifi_canfd_dev(int sizeof_priv, int echo_skb_max);
+
+/**
+ * free_ifi_canfd_dev() - Free CAN device
+ * @ndev: Network device (CAN)
+ *
+ * Frees previously allocated CAN device
+ *
+ * Return: None
+ */
+void free_ifi_canfd_dev(struct net_device *ndev);
+
+/**
+ * register_ifi_canfd_dev() - Register CAN device
+ * @ndev: Network device (CAN)
+ *
+ * Registers CAN device and sets netdev_ops structure
+ *
+ * Return: return code register_candev
+ */
+int register_ifi_canfd_dev(struct net_device *ndev);
+
+/**
+ * unregister_ifi_canfd_dev() - Unregister CAN device
+ * @ndev: Network device (CAN)
+ *
+ * Unregisters CAN device
+ *
+ * Return: None
+ */
+void unregister_ifi_canfd_dev(struct net_device *ndev);
+
+#endif /* IFI_CANFD_H_ */
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd_platform.c b/drivers/net/can/ifi_canfd/ifi_canfd_platform.c
new file mode 100644
index 000000000000..2bbcfc2d77ce
--- /dev/null
+++ b/drivers/net/can/ifi_canfd/ifi_canfd_platform.c
@@ -0,0 +1,121 @@
+/*
+ * CAN bus driver for IFI CANFD controller
+ *
+ * Copyright (C) 2016 Marek Vasut <marex@denx.de>
+ *
+ * Details about this controller can be found at
+ * http://www.ifi-pld.de/IP/CANFD/canfd.html
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <linux/can/dev.h>
+#include "ifi_canfd.h"
+
+static int ifi_canfd_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct net_device *ndev;
+	struct ifi_canfd_priv *priv;
+	struct resource *res;
+	void __iomem *addr;
+	int irq, ret;
+	u32 id, rev;
+
+	dev_err(dev, "IFI-FD Probe start\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	addr = devm_ioremap_resource(dev, res);
+	irq = platform_get_irq(pdev, 0);
+	if (IS_ERR(addr) || irq < 0)
+		return -EINVAL;
+
+	id = readl(addr + IFI_CANFD_IP_ID);
+	if (id != IFI_CANFD_IP_ID_VALUE) {
+		dev_err(dev, "This block is not IFI CANFD, id=%08x\n", id);
+		return -EINVAL;
+	}
+
+	rev = readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
+	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
+		dev_err(dev, "This block is too old (rev %i), minimum supported is rev %i\n",
+			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
+		return -EINVAL;
+	}
+
+	ndev = alloc_ifi_canfd_dev(0, 1);
+	if (!ndev)
+		return -ENOMEM;
+
+	priv = netdev_priv(ndev);
+
+	priv->can.state = CAN_STATE_STOPPED;
+	priv->can.clock.freq = readl(addr + IFI_CANFD_CANCLOCK);
+
+	ndev->irq = irq;
+	priv->base = addr;
+
+	netif_napi_add(ndev, &priv->napi, ifi_canfd_poll, 64);
+
+	platform_set_drvdata(pdev, ndev);
+	SET_NETDEV_DEV(ndev, dev);
+
+	ret = register_ifi_canfd_dev(ndev);
+	if (ret) {
+		dev_err(dev, "Failed to register (ret=%d)\n", ret);
+		goto err_reg;
+	}
+
+	dev_info(dev, "Driver registered: regs=%p, irq=%d, clock=%d\n",
+		 priv->base, ndev->irq, priv->can.clock.freq);
+
+	return 0;
+
+err_reg:
+	free_ifi_canfd_dev(ndev);
+	return ret;
+}
+
+static int ifi_canfd_plat_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+
+	unregister_ifi_canfd_dev(ndev);
+	platform_set_drvdata(pdev, NULL);
+	free_ifi_canfd_dev(ndev);
+
+	return 0;
+}
+
+static const struct of_device_id ifi_canfd_of_table[] = {
+	{ .compatible = "ifi,canfd-1.0", .data = NULL },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ifi_canfd_of_table);
+
+static struct platform_driver ifi_canfd_plat_driver = {
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= ifi_canfd_of_table,
+	},
+	.probe	= ifi_canfd_plat_probe,
+	.remove	= ifi_canfd_plat_remove,
+};
+
+module_platform_driver(ifi_canfd_plat_driver);
+
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CAN bus driver for IFI CANFD controller");
-- 
2.17.1

