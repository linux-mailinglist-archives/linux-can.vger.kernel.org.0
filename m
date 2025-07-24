Return-Path: <linux-can+bounces-4098-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD6B10339
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03FF5600B4
	for <lists+linux-can@lfdr.de>; Thu, 24 Jul 2025 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4895027602E;
	Thu, 24 Jul 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Gnz/OdC3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B7274FEF
	for <linux-can@vger.kernel.org>; Thu, 24 Jul 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344975; cv=none; b=X/AJ6pNvDI5ejrRSHMmbsErnOucn19+rWc4aym9O/lqumTIgSZ/MORoQIt7e6UwjdUFRmUutTnkLxf8j7segHfCSiK/hpSYlYOGREnHfjDTUtAEzKFXnYhHbWKDfDtpQPirIjkyT/ZItFnaec1G4gFPTWW349ZwWypDhpeV2ZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344975; c=relaxed/simple;
	bh=hoLjzdlhF9fle7dQGkLZT07586YYJJ3B//87Lj/hj7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMjDLYioVx/c4dbTu1/6RuXsOZfrdTqu+pWhQXfR4RMf/6RqzztH2p1vKwcYwNb09LZ/shgriVUnC3dXAf0MglpykdwMkJ0VWt+6VIPgsP/5CVCUEVq0tGl07YL5tc0ZWtI6GfU4JwTuRjpPcW4ECSuHW+LfDQA8DG1e1PA7YzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Gnz/OdC3; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from stf-laptop.box.freepro.com (unknown [IPv6:2a05:6e02:1102:5710:5084:4ff2:f1ab:fa40])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4BD5378035B;
	Thu, 24 Jul 2025 10:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1753344968;
	bh=hoLjzdlhF9fle7dQGkLZT07586YYJJ3B//87Lj/hj7M=;
	h=From:To:Cc:Subject:Date:From;
	b=Gnz/OdC3VrOV7YaGqlctU3lITEE1MM1LW7UksQ+sUtTE94i06UozSUgaB8rjW0Ysq
	 SWxDyoQWphtHGcAIb7EUB/rtap6ctBQsoUvSWjcBla/+UxwkTeoGIY8mUIp3NO6T8o
	 3CWzAIh48qoOrA8nJ1IMLYMYEafu9oaL2scWWJbPdA5XCLn3bRgmCb677gCLcTsjB9
	 40LjuHGJWGbnGj/UhUOeoL96WA/c280aVTKWXaP76ehliKFQZBlltLhkPBk5pYlwt4
	 cF4iQSnxXZ2hIJM0i5ANuFdaMgYqouM5kcgXL1zo4uJHyw7bITxntIUStYTnsyNZF1
	 vYSmK6Xwc5JIw==
From: Stephane Grosjean <stephane.grosjean@free.fr>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [PATCH v2] can: peak_usb: fix USB FD devices potential malfunction
Date: Thu, 24 Jul 2025 10:13:19 +0200
Message-ID: <20250724081550.11694-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stephane Grosjean <stephane.grosjean@hms-networks.com>

The latest firmware versions of USB CAN FD interfaces export the EP numbers
to be used to dialog with the device via the "type" field of a response to
a vendor request structure, particularly when its value is greater than or
equal to 2.

This patch corrects the driver's test of this field.

Fixes: 4f232482467a ("can: peak_usb: include support for a new MCU")
Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

v2: Added "Fixes:" tag
    Fixed comments around new way of how "type" is handled
    Added 2nd correction to "type" handling, which had been forgotten in v1

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index aa0b68c1ae81..ec77aa29a8c5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -49,7 +49,7 @@ struct __packed pcan_ufd_fw_info {
 	__le32	ser_no;		/* S/N */
 	__le32	flags;		/* special functions */
 
-	/* extended data when type == PCAN_USBFD_TYPE_EXT */
+	/* extended data when type >= PCAN_USBFD_TYPE_EXT */
 	u8	cmd_out_ep;	/* ep for cmd */
 	u8	cmd_in_ep;	/* ep for replies */
 	u8	data_out_ep[2];	/* ep for CANx TX */
@@ -1003,10 +1003,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 			dev->can.ctrlmode |= CAN_CTRLMODE_FD_NON_ISO;
 		}
 
-		/* if vendor rsp is of type 2, then it contains EP numbers to
-		 * use for cmds pipes. If not, then default EP should be used.
+		/* if vendor rsp type is greater than or equal to 2, then it
+		 * contains EP numbers to use for cmds pipes. If not, then
+		 * default EP should be used.
 		 */
-		if (fw_info->type != cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+		if (le16_to_cpu(fw_info->type) < PCAN_USBFD_TYPE_EXT) {
 			fw_info->cmd_out_ep = PCAN_USBPRO_EP_CMDOUT;
 			fw_info->cmd_in_ep = PCAN_USBPRO_EP_CMDIN;
 		}
@@ -1039,11 +1040,11 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 	dev->can_channel_id =
 		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
-	/* if vendor rsp is of type 2, then it contains EP numbers to
-	 * use for data pipes. If not, then statically defined EP are used
-	 * (see peak_usb_create_dev()).
+	/* if vendor rsp type is greater than or equal to 2, then it contains EP
+	 * numbers to use for data pipes. If not, then statically defined EP are
+	 * used (see peak_usb_create_dev()).
 	 */
-	if (fw_info->type == cpu_to_le16(PCAN_USBFD_TYPE_EXT)) {
+	if (le16_to_cpu(fw_info->type) >= PCAN_USBFD_TYPE_EXT) {
 		dev->ep_msg_in = fw_info->data_in_ep;
 		dev->ep_msg_out = fw_info->data_out_ep[dev->ctrl_idx];
 	}
-- 
2.43.0


