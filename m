Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2D66CFE4
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 21:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjAPUL5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 15:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjAPUL4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 15:11:56 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5555B241CA
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 12:11:53 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 061AB240068
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 21:11:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673899912; bh=2+/B/wB4p4AYY1SHbycvFUvK8C00Fvx2SWluuJXNAgA=;
        h=From:To:Cc:Subject:Date:From;
        b=HZLUgV9vDHZ2TOXnKNJMfYvKYQ/1ZJBxyOj9Fno/IKA5+P1SJ2cA9YjFW1K0bMr0w
         agrAN0iHucs63/fBj96f9VG6uEGwRAO777dl097r0Foh4axUV2dq4RM0QgfNJvWJBS
         6R8bbgZ2setruSqtrXsvoxWkVf9yTxvdHzbQUDhlinUOfDJhp6esVtgN0eQA9nQyfT
         cg5iNNgPz0tBRgcHAYqzuA65wG/NPA4pKcH4ija6jyl1TzQa/o4Xv+DfafBr1dGOoO
         2Tr8Ync1iYCc6yZwPUv4ofRslY7GWxudyh4LBTpru/QrAqU6bH6QLuQgvC8BqePLcv
         38CDYKicZR77A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nwjpv2X45z9rxB;
        Mon, 16 Jan 2023 21:11:51 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 2/8] can: peak_usb: add callback to read CAN channel ID of PEAK CAN-FD devices
Date:   Mon, 16 Jan 2023 20:09:26 +0000
Message-Id: <20230116200932.157769-3-lukas.magel@posteo.net>
In-Reply-To: <20230116200932.157769-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20230116200932.157769-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds a new function that allows to read the CAN channel ID
from the non volatile memory of the USB CAN-FD PEAK devices. The CAN
channel ID is a user-configurable u8/u32 identifier value that can be set
individually for each PEAK CAN interface.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  3 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 33 +++++++++++++++++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index a3a25a2e8d41..54e2481cce30 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -922,8 +922,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	}
 
 	/* get CAN channel id early */
-	if (dev->adapter->dev_get_can_channel_id)
-		dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
+	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
 
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
 			peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 2e0955900ebe..a70ef0c7a800 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -234,6 +234,15 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd_tail)
 	return err;
 }
 
+static int pcan_usb_fd_read_fwinfo(struct peak_usb_device *dev,
+				   struct pcan_ufd_fw_info *fw_info)
+{
+	return pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
+				     PCAN_USBPRO_INFO_FW,
+				     fw_info,
+				     sizeof(*fw_info));
+}
+
 /* build the commands list in the given buffer, to enter operational mode */
 static int pcan_usb_fd_build_restart_cmd(struct peak_usb_device *dev, u8 *buf)
 {
@@ -434,6 +443,21 @@ static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *dev,
 	return pcan_usb_fd_send_cmd(dev, ++cmd);
 }
 
+/* read user CAN channel id from device */
+static int pcan_usb_fd_get_can_channel_id(struct peak_usb_device *dev,
+					  u32 *can_ch_id)
+{
+	int err;
+	struct pcan_usb_fd_if *usb_if = pcan_usb_fd_dev_if(dev);
+
+	err = pcan_usb_fd_read_fwinfo(dev, &usb_if->fw_info);
+	if (err)
+		return err;
+
+	*can_ch_id = le32_to_cpu(usb_if->fw_info.dev_id[dev->ctrl_idx]);
+	return err;
+}
+
 /* handle restart but in asynchronously way
  * (uses PCAN-USB Pro code to complete asynchronous request)
  */
@@ -907,10 +931,7 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 
 		fw_info = &pdev->usb_if->fw_info;
 
-		err = pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
-					    PCAN_USBPRO_INFO_FW,
-					    fw_info,
-					    sizeof(*fw_info));
+		err = pcan_usb_fd_read_fwinfo(dev, fw_info);
 		if (err) {
 			dev_err(dev->netdev->dev.parent,
 				"unable to read %s firmware info (err %d)\n",
@@ -1148,6 +1169,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1222,6 +1244,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1296,6 +1319,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1370,6 +1394,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_can_channel_id = pcan_usb_fd_get_can_channel_id,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
-- 
2.38.1

