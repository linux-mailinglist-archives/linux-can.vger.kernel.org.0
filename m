Return-Path: <linux-can+bounces-2844-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B8A3A070
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B51161CC7
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7C726A1B0;
	Tue, 18 Feb 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tnp6TO7k"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-73.smtpout.orange.fr [193.252.22.73])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E52309B5;
	Tue, 18 Feb 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889902; cv=none; b=rYaaXR9qDVzjy3oesnXV/rs+xHEFTwYTNc99vLVi7/iPFJCMFPd/2/E/gDo4babRKYIzJ72XGiHQQHJsL4sfUyUE6bLjJ5R2uLOhTYJkjVB1hN5ekxP94KyMvz5ESac1jNv9e4x+KP0lUkPw+J1Y8H3aj/oJ+gmAmTBaSpUB/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889902; c=relaxed/simple;
	bh=iLs3plEjkwEpLyj0A8yL7flOYDE8g7L+9PydZRFPTfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ljw26P8UDvR3TeCkbKFpgu1opo4HA+PKikavDDQIJo/CrXOzrSNu36S6UCxRWqBaSOrBg3N2psFYZsKg2erG8TA0cQEmRTsNrzqmIYuuVjmlzVuk/tES8xG2XregLVFxF0YRoWACdsicLJg1UJ29wbkr516toHD1Yyb44KDSsjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tnp6TO7k; arc=none smtp.client-ip=193.252.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id kOhEtKM4rovodkOhQtiUMN; Tue, 18 Feb 2025 15:35:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739889354;
	bh=g/yw2yo0t0Acq9kWMIp+qDeiq85Jgqqq0N/OKh7IZqk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=tnp6TO7kVuDCNYNMXAjCTeVfIIgrjRNUMEN+ThL87akWRBbHTnEvZgs65Aq7d674U
	 oHxWac9ko9nvTB8GpyjXv3ygBlz90pwCrIbGmd+bdPIG7SGCCzpWS6BAIRvlB2GtSJ
	 cgO0qKu5TWtEg+c4xwq0jvG+EC/Fyp0wE7jbITsiV90CGKvcisbeMQw0M0uUNSm210
	 VV5QVQKXp3S9EJMObSpVUJBF3tF0Eue8ifep9wWg1kZSUip2p1l8bwBJvDrvDJ48BI
	 FvxQzCpEGfOnqYpqFrV15v54q7CKaCgl3eSq6ZC2A9TqheQ1LwMWOHm9ENNxPCF2Al
	 eiMEEioW9KSzA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Feb 2025 15:35:54 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Matt Jan <zoo868e@gmail.com>,
	Xu Panda <xu.panda@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Subject: [PATCH] can: ucan: fix out of bound read in strscpy() source
Date: Tue, 18 Feb 2025 23:32:28 +0900
Message-ID: <20250218143515.627682-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <67b323a4.050a0220.173698.002b.GAE@google.com>
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4692; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=iLs3plEjkwEpLyj0A8yL7flOYDE8g7L+9PydZRFPTfM=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOlbZi1e//yDpZutBcO3D4ZOoR5LXvnO2Wb1r/i/8f/UX RsvnSwR7yhlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCR2jSGP9xyb5rX8h948zOX US06q3P5F3uDwu/V/aG+TOVsmk1J7Az/tM8nHRat3bG63t/xP5PQAn0BVYG1V6c2W7QLSK7/8ug uAwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Commit 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
unintentionally introduced a one byte out of bound read on strscpy()'s
source argument (which is kind of ironic knowing that strscpy() is meant
to be a more secure alternative :)).

Let's consider below buffers:

  dest[len + 1]; /* will be NUL terminated */
  src[len]; /* may not be NUL terminated */

When doing:

  strncpy(dest, src, len);
  dest[len] = '\0';

strncpy() will read up to len bytes from src.

On the other hand:

  strscpy(dest, src, len + 1);

will read up to len + 1 bytes from src, that is to say, an out of bound
read of one byte will occur on src if it is not NUL terminated. Note
that the src[len] byte is never copied, but strscpy() still needs to
read it to check whether a truncation occurred or not.

This exact pattern happened in ucan.

The root cause is that the source is not NUL terminated. Instead of
doing a copy in a local buffer, directly NUL terminate it as soon as
usb_control_msg() returns. With this, the local firmware_str[] variable
can be removed.

On top of this do a couple refactors:

  - ucan_ctl_payload->raw is only used for the firmware string, so
    rename it to ucan_ctl_payload->fw_str and change its type from u8 to
    char.

  - ucan_device_request_in() is only used to retrieve the firmware
    string, so rename it to ucan_get_fw_str() and refactor it to make it
    directly handle all the string termination logic.

Reported-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/67b323a4.050a0220.173698.002b.GAE@google.com/
Fixes: 7fdaf8966aae ("can: ucan: use strscpy() to instead of strncpy()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/ucan.c | 43 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 39a63b7313a4..07406daf7c88 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -186,7 +186,7 @@ union ucan_ctl_payload {
 	 */
 	struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
 
-	u8 raw[128];
+	u8 fw_str[128];
 } __packed;
 
 enum {
@@ -424,18 +424,20 @@ static int ucan_ctrl_command_out(struct ucan_priv *up,
 			       UCAN_USB_CTL_PIPE_TIMEOUT);
 }
 
-static int ucan_device_request_in(struct ucan_priv *up,
-				  u8 cmd, u16 subcmd, u16 datalen)
+static void ucan_get_fw_str(struct ucan_priv *up, char *fw_str, size_t size)
 {
-	return usb_control_msg(up->udev,
-			       usb_rcvctrlpipe(up->udev, 0),
-			       cmd,
-			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			       subcmd,
-			       0,
-			       up->ctl_msg_buffer,
-			       datalen,
-			       UCAN_USB_CTL_PIPE_TIMEOUT);
+	int ret;
+
+	ret = usb_control_msg(up->udev, usb_rcvctrlpipe(up->udev, 0),
+			      UCAN_DEVICE_GET_FW_STRING,
+			      USB_DIR_IN | USB_TYPE_VENDOR |
+			      USB_RECIP_DEVICE,
+			      0, 0, fw_str, size - 1,
+			      UCAN_USB_CTL_PIPE_TIMEOUT);
+	if (ret > 0)
+		fw_str[ret] = '\0';
+	else
+		strscpy(fw_str, "unknown", size);
 }
 
 /* Parse the device information structure reported by the device and
@@ -1314,7 +1316,6 @@ static int ucan_probe(struct usb_interface *intf,
 	u8 in_ep_addr;
 	u8 out_ep_addr;
 	union ucan_ctl_payload *ctl_msg_buffer;
-	char firmware_str[sizeof(union ucan_ctl_payload) + 1];
 
 	udev = interface_to_usbdev(intf);
 
@@ -1527,17 +1528,6 @@ static int ucan_probe(struct usb_interface *intf,
 	 */
 	ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);
 
-	/* just print some device information - if available */
-	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
-				     sizeof(union ucan_ctl_payload));
-	if (ret > 0) {
-		/* copy string while ensuring zero termination */
-		strscpy(firmware_str, up->ctl_msg_buffer->raw,
-			sizeof(union ucan_ctl_payload) + 1);
-	} else {
-		strcpy(firmware_str, "unknown");
-	}
-
 	/* device is compatible, reset it */
 	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
 	if (ret < 0)
@@ -1555,7 +1545,10 @@ static int ucan_probe(struct usb_interface *intf,
 
 	/* initialisation complete, log device info */
 	netdev_info(up->netdev, "registered device\n");
-	netdev_info(up->netdev, "firmware string: %s\n", firmware_str);
+	ucan_get_fw_str(up, up->ctl_msg_buffer->fw_str,
+			sizeof(up->ctl_msg_buffer->fw_str));
+	netdev_info(up->netdev, "firmware string: %s\n",
+		    up->ctl_msg_buffer->fw_str);
 
 	/* success */
 	return 0;
-- 
2.45.3


