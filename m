Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D9B49FC57
	for <lists+linux-can@lfdr.de>; Fri, 28 Jan 2022 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbiA1PCU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jan 2022 10:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiA1PCU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jan 2022 10:02:20 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577BAC061714
        for <linux-can@vger.kernel.org>; Fri, 28 Jan 2022 07:02:20 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id D862C2003E0;
        Fri, 28 Jan 2022 16:02:16 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/6] can: peak_usb: add callback to read user value of CANFD devices
Date:   Fri, 28 Jan 2022 16:01:53 +0100
Message-Id: <20220128150157.1222850-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128150157.1222850-1-s.grosjean@peak-system.com>
References: <20220128150157.1222850-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds the specific function that allows to read a user defined
value from the non volatile memory of the USB CANFD interfaces of
PEAK-System.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 65487ec33566..ab1a8b797ece 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -420,6 +420,24 @@ static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *dev,
 	return pcan_usb_fd_send_cmd(dev, ++cmd);
 }
 
+/* read user device id from device */
+static int pcan_usb_fd_get_user_devid(struct peak_usb_device *dev,
+				      u32 *device_id)
+{
+	struct pcan_usb_fd_device *pdev =
+		container_of(dev, struct pcan_usb_fd_device, dev);
+	struct pcan_ufd_fw_info *fw_info = &pdev->usb_if->fw_info;
+	int err;
+
+	err = pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
+				    PCAN_USBPRO_INFO_FW,
+				    fw_info, sizeof(*fw_info));
+	if (!err)
+		*device_id = le32_to_cpu(fw_info->dev_id[dev->ctrl_idx]);
+
+	return err;
+}
+
 /* handle restart but in asynchronously way
  * (uses PCAN-USB Pro code to complete asynchronous request)
  */
@@ -1099,6 +1117,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1173,6 +1192,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1247,6 +1267,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
@@ -1321,6 +1342,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.dev_set_bus = pcan_usb_fd_set_bus,
 	.dev_set_bittiming = pcan_usb_fd_set_bittiming_slow,
 	.dev_set_data_bittiming = pcan_usb_fd_set_bittiming_fast,
+	.dev_get_user_devid = pcan_usb_fd_get_user_devid,
 	.dev_decode_buf = pcan_usb_fd_decode_buf,
 	.dev_start = pcan_usb_fd_start,
 	.dev_stop = pcan_usb_fd_stop,
-- 
2.25.1

