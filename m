Return-Path: <linux-can+bounces-3070-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4EA61207
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0910A1B62ED0
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C31FF5F6;
	Fri, 14 Mar 2025 13:09:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4EB1FE44B
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957760; cv=none; b=SJoMyQx3/YQqFQFPu2DdUhqskN1bNBVqd017RZw2XbF2x2dCaZKW4SHw7BF9tr/J9twRL1GHOmsLdzGZGKZkb26ERUWI+epqC2t3Q2muG54LcytZYkAdUdPqqjQ74FV6lUvtIet8EWmjV+zJvDbvhD3GxZgaF6MF2vavvo6Myho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957760; c=relaxed/simple;
	bh=CsSR2zUwu6jrdEDlu7QZuMGjGVG4dVHVjaXe3iPZz50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umXAnm8d0W/4r2b4aY5ZEsUW+sMeKRfExjz+6yBpTxkemdKToENy/5cXu0jTKKoabMAxiAfP3QdwI0GSO36mnZS1RH0WfKCCQQHWN9qW7xdDDzIePK9BzZu8KDEmWBLeEol0vU7EYh2a/5mHOSntJNsX5adGvBlG7J7ROTtbEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mq-0007K6-JV
	for linux-can@vger.kernel.org; Fri, 14 Mar 2025 14:09:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt4mq-005hnp-0J
	for linux-can@vger.kernel.org;
	Fri, 14 Mar 2025 14:09:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B6C2C3DBB6C
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:09:15 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F40673DBB4C;
	Fri, 14 Mar 2025 13:09:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id b390e868;
	Fri, 14 Mar 2025 13:09:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/6] can: ucan: fix out of bound read in strscpy() source
Date: Fri, 14 Mar 2025 14:04:00 +0100
Message-ID: <20250314130909.2890541-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314130909.2890541-1-mkl@pengutronix.de>
References: <20250314130909.2890541-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

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
Link: https://patch.msgid.link/20250218143515.627682-2-mailhol.vincent@wanadoo.fr
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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

base-commit: 4003c9e78778e93188a09d6043a74f7154449d43
-- 
2.47.2



