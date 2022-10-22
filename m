Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC6608FBF
	for <lists+linux-can@lfdr.de>; Sat, 22 Oct 2022 23:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJVVg1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Oct 2022 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJVVgY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2022 17:36:24 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4053F6C05
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 14:36:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2ECE2240026
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:36:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666474579; bh=UXo8SWSLjX5b/DzB0TXVybqyfBzGWqgNdN1XaWneBFs=;
        h=From:To:Cc:Subject:Date:From;
        b=pJ44kQ6u8k7QKi/14kHDWskknTCdcPDfZeFfoEHPWoJs6vF0K92WomvJ1MjtbKuPP
         kgfovsn6Zy356fyvKhrmkV/4gKAD+AtWaRo0ncB2ApvHdLYqfdbQq8ePYu479iI09Q
         L/rbAsRzXiE8Toj7Nu8uTPhvMG3nrhcByZyB2lN338u+w71JkaUbhhbmHxq54vIJRb
         7p/NaqNgoUJZJ6nSJZnn/j0zXcb0+zl4jOAeTalLoptEFcJDNU2xJk/8lGKa51CxBm
         7JcoTvke1TJ+3O60m4dfZ/3QofPxzosPoStMwXLpI7q3/C+R6VBjV4WBZmiatrzWr2
         Kwo1yH2GTdxpA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Mvvm24Tlvz9rxD;
        Sat, 22 Oct 2022 23:36:18 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH 2/7] can: peak_usb: add callback to read user value of CANFD devices
Date:   Sat, 22 Oct 2022 21:35:30 +0000
Message-Id: <20221022213535.8495-3-lukas.magel@posteo.net>
In-Reply-To: <20221022213535.8495-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20221022213535.8495-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds the specific function that allows to read a user defined
value from the non volatile memory of the USB CANFD interfaces of
PEAK-System.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  3 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 33 +++++++++++++++++---
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 8e1b3c19f92f..ca282b0aa9a5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -922,8 +922,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	}
 
 	/* get device number early */
-	if (dev->adapter->dev_get_user_devid)
-		dev->adapter->dev_get_user_devid(dev, &dev->user_devid);
+	dev->adapter->dev_get_user_devid(dev, &dev->user_devid);
 
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
 			peak_usb_adapter->name, ctrl_idx, dev->user_devid);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index b8053e697261..2db358d0295e 100644
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
 
+/* read user device id from device */
+static int pcan_usb_fd_get_user_devid(struct peak_usb_device *dev,
+				      u32 *user_devid)
+{
+	int err;
+	struct pcan_usb_fd_if *usb_if = pcan_usb_fd_dev_if(dev);
+
+	err = pcan_usb_fd_read_fwinfo(dev, &usb_if->fw_info);
+	if (err)
+		return err;
+
+	*user_devid = le32_to_cpu(usb_if->fw_info.dev_id[dev->ctrl_idx]);
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
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1222,6 +1244,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1296,6 +1319,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1370,6 +1394,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
-- 
2.37.2

