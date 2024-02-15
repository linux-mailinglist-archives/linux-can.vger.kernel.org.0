Return-Path: <linux-can+bounces-282-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A66856785
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A45281C20
	for <lists+linux-can@lfdr.de>; Thu, 15 Feb 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397B1133283;
	Thu, 15 Feb 2024 15:27:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10101132C15
	for <linux-can@vger.kernel.org>; Thu, 15 Feb 2024 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010841; cv=none; b=diXt+Aw0lrxohwc6Lw9zrL2i+BWopzBUZ3K5V8a5wtkY+QlVkHQcx3q4Uboa9qjOYnlxpZ+FPzYFKE2WG3+4lUFrksuBhY65w4Ul0LFCoZiC3R9kJ82UK5uL6QBsnBdoiSSA2/qLa3DG9eOK+at8TgBsb8KeEjM++2VSHPZn30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010841; c=relaxed/simple;
	bh=Y5ztq7NSzHG+wO6yEIr+RF4rM1ChFEn+57AMhar4IM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvTZV/utxI7Rtff5W7N/g3yhzr2v8i1Gb//VcmZdWa9l720y/v1XhVUTtIMk4fEKZP4kwJsTbpcnellkAylMF+OV/FIcLT7KFLBuDa6990n4C/ZX4WI82CFaB3fic/B7WzQxfyQdOZ3rNMOhj8wwqBCR2DJGb5sQBOa83xa2a2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com; spf=fail smtp.mailfrom=peak-system.com; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peak-system.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=peak-system.com
Received: from stf-laptop.. (unknown [IPv6:2a02:8428:60a1:3e01:d1b:b57b:aee8:95cc])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 90C13B00563;
	Thu, 15 Feb 2024 16:27:12 +0100 (CET)
From: Stephane Grosjean <s.grosjean@peak-system.com>
To: linux-can Mailing List <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/3] can: peak_usb: increase rx buffer size used for USB bulk transfer
Date: Thu, 15 Feb 2024 16:26:55 +0100
Message-Id: <20240215152656.13883-2-s.grosjean@peak-system.com>
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

In case of high bud load, 2KB can sometimes be too small for the device,
leading to potential fragmentation of USB records, while 4KB better suits
its internal buffer size.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 4d85b29a17b7..a1c339716776 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -30,7 +30,7 @@
 #define PCAN_UFD_CMD_TIMEOUT_MS		1000
 
 /* PCAN-USB Pro FD rx/tx buffers size */
-#define PCAN_UFD_RX_BUFFER_SIZE		2048
+#define PCAN_UFD_RX_BUFFER_SIZE		4096
 #define PCAN_UFD_TX_BUFFER_SIZE		512
 
 /* struct pcan_ufd_fw_info::type */
-- 
2.34.1


