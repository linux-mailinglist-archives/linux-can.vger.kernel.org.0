Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3090C64B0BA
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 09:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiLMIEm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 03:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiLMIEi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 03:04:38 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96A312AB1
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 00:04:36 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A11AC240104
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:04:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1670918675; bh=uGd1zQDLFm7R5LY+ONuIuElI48jBLvT5JdTTnlquqAU=;
        h=From:To:Cc:Subject:Date:From;
        b=CRhinUwFjFxhnnjG5Q4HDA13CNZSDZttz4I8a4nuHPuy72Lh697QzLvjAJfncUK28
         hYQxgqayWrRJRZUelBH5IwzbYm17nMhu5lMUI9OnfuEeYZAbR08aC0sD5XMa4KCwj2
         jVERDjmstNE7vytfCDofacmnoZLqXVILO2HijmkiP8S43K+QM299pFWfRs1ADa+s2d
         KYJVd2naqQSQe98Lx6VNlmlLkX4Z0djnXCbgcH1xXzH3S5Nb/F5ONrrVldaVS6pS/O
         XENMOyctpxDsRITRK00oHQO2zNdG4YMgcUtBu2LZK3Qb/heU9J5vUfHTPiKlol++0G
         HSUlpcnGcXGyg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NWWHR0ksmz6tmK;
        Tue, 13 Dec 2022 09:04:35 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 3/8] can: peak_usb: allow flashing of the CAN channel ID
Date:   Tue, 13 Dec 2022 08:03:05 +0000
Message-Id: <20221213080309.9013-4-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
Reply-To: Lukas Magel <lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds callbacks that allow the user to set a new self-defined
CAN channel ID to all USB - CAN/CANFD interfaces of PEAK-System managed by
this driver, namely:
- PCAN-USB
- PCAN-USB FD
- PCAN-USB Pro FD
- PCAN-USB X6
- PCAN-Chip USB
- PCAN-USB Pro

The callback functions write the CAN channel ID to the non-volatile
memory of the devices.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 26 ++++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 26 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 15 +++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  1 +
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 7b3282e5c880..92472149cfba 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -9,10 +9,12 @@
  * Many thanks to Klaus Hitschler <klaus.hitschler@gmx.de>
  */
 #include <asm/unaligned.h>
+
+#include <linux/ethtool.h>
+#include <linux/limits.h>
+#include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/usb.h>
-#include <linux/module.h>
-#include <linux/ethtool.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -398,6 +400,25 @@ static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_
 	return err;
 }
 
+/* set a new CAN channel id in the flash memory of the device */
+static int pcan_usb_set_can_channel_id(struct peak_usb_device *dev, u32 can_ch_id)
+{
+	u8 args[PCAN_USB_CMD_ARGS_LEN];
+
+	/* this kind of device supports 8-bit values only */
+	if (can_ch_id > U8_MAX)
+		return -EINVAL;
+
+	/* during the flash process the device disconnects during ~1.25 s.:
+	 * prohibit access when interface is UP
+	 */
+	if (dev->netdev->flags & IFF_UP)
+		return -EBUSY;
+
+	args[0] = can_ch_id;
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_DEVID, PCAN_USB_SET, args);
+}
+
 /*
  * update current time ref with received timestamp
  */
@@ -1018,6 +1039,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_set_bus = pcan_usb_write_mode,
 	.dev_set_bittiming = pcan_usb_set_bittiming,
 	.dev_get_can_channel_id = pcan_usb_get_can_channel_id,
+	.dev_set_can_channel_id = pcan_usb_set_can_channel_id,
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 6de0429c268f..1e461aef0f2a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -61,6 +61,7 @@ struct peak_usb_adapter {
 				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
 	int (*dev_get_can_channel_id)(struct peak_usb_device *dev, u32 *can_ch_id);
+	int (*dev_set_can_channel_id)(struct peak_usb_device *dev, u32 can_ch_id);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
 	int (*dev_encode_msg)(struct peak_usb_device *dev, struct sk_buff *skb,
 					u8 *obuf, size_t *size);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index a70ef0c7a800..1ea4cfdfd640 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -147,6 +147,15 @@ struct __packed pcan_ufd_ovr_msg {
 	u8	unused[3];
 };
 
+#define PCAN_UFD_CMD_DEVID_SET		0x81
+
+struct __packed pcan_ufd_device_id {
+	__le16	opcode_channel;
+
+	u16	unused;
+	__le32	device_id;
+};
+
 static inline int pufd_omsg_get_channel(struct pcan_ufd_ovr_msg *om)
 {
 	return om->channel & 0xf;
@@ -458,6 +467,19 @@ static int pcan_usb_fd_get_can_channel_id(struct peak_usb_device *dev,
 	return err;
 }
 
+/* set a new CAN channel id in the flash memory of the device */
+static int pcan_usb_fd_set_can_channel_id(struct peak_usb_device *dev, u32 can_ch_id)
+{
+	struct pcan_ufd_device_id *cmd = pcan_usb_fd_cmd_buffer(dev);
+
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
+						       PCAN_UFD_CMD_DEVID_SET);
+	cmd->device_id = cpu_to_le32(can_ch_id);
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
+}
+
 /* handle restart but in asynchronously way
  * (uses PCAN-USB Pro code to complete asynchronous request)
  */
@@ -1170,6 +1192,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
+	.dev_set_can_channel_id = pcan_usb_fd_set_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1245,6 +1268,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
+	.dev_set_can_channel_id = pcan_usb_fd_set_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1320,6 +1344,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
+	.dev_set_can_channel_id = pcan_usb_fd_set_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1395,6 +1420,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
+	.dev_set_can_channel_id = pcan_usb_fd_set_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 3a13cfef47bb..061f04c20f96 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -76,6 +76,7 @@ static u16 pcan_usb_pro_sizeof_rec[256] = {
 	[PCAN_USBPRO_SETFILTR] = sizeof(struct pcan_usb_pro_filter),
 	[PCAN_USBPRO_SETTS] = sizeof(struct pcan_usb_pro_setts),
 	[PCAN_USBPRO_GETDEVID] = sizeof(struct pcan_usb_pro_devid),
+	[PCAN_USBPRO_SETDEVID] = sizeof(struct pcan_usb_pro_devid),
 	[PCAN_USBPRO_SETLED] = sizeof(struct pcan_usb_pro_setled),
 	[PCAN_USBPRO_RXMSG8] = sizeof(struct pcan_usb_pro_rxmsg),
 	[PCAN_USBPRO_RXMSG4] = sizeof(struct pcan_usb_pro_rxmsg) - 4,
@@ -149,6 +150,7 @@ static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, int id, ...)
 
 	case PCAN_USBPRO_SETBTR:
 	case PCAN_USBPRO_GETDEVID:
+	case PCAN_USBPRO_SETDEVID:
 		*pc++ = va_arg(ap, int);
 		pc += 2;
 		*(__le32 *)pc = cpu_to_le32(va_arg(ap, u32));
@@ -444,6 +446,18 @@ static int pcan_usb_pro_get_can_channel_id(struct peak_usb_device *dev,
 	return err;
 }
 
+static int pcan_usb_pro_set_can_channel_id(struct peak_usb_device *dev,
+					   u32 can_ch_id)
+{
+	struct pcan_usb_pro_msg um;
+
+	pcan_msg_init_empty(&um, dev->cmd_buf, PCAN_USB_MAX_CMD_LEN);
+	pcan_msg_add_rec(&um, PCAN_USBPRO_SETDEVID, dev->ctrl_idx,
+			 can_ch_id);
+
+	return pcan_usb_pro_send_cmd(dev, &um);
+}
+
 static int pcan_usb_pro_set_bittiming(struct peak_usb_device *dev,
 				      struct can_bittiming *bt)
 {
@@ -1077,6 +1091,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.dev_set_bus = pcan_usb_pro_set_bus,
 	.dev_set_bittiming = pcan_usb_pro_set_bittiming,
 	.dev_get_can_channel_id = pcan_usb_pro_get_can_channel_id,
+	.dev_set_can_channel_id = pcan_usb_pro_set_can_channel_id,
 	.dev_decode_buf = pcan_usb_pro_decode_buf,
 	.dev_encode_msg = pcan_usb_pro_encode_msg,
 	.dev_start = pcan_usb_pro_start,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index a34e0fc021c9..28e740af905d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -62,6 +62,7 @@ struct __packed pcan_usb_pro_fwinfo {
 #define PCAN_USBPRO_SETBTR	0x02
 #define PCAN_USBPRO_SETBUSACT	0x04
 #define PCAN_USBPRO_SETSILENT	0x05
+#define PCAN_USBPRO_SETDEVID	0x06
 #define PCAN_USBPRO_SETFILTR	0x0a
 #define PCAN_USBPRO_SETTS	0x10
 #define PCAN_USBPRO_GETDEVID	0x12
-- 
2.38.1

