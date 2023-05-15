Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2EB703FCF
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 23:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245545AbjEOV3v (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245364AbjEOV3u (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 17:29:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CDF10E48
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 14:29:35 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyfl8-0003IU-7O
        for linux-can@vger.kernel.org; Mon, 15 May 2023 23:29:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8792F1C5E54
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 21:29:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 88B7A1C5E50;
        Mon, 15 May 2023 21:29:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bd4e24f8;
        Mon, 15 May 2023 21:29:31 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Florian Ferg <flfe@hms-networks.de>,
        Peter Seiderer <ps.report@gmx.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v8] can: usb: IXXAT USB-to-CAN adapters drivers
Date:   Mon, 15 May 2023 23:29:30 +0200
Message-Id: <20230515212930.1019702-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Florian Ferg <flfe@hms-networks.de>

This patch adds the driver for the IXXAT USB-to-CAN interfaces. There
is an adapter for the older communication layer cl1 and another
adapter for the newer communication layer cl2.

Cc: Peter Seiderer <ps.report@gmx.net>
Signed-off-by: Florian Ferg <flfe@hms-networks.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

this is a quick port of Florian's driver to recent net-next. Compile
tested only.

regards,
Marc

 drivers/net/can/usb/Kconfig                   |   17 +
 drivers/net/can/usb/Makefile                  |    1 +
 drivers/net/can/usb/ixxat_usb/Makefile        |    2 +
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  132 ++
 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  255 ++++
 .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 1299 +++++++++++++++++
 .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  519 +++++++
 7 files changed, 2225 insertions(+)
 create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
 create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 445504ababce..9ce31848d257 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -50,6 +50,23 @@ config CAN_GS_USB
 	  choose Y for built in support,
 	  M to compile as module (module will be named: gs_usb).
 
+config CAN_IXXAT_USB
+	tristate "IXXAT USB-to-CAN interfaces"
+	help
+	  This driver adds support for IXXAT USB-to-CAN devices.
+
+	  The driver provides support for the following devices:
+	    - IXXAT USB-to-CAN compact
+	    - IXXAT USB-to-CAN embedded
+	    - IXXAT USB-to-CAN professional
+	    - IXXAT USB-to-CAN automotive
+	    - IXXAT USB-to-CAN FD compact
+	    - IXXAT USB-to-CAN FD professional
+	    - IXXAT USB-to-CAN FD automotive
+	    - IXXAT USB-to-CAN FD MiniPCIe
+	    - IXXAT USB-to-CAR
+	    - IXXAT CAN-IDM101
+
 config CAN_KVASER_USB
 	tristate "Kvaser CAN/USB interface"
 	help
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index 1ea16be5743b..d57c06e95751 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
 obj-$(CONFIG_CAN_ESD_USB) += esd_usb.o
 obj-$(CONFIG_CAN_ETAS_ES58X) += etas_es58x/
 obj-$(CONFIG_CAN_GS_USB) += gs_usb.o
+obj-$(CONFIG_CAN_IXXAT_USB) += ixxat_usb/
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb/
 obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
 obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
diff --git a/drivers/net/can/usb/ixxat_usb/Makefile b/drivers/net/can/usb/ixxat_usb/Makefile
new file mode 100644
index 000000000000..125d2705979f
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CAN_IXXAT_USB) += ixxat_usb2can.o
+ixxat_usb2can-y = ixxat_usb_cl1.o ixxat_usb_cl2.o ixxat_usb_core.o
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
new file mode 100644
index 000000000000..2a17392db583
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* CAN driver adapter for IXXAT USB-to-CAN CL1
+ *
+ * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/can/dev.h>
+#include <linux/usb.h>
+
+#include "ixxat_usb_core.h"
+
+#define IXXAT_USB_CLOCK 8000000
+
+#define IXXAT_USB_BUFFER_SIZE_RX 512
+#define IXXAT_USB_BUFFER_SIZE_TX 256
+
+#define IXXAT_USB_MODES (CAN_CTRLMODE_3_SAMPLES | \
+			 CAN_CTRLMODE_BERR_REPORTING | \
+			 CAN_CTRLMODE_LISTENONLY) \
+
+#define IXXAT_USB_BTMODE_TSM_CL1 0x80
+
+/* bittiming parameters */
+#define IXXAT_USB2CAN_TSEG1_MIN 1
+#define IXXAT_USB2CAN_TSEG1_MAX 16
+#define IXXAT_USB2CAN_TSEG2_MIN 1
+#define IXXAT_USB2CAN_TSEG2_MAX 8
+#define IXXAT_USB2CAN_SJW_MAX 4
+#define IXXAT_USB2CAN_BRP_MIN 1
+#define IXXAT_USB2CAN_BRP_MAX 64
+#define IXXAT_USB2CAN_BRP_INC 1
+
+/* USB endpoint mapping for CL1 */
+#define IXXAT_USB2CAN_EP1_IN (1 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP2_IN (2 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP3_IN (3 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP4_IN (4 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP5_IN (5 | USB_DIR_IN)
+
+#define IXXAT_USB2CAN_EP1_OUT (1 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP2_OUT (2 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP3_OUT (3 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP4_OUT (4 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP5_OUT (5 | USB_DIR_OUT)
+
+#define IXXAT_USB_CAN_CMD_INIT 0x325
+
+static const struct can_bittiming_const usb2can_bt = {
+	.name = IXXAT_USB_CTRL_NAME,
+	.tseg1_min = IXXAT_USB2CAN_TSEG1_MIN,
+	.tseg1_max = IXXAT_USB2CAN_TSEG1_MAX,
+	.tseg2_min = IXXAT_USB2CAN_TSEG2_MIN,
+	.tseg2_max = IXXAT_USB2CAN_TSEG2_MAX,
+	.sjw_max = IXXAT_USB2CAN_SJW_MAX,
+	.brp_min = IXXAT_USB2CAN_BRP_MIN,
+	.brp_max = IXXAT_USB2CAN_BRP_MAX,
+	.brp_inc = IXXAT_USB2CAN_BRP_INC,
+};
+
+static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
+{
+	const struct can_bittiming *bt = &dev->can.bittiming;
+	const u16 port = dev->ctrl_index;
+	int err;
+	struct ixxat_usb_init_cl1_cmd *cmd;
+	const u32 rcv_size = sizeof(cmd->res);
+	const u32 snd_size = sizeof(*cmd);
+	u8 opmode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
+	u8 btr0 = ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
+	u8 btr1 = ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) |
+		  (((bt->phase_seg2 - 1) & 0x7) << 4);
+
+	cmd = kmalloc(snd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		btr1 |= IXXAT_USB_BTMODE_TSM_CL1;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		opmode |= IXXAT_USB_OPMODE_ERRFRAME;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		opmode |= IXXAT_USB_OPMODE_LISTONLY;
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.size = cpu_to_le32(snd_size - rcv_size);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
+	cmd->req.port = cpu_to_le16(port);
+	cmd->mode = opmode;
+	cmd->btr0 = btr0;
+	cmd->btr1 = btr1;
+
+	err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
+				 rcv_size);
+	kfree(cmd);
+	return err;
+}
+
+const struct ixxat_usb_adapter usb2can_cl1 = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &usb2can_bt,
+	.btd = NULL,
+	.modes = IXXAT_USB_MODES,
+	.buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
+	.ep_msg_in = {
+		IXXAT_USB2CAN_EP1_IN,
+		IXXAT_USB2CAN_EP2_IN,
+		IXXAT_USB2CAN_EP3_IN,
+		IXXAT_USB2CAN_EP4_IN,
+		IXXAT_USB2CAN_EP5_IN
+	},
+	.ep_msg_out = {
+		IXXAT_USB2CAN_EP1_OUT,
+		IXXAT_USB2CAN_EP2_OUT,
+		IXXAT_USB2CAN_EP3_OUT,
+		IXXAT_USB2CAN_EP4_OUT,
+		IXXAT_USB2CAN_EP5_OUT
+	},
+	.ep_offs = 0,
+	.init_ctrl = ixxat_usb_init_ctrl
+};
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
new file mode 100644
index 000000000000..c08f323c5765
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* CAN driver adapter for IXXAT USB-to-CAN CL2
+ *
+ * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/can/dev.h>
+#include <linux/usb.h>
+
+#include "ixxat_usb_core.h"
+
+#define IXXAT_USB_CLOCK 80000000
+
+#define IXXAT_USB_BUFFER_SIZE_RX 512
+#define IXXAT_USB_BUFFER_SIZE_TX 512
+
+#define IXXAT_USB_MODES (CAN_CTRLMODE_3_SAMPLES | \
+			 CAN_CTRLMODE_LISTENONLY | \
+			 CAN_CTRLMODE_BERR_REPORTING | \
+			 CAN_CTRLMODE_FD | \
+			 CAN_CTRLMODE_FD_NON_ISO)
+
+/* bittiming parameters CL2 */
+#define IXXAT_USB2CAN_TSEG1_MIN 1
+#define IXXAT_USB2CAN_TSEG1_MAX 256
+#define IXXAT_USB2CAN_TSEG2_MIN 1
+#define IXXAT_USB2CAN_TSEG2_MAX 256
+#define IXXAT_USB2CAN_SJW_MAX 128
+#define IXXAT_USB2CAN_BRP_MIN 2
+#define IXXAT_USB2CAN_BRP_MAX 513
+#define IXXAT_USB2CAN_BRP_INC 1
+
+#define IXXAT_USB2CAN_TSEG1_MIN_DATA 1
+#define IXXAT_USB2CAN_TSEG1_MAX_DATA 256
+#define IXXAT_USB2CAN_TSEG2_MIN_DATA 1
+#define IXXAT_USB2CAN_TSEG2_MAX_DATA 256
+#define IXXAT_USB2CAN_SJW_MAX_DATA 128
+#define IXXAT_USB2CAN_BRP_MIN_DATA 2
+#define IXXAT_USB2CAN_BRP_MAX_DATA 513
+#define IXXAT_USB2CAN_BRP_INC_DATA 1
+
+/* bittiming parameters CAN IDM */
+#define IXXAT_CANIDM_TSEG1_MIN 1
+#define IXXAT_CANIDM_TSEG1_MAX 256
+#define IXXAT_CANIDM_TSEG2_MIN 1
+#define IXXAT_CANIDM_TSEG2_MAX 128
+#define IXXAT_CANIDM_SJW_MAX 128
+#define IXXAT_CANIDM_BRP_MIN 1
+#define IXXAT_CANIDM_BRP_MAX 512
+#define IXXAT_CANIDM_BRP_INC 1
+
+#define IXXAT_CANIDM_TSEG1_MIN_DATA 1
+#define IXXAT_CANIDM_TSEG1_MAX_DATA 32
+#define IXXAT_CANIDM_TSEG2_MIN_DATA 1
+#define IXXAT_CANIDM_TSEG2_MAX_DATA 16
+#define IXXAT_CANIDM_SJW_MAX_DATA 8
+#define IXXAT_CANIDM_BRP_MIN_DATA 1
+#define IXXAT_CANIDM_BRP_MAX_DATA 32
+#define IXXAT_CANIDM_BRP_INC_DATA 1
+
+/* USB endpoint mapping for CL2 */
+#define IXXAT_USB2CAN_EP1_IN (1 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP2_IN (2 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP3_IN (3 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP4_IN (4 | USB_DIR_IN)
+#define IXXAT_USB2CAN_EP5_IN (5 | USB_DIR_IN)
+
+#define IXXAT_USB2CAN_EP1_OUT (1 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP2_OUT (2 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP3_OUT (3 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP4_OUT (4 | USB_DIR_OUT)
+#define IXXAT_USB2CAN_EP5_OUT (5 | USB_DIR_OUT)
+
+/* USB endpoint mapping for CAN IDM */
+#define IXXAT_CANIDM_EP1_IN (2 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP2_IN (4 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP3_IN (6 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP4_IN (8 | USB_DIR_IN)
+#define IXXAT_CANIDM_EP5_IN (10 | USB_DIR_IN)
+
+#define IXXAT_CANIDM_EP1_OUT (1 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP2_OUT (3 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP3_OUT (5 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP4_OUT (7 | USB_DIR_OUT)
+#define IXXAT_CANIDM_EP5_OUT (9 | USB_DIR_OUT)
+
+#define IXXAT_USB_CAN_CMD_INIT 0x337
+
+static const struct can_bittiming_const usb2can_bt = {
+	.name = IXXAT_USB_CTRL_NAME,
+	.tseg1_min = IXXAT_USB2CAN_TSEG1_MIN,
+	.tseg1_max = IXXAT_USB2CAN_TSEG1_MAX,
+	.tseg2_min = IXXAT_USB2CAN_TSEG2_MIN,
+	.tseg2_max = IXXAT_USB2CAN_TSEG2_MAX,
+	.sjw_max = IXXAT_USB2CAN_SJW_MAX,
+	.brp_min = IXXAT_USB2CAN_BRP_MIN,
+	.brp_max = IXXAT_USB2CAN_BRP_MAX,
+	.brp_inc = IXXAT_USB2CAN_BRP_INC,
+};
+
+static const struct can_bittiming_const usb2can_btd = {
+	.name = IXXAT_USB_CTRL_NAME,
+	.tseg1_min = IXXAT_USB2CAN_TSEG1_MIN_DATA,
+	.tseg1_max = IXXAT_USB2CAN_TSEG1_MAX_DATA,
+	.tseg2_min = IXXAT_USB2CAN_TSEG2_MIN_DATA,
+	.tseg2_max = IXXAT_USB2CAN_TSEG2_MAX_DATA,
+	.sjw_max = IXXAT_USB2CAN_SJW_MAX_DATA,
+	.brp_min = IXXAT_USB2CAN_BRP_MIN_DATA,
+	.brp_max = IXXAT_USB2CAN_BRP_MAX_DATA,
+	.brp_inc = IXXAT_USB2CAN_BRP_INC_DATA,
+};
+
+static const struct can_bittiming_const canidm_bt = {
+	.name = IXXAT_USB_CTRL_NAME,
+	.tseg1_min = IXXAT_CANIDM_TSEG1_MIN,
+	.tseg1_max = IXXAT_CANIDM_TSEG1_MAX,
+	.tseg2_min = IXXAT_CANIDM_TSEG2_MIN,
+	.tseg2_max = IXXAT_CANIDM_TSEG2_MAX,
+	.sjw_max = IXXAT_CANIDM_SJW_MAX,
+	.brp_min = IXXAT_CANIDM_BRP_MIN,
+	.brp_max = IXXAT_CANIDM_BRP_MAX,
+	.brp_inc = IXXAT_CANIDM_BRP_INC
+};
+
+static const struct can_bittiming_const canidm_btd = {
+	.name = IXXAT_USB_CTRL_NAME,
+	.tseg1_min = IXXAT_CANIDM_TSEG1_MIN_DATA,
+	.tseg1_max = IXXAT_CANIDM_TSEG1_MAX_DATA,
+	.tseg2_min = IXXAT_CANIDM_TSEG2_MIN_DATA,
+	.tseg2_max = IXXAT_CANIDM_TSEG2_MAX_DATA,
+	.sjw_max = IXXAT_CANIDM_SJW_MAX_DATA,
+	.brp_min = IXXAT_CANIDM_BRP_MIN_DATA,
+	.brp_max = IXXAT_CANIDM_BRP_MAX_DATA,
+	.brp_inc = IXXAT_CANIDM_BRP_INC_DATA
+};
+
+static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
+{
+	const struct can_bittiming *bt = &dev->can.bittiming;
+	const struct can_bittiming *btd = &dev->can.data_bittiming;
+	const u16 port = dev->ctrl_index;
+	int err;
+	struct ixxat_usb_init_cl2_cmd *cmd;
+	const u32 rcv_size = sizeof(cmd->res);
+	const u32 snd_size = sizeof(*cmd);
+	u32 btmode = IXXAT_USB_BTMODE_NAT;
+	u8 exmode = 0;
+	u8 opmode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
+
+	cmd = kmalloc(snd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		btmode = IXXAT_USB_BTMODE_TSM;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		opmode |= IXXAT_USB_OPMODE_ERRFRAME;
+	if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		opmode |= IXXAT_USB_OPMODE_LISTONLY;
+	if (dev->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO)) {
+		exmode |= IXXAT_USB_EXMODE_EXTDATA | IXXAT_USB_EXMODE_FASTDATA;
+
+		if (!(dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+			exmode |= IXXAT_USB_EXMODE_ISOFD;
+	}
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.size = cpu_to_le32(snd_size - rcv_size);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
+	cmd->req.port = cpu_to_le16(port);
+	cmd->opmode = opmode;
+	cmd->exmode = exmode;
+	cmd->sdr.mode = cpu_to_le32(btmode);
+	cmd->sdr.bps = cpu_to_le32(bt->brp);
+	cmd->sdr.ts1 = cpu_to_le16(bt->prop_seg + bt->phase_seg1);
+	cmd->sdr.ts2 = cpu_to_le16(bt->phase_seg2);
+	cmd->sdr.sjw = cpu_to_le16(bt->sjw);
+	cmd->sdr.tdo = 0;
+
+	if (exmode) {
+		cmd->fdr.mode = cpu_to_le32(btmode);
+		cmd->fdr.bps = cpu_to_le32(btd->brp);
+		cmd->fdr.ts1 = cpu_to_le16(btd->prop_seg + btd->phase_seg1);
+		cmd->fdr.ts2 = cpu_to_le16(btd->phase_seg2);
+		cmd->fdr.sjw = cpu_to_le16(btd->sjw);
+		cmd->fdr.tdo = cpu_to_le16(btd->brp * (btd->phase_seg1 + 1 +
+						       btd->prop_seg));
+	}
+
+	err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
+				 rcv_size);
+	kfree(cmd);
+	return err;
+}
+
+const struct ixxat_usb_adapter usb2can_cl2 = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &usb2can_bt,
+	.btd = &usb2can_btd,
+	.modes = IXXAT_USB_MODES,
+	.buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
+	.ep_msg_in = {
+		IXXAT_USB2CAN_EP1_IN,
+		IXXAT_USB2CAN_EP2_IN,
+		IXXAT_USB2CAN_EP3_IN,
+		IXXAT_USB2CAN_EP4_IN,
+		IXXAT_USB2CAN_EP5_IN
+	},
+	.ep_msg_out = {
+		IXXAT_USB2CAN_EP1_OUT,
+		IXXAT_USB2CAN_EP2_OUT,
+		IXXAT_USB2CAN_EP3_OUT,
+		IXXAT_USB2CAN_EP4_OUT,
+		IXXAT_USB2CAN_EP5_OUT
+	},
+	.ep_offs = 1,
+	.init_ctrl = ixxat_usb_init_ctrl
+};
+
+const struct ixxat_usb_adapter can_idm = {
+	.clock = IXXAT_USB_CLOCK,
+	.bt = &canidm_bt,
+	.btd = &canidm_btd,
+	.modes = IXXAT_USB_MODES,
+	.buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
+	.buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
+	.ep_msg_in = {
+		IXXAT_CANIDM_EP1_IN,
+		IXXAT_CANIDM_EP2_IN,
+		IXXAT_CANIDM_EP3_IN,
+		IXXAT_CANIDM_EP4_IN,
+		IXXAT_CANIDM_EP5_IN
+	},
+	.ep_msg_out = {
+		IXXAT_CANIDM_EP1_OUT,
+		IXXAT_CANIDM_EP2_OUT,
+		IXXAT_CANIDM_EP3_OUT,
+		IXXAT_CANIDM_EP4_OUT,
+		IXXAT_CANIDM_EP5_OUT
+	},
+	.ep_offs = 0,
+	.init_ctrl = ixxat_usb_init_ctrl
+};
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
new file mode 100644
index 000000000000..eee5a6b39774
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
@@ -0,0 +1,1299 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* CAN driver for IXXAT USB-to-CAN
+ *
+ * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/can/dev.h>
+#include <linux/kthread.h>
+#include <linux/usb.h>
+
+#include "ixxat_usb_core.h"
+
+MODULE_AUTHOR("Marcel Schmidt <socketcan@hms-networks.de>");
+MODULE_DESCRIPTION("CAN driver for IXXAT USB-to-CAN / CAN FD adapters");
+MODULE_LICENSE("GPL v2");
+
+/* Table of devices that work with this driver */
+static const struct usb_device_id ixxat_usb_table[] = {
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_COMPACT_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_EMBEDDED_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_PROFESSIONAL_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_AUTOMOTIVE_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_COMPACT_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PROFESSIONAL_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PCIE_MINI_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAR_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM101_PRODUCT_ID) },
+	{ USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM200_PRODUCT_ID) },
+	{ } /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, ixxat_usb_table);
+
+void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
+			 struct ixxat_usb_dal_res *res)
+{
+	req->size = cpu_to_le32(sizeof(*req));
+	req->port = cpu_to_le16(0xffff);
+	req->socket = cpu_to_le16(0xffff);
+	req->code = cpu_to_le32(0);
+
+	res->res_size = cpu_to_le32(sizeof(*res));
+	res->ret_size = cpu_to_le32(0);
+	res->code = cpu_to_le32(0xffffffff);
+}
+
+int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *req,
+		       const u16 req_size, void *res, const u16 res_size)
+{
+	const int to = msecs_to_jiffies(IXXAT_USB_MSG_TIMEOUT);
+	const u8 rq = 0xff;
+	const u8 rti = USB_TYPE_VENDOR | USB_DIR_IN;
+	const u8 rto = USB_TYPE_VENDOR | USB_DIR_OUT;
+	int i;
+	int pos = 0;
+	int rcp = usb_rcvctrlpipe(dev, 0);
+	int scp = usb_sndctrlpipe(dev, 0);
+	int ret = 0;
+	struct ixxat_usb_dal_res *dal_res = res;
+
+	for (i = 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
+		ret = usb_control_msg(dev, scp, rq, rto, port, 0, req, req_size,
+				      to);
+		if (ret < 0)
+			msleep(IXXAT_USB_MSG_CYCLE);
+		else
+			break;
+	}
+
+	if (ret < 0) {
+		dev_err(&dev->dev, "Error %d: TX command failure\n", ret);
+		goto fail;
+	}
+
+	for (i = 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
+		const int rs = res_size - pos;
+		void *rb = res + pos;
+
+		ret = usb_control_msg(dev, rcp, rq, rti, port, 0, rb, rs, to);
+		if (ret < 0) {
+			msleep(IXXAT_USB_MSG_CYCLE);
+			continue;
+		}
+
+		pos += ret;
+		if (pos < res_size)
+			msleep(IXXAT_USB_MSG_CYCLE);
+		else
+			break;
+	}
+
+	if (pos != res_size)
+		ret = -EBADMSG;
+
+	if (ret < 0) {
+		dev_err(&dev->dev, "Error %d: RX command failure\n", ret);
+		goto fail;
+	}
+
+	ret = le32_to_cpu(dal_res->code);
+
+fail:
+	return ret;
+}
+
+static void ixxat_usb_update_ts_now(struct ixxat_usb_device *dev, u32 ts_now)
+{
+	u32 *ts_dev = &dev->time_ref.ts_dev_0;
+	ktime_t *kt_host = &dev->time_ref.kt_host_0;
+	u64 timebase = (u64)0x00000000FFFFFFFF - (u64)(*ts_dev) + (u64)ts_now;
+
+	*kt_host = ktime_add_us(*kt_host, timebase);
+	*ts_dev = ts_now;
+}
+
+static void ixxat_usb_get_ts_tv(struct ixxat_usb_device *dev, u32 ts,
+				ktime_t *k_time)
+{
+	ktime_t tmp_time = dev->time_ref.kt_host_0;
+
+	if (ts < dev->time_ref.ts_dev_last)
+		ixxat_usb_update_ts_now(dev, ts);
+
+	dev->time_ref.ts_dev_last = ts;
+	tmp_time = ktime_add_us(tmp_time, ts - dev->time_ref.ts_dev_0);
+
+	if (k_time)
+		*k_time = tmp_time;
+}
+
+static void ixxat_usb_set_ts_now(struct ixxat_usb_device *dev, u32 ts_now)
+{
+	dev->time_ref.ts_dev_0 = ts_now;
+	dev->time_ref.kt_host_0 = ktime_get_real();
+	dev->time_ref.ts_dev_last = ts_now;
+}
+
+static int ixxat_usb_get_dev_caps(struct usb_device *dev,
+				  struct ixxat_dev_caps *dev_caps)
+{
+	int i;
+	int err;
+	struct ixxat_usb_caps_cmd *cmd;
+	const u32 cmd_size = sizeof(*cmd);
+	const u32 req_size = sizeof(cmd->req);
+	const u32 rcv_size = cmd_size - req_size;
+	const u32 snd_size = req_size + sizeof(cmd->res);
+	u16 num_ctrl;
+
+	cmd = kmalloc(cmd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVCAPS);
+	cmd->res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd, snd_size,
+				 &cmd->res, rcv_size);
+	if (err)
+		goto fail;
+
+	dev_caps->bus_ctrl_count = cmd->caps.bus_ctrl_count;
+	num_ctrl = le16_to_cpu(dev_caps->bus_ctrl_count);
+	if (num_ctrl > ARRAY_SIZE(dev_caps->bus_ctrl_types)) {
+		err = -EINVAL;
+		goto fail;
+	}
+
+	for (i = 0; i < num_ctrl; i++)
+		dev_caps->bus_ctrl_types[i] = cmd->caps.bus_ctrl_types[i];
+
+fail:
+	kfree(cmd);
+	return err;
+}
+
+static int ixxat_usb_get_dev_info(struct usb_device *dev,
+				  struct ixxat_dev_info *dev_info)
+{
+	int err;
+	struct ixxat_usb_info_cmd *cmd;
+	const u32 cmd_size = sizeof(*cmd);
+	const u32 req_size = sizeof(cmd->req);
+	const u32 rcv_size = cmd_size - req_size;
+	const u32 snd_size = req_size + sizeof(cmd->res);
+
+	cmd = kmalloc(cmd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVINFO);
+	cmd->res.res_size = cpu_to_le32(rcv_size);
+
+	err = ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd, snd_size,
+				 &cmd->res, rcv_size);
+	if (err)
+		goto fail;
+
+	if (dev_info) {
+		memcpy(dev_info->device_id, &cmd->info.device_id,
+		       sizeof(cmd->info.device_id));
+		memcpy(dev_info->device_name, &cmd->info.device_name,
+		       sizeof(cmd->info.device_name));
+		dev_info->device_fpga_version = cmd->info.device_fpga_version;
+		dev_info->device_version = cmd->info.device_version;
+	}
+
+fail:
+	kfree(cmd);
+	return err;
+}
+
+static int ixxat_usb_start_ctrl(struct ixxat_usb_device *dev, u32 *time_ref)
+{
+	const u16 port = dev->ctrl_index;
+	int err;
+	struct ixxat_usb_start_cmd *cmd;
+	const u32 cmd_size = sizeof(*cmd);
+	const u32 req_size = sizeof(cmd->req);
+	const u32 rcv_size = cmd_size - req_size;
+	const u32 snd_size = req_size + sizeof(cmd->res);
+
+	cmd = kmalloc(cmd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_START);
+	cmd->req.port = cpu_to_le16(port);
+	cmd->res.res_size = cpu_to_le32(rcv_size);
+	cmd->time = 0;
+
+	err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
+				 rcv_size);
+	if (err)
+		goto fail;
+
+	if (time_ref)
+		*time_ref = le32_to_cpu(cmd->time);
+
+fail:
+	kfree(cmd);
+	return err;
+}
+
+static int ixxat_usb_stop_ctrl(struct ixxat_usb_device *dev)
+{
+	const u16 port = dev->ctrl_index;
+	int err;
+	struct ixxat_usb_stop_cmd *cmd;
+	const u32 rcv_size = sizeof(cmd->res);
+	const u32 snd_size = sizeof(*cmd);
+
+	cmd = kmalloc(snd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.size = cpu_to_le32(snd_size - rcv_size);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_STOP);
+	cmd->req.port = cpu_to_le16(port);
+	cmd->action = cpu_to_le32(IXXAT_USB_STOP_ACTION_CLEARALL);
+
+	err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
+				 rcv_size);
+	kfree(cmd);
+	return err;
+}
+
+static int ixxat_usb_power_ctrl(struct usb_device *dev, u8 mode)
+{
+	int err;
+	struct ixxat_usb_power_cmd *cmd;
+	const u32 rcv_size = sizeof(cmd->res);
+	const u32 snd_size = sizeof(*cmd);
+
+	cmd = kmalloc(snd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.size = cpu_to_le32(snd_size - rcv_size);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_POWER);
+	cmd->mode = mode;
+
+	err = ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd, snd_size,
+				 &cmd->res, rcv_size);
+	kfree(cmd);
+	return err;
+}
+
+static int ixxat_usb_reset_ctrl(struct ixxat_usb_device *dev)
+{
+	const u16 port = dev->ctrl_index;
+	int err;
+	struct ixxat_usb_dal_cmd *cmd;
+	const u32 snd_size = sizeof(*cmd);
+	const u32 rcv_size = sizeof(cmd->res);
+
+	cmd = kmalloc(snd_size, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
+	cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_RESET);
+	cmd->req.port = cpu_to_le16(port);
+
+	err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
+				 rcv_size);
+	kfree(cmd);
+	return err;
+}
+
+static void ixxat_usb_stop_queue(struct ixxat_usb_device *dev)
+{
+	struct net_device *netdev = dev->netdev;
+	u32 i;
+
+	netif_stop_queue(netdev);
+	usb_kill_anchored_urbs(&dev->rx_submitted);
+	usb_kill_anchored_urbs(&dev->tx_submitted);
+	atomic_set(&dev->active_tx_urbs, 0);
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
+		if (dev->tx_contexts[i].echo_index != IXXAT_USB_MAX_TX_URBS) {
+			can_free_echo_skb(netdev, i, NULL);
+			dev->tx_contexts[i].echo_index = IXXAT_USB_MAX_TX_URBS;
+		}
+	}
+}
+
+static int ixxat_usb_restart(struct ixxat_usb_device *dev)
+{
+	int err;
+	struct net_device *netdev = dev->netdev;
+	u32 t;
+
+	ixxat_usb_stop_queue(dev);
+	err = ixxat_usb_stop_ctrl(dev);
+	if (err)
+		goto fail;
+
+	err = ixxat_usb_start_ctrl(dev, &t);
+	if (err)
+		goto fail;
+
+	dev->can.state = CAN_STATE_ERROR_ACTIVE;
+	netif_wake_queue(netdev);
+
+fail:
+	return err;
+}
+
+static int ixxat_usb_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	struct ixxat_usb_device *dev = netdev_priv(netdev);
+
+	if (mode != CAN_MODE_START)
+		return -EOPNOTSUPP;
+
+	return ixxat_usb_restart(dev);
+}
+
+static int ixxat_usb_get_berr_counter(const struct net_device *netdev,
+				      struct can_berr_counter *bec)
+{
+	struct ixxat_usb_device *dev = netdev_priv(netdev);
+
+	*bec = dev->bec;
+	return 0;
+}
+
+static int ixxat_usb_handle_canmsg(struct ixxat_usb_device *dev,
+				   struct ixxat_can_msg *rx)
+{
+	const u32 ixx_flags = le32_to_cpu(rx->base.flags);
+	const u8 dlc = IXXAT_USB_DECODE_DLC(ixx_flags);
+	struct canfd_frame *cf;
+	struct net_device *netdev = dev->netdev;
+	struct sk_buff *skb;
+	u8 flags = 0;
+	u8 len;
+	u8 min_size;
+
+	if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL) {
+		if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_FDR)
+			flags |= CANFD_BRS;
+
+		if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_ESI)
+			flags |= CANFD_ESI;
+
+		len = can_fd_dlc2len(dlc);
+	} else {
+		len = can_cc_dlc2len(dlc);
+	}
+
+	min_size = sizeof(rx->base) + len;
+
+	if (dev->adapter == &usb2can_cl1)
+		min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
+	else
+		min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
+
+	if (rx->base.size < (min_size - 1)) {
+		netdev_err(netdev, "Error: Invalid can data message size\n");
+		return -EBADMSG;
+	}
+
+	if (ixx_flags & IXXAT_USB_MSG_FLAGS_OVR) {
+		netdev->stats.rx_over_errors++;
+		netdev->stats.rx_errors++;
+		netdev_err(netdev, "Error: Message overflow\n");
+	}
+
+	if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL)
+		skb = alloc_canfd_skb(netdev, &cf);
+	else
+		skb = alloc_can_skb(netdev, (struct can_frame **)&cf);
+
+	if (!skb)
+		return -ENOMEM;
+
+	cf->can_id = le32_to_cpu(rx->base.msg_id);
+	cf->len = len;
+	cf->flags |= flags;
+
+	if (ixx_flags & IXXAT_USB_MSG_FLAGS_EXT)
+		cf->can_id |= CAN_EFF_FLAG;
+
+	if (ixx_flags & IXXAT_USB_MSG_FLAGS_RTR) {
+		cf->can_id |= CAN_RTR_FLAG;
+	} else {
+		if (dev->adapter == &usb2can_cl1)
+			memcpy(cf->data, rx->cl1.data, len);
+		else
+			memcpy(cf->data, rx->cl2.data, len);
+	}
+
+	ixxat_usb_get_ts_tv(dev, le32_to_cpu(rx->base.time), &skb->tstamp);
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += cf->len;
+	netif_rx(skb);
+
+	return 0;
+}
+
+static int ixxat_usb_handle_status(struct ixxat_usb_device *dev,
+				   struct ixxat_can_msg *rx)
+{
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *can_frame;
+	struct sk_buff *skb;
+	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
+	u32 raw_status;
+	u8 min_size = sizeof(rx->base) + sizeof(raw_status);
+
+	if (dev->adapter == &usb2can_cl1)
+		min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
+	else
+		min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
+
+	if (rx->base.size < (min_size - 1)) {
+		netdev_err(netdev, "Error: Invalid can status message size\n");
+		return -EBADMSG;
+	}
+
+	if (dev->adapter == &usb2can_cl1)
+		raw_status = le32_to_cpup((__le32 *)rx->cl1.data);
+	else
+		raw_status = le32_to_cpup((__le32 *)rx->cl2.data);
+
+	if (raw_status != IXXAT_USB_CAN_STATUS_OK) {
+		if (raw_status & IXXAT_USB_CAN_STATUS_BUSOFF) {
+			dev->can.can_stats.bus_off++;
+			new_state = CAN_STATE_BUS_OFF;
+			can_bus_off(netdev);
+		} else {
+			if (raw_status & IXXAT_USB_CAN_STATUS_ERRLIM) {
+				dev->can.can_stats.error_warning++;
+				new_state = CAN_STATE_ERROR_WARNING;
+			}
+
+			if (raw_status & IXXAT_USB_CAN_STATUS_ERR_PAS) {
+				dev->can.can_stats.error_passive++;
+				new_state = CAN_STATE_ERROR_PASSIVE;
+			}
+
+			if (raw_status & IXXAT_USB_CAN_STATUS_OVERRUN)
+				new_state = CAN_STATE_MAX;
+		}
+	}
+
+	if (new_state == CAN_STATE_ERROR_ACTIVE) {
+		dev->bec.txerr = 0;
+		dev->bec.rxerr = 0;
+	}
+
+	if (new_state != CAN_STATE_MAX)
+		dev->can.state = new_state;
+
+	skb = alloc_can_err_skb(netdev, &can_frame);
+	if (!skb)
+		return -ENOMEM;
+
+	switch (new_state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		can_frame->can_id |= CAN_ERR_CRTL;
+		can_frame->data[1] |= CAN_ERR_CRTL_ACTIVE;
+		break;
+	case CAN_STATE_ERROR_WARNING:
+		can_frame->can_id |= CAN_ERR_CRTL;
+		can_frame->data[1] |= CAN_ERR_CRTL_TX_WARNING;
+		can_frame->data[1] |= CAN_ERR_CRTL_RX_WARNING;
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		can_frame->can_id |= CAN_ERR_CRTL;
+		can_frame->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+		can_frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+		break;
+	case CAN_STATE_BUS_OFF:
+		can_frame->can_id |= CAN_ERR_BUSOFF;
+		break;
+	case CAN_STATE_MAX:
+		can_frame->can_id |= CAN_ERR_CRTL;
+		can_frame->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+		break;
+	default:
+		netdev_err(netdev, "Error: Unhandled can status %d\n",
+			   new_state);
+		break;
+	}
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += can_frame->can_dlc;
+	netif_rx(skb);
+
+	return 0;
+}
+
+static int ixxat_usb_handle_error(struct ixxat_usb_device *dev,
+				  struct ixxat_can_msg *rx)
+{
+	struct net_device *netdev = dev->netdev;
+	struct can_frame *can_frame;
+	struct sk_buff *skb;
+	u8 raw_error;
+	u8 min_size = sizeof(rx->base) + IXXAT_USB_CAN_ERROR_LEN;
+
+	if (dev->adapter == &usb2can_cl1)
+		min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
+	else
+		min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
+
+	if (rx->base.size < (min_size - 1)) {
+		netdev_err(netdev, "Error: Invalid can error message size\n");
+		return -EBADMSG;
+	}
+
+	if (dev->can.state == CAN_STATE_BUS_OFF)
+		return 0;
+
+	if (dev->adapter == &usb2can_cl1) {
+		raw_error = rx->cl1.data[IXXAT_USB_CAN_ERROR_CODE];
+		dev->bec.rxerr = rx->cl1.data[IXXAT_USB_CAN_ERROR_COUNTER_RX];
+		dev->bec.txerr = rx->cl1.data[IXXAT_USB_CAN_ERROR_COUNTER_TX];
+	} else {
+		raw_error = rx->cl2.data[IXXAT_USB_CAN_ERROR_CODE];
+		dev->bec.rxerr = rx->cl2.data[IXXAT_USB_CAN_ERROR_COUNTER_RX];
+		dev->bec.txerr = rx->cl2.data[IXXAT_USB_CAN_ERROR_COUNTER_TX];
+	}
+
+	if (raw_error == IXXAT_USB_CAN_ERROR_ACK)
+		netdev->stats.tx_errors++;
+	else
+		netdev->stats.rx_errors++;
+
+	skb = alloc_can_err_skb(netdev, &can_frame);
+	if (!skb)
+		return -ENOMEM;
+
+	switch (raw_error) {
+	case IXXAT_USB_CAN_ERROR_ACK:
+		can_frame->can_id |= CAN_ERR_ACK;
+		break;
+	case IXXAT_USB_CAN_ERROR_BIT:
+		can_frame->can_id |= CAN_ERR_PROT;
+		can_frame->data[2] |= CAN_ERR_PROT_BIT;
+		break;
+	case IXXAT_USB_CAN_ERROR_CRC:
+		can_frame->can_id |= CAN_ERR_PROT;
+		can_frame->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+		break;
+	case IXXAT_USB_CAN_ERROR_FORM:
+		can_frame->can_id |= CAN_ERR_PROT;
+		can_frame->data[2] |= CAN_ERR_PROT_FORM;
+		break;
+	case IXXAT_USB_CAN_ERROR_STUFF:
+		can_frame->can_id |= CAN_ERR_PROT;
+		can_frame->data[2] |= CAN_ERR_PROT_STUFF;
+		break;
+	default:
+		can_frame->can_id |= CAN_ERR_PROT;
+		can_frame->data[2] |= CAN_ERR_PROT_UNSPEC;
+		break;
+	}
+
+	netdev->stats.rx_packets++;
+	netdev->stats.rx_bytes += can_frame->can_dlc;
+	netif_rx(skb);
+
+	return 0;
+}
+
+static void ixxat_usb_decode_buf(struct urb *urb)
+{
+	struct ixxat_usb_device *dev = urb->context;
+	struct net_device *netdev = dev->netdev;
+	struct ixxat_can_msg *can_msg;
+	int err = 0;
+	u32 pos = 0;
+	u8 *data = urb->transfer_buffer;
+
+	while (pos < urb->actual_length) {
+		u32 time;
+		u8 size;
+		u8 type;
+
+		can_msg = (struct ixxat_can_msg *)&data[pos];
+		if (!can_msg || !can_msg->base.size) {
+			err = -ENOTSUPP;
+			netdev_err(netdev, "Error %d: Unsupported usb msg\n",
+				   err);
+			break;
+		}
+
+		size = can_msg->base.size + 1;
+		if (size < sizeof(can_msg->base) ||
+		    (pos + size) > urb->actual_length) {
+			err = -EBADMSG;
+			netdev_err(netdev,
+				   "Error %d: Invalid usb message size\n",
+				   err);
+			break;
+		}
+
+		type = le32_to_cpu(can_msg->base.flags);
+		type &= IXXAT_USB_MSG_FLAGS_TYPE;
+		time = le32_to_cpu(can_msg->base.time);
+
+		switch (type) {
+		case IXXAT_USB_CAN_DATA:
+			err = ixxat_usb_handle_canmsg(dev, can_msg);
+			if (err)
+				goto fail;
+			break;
+		case IXXAT_USB_CAN_STATUS:
+			err = ixxat_usb_handle_status(dev, can_msg);
+			if (err)
+				goto fail;
+			break;
+		case IXXAT_USB_CAN_ERROR:
+			err = ixxat_usb_handle_error(dev, can_msg);
+			if (err)
+				goto fail;
+			break;
+		case IXXAT_USB_CAN_TIMEOVR:
+			ixxat_usb_get_ts_tv(dev, time, NULL);
+			break;
+		case IXXAT_USB_CAN_INFO:
+		case IXXAT_USB_CAN_WAKEUP:
+		case IXXAT_USB_CAN_TIMERST:
+			break;
+		default:
+			netdev_err(netdev,
+				   "Unhandled rec type 0x%02x (%d): ignored\n",
+				   type, type);
+			break;
+		}
+
+		pos += size;
+	}
+
+fail:
+	if (err)
+		netdev_err(netdev, "Error %d: Buffer decoding failed\n", err);
+}
+
+static int ixxat_usb_encode_msg(struct ixxat_usb_device *dev,
+				struct sk_buff *skb, u8 *obuf)
+{
+	int size;
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct ixxat_can_msg can_msg = { {0} };
+	struct ixxat_can_msg_base *msg_base = &can_msg.base;
+	u32 flags = 0;
+	u32 msg_id = 0;
+
+	if (cf->can_id & CAN_RTR_FLAG)
+		flags |= IXXAT_USB_MSG_FLAGS_RTR;
+
+	if (cf->can_id & CAN_EFF_FLAG) {
+		flags |= IXXAT_USB_MSG_FLAGS_EXT;
+		msg_id = cf->can_id & CAN_EFF_MASK;
+	} else {
+		msg_id = cf->can_id & CAN_SFF_MASK;
+	}
+
+	if (can_is_canfd_skb(skb)) {
+		flags |= IXXAT_USB_FDMSG_FLAGS_EDL;
+
+		if (!(cf->can_id & CAN_RTR_FLAG) && (cf->flags & CANFD_BRS))
+			flags |= IXXAT_USB_FDMSG_FLAGS_FDR;
+
+		flags |= IXXAT_USB_ENCODE_DLC(can_fd_len2dlc(cf->len));
+	} else {
+		flags |= IXXAT_USB_ENCODE_DLC(cf->len);
+	}
+
+	msg_base->flags = cpu_to_le32(flags);
+	msg_base->msg_id = cpu_to_le32(msg_id);
+	msg_base->size = sizeof(*msg_base) + cf->len - 1;
+	if (dev->adapter == &usb2can_cl1) {
+		msg_base->size += sizeof(can_msg.cl1);
+		msg_base->size -= sizeof(can_msg.cl1.data);
+		memcpy(can_msg.cl1.data, cf->data, cf->len);
+	} else {
+		msg_base->size += sizeof(can_msg.cl2);
+		msg_base->size -= sizeof(can_msg.cl2.data);
+		memcpy(can_msg.cl2.data, cf->data, cf->len);
+	}
+
+	size = msg_base->size + 1;
+	memcpy(obuf, &can_msg, size);
+	return size;
+}
+
+static void ixxat_usb_read_bulk_callback(struct urb *urb)
+{
+	struct ixxat_usb_device *dev = urb->context;
+	const struct ixxat_usb_adapter *adapter = dev->adapter;
+	struct net_device *netdev = dev->netdev;
+	struct usb_device *udev = dev->udev;
+	int err;
+
+	if (!netif_device_present(netdev))
+		return;
+
+	switch (urb->status) {
+	case 0: /* success */
+		break;
+	case -EPROTO:
+	case -EILSEQ:
+	case -ENOENT:
+	case -ECONNRESET:
+	case -ESHUTDOWN:
+		return;
+	default:
+		netdev_err(netdev, "Rx urb aborted /(%d)\n", urb->status);
+		goto resubmit_urb;
+	}
+
+	if (urb->actual_length > 0)
+		if (dev->state & IXXAT_USB_STATE_STARTED)
+			ixxat_usb_decode_buf(urb);
+
+resubmit_urb:
+	usb_fill_bulk_urb(urb, udev, usb_rcvbulkpipe(udev, dev->ep_msg_in),
+			  urb->transfer_buffer, adapter->buffer_size_rx,
+			  ixxat_usb_read_bulk_callback, dev);
+
+	usb_anchor_urb(urb, &dev->rx_submitted);
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!err)
+		return;
+
+	usb_unanchor_urb(urb);
+
+	if (err == -ENODEV)
+		netif_device_detach(netdev);
+	else
+		netdev_err(netdev,
+			   "Error %d: Failed to resubmit read bulk urb\n", err);
+}
+
+static void ixxat_usb_write_bulk_callback(struct urb *urb)
+{
+	struct ixxat_tx_urb_context *context = urb->context;
+	struct ixxat_usb_device *dev;
+	struct net_device *netdev;
+
+	if (WARN_ON(!context))
+		return;
+
+	dev = context->dev;
+	netdev = dev->netdev;
+
+	if (!netif_device_present(netdev))
+		return;
+
+	if (!urb->status) {
+		netdev->stats.tx_packets++;
+		netdev->stats.tx_bytes += can_get_echo_skb(netdev, context->echo_index, NULL);
+	} else {
+		netdev_err(netdev, "Error %d: Tx urb aborted\n", urb->status);
+		can_free_echo_skb(netdev, context->echo_index, NULL);
+	}
+
+	context->echo_index = IXXAT_USB_MAX_TX_URBS;
+	atomic_dec(&dev->active_tx_urbs);
+
+	if (!urb->status)
+		netif_wake_queue(netdev);
+}
+
+static netdev_tx_t ixxat_usb_start_xmit(struct sk_buff *skb,
+					struct net_device *netdev)
+{
+	int err;
+	int size;
+	struct ixxat_usb_device *dev = netdev_priv(netdev);
+	struct ixxat_tx_urb_context *context = NULL;
+	struct net_device_stats *stats = &netdev->stats;
+	struct urb *urb;
+	u8 *obuf;
+	u32 i;
+
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
+		if (dev->tx_contexts[i].echo_index == IXXAT_USB_MAX_TX_URBS) {
+			context = dev->tx_contexts + i;
+			break;
+		}
+	}
+
+	if (WARN_ON_ONCE(!context))
+		return NETDEV_TX_BUSY;
+
+	urb = context->urb;
+	obuf = urb->transfer_buffer;
+
+	size = ixxat_usb_encode_msg(dev, skb, obuf);
+
+	context->echo_index = i;
+
+	urb->transfer_buffer_length = size;
+	usb_anchor_urb(urb, &dev->tx_submitted);
+	can_put_echo_skb(skb, netdev, i, 0);
+	atomic_inc(&dev->active_tx_urbs);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err) {
+		can_free_echo_skb(netdev, i, NULL);
+		usb_unanchor_urb(urb);
+		atomic_dec(&dev->active_tx_urbs);
+
+		context->echo_index = IXXAT_USB_MAX_TX_URBS;
+
+		if (err == -ENODEV) {
+			netif_device_detach(netdev);
+		} else {
+			stats->tx_dropped++;
+			netdev_err(netdev,
+				   "Error %d: Submitting tx-urb failed\n", err);
+		}
+	} else {
+		if (atomic_read(&dev->active_tx_urbs) >= IXXAT_USB_MAX_TX_URBS)
+			netif_stop_queue(netdev);
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static int ixxat_usb_setup_rx_urbs(struct ixxat_usb_device *dev)
+{
+	int i;
+	int err = 0;
+	const struct ixxat_usb_adapter *adapter = dev->adapter;
+	struct net_device *netdev = dev->netdev;
+	struct usb_device *udev = dev->udev;
+
+	for (i = 0; i < IXXAT_USB_MAX_RX_URBS; i++) {
+		struct urb *urb;
+		u8 *buf;
+
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb) {
+			err = -ENOMEM;
+			netdev_err(netdev, "Error %d: No memory for URBs\n",
+				   err);
+			break;
+		}
+
+		buf = kmalloc(adapter->buffer_size_rx, GFP_KERNEL);
+		if (!buf) {
+			usb_free_urb(urb);
+			err = -ENOMEM;
+			netdev_err(netdev,
+				   "Error %d: No memory for USB-buffer\n", err);
+			break;
+		}
+
+		usb_fill_bulk_urb(urb, udev,
+				  usb_rcvbulkpipe(udev, dev->ep_msg_in), buf,
+				  adapter->buffer_size_rx,
+				  ixxat_usb_read_bulk_callback, dev);
+
+		urb->transfer_flags |= URB_FREE_BUFFER;
+		usb_anchor_urb(urb, &dev->rx_submitted);
+
+		err = usb_submit_urb(urb, GFP_KERNEL);
+		if (err) {
+			usb_unanchor_urb(urb);
+			kfree(buf);
+			usb_free_urb(urb);
+
+			if (err == -ENODEV)
+				netif_device_detach(netdev);
+
+			break;
+		}
+
+		usb_free_urb(urb);
+	}
+
+	if (i == 0)
+		netdev_err(netdev, "Error: Couldn't setup any rx-URBs\n");
+
+	return err;
+}
+
+static int ixxat_usb_setup_tx_urbs(struct ixxat_usb_device *dev)
+{
+	int i;
+	int ret = 0;
+	const struct ixxat_usb_adapter *adapter = dev->adapter;
+	struct net_device *netdev = dev->netdev;
+	struct usb_device *udev = dev->udev;
+
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
+		struct ixxat_tx_urb_context *context;
+		struct urb *urb;
+		u8 *buf;
+
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb) {
+			ret = -ENOMEM;
+			netdev_err(netdev, "Error %d: No memory for URBs\n",
+				   ret);
+			break;
+		}
+
+		buf = kmalloc(adapter->buffer_size_tx, GFP_KERNEL);
+		if (!buf) {
+			usb_free_urb(urb);
+			ret = -ENOMEM;
+			netdev_err(netdev,
+				   "Error %d: No memory for USB-buffer\n", ret);
+			break;
+		}
+
+		context = dev->tx_contexts + i;
+		context->dev = dev;
+		context->urb = urb;
+
+		usb_fill_bulk_urb(urb, udev,
+				  usb_sndbulkpipe(udev, dev->ep_msg_out), buf,
+				  adapter->buffer_size_tx,
+				  ixxat_usb_write_bulk_callback, context);
+
+		urb->transfer_flags |= URB_FREE_BUFFER;
+	}
+
+	if (i == 0) {
+		netdev_err(netdev, "Error: Couldn't setup any tx-URBs\n");
+		usb_kill_anchored_urbs(&dev->rx_submitted);
+	}
+
+	return ret;
+}
+
+static void ixxat_usb_disconnect(struct usb_interface *intf)
+{
+	struct ixxat_usb_device *dev;
+	struct ixxat_usb_device *prev_dev;
+
+	/* unregister the given device and all previous devices */
+	for (dev = usb_get_intfdata(intf); dev; dev = prev_dev) {
+		prev_dev = dev->prev_dev;
+		unregister_netdev(dev->netdev);
+		free_candev(dev->netdev);
+	}
+
+	usb_set_intfdata(intf, NULL);
+}
+
+static int ixxat_usb_start(struct ixxat_usb_device *dev)
+{
+	int err;
+	int i;
+	u32 time_ref = 0;
+	const struct ixxat_usb_adapter *adapter = dev->adapter;
+
+	err = ixxat_usb_setup_rx_urbs(dev);
+	if (err)
+		return err;
+
+	err = ixxat_usb_setup_tx_urbs(dev);
+	if (err)
+		return err;
+
+	/* Try to reset the controller, in case it is already initialized
+	 * from a previous unclean shutdown
+	 */
+	ixxat_usb_reset_ctrl(dev);
+
+	if (adapter->init_ctrl) {
+		err = adapter->init_ctrl(dev);
+		if (err)
+			goto fail;
+	}
+
+	if (!(dev->state & IXXAT_USB_STATE_STARTED)) {
+		err = ixxat_usb_start_ctrl(dev, &time_ref);
+		if (err)
+			goto fail;
+
+		ixxat_usb_set_ts_now(dev, time_ref);
+	}
+
+	dev->bec.txerr = 0;
+	dev->bec.rxerr = 0;
+
+	dev->state |= IXXAT_USB_STATE_STARTED;
+	dev->can.state = CAN_STATE_ERROR_ACTIVE;
+	return 0;
+
+fail:
+	if (err == -ENODEV)
+		netif_device_detach(dev->netdev);
+
+	netdev_err(dev->netdev, "Error %d: Couldn't submit control\n", err);
+
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
+		usb_free_urb(dev->tx_contexts[i].urb);
+		dev->tx_contexts[i].urb = NULL;
+	}
+
+	return err;
+}
+
+static int ixxat_usb_open(struct net_device *netdev)
+{
+	struct ixxat_usb_device *dev = netdev_priv(netdev);
+	int err;
+
+	/* common open */
+	err = open_candev(netdev);
+	if (err)
+		goto fail;
+
+	/* finally start device */
+	err = ixxat_usb_start(dev);
+	if (err) {
+		netdev_err(netdev, "Error %d: Couldn't start device.\n", err);
+		close_candev(netdev);
+		goto fail;
+	}
+
+	netif_start_queue(netdev);
+
+fail:
+	return err;
+}
+
+static int ixxat_usb_stop(struct net_device *netdev)
+{
+	int err = 0;
+	struct ixxat_usb_device *dev = netdev_priv(netdev);
+
+	ixxat_usb_stop_queue(dev);
+	if (dev->state & IXXAT_USB_STATE_STARTED) {
+		err = ixxat_usb_stop_ctrl(dev);
+		if (err)
+			netdev_warn(netdev, "Error %d: Cannot stop device\n",
+				    err);
+	}
+
+	dev->state &= ~IXXAT_USB_STATE_STARTED;
+	close_candev(netdev);
+	dev->can.state = CAN_STATE_STOPPED;
+	return err;
+}
+
+static const struct net_device_ops ixxat_usb_netdev_ops = {
+	.ndo_open = ixxat_usb_open,
+	.ndo_stop = ixxat_usb_stop,
+	.ndo_start_xmit = ixxat_usb_start_xmit
+};
+
+static const struct ixxat_usb_adapter *ixxat_usb_get_adapter(const u16 id)
+{
+	switch (id) {
+	case USB2CAN_COMPACT_PRODUCT_ID:
+	case USB2CAN_EMBEDDED_PRODUCT_ID:
+	case USB2CAN_PROFESSIONAL_PRODUCT_ID:
+	case USB2CAN_AUTOMOTIVE_PRODUCT_ID:
+		return &usb2can_cl1;
+	case USB2CAN_FD_COMPACT_PRODUCT_ID:
+	case USB2CAN_FD_PROFESSIONAL_PRODUCT_ID:
+	case USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID:
+	case USB2CAN_FD_PCIE_MINI_PRODUCT_ID:
+	case USB2CAR_PRODUCT_ID:
+		return &usb2can_cl2;
+	case CAN_IDM101_PRODUCT_ID:
+	case CAN_IDM200_PRODUCT_ID:
+		return &can_idm;
+	default:
+		return NULL;
+	}
+}
+
+static int ixxat_usb_create_dev(struct usb_interface *intf,
+				const struct ixxat_usb_adapter *adapter,
+				u16 ctrl_index)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct ixxat_usb_device *dev;
+	struct net_device *netdev;
+	int err;
+	int i;
+
+	netdev = alloc_candev(sizeof(*dev), IXXAT_USB_MAX_TX_URBS);
+	if (!netdev) {
+		dev_err(&intf->dev, "Cannot allocate candev\n");
+		return -ENOMEM;
+	}
+
+	dev = netdev_priv(netdev);
+	dev->udev = udev;
+	dev->netdev = netdev;
+	dev->adapter = adapter;
+	dev->ctrl_index = ctrl_index;
+	dev->state = IXXAT_USB_STATE_CONNECTED;
+
+	i = ctrl_index + adapter->ep_offs;
+	dev->ep_msg_in = adapter->ep_msg_in[i];
+	dev->ep_msg_out = adapter->ep_msg_out[i];
+
+	dev->can.clock.freq = adapter->clock;
+	dev->can.bittiming_const = adapter->bt;
+	dev->can.data_bittiming_const = adapter->btd;
+
+	dev->can.do_set_mode = ixxat_usb_set_mode;
+	dev->can.do_get_berr_counter = ixxat_usb_get_berr_counter;
+
+	dev->can.ctrlmode_supported = adapter->modes;
+
+	netdev->netdev_ops = &ixxat_usb_netdev_ops;
+
+	netdev->flags |= IFF_ECHO;
+
+	init_usb_anchor(&dev->rx_submitted);
+	init_usb_anchor(&dev->tx_submitted);
+
+	atomic_set(&dev->active_tx_urbs, 0);
+
+	for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++)
+		dev->tx_contexts[i].echo_index = IXXAT_USB_MAX_TX_URBS;
+
+	dev->prev_dev = usb_get_intfdata(intf);
+	usb_set_intfdata(intf, dev);
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+	err = register_candev(netdev);
+	if (err) {
+		dev_err(&intf->dev, "Error %d: Failed to register can device\n",
+			err);
+		goto free_candev;
+	}
+
+	if (dev->prev_dev)
+		(dev->prev_dev)->next_dev = dev;
+
+	err = ixxat_usb_get_dev_info(udev, &dev->dev_info);
+	if (err) {
+		dev_err(&intf->dev,
+			"Error %d: Failed to get device information\n", err);
+		goto unreg_candev;
+	}
+
+	netdev_info(netdev, "%s: Connected Channel %u (device %s)\n",
+		    dev->dev_info.device_name, ctrl_index,
+		    dev->dev_info.device_id);
+
+	return 0;
+
+unreg_candev:
+	unregister_candev(netdev);
+free_candev:
+	usb_set_intfdata(intf, dev->prev_dev);
+	free_candev(netdev);
+	return err;
+}
+
+static int ixxat_usb_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_host_interface *host_intf = intf->altsetting;
+	const struct ixxat_usb_adapter *adapter;
+	struct ixxat_dev_caps dev_caps;
+	u16 i;
+	int err;
+
+	usb_reset_configuration(udev);
+
+	adapter = ixxat_usb_get_adapter(id->idProduct);
+	if (!adapter) {
+		dev_err(&intf->dev, "%s: Unknown device id %d\n",
+			IXXAT_USB_DRIVER_NAME, id->idProduct);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < host_intf->desc.bNumEndpoints; i++) {
+		const u8 epaddr = host_intf->endpoint[i].desc.bEndpointAddress;
+		int match;
+		u8 j;
+
+		/* Check if usb-endpoint address matches known usb-endpoints */
+		for (j = 0; j < IXXAT_USB_MAX_CHANNEL; j++) {
+			u8 ep_msg_in = adapter->ep_msg_in[j];
+			u8 ep_msg_out = adapter->ep_msg_in[j];
+
+			if (epaddr == ep_msg_in || epaddr == ep_msg_out) {
+				match = 1;
+				break;
+			}
+		}
+
+		if (!match)
+			return -ENODEV;
+	}
+
+	err = ixxat_usb_power_ctrl(udev, IXXAT_USB_POWER_WAKEUP);
+	if (err)
+		return err;
+
+	msleep(IXXAT_USB_POWER_WAKEUP_TIME);
+
+	err = ixxat_usb_get_dev_caps(udev, &dev_caps);
+	if (err) {
+		dev_err(&intf->dev,
+			"Error %d: Failed to get device capabilities\n", err);
+		return err;
+	}
+
+	err = -ENODEV;
+	for (i = 0; i < le16_to_cpu(dev_caps.bus_ctrl_count); i++) {
+		u16 dev_bustype = le16_to_cpu(dev_caps.bus_ctrl_types[i]);
+		u8 bustype = IXXAT_USB_BUS_TYPE(dev_bustype);
+
+		if (bustype == IXXAT_USB_BUS_CAN)
+			err = ixxat_usb_create_dev(intf, adapter, i);
+
+		if (err) {
+			/* deregister already created devices */
+			ixxat_usb_disconnect(intf);
+			return err;
+		}
+	}
+
+	return err;
+}
+
+static struct usb_driver ixxat_usb_driver = {
+	.name = IXXAT_USB_DRIVER_NAME,
+	.probe = ixxat_usb_probe,
+	.disconnect = ixxat_usb_disconnect,
+	.id_table = ixxat_usb_table,
+};
+
+module_usb_driver(ixxat_usb_driver);
diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
new file mode 100644
index 000000000000..0f3e4c0b9f1b
--- /dev/null
+++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
@@ -0,0 +1,519 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* CAN driver base for IXXAT USB-to-CAN
+ *
+ * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#ifndef IXXAT_USB_CORE_H
+#define IXXAT_USB_CORE_H
+
+#define IXXAT_USB_DRIVER_NAME "ixxat_usb2can"
+#define IXXAT_USB_CTRL_NAME "ixxat_usb"
+
+#define IXXAT_USB_VENDOR_ID 0x08d8
+
+/* supported device ids: CL1 */
+#define USB2CAN_COMPACT_PRODUCT_ID 0x0008
+#define USB2CAN_EMBEDDED_PRODUCT_ID 0x0009
+#define USB2CAN_PROFESSIONAL_PRODUCT_ID 0x000A
+#define USB2CAN_AUTOMOTIVE_PRODUCT_ID 0x000B
+
+/* supported device ids: CL2 */
+#define USB2CAN_FD_COMPACT_PRODUCT_ID 0x0014
+#define USB2CAN_FD_PROFESSIONAL_PRODUCT_ID 0x0016
+#define USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID 0x0017
+#define USB2CAN_FD_PCIE_MINI_PRODUCT_ID 0x001B
+#define USB2CAR_PRODUCT_ID 0x001C
+#define CAN_IDM101_PRODUCT_ID 0xFF12
+#define CAN_IDM200_PRODUCT_ID 0xFF13
+
+#define IXXAT_USB_BUS_CAN 1
+
+#define IXXAT_USB_BUS_TYPE(type) ((u8)(((type) >> 8) & 0x00FF))
+
+#define IXXAT_USB_STATE_CONNECTED BIT(0)
+#define IXXAT_USB_STATE_STARTED BIT(1)
+
+#define IXXAT_USB_MAX_CHANNEL 5
+#define IXXAT_USB_MAX_TYPES 32
+#define IXXAT_USB_MAX_RX_URBS 4
+#define IXXAT_USB_MAX_TX_URBS 10
+#define IXXAT_USB_MAX_COM_REQ 10
+
+#define IXXAT_USB_MSG_TIMEOUT 50
+#define IXXAT_USB_MSG_CYCLE 20
+
+#define IXXAT_USB_POWER_WAKEUP 0
+#define IXXAT_USB_POWER_WAKEUP_TIME 500
+
+#define IXXAT_USB_OPMODE_STANDARD BIT(0)
+#define IXXAT_USB_OPMODE_EXTENDED BIT(1)
+#define IXXAT_USB_OPMODE_ERRFRAME BIT(2)
+#define IXXAT_USB_OPMODE_LISTONLY BIT(3)
+
+#define IXXAT_USB_EXMODE_EXTDATA BIT(0)
+#define IXXAT_USB_EXMODE_FASTDATA BIT(1)
+#define IXXAT_USB_EXMODE_ISOFD BIT(2)
+
+#define IXXAT_USB_BTMODE_NAT BIT(0)
+#define IXXAT_USB_BTMODE_TSM BIT(1)
+
+#define IXXAT_USB_STOP_ACTION_CLEARALL 3
+
+#define IXXAT_RESTART_TASK_CYCLE_TIME 20
+
+#define IXXAT_USB_CAN_DATA 0x00
+#define IXXAT_USB_CAN_INFO 0x01
+#define IXXAT_USB_CAN_ERROR 0x02
+#define IXXAT_USB_CAN_STATUS 0x03
+#define IXXAT_USB_CAN_WAKEUP 0x04
+#define IXXAT_USB_CAN_TIMEOVR 0x05
+#define IXXAT_USB_CAN_TIMERST 0x06
+
+#define IXXAT_USB_CAN_STATUS_OK 0x00000000
+#define IXXAT_USB_CAN_STATUS_OVERRUN 0x00000002
+#define IXXAT_USB_CAN_STATUS_ERRLIM 0x00000004
+#define IXXAT_USB_CAN_STATUS_BUSOFF 0x00000008
+#define IXXAT_USB_CAN_STATUS_ERR_PAS 0x00002000
+
+#define IXXAT_USB_CAN_ERROR_LEN 5
+
+#define IXXAT_USB_CAN_ERROR_CODE 0
+#define IXXAT_USB_CAN_ERROR_COUNTER_RX 3
+#define IXXAT_USB_CAN_ERROR_COUNTER_TX 4
+
+#define IXXAT_USB_CAN_ERROR_STUFF 1
+#define IXXAT_USB_CAN_ERROR_FORM 2
+#define IXXAT_USB_CAN_ERROR_ACK 3
+#define IXXAT_USB_CAN_ERROR_BIT 4
+#define IXXAT_USB_CAN_ERROR_CRC 6
+
+#define IXXAT_USB_MSG_FLAGS_TYPE 0x000000FF
+#define IXXAT_USB_MSG_FLAGS_DLC 0x000F0000
+#define IXXAT_USB_MSG_FLAGS_OVR 0x00100000
+#define IXXAT_USB_MSG_FLAGS_RTR 0x00400000
+#define IXXAT_USB_MSG_FLAGS_EXT 0x00800000
+
+#define IXXAT_USB_DECODE_DLC(flags) (((flags) & IXXAT_USB_MSG_FLAGS_DLC) >> 16)
+#define IXXAT_USB_ENCODE_DLC(len) (((len) << 16) & IXXAT_USB_MSG_FLAGS_DLC)
+
+#define IXXAT_USB_FDMSG_FLAGS_EDL 0x00000400
+#define IXXAT_USB_FDMSG_FLAGS_FDR 0x00000800
+#define IXXAT_USB_FDMSG_FLAGS_ESI 0x00001000
+
+#define IXXAT_USB_CAN_CMD_START 0x326
+#define IXXAT_USB_CAN_CMD_STOP 0x327
+#define IXXAT_USB_CAN_CMD_RESET 0x328
+
+#define IXXAT_USB_BRD_CMD_GET_DEVCAPS 0x401
+#define IXXAT_USB_BRD_CMD_GET_DEVINFO 0x402
+#define IXXAT_USB_BRD_CMD_POWER 0x421
+
+/**
+ * struct ixxat_can_msg_base - IXXAT CAN message base (CL1/CL2)
+ * @size: Message size (this field excluded)
+ * @time: Message timestamp
+ * @msg_id: Message ID
+ * @flags: Message flags
+ *
+ * Contains the common fields of an IXXAT CAN message on both CL1 and CL2
+ * devices
+ */
+struct ixxat_can_msg_base {
+	u8 size;
+	__le32 time;
+	__le32 msg_id;
+	__le32 flags;
+} __packed;
+
+/**
+ * struct ixxat_can_msg_cl1 - IXXAT CAN message (CL1)
+ * @data: Message data (standard CAN frame)
+ *
+ * Contains the fields of an IXXAT CAN message on CL1 devices
+ */
+struct ixxat_can_msg_cl1 {
+	u8 data[CAN_MAX_DLEN];
+} __packed;
+
+/**
+ * struct ixxat_can_msg_cl2 - IXXAT CAN message (CL2)
+ * @client_id: Client ID
+ * @data: Message data (CAN FD frame)
+ *
+ * Contains the fields of an IXXAT CAN message on CL2 devices
+ */
+struct ixxat_can_msg_cl2 {
+	__le32 client_id;
+	u8 data[CANFD_MAX_DLEN];
+} __packed;
+
+/**
+ * struct ixxat_can_msg - IXXAT CAN message
+ * @base: Base message
+ * @cl1: Cl1 message
+ * @cl2: Cl2 message
+ *
+ * Contains an IXXAT CAN message
+ */
+struct ixxat_can_msg {
+	struct ixxat_can_msg_base base;
+	union {
+		struct ixxat_can_msg_cl1 cl1;
+		struct ixxat_can_msg_cl2 cl2;
+	};
+} __packed;
+
+/**
+ * struct ixxat_dev_caps - Device capabilities
+ * @bus_ctrl_count: Stores the bus controller counter
+ * @bus_ctrl_types: Stores the bus controller types
+ *
+ * Contains the device capabilities
+ */
+struct ixxat_dev_caps {
+	__le16 bus_ctrl_count;
+	__le16 bus_ctrl_types[IXXAT_USB_MAX_TYPES];
+} __packed;
+
+/**
+ * struct ixxat_canbtp Bittiming parameters (CL2)
+ * @mode: Operation mode
+ * @bps: Bits per second
+ * @ts1: First time segment
+ * @ts2: Second time segment
+ * @sjw: Synchronization jump width
+ * @tdo: Transmitter delay offset
+ *
+ * Bittiming parameters of a CL2 initialization request
+ */
+struct ixxat_canbtp {
+	__le32 mode;
+	__le32 bps;
+	__le16 ts1;
+	__le16 ts2;
+	__le16 sjw;
+	__le16 tdo;
+} __packed;
+
+/**
+ * struct ixxat_dev_info IXXAT usb device information
+ * @device_name: Name of the device
+ * @device_id: Device identification ( unique device id)
+ * @device_version: Device version ( 0, 1, ...)
+ * @device_fpga_version: Version of FPGA design
+ *
+ * Contains device information of IXXAT USB devices
+ */
+struct ixxat_dev_info {
+	char device_name[16];
+	char device_id[16];
+	__le16 device_version;
+	__le32 device_fpga_version;
+} __packed;
+
+/**
+ * struct ixxat_time_ref Time reference
+ * @kt_host_0: Latest time on the host
+ * @ts_dev_0: Latest time stamp on the device
+ * @ts_dev_last: Last device time stamp
+ *
+ * Contains time references of the device and the host
+ */
+struct ixxat_time_ref {
+	ktime_t kt_host_0;
+	u32 ts_dev_0;
+	u32 ts_dev_last;
+};
+
+/**
+ * struct ixxat_tx_urb_context URB content for transmission
+ * @dev: IXXAT USB device
+ * @urb: USB request block
+ * @echo_index: Echo index
+ * @dlc: Data length code
+ * @count: Counter
+ *
+ * Contains content for USB request block transmissions
+ */
+struct ixxat_tx_urb_context {
+	struct ixxat_usb_device *dev;
+	struct urb *urb;
+	u32 echo_index;
+};
+
+/**
+ * struct ixxat_usb_device IXXAT USB device
+ * @can: CAN common private data
+ * @adapter: USB network descriptor
+ * @udev: USB device
+ * @netdev: Net_device
+ * @active_tx_urbs: Active tx urbs
+ * @tx_submitted: Submitted tx usb anchor
+ * @tx_contexts: Buffer for tx contexts
+ * @rx_submitted: Submitted rx usb anchor
+ * @state: Device state
+ * @ctrl_index: Controller index
+ * @ep_msg_in: USB endpoint for incoming messages
+ * @ep_msg_out: USB endpoint for outgoing messages
+ * @prev_dev: Previous opened device
+ * @next_dev: Next opened device in list
+ * @time_ref: Time reference
+ * @dev_info: Device information
+ * @bec: CAN error counter
+ *
+ * IXXAT USB-to-CAN device
+ */
+struct ixxat_usb_device {
+	struct can_priv can;
+	const struct ixxat_usb_adapter *adapter;
+	struct usb_device *udev;
+	struct net_device *netdev;
+
+	atomic_t active_tx_urbs;
+	struct usb_anchor tx_submitted;
+	struct ixxat_tx_urb_context tx_contexts[IXXAT_USB_MAX_TX_URBS];
+	struct usb_anchor rx_submitted;
+
+	u32 state;
+	u16 ctrl_index;
+
+	u8 ep_msg_in;
+	u8 ep_msg_out;
+
+	struct ixxat_usb_device *prev_dev;
+	struct ixxat_usb_device *next_dev;
+
+	struct ixxat_time_ref time_ref;
+	struct ixxat_dev_info dev_info;
+
+	struct can_berr_counter bec;
+};
+
+/**
+ * struct ixxat_usb_dal_req IXXAT device request block
+ * @size: Request size
+ * @port: Request port
+ * @socket: Request socket
+ * @code: Request code
+ *
+ * IXXAT device request block
+ */
+struct ixxat_usb_dal_req {
+	__le32 size;
+	__le16 port;
+	__le16 socket;
+	__le32 code;
+} __packed;
+
+/**
+ * struct ixxat_usb_dal_res IXXAT device response block
+ * @res_size: Expected response size
+ * @ret_size: Actual response size
+ * @code: Return code
+ *
+ * IXXAT device response block
+ */
+struct ixxat_usb_dal_res {
+	__le32 res_size;
+	__le32 ret_size;
+	__le32 code;
+} __packed;
+
+/**
+ * struct ixxat_usb_dal_cmd IXXAT device command
+ * @req: Request block
+ * @req: Response block
+ *
+ * IXXAT device command
+ */
+struct ixxat_usb_dal_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/**
+ * struct ixxat_usb_caps_cmd Device capabilities command
+ * @req: Request block
+ * @res: Response block
+ * @caps: Device capabilities
+ *
+ * Can be sent to a device to request its capabilities
+ */
+struct ixxat_usb_caps_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_dev_caps caps;
+} __packed;
+
+/**
+ * struct ixxat_usb_init_cl1_cmd Initialization command (CL1)
+ * @req: Request block
+ * @mode: Operation mode
+ * @btr0: Bittiming register 0
+ * @btr1: Bittiming register 1
+ * @padding: 1 byte padding
+ * @res: Response block
+ *
+ * Can be sent to a CL1 device to initialize it
+ */
+struct ixxat_usb_init_cl1_cmd {
+	struct ixxat_usb_dal_req req;
+	u8 mode;
+	u8 btr0;
+	u8 btr1;
+	u8 padding;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/**
+ * struct ixxat_usb_init_cl2_cmd Initialization command (CL2)
+ * @req: Request block
+ * @opmode: Operation mode
+ * @exmode: Extended mode
+ * @sdr: Stadard bittiming parameters
+ * @fdr: Fast data bittiming parameters
+ * @_padding: 2 bytes padding
+ * @res: Response block
+ *
+ * Can be sent to a CL2 device to initialize it
+ */
+struct ixxat_usb_init_cl2_cmd {
+	struct ixxat_usb_dal_req req;
+	u8 opmode;
+	u8 exmode;
+	struct ixxat_canbtp sdr;
+	struct ixxat_canbtp fdr;
+	__le16 _padding;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/**
+ * struct ixxat_usb_start_cmd Controller start command
+ * @req: Request block
+ * @res: Response block
+ * @time: Timestamp
+ *
+ * Can be sent to a device to start its controller
+ */
+struct ixxat_usb_start_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	__le32 time;
+} __packed;
+
+/**
+ * struct ixxat_usb_stop_cmd Controller stop command
+ * @req: Request block
+ * @action: Stop action
+ * @res: Response block
+ *
+ * Can be sent to a device to start its controller
+ */
+struct ixxat_usb_stop_cmd {
+	struct ixxat_usb_dal_req req;
+	__le32 action;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/**
+ * struct ixxat_usb_power_cmd Power command
+ * @req: Request block
+ * @mode: Power mode
+ * @_padding1: 1 byte padding
+ * @_padding2: 2 byte padding
+ * @res: Response block
+ *
+ * Can be sent to a device to set its power mode
+ */
+struct ixxat_usb_power_cmd {
+	struct ixxat_usb_dal_req req;
+	u8 mode;
+	u8 _padding1;
+	__le16 _padding2;
+	struct ixxat_usb_dal_res res;
+} __packed;
+
+/**
+ * struct ixxat_usb_info_cmd Device information command
+ * @req: Request block
+ * @res: Response block
+ * @info: Device information
+ *
+ * Can be sent to a device to request its device information
+ */
+struct ixxat_usb_info_cmd {
+	struct ixxat_usb_dal_req req;
+	struct ixxat_usb_dal_res res;
+	struct ixxat_dev_info info;
+} __packed;
+
+/**
+ * struct ixxat_usb_adapter IXXAT USB device adapter
+ * @clock: Clock frequency
+ * @bt: Bittiming constants
+ * @btd: Data bittiming constants
+ * @modes: Supported modes
+ * @buffer_size_rx: Buffer size for receiving
+ * @buffer_size_tx: Buffer size for transfer
+ * @ep_msg_in: USB endpoint buffer for incoming messages
+ * @ep_msg_out: USB endpoint buffer for outgoing messages
+ * @ep_offs: Endpoint offset (device depended)
+ *
+ * Device Adapter for IXXAT USB devices
+ */
+struct ixxat_usb_adapter {
+	const u32 clock;
+	const struct can_bittiming_const *bt;
+	const struct can_bittiming_const *btd;
+	const u32 modes;
+	const u16 buffer_size_rx;
+	const u16 buffer_size_tx;
+	const u8 ep_msg_in[IXXAT_USB_MAX_CHANNEL];
+	const u8 ep_msg_out[IXXAT_USB_MAX_CHANNEL];
+	const u8 ep_offs;
+	int (*init_ctrl)(struct ixxat_usb_device *dev);
+};
+
+extern const struct ixxat_usb_adapter usb2can_cl1;
+extern const struct ixxat_usb_adapter usb2can_cl2;
+extern const struct ixxat_usb_adapter can_idm;
+
+/**
+ * ixxat_usb_setup_cmd() - Setup a device command
+ * @req: Request block
+ * @res: Response block
+ *
+ * This function sets the default values in the request and the response block
+ * of a device command
+ */
+void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
+			 struct ixxat_usb_dal_res *res);
+
+/**
+ * ixxat_usb_send_cmd() - Send a command to the device
+ * @dev: USB device
+ * @port: Command port
+ * @req: Command request buffer
+ * @req_size: Command request size
+ * @res: Command response buffer
+ * @res_size: Command response size
+ *
+ * This function sends a specific command to the device
+ *
+ * Return: Negative error code or zero on success
+ */
+int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *req,
+		       const u16 req_size, void *res, const u16 res_size);
+
+#endif /* IXXAT_USB_CORE_H */
-- 
2.39.2


