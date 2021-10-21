Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FB435CBF
	for <lists+linux-can@lfdr.de>; Thu, 21 Oct 2021 10:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJUISG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Oct 2021 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhJUISC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Oct 2021 04:18:02 -0400
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBCFC06161C
        for <linux-can@vger.kernel.org>; Thu, 21 Oct 2021 01:15:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0FA465FF9E;
        Thu, 21 Oct 2021 10:15:29 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/2 v2] can: peak_usb: always ask for BERR reporting for PCAN-USB devices
Date:   Thu, 21 Oct 2021 10:15:04 +0200
Message-Id: <20211021081505.18223-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021081505.18223-1-s.grosjean@peak-system.com>
References: <20211021081505.18223-1-s.grosjean@peak-system.com>
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
v2:
- remove CAN_CTRLMODE_BERR_REPORTING from ctrlmode_supported

 drivers/net/can/usb/peak_usb/pcan_usb.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 837b3fecd71e..af8d3dadbbb8 100644
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
@@ -986,7 +986,6 @@ const struct peak_usb_adapter pcan_usb = {
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
 	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			      CAN_CTRLMODE_BERR_REPORTING |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2,
-- 
2.25.1

