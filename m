Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D444D441B
	for <lists+linux-can@lfdr.de>; Thu, 10 Mar 2022 10:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiCJKAP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Mar 2022 05:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiCJKAN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 05:00:13 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B1310CF26
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 01:59:10 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 86F292003CA;
        Thu, 10 Mar 2022 10:59:07 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 5/8 v3] can: peak_usb: allow flashing of user defined value
Date:   Thu, 10 Mar 2022 10:58:38 +0100
Message-Id: <20220310095841.9134-6-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095841.9134-1-s.grosjean@peak-system.com>
References: <20220310095841.9134-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches adds a callback that allows the user to flash a
self-defined value to all USB - CAN/CANFD interfaces of PEAK-System managed
by this driver, namely:
- PCAN-USB
- PCAN-USB FD
- PCAN-USB Pro FD
- PCAN-USB X6
- PCAN-Chip USB
- PCAN-USB Pro

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      | 21 ++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 25 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 15 ++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  1 +
 5 files changed, 63 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 313db844ee52..af3a2dcb5abc 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -398,6 +398,26 @@ static int pcan_usb_get_user_devid(struct peak_usb_device *dev, __le32 *ledevid)
 	return err;
 }
 
+/* set a new user device id in the flash memory of the device */
+static int pcan_usb_set_user_devid(struct peak_usb_device *dev, __le32 ledevid)
+{
+	u8 args[PCAN_USB_CMD_ARGS_LEN];
+	u32 devid = le32_to_cpu(ledevid);
+
+	/* this kind of device supports 8-bit values only */
+	if (devid > U8_MAX)
+		return -EINVAL;
+
+	/* during the flash process the device disconnects during ~1.25 s.:
+	 * prohibit access when interface is UP
+	 */
+	if (dev->netdev->flags & IFF_UP)
+		return -EBUSY;
+
+	args[0] = devid;
+	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_DEVID, PCAN_USB_SET, args);
+}
+
 /*
  * update current time ref with received timestamp
  */
@@ -1016,6 +1036,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_set_bus = pcan_usb_write_mode,
 	.dev_set_bittiming = pcan_usb_set_bittiming,
 	.dev_get_user_devid = pcan_usb_get_user_devid,
+	.dev_set_user_devid = pcan_usb_set_user_devid,
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 03c8f942d684..2d2f53edc6a2 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -61,6 +61,7 @@ struct peak_usb_adapter {
 				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
 	int (*dev_get_user_devid)(struct peak_usb_device *dev, __le32 *ledevid);
+	int (*dev_set_user_devid)(struct peak_usb_device *dev, __le32 ledevid);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
 	int (*dev_encode_msg)(struct peak_usb_device *dev, struct sk_buff *skb,
 					u8 *obuf, size_t *size);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 533277b41a02..d0b9c9f5357f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -136,6 +136,15 @@ struct __packed pcan_ufd_ovr_msg {
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
@@ -440,6 +449,18 @@ static int pcan_usb_fd_get_user_devid(struct peak_usb_device *dev,
 	return 0;
 }
 
+/* set a new user device id in the flash memory of the device */
+static int pcan_usb_fd_set_user_devid(struct peak_usb_device *dev,
+				      __le32 ledevid)
+{
+	struct pcan_ufd_device_id *cmd = pcan_usb_fd_cmd_buffer(dev);
+
+	cmd->opcode_channel = pucan_cmd_opcode_channel(dev->ctrl_idx,
+						       PCAN_UFD_CMD_DEVID_SET);
+	cmd->device_id = ledevid;
+
+	/* send the command */
+	return pcan_usb_fd_send_cmd(dev, ++cmd);
 }
 
 /* handle restart but in asynchronously way
@@ -1122,6 +1143,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
+	.dev_set_user_devid = pcan_usb_fd_set_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1197,6 +1219,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
+	.dev_set_user_devid = pcan_usb_fd_set_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1272,6 +1295,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
+	.dev_set_user_devid = pcan_usb_fd_set_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1347,6 +1371,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
 	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
+	.dev_set_user_devid = pcan_usb_fd_set_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4fda5bb509f0..9b394277ec2e 100644
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
@@ -444,6 +446,18 @@ static int pcan_usb_pro_get_user_devid(struct peak_usb_device *dev,
 	return err;
 }
 
+static int pcan_usb_pro_set_user_devid(struct peak_usb_device *dev,
+				       __le32 ledevid)
+{
+	struct pcan_usb_pro_msg um;
+
+	pcan_msg_init_empty(&um, dev->cmd_buf, PCAN_USB_MAX_CMD_LEN);
+	pcan_msg_add_rec(&um, PCAN_USBPRO_SETDEVID, dev->ctrl_idx,
+			 le32_to_cpu(ledevid));
+
+	return pcan_usb_pro_send_cmd(dev, &um);
+}
+
 static int pcan_usb_pro_set_bittiming(struct peak_usb_device *dev,
 				      struct can_bittiming *bt)
 {
@@ -1076,6 +1090,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.dev_set_bus = pcan_usb_pro_set_bus,
 	.dev_set_bittiming = pcan_usb_pro_set_bittiming,
 	.dev_get_user_devid = pcan_usb_pro_get_user_devid,
+	.dev_set_user_devid = pcan_usb_pro_set_user_devid,
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
2.25.1

