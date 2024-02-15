Return-Path: <linux-can+bounces-283-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C537F856786
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 16:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D251C20F50
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B3132C1A;
	Thu, 15 Feb 2024 15:27:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB0132C1B
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010843; cv=none; b=QktWjyBPGLcpxoMuIGzTnZ0qGhTrvbV/9VskqFXj9g1HZLzQ1mKCAj7qQon8N8sw7tOr7FtgR/oIgziIdxyzdueoh6XPBwu2dAb1lba54L2JU54iQl3IHDX8yLZd8HY5tkOyrgIZFbfuJphlnjup9d2P4lPl+cZd14HCDcGKOlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010843; c=relaxed/simple;
	bh=B36qZuLxUdzbT6s4DW1VabYjRdCvzgLMl7VbRLHgGDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iqY4HyCAGcyAC2OSV1t8iJagmyP2c0515ouKVHlURVk3GZkFxs3oCM5SWsfVLqPW79heGEqhUsYaoiuzXXCklCHFpPb0y0ymual0nFtBd29i+ioS7GOY8YyA18qYcQMxu6AFFI8O40PSURWkqbC0lc2GiD8s17TQ7yQ63Etp6Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com; spf=fail smtp.mailfrom=peak-system.com; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=peak-system.com
Received: from stf-laptop.. (unknown [IPv6:2a02:8428:60a1:3e01:d1b:b57b:aee8:95cc])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 80889B005B6;
	Thu, 15 Feb 2024 16:27:16 +0100 (CET)
From: Stephane Grosjean <s.grosjean@peak-system.com>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 3/3] can: peak_usb: fix potential kernel log flooding
Date: Thu, 15 Feb 2024 16:26:56 +0100
Message-Id: <20240215152656.13883-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215152656.13883-1-s.grosjean@peak-system.com>
References: <20240215152656.13883-1-s.grosjean@peak-system.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rare cases of very high bus load, the firmware can generate messages
warning that the receive cache capacity is about to be exceeded.
This modification prevents the driver from flooding the kernel log with
messages and memory dumps that are far too verbose in such cases,
by limiting their production to once per session.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index a1c339716776..d444ff0fa7cc 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -70,6 +70,7 @@ struct pcan_usb_fd_if {
 struct pcan_usb_fd_device {
 	struct peak_usb_device	dev;
 	struct can_berr_counter	bec;
+	bool			rx_cache_warn_handled;
 	struct pcan_usb_fd_if	*usb_if;
 	u8			*cmd_buffer_addr;
 };
@@ -667,6 +668,28 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
 	return 0;
 }
 
+/* Handle uCAN Rx cache warning messages.
+ *
+ * Such messages SHOULD NOT occur. If they do, then this might come from
+ * massive PING host flooding that prevents PCAN-USB Pro FD HW v4 to handle
+ * CAN traffic anymore. In this case, the driver itself manages the display of
+ * the warning message.
+ */
+static void pcan_usb_fd_handle_rx_cache_warn(struct peak_usb_device *dev,
+					     struct pucan_msg *rx_msg)
+{
+	struct pcan_usb_fd_device *pdev =
+			container_of(dev, struct pcan_usb_fd_device, dev);
+
+	if (pdev->rx_cache_warn_handled)
+		return;
+
+	netdev_warn(dev->netdev,
+		    "Rx cache size warning! Possible loss of frames\n");
+
+	pdev->rx_cache_warn_handled = true;
+}
+
 /* handle uCAN overrun message */
 static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 				      struct pucan_msg *rx_msg)
@@ -768,6 +791,14 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 				goto fail;
 			break;
 
+		case PUCAN_MSG_CACHE_CRITICAL:
+			pcan_usb_fd_handle_rx_cache_warn(dev, rx_msg);
+
+			/* Rx cache warning means possible overrun cases in
+			 * the device.
+			 */
+			fallthrough;
+
 		case PCAN_UFD_MSG_OVERRUN:
 			err = pcan_usb_fd_decode_overrun(usb_if, rx_msg);
 			if (err < 0)
@@ -885,6 +916,11 @@ static int pcan_usb_fd_start(struct peak_usb_device *dev)
 	pdev->bec.txerr = 0;
 	pdev->bec.rxerr = 0;
 
+	/* warn of a cache problem only once per session, to avoid flooding
+	 * the kernel log.
+	 */
+	pdev->rx_cache_warn_handled = false;
+
 	return err;
 }
 
-- 
2.34.1


