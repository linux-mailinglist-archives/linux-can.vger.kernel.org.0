Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776C56069E
	for <lists+linux-can@lfdr.de>; Fri,  5 Jul 2019 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfGENce (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Jul 2019 09:32:34 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:64949 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfGENcd (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 5 Jul 2019 09:32:33 -0400
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 02262B0056A;
        Fri,  5 Jul 2019 15:32:28 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_usb: fix potential double kfree_skb()
Date:   Fri,  5 Jul 2019 15:32:16 +0200
Message-Id: <20190705133217.4204-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When closing the CAN device while tx skbs are inflight, echo skb could be
released twice. By calling close_candev() before unlinking all pending
tx urbs, then the internal echo_skb[] array is fully and correctly cleared
before the USB write callback and, therefore, can_get_echo_skb() are called,
for each aborted URB.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 611f9d31be5d..740ef47eab01 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -576,16 +576,16 @@ static int peak_usb_ndo_stop(struct net_device *netdev)
 	dev->state &= ~PCAN_USB_STATE_STARTED;
 	netif_stop_queue(netdev);
 
+	close_candev(netdev);
+
+	dev->can.state = CAN_STATE_STOPPED;
+
 	/* unlink all pending urbs and free used memory */
 	peak_usb_unlink_all_urbs(dev);
 
 	if (dev->adapter->dev_stop)
 		dev->adapter->dev_stop(dev);
 
-	close_candev(netdev);
-
-	dev->can.state = CAN_STATE_STOPPED;
-
 	/* can set bus off now */
 	if (dev->adapter->dev_set_bus) {
 		int err = dev->adapter->dev_set_bus(dev, 0);
-- 
2.20.1

