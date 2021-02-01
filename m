Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FBC30A8C4
	for <lists+linux-can@lfdr.de>; Mon,  1 Feb 2021 14:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBANbM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 1 Feb 2021 08:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhBANaz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 1 Feb 2021 08:30:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23107C06174A
        for <linux-can@vger.kernel.org>; Mon,  1 Feb 2021 05:30:14 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l6ZHQ-0000KE-Nm
        for linux-can@vger.kernel.org; Mon, 01 Feb 2021 14:30:12 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C33645D3CA3
        for <linux-can@vger.kernel.org>; Mon,  1 Feb 2021 13:30:11 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 30B895D3C9E;
        Mon,  1 Feb 2021 13:30:11 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 86214b3b;
        Mon, 1 Feb 2021 13:30:10 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de, linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mcp251xfd: add coredump support
Date:   Mon,  1 Feb 2021 14:30:07 +0100
Message-Id: <20210201133007.3260567-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

For easier debugging this patch adds dev coredump support to the
driver. A dev coredump is generated in case the chip fails to start or
an error in the interrupt handler is detected.

The dev coredump consists of all chip registers and chip memory, as
well as the driver's internal state of the TEF-, TX- and RX-FIFOs.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/Kconfig         |   1 +
 drivers/net/can/spi/mcp251xfd/Makefile        |   2 +
 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    |   2 +
 .../net/can/spi/mcp251xfd/mcp251xfd-dump.c    | 265 ++++++++++++++++++
 .../net/can/spi/mcp251xfd/mcp251xfd-dump.h    |  45 +++
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   8 +
 6 files changed, 323 insertions(+)
 create mode 100644 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
 create mode 100644 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.h

diff --git a/drivers/net/can/spi/mcp251xfd/Kconfig b/drivers/net/can/spi/mcp251xfd/Kconfig
index f5a147a92cb2..dd0fc0a54be1 100644
--- a/drivers/net/can/spi/mcp251xfd/Kconfig
+++ b/drivers/net/can/spi/mcp251xfd/Kconfig
@@ -3,6 +3,7 @@
 config CAN_MCP251XFD
 	tristate "Microchip MCP251xFD SPI CAN controllers"
 	select REGMAP
+	select WANT_DEV_COREDUMP
 	help
 	  Driver for the Microchip MCP251XFD SPI FD-CAN controller
 	  family.
diff --git a/drivers/net/can/spi/mcp251xfd/Makefile b/drivers/net/can/spi/mcp251xfd/Makefile
index cb71244cbe89..e87e668a08a0 100644
--- a/drivers/net/can/spi/mcp251xfd/Makefile
+++ b/drivers/net/can/spi/mcp251xfd/Makefile
@@ -6,3 +6,5 @@ mcp251xfd-objs :=
 mcp251xfd-objs += mcp251xfd-core.o
 mcp251xfd-objs += mcp251xfd-crc16.o
 mcp251xfd-objs += mcp251xfd-regmap.o
+
+mcp251xfd-$(CONFIG_DEV_COREDUMP) += mcp251xfd-dump.o
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3c5b92911d46..cf776578ad57 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1099,6 +1099,7 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	return 0;
 
  out_chip_stop:
+	mcp251xfd_dump(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 
 	return err;
@@ -2287,6 +2288,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
  out_fail:
 	netdev_err(priv->ndev, "IRQ handler returned %d (intf=0x%08x).\n",
 		   err, priv->regs_status.intf);
+	mcp251xfd_dump(priv);
 	mcp251xfd_chip_interrupts_disable(priv);
 
 	return handled;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
new file mode 100644
index 000000000000..2989df783535
--- /dev/null
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mcp251xfd - Microchip MCP251xFD Family CAN controller driver
+//
+// Copyright (c) 2020, 2021 Pengutronix,
+//               Marc Kleine-Budde <kernel@pengutronix.de>
+// Copyright (C) 2015-2018 Etnaviv Project
+//
+
+#include <linux/devcoredump.h>
+
+#include "mcp251xfd.h"
+#include "mcp251xfd-dump.h"
+
+struct mcp251xfd_dump_iter {
+	void *start;
+	struct mcp251xfd_dump_object_header *hdr;
+	void *data;
+};
+
+struct mcp251xfd_dump_reg_space {
+	u16 base;
+	u16 size;
+};
+
+struct mcp251xfd_dump_ring {
+	enum mcp251xfd_dump_object_ring_key key;
+	u32 val;
+};
+
+static const struct mcp251xfd_dump_reg_space
+mcp251xfd_dump_reg_space[] = {
+	{
+		.base = MCP251XFD_REG_CON,
+		.size = MCP251XFD_REG_FLTOBJ(32) - MCP251XFD_REG_CON,
+	}, {
+		.base = MCP251XFD_RAM_START,
+		.size = MCP251XFD_RAM_SIZE,
+	}, {
+		.base = MCP251XFD_REG_OSC,
+		.size = MCP251XFD_REG_DEVID - MCP251XFD_REG_OSC,
+	},
+};
+
+static void
+mcp251xfd_dump_header(struct mcp251xfd_dump_iter *iter,
+		      enum mcp251xfd_dump_object object, void *data_end)
+{
+	struct mcp251xfd_dump_object_header *hdr = iter->hdr;
+
+	hdr->magic = cpu_to_le32(MCP251XFD_DUMP_MAGIC);
+	hdr->object = cpu_to_le32(object);
+	hdr->file_offset = cpu_to_le32(iter->data - iter->start);
+	hdr->file_size = cpu_to_le32(data_end - iter->data);
+
+	iter->hdr++;
+	iter->data += le32_to_cpu(hdr->file_size);
+}
+
+static void mcp251xfd_dump_registers(const struct mcp251xfd_priv *priv,
+				     struct mcp251xfd_dump_iter *iter)
+{
+	struct mcp251xfd_dump_object_reg *reg = iter->data;
+	unsigned int i, j;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(mcp251xfd_dump_reg_space); i++) {
+		const struct mcp251xfd_dump_reg_space *reg_space;
+		void *buf;
+
+		reg_space = &mcp251xfd_dump_reg_space[i];
+
+		buf = kmalloc(reg_space->size, GFP_KERNEL);
+		if (!buf)
+			return;
+
+		err = regmap_bulk_read(priv->map_reg, reg_space->base,
+				       buf, reg_space->size / sizeof(u32));
+		if (err) {
+			kfree(buf);
+			return;
+		}
+
+		for (j = 0; j < reg_space->size; j += sizeof(u32), reg++) {
+			reg->reg = cpu_to_le32(reg_space->base + j);
+			reg->val = cpu_to_le32p(buf + j);
+		}
+
+		kfree(buf);
+	}
+
+	mcp251xfd_dump_header(iter, MCP251XFD_DUMP_OBJECT_REG, reg);
+}
+
+static void mcp251xfd_dump_ring(struct mcp251xfd_dump_iter *iter,
+				enum mcp251xfd_dump_object object,
+				const struct mcp251xfd_dump_ring *dump_ring,
+				unsigned int len)
+{
+	struct mcp251xfd_dump_object_reg *reg = iter->data;
+	unsigned int i;
+
+	for (i = 0; i < len; i++, reg++) {
+		reg->reg = cpu_to_le32(dump_ring[i].key);
+		reg->val = cpu_to_le32(dump_ring[i].val);
+	}
+
+	mcp251xfd_dump_header(iter, object, reg);
+}
+
+static void mcp251xfd_dump_tef_ring(const struct mcp251xfd_priv *priv,
+				    struct mcp251xfd_dump_iter *iter)
+{
+	const struct mcp251xfd_tef_ring *tef = priv->tef;
+	const struct mcp251xfd_tx_ring *tx = priv->tx;
+	const struct mcp251xfd_dump_ring dump_ring[] = {
+		{
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_HEAD,
+			.val = tef->head,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_TAIL,
+			.val = tef->tail,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_BASE,
+			.val = 0,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_NR,
+			.val = 0,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_FIFO_NR,
+			.val = 0,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_NUM,
+			.val = tx->obj_num,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_SIZE,
+			.val = sizeof(struct mcp251xfd_hw_tef_obj),
+		},
+	};
+
+	mcp251xfd_dump_ring(iter, MCP251XFD_DUMP_OBJECT_TEF,
+			    dump_ring, ARRAY_SIZE(dump_ring));
+}
+
+static void mcp251xfd_dump_tx_ring(const struct mcp251xfd_priv *priv,
+				   struct mcp251xfd_dump_iter *iter)
+{
+	const struct mcp251xfd_tx_ring *tx = priv->tx;
+	const struct mcp251xfd_dump_ring dump_ring[] = {
+		{
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_HEAD,
+			.val = tx->head,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_TAIL,
+			.val = tx->tail,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_BASE,
+			.val = tx->base,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_NR,
+			.val = 0,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_FIFO_NR,
+			.val = MCP251XFD_TX_FIFO,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_NUM,
+			.val = tx->obj_num,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_SIZE,
+			.val = tx->obj_size,
+		},
+	};
+
+	mcp251xfd_dump_ring(iter, MCP251XFD_DUMP_OBJECT_TX,
+			    dump_ring, ARRAY_SIZE(dump_ring));
+}
+
+static void mcp251xfd_dump_rx_ring_one(const struct mcp251xfd_priv *priv,
+				       struct mcp251xfd_dump_iter *iter,
+				       const struct mcp251xfd_rx_ring *rx)
+{
+	const struct mcp251xfd_dump_ring dump_ring[] = {
+		{
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_HEAD,
+			.val = rx->head,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_TAIL,
+			.val = rx->tail,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_BASE,
+			.val = rx->base,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_NR,
+			.val = rx->nr,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_FIFO_NR,
+			.val = rx->fifo_nr,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_NUM,
+			.val = rx->obj_num,
+		}, {
+			.key = MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_SIZE,
+			.val = rx->obj_size,
+		},
+	};
+
+	mcp251xfd_dump_ring(iter, MCP251XFD_DUMP_OBJECT_RX,
+			    dump_ring, ARRAY_SIZE(dump_ring));
+}
+
+static void mcp251xfd_dump_rx_ring(const struct mcp251xfd_priv *priv,
+				   struct mcp251xfd_dump_iter *iter)
+{
+	struct mcp251xfd_rx_ring *rx_ring;
+	unsigned int i;
+
+	mcp251xfd_for_each_rx_ring(priv, rx_ring, i)
+		mcp251xfd_dump_rx_ring_one(priv, iter, rx_ring);
+}
+
+void mcp251xfd_dump(const struct mcp251xfd_priv *priv)
+{
+	struct mcp251xfd_dump_iter iter;
+	unsigned int rings_num, obj_num;
+	unsigned int file_size = 0;
+	unsigned int i;
+
+	/* register space + end marker */
+	obj_num = 2;
+
+	/* register space */
+	for (i = 0; i < ARRAY_SIZE(mcp251xfd_dump_reg_space); i++)
+		file_size += mcp251xfd_dump_reg_space[i].size / sizeof(u32) *
+			sizeof(struct mcp251xfd_dump_object_reg);
+
+	/* TEF ring, TX ring, RX rings */
+	rings_num = 2 + priv->rx_ring_num;
+	obj_num += rings_num;
+	file_size += rings_num * __MCP251XFD_DUMP_OBJECT_RING_KEY_MAX  *
+		sizeof(struct mcp251xfd_dump_object_reg);
+
+	/* size of the headers */
+	file_size += sizeof(*iter.hdr) * obj_num;
+
+	/* allocate the file in vmalloc memory, it's likely to be big */
+	iter.start = __vmalloc(file_size, GFP_KERNEL | __GFP_NOWARN |
+			       __GFP_ZERO | __GFP_NORETRY);
+	if (!iter.start) {
+		netdev_warn(priv->ndev, "Failed to allocate devcoredump file.\n");
+		return;
+	}
+
+	/* point the data member after the headers */
+	iter.hdr = iter.start;
+	iter.data = &iter.hdr[obj_num];
+
+	mcp251xfd_dump_registers(priv, &iter);
+	mcp251xfd_dump_tef_ring(priv, &iter);
+	mcp251xfd_dump_tx_ring(priv, &iter);
+	mcp251xfd_dump_rx_ring(priv, &iter);
+	mcp251xfd_dump_header(&iter, MCP251XFD_DUMP_OBJECT_END, iter.data);
+
+	dev_coredumpv(&priv->spi->dev, iter.start,
+		      iter.data - iter.start, GFP_KERNEL);
+}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.h
new file mode 100644
index 000000000000..34628acac78e
--- /dev/null
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * mcp251xfd - Microchip MCP251xFD Family CAN controller driver
+ *
+ * Copyright (c) 2019, 2020, 2021 Pengutronix,
+ *               Marc Kleine-Budde <kernel@pengutronix.de>
+ */
+
+#ifndef _MCP251XFD_DUMP_H
+#define _MCP251XFD_DUMP_H
+
+#define MCP251XFD_DUMP_MAGIC 0x1825434d
+
+enum mcp251xfd_dump_object {
+	MCP251XFD_DUMP_OBJECT_REG,
+	MCP251XFD_DUMP_OBJECT_TEF,
+	MCP251XFD_DUMP_OBJECT_TX,
+	MCP251XFD_DUMP_OBJECT_RX,
+	MCP251XFD_DUMP_OBJECT_END = -1,
+};
+
+enum mcp251xfd_dump_object_ring_key {
+	MCP251XFD_DUMP_OBJECT_RING_KEY_HEAD,
+	MCP251XFD_DUMP_OBJECT_RING_KEY_TAIL,
+	MCP251XFD_DUMP_OBJECT_RING_KEY_BASE,
+	MCP251XFD_DUMP_OBJECT_RING_KEY_NR,
+	MCP251XFD_DUMP_OBJECT_RING_KEY_FIFO_NR,
+	MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_NUM,
+	MCP251XFD_DUMP_OBJECT_RING_KEY_OBJ_SIZE,
+	__MCP251XFD_DUMP_OBJECT_RING_KEY_MAX,
+};
+
+struct mcp251xfd_dump_object_header {
+	__le32 magic;
+	__le32 object;
+	__le32 file_offset;
+	__le32 file_size;
+};
+
+struct mcp251xfd_dump_object_reg {
+	__le32 reg;
+	__le32 val;
+};
+
+#endif
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 480bd4480bdf..fe8be4a80798 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -838,4 +838,12 @@ u16 mcp251xfd_crc16_compute2(const void *cmd, size_t cmd_size,
 			     const void *data, size_t data_size);
 u16 mcp251xfd_crc16_compute(const void *data, size_t data_size);
 
+#if IS_ENABLED(CONFIG_DEV_COREDUMP)
+void mcp251xfd_dump(const struct mcp251xfd_priv *priv);
+#else
+static inline void mcp251xfd_dump(const struct mcp251xfd_priv *priv)
+{
+}
+#endif
+
 #endif
-- 
2.30.0


