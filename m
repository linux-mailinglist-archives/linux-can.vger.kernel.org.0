Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA87841C678
	for <lists+linux-can@lfdr.de>; Wed, 29 Sep 2021 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbhI2ORC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 Sep 2021 10:17:02 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:32842 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245475AbhI2ORC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 Sep 2021 10:17:02 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id BEFBA5FF10;
        Wed, 29 Sep 2021 16:14:44 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/2] can: peak_usb: always ask for BERR reporting for PCAN-USB devices
Date:   Wed, 29 Sep 2021 16:14:20 +0200
Message-Id: <20210929141421.55580-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since for the PCAN-USB, the management of the transition to the
ERROR_WARNING or ERROR_PASSIVE state is done according to the error
counters, these must be requested unconditionally.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 837b3fecd71e..4c8993f69e6b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -841,14 +841,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	pdev->bec.rxerr = 0;
 	pdev->bec.txerr = 0;
 
-	/* be notified on error counter changes (if requested by user) */
-	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
-		err = pcan_usb_set_err_frame(dev, PCAN_USB_BERR_MASK);
-		if (err)
-			netdev_warn(dev->netdev,
-				    "Asking for BERR reporting error %u\n",
-				    err);
-	}
+	/* always ask the device for BERR reporting, to be able to switch from
+	 * WARNING to PASSIVE state
+	 */
+	err = pcan_usb_set_err_frame(dev, PCAN_USB_BERR_MASK);
+	if (err)
+		netdev_warn(dev->netdev,
+			    "Asking for BERR reporting error %u\n",
+			    err);
 
 	/* if revision greater than 3, can put silent mode on/off */
 	if (dev->device_rev > 3) {
-- 
2.25.1

