Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02E33206E
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 09:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhCIIW7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 03:22:59 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:13366 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230143AbhCIIWt (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 03:22:49 -0500
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 95BE65FF3F;
        Tue,  9 Mar 2021 09:22:14 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 3/3] can/peak_usb: add support of ONE_SHOT mode
Date:   Tue,  9 Mar 2021 09:21:28 +0100
Message-Id: <20210309082128.23125-4-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309082128.23125-1-s.grosjean@peak-system.com>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds "ONE-SHOT" mode support to the following CAN-USB
PEAK-System GmbH interfaces:
- PCAN-USB X6
- PCAN-USB FD
- PCAN-USB Pro FD
- PCAN-Chip USB
- PCAN-USB Pro

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c  | 12 ++++++++----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 12 +++++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 8e6250c4c417..0e3bb3a4945d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -779,6 +779,10 @@ static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
 			tx_msg_flags |= PUCAN_MSG_RTR;
 	}
 
+	/* Single-Shot frame */
+	if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		tx_msg_flags |= PUCAN_MSG_SINGLE_SHOT;
+
 	tx_msg->flags = cpu_to_le16(tx_msg_flags);
 	tx_msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, dlc);
 	memcpy(tx_msg->d, cfd->data, cfd->len);
@@ -1068,7 +1072,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_CC_LEN8_DLC,
+			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1143,7 +1147,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_CC_LEN8_DLC,
+		CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1217,7 +1221,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_CC_LEN8_DLC,
+			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1292,7 +1296,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_CC_LEN8_DLC,
+			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index ff740b4203fa..5b098d1e3746 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -39,6 +39,7 @@ MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
 
 #define PCAN_USBPRO_RTR			0x01
 #define PCAN_USBPRO_EXT			0x02
+#define PCAN_USBPRO_SS			0x08
 
 #define PCAN_USBPRO_CMD_BUFFER_SIZE	512
 
@@ -779,9 +780,13 @@ static int pcan_usb_pro_encode_msg(struct peak_usb_device *dev,
 
 	flags = 0;
 	if (cf->can_id & CAN_EFF_FLAG)
-		flags |= 0x02;
+		flags |= PCAN_USBPRO_EXT;
 	if (cf->can_id & CAN_RTR_FLAG)
-		flags |= 0x01;
+		flags |= PCAN_USBPRO_RTR;
+
+	/* Single-Shot frame */
+	if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		flags |= PCAN_USBPRO_SS;
 
 	pcan_msg_add_rec(&usb_msg, data_type, 0, flags, len, cf->can_id,
 			 cf->data);
@@ -1041,7 +1046,8 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	.name = "PCAN-USB Pro",
 	.device_id = PCAN_USBPRO_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
-	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
+			      CAN_CTRLMODE_ONE_SHOT,
 	.clock = {
 		.freq = PCAN_USBPRO_CRYSTAL_HZ,
 	},
-- 
2.25.1

