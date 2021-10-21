Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC79435CBE
	for <lists+linux-can@lfdr.de>; Thu, 21 Oct 2021 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhJUISC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Oct 2021 04:18:02 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:46382 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhJUIRx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 21 Oct 2021 04:17:53 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 37AF25FFC7;
        Thu, 21 Oct 2021 10:15:33 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2 v2] can: peak_usb: exchange the order of information messages
Date:   Thu, 21 Oct 2021 10:15:05 +0200
Message-Id: <20211021081505.18223-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021081505.18223-1-s.grosjean@peak-system.com>
References: <20211021081505.18223-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Proposes the possible update of the PCAN-USB firmware after indicating its
name and current version.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index af8d3dadbbb8..876218752766 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -883,6 +883,11 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		return err;
 	}
 
+	dev_info(dev->netdev->dev.parent,
+		 "PEAK-System %s adapter hwrev %u serial %08X (%u channel)\n",
+		 pcan_usb.name, dev->device_rev, serial_number,
+		 pcan_usb.ctrl_count);
+
 	/* Since rev 4.1, PCAN-USB is able to make single-shot as well as
 	 * looped back frames.
 	 */
@@ -896,11 +901,6 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 			 "Firmware update available. Please contact support@peak-system.com\n");
 	}
 
-	dev_info(dev->netdev->dev.parent,
-		 "PEAK-System %s adapter hwrev %u serial %08X (%u channel)\n",
-		 pcan_usb.name, dev->device_rev, serial_number,
-		 pcan_usb.ctrl_count);
-
 	return 0;
 }
 
-- 
2.25.1

