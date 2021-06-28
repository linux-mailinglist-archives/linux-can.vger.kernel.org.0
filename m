Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523893B608C
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 16:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhF1OZt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 10:25:49 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:20444 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhF1OYV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 28 Jun 2021 10:24:21 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 702885FF9A;
        Mon, 28 Jun 2021 16:21:20 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2] can: peak_usb: Add a "firmware update available" message to old PCAN-USB
Date:   Mon, 28 Jun 2021 16:20:43 +0200
Message-Id: <20210628142043.15034-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210628142043.15034-1-s.grosjean@peak-system.com>
References: <20210628142043.15034-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When the driver detects that the PCAN-USB device runs an old firmware
(< 4.1) then it prints a message suggesting to contact
<support@peak-system.com> for a possible firmware update.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4c3e18ca3181..f5edfc1e412e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -878,6 +878,11 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		return err;
 	}
 
+	dev_info(dev->netdev->dev.parent,
+		 "PEAK-System %s adapter hwrev %u serial %08X (%u channel)\n",
+		 pcan_usb.name, dev->device_rev, serial_number,
+		 pcan_usb.ctrl_count);
+
 	/* Since rev 4.1, PCAN-USB is able to make single-short as well as
 	 * looped back frames.
 	 */
@@ -886,13 +891,11 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 
 		priv->ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT |
 					    CAN_CTRLMODE_LOOPBACK;
+	} else {
+		dev_info(dev->netdev->dev.parent,
+			 "Firmware update available. Please contact support@peak-system.com\n");
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

