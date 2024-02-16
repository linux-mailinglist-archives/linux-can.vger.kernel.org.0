Return-Path: <linux-can+bounces-294-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AC5857E37
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 14:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F401F28117
	for <lists+linux-can@lfdr.de>; Fri, 16 Feb 2024 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF13012C54C;
	Fri, 16 Feb 2024 13:56:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084512C53C
	for <linux-can@vger.kernel.org>; Fri, 16 Feb 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091780; cv=none; b=qChRTvkPUK4r9eAvNhR1MLlRmlRyWxR1ReRH/lEWEKD9+2iLy5QSAI7np9CI3M8brtVYqBF2W22NPMKCGO/TFHMEm5GbEnOHjMTes/3dLuOEElYckbpvnrx20/oZZGwrOxZtIEXlNFrEFIb0B08O0520ud38uv/Vnu/8Yh53xEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091780; c=relaxed/simple;
	bh=herowkuHg3LQ6HhY99pnTEmII+EX8JQNqnsHwv6Zh/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6rzC/akOsZBPiwA9TcNDcqQ1CNs7SDnWwPh3edvQ9TmMtwqdqixwSBkYBs19LcBuZoEYoFYabOkPx2Ox7g8/iegfSha6LI9p+29T7YsvkR7IELcXJgFEhUkeZygo3V2mAkIsjS//4qqz2YgMwMu4eaqmzeVGr7D234uBq6MLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com; spf=fail smtp.mailfrom=peak-system.com; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=peak-system.com
Received: from stf-laptop.peak-system.com (unknown [IPv6:2a02:8428:60a1:3e01:3d9:efe8:4f4a:17b1])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id D3C4C20041C;
	Fri, 16 Feb 2024 14:56:05 +0100 (CET)
From: Stephane Grosjean <s.grosjean@peak-system.com>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v2] can: peak_usb: fix potential kernel log flooding
Date: Fri, 16 Feb 2024 14:55:53 +0100
Message-Id: <20240216135553.97845-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rare cases of very high bus load, the firmware of the PEAK-System
PCAN-USB Pro FD HW v4 can generate messages warning that the receive cache
capacity is about to be exceeded. This modification prevents the driver
from flooding the kernel log with messages and memory dumps that are far
too verbose in such cases, by limiting their production to once for all.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index a1c339716776..aa0b68c1ae81 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -667,6 +667,19 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
 	return 0;
 }
 
+/* Handle uCAN Rx cache warning messages.
+ *
+ * Such messages SHOULD NOT occur. If they do, then this might come from
+ * massive PING host flooding that prevents PCAN-USB Pro FD HW v4 to handle
+ * CAN traffic anymore.
+ */
+static void pcan_usb_fd_handle_rx_cache_warn(struct peak_usb_device *dev,
+					     struct pucan_msg *rx_msg)
+{
+	netdev_warn_once(dev->netdev,
+			 "Rx cache size warning! Possible loss of frames\n");
+}
+
 /* handle uCAN overrun message */
 static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 				      struct pucan_msg *rx_msg)
@@ -768,6 +781,14 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
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
-- 
2.34.1


