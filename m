Return-Path: <linux-can+bounces-4055-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B829B0EDFD
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CAE1885D5A
	for <lists+linux-can@lfdr.de>; Wed, 23 Jul 2025 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BC27BF80;
	Wed, 23 Jul 2025 09:03:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E404D23C51B
	for <linux-can@vger.kernel.org>; Wed, 23 Jul 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261392; cv=none; b=eqQivx1XOvaGnZEnZyRIgqd6oZ0b53Fb/b5WOrq0J+fEYDEQUHM4rJBrStye65WMad/EYrL+Av1QWN7nksa2fX07jEoX16SsCLWU+Mol3bxI3Oj7tytZZAEqkW1HuWp0ZJIjJC2gZonbkpsrNGTb4K5D+vUN6C2NTiPvbGb/IhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261392; c=relaxed/simple;
	bh=Cr0bGwwsIcT/ZeXCemZZ1ynPZ0ST2tsDYiDGPLh3j/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oxoBBa+PzHKNs78a5KUDZ4J2+yPUnHRCaTt0V71C0XwW3kNWRie+kVPYqIX07OIUowOP8N/5CBD8+E5p6jc025zCWxEAHYUACIfboYKh226U2Ho2BFMEgvybxxB2AjgmXgboY/1We4y2Yld0xu9FE5PFXszKD2uQAQe7Kyy97jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hms-networks.com; spf=fail smtp.mailfrom=hms-networks.com; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hms-networks.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hms-networks.com
Received: from stf-laptop.. (unknown [IPv6:2a02:8428:60a1:3e01:4d27:5b07:17ce:6dc9])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 291757803A2;
	Wed, 23 Jul 2025 11:03:05 +0200 (CEST)
From: Stephane Grosjean <stephane.grosjean@hms-networks.com>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <stephane.grosjean@hms-networks.com>
Subject: [PATCH] can: peak_usb: fix USB CANFD devices potential malfunction
Date: Wed, 23 Jul 2025 11:02:10 +0200
Message-ID: <20250723090255.36317-1-stephane.grosjean@hms-networks.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The latest firmware versions of USB CANFD interfaces export the EP numbers
to be used to dialog with the device via the "type" field of a response to
a vendor request structure, particularly when its value is greater than or
equal to 2.

This patch corrects the driver's test of this field.

Signed-off-by: Stephane Grosjean <stephane.grosjean@hms-networks.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index aa0b68c1ae81..356f76acedd4 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
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
-- 
2.43.0


