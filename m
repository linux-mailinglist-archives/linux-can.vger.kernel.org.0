Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF641C690
	for <lists+linux-can@lfdr.de>; Wed, 29 Sep 2021 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbhI2OXI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 Sep 2021 10:23:08 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:35638 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244491AbhI2OXG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 Sep 2021 10:23:06 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 2A1F05FFB9;
        Wed, 29 Sep 2021 16:21:21 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/2] can: peak_usb: fix back to ERROR_ACTIVE state notification
Date:   Wed, 29 Sep 2021 16:21:10 +0200
Message-Id: <20210929142111.55757-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This corrects the lack of notification of a return to ERROR_ACTIVE state
for USB - CANFD devices from PEAK-System.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index b11eabad575b..e206959b3d06 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -551,11 +551,10 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	} else if (sm->channel_p_w_b & PUCAN_BUS_WARNING) {
 		new_state = CAN_STATE_ERROR_WARNING;
 	} else {
-		/* no error bit (so, no error skb, back to active state) */
-		dev->can.state = CAN_STATE_ERROR_ACTIVE;
+		/* back to (or still in) ERROR_ACTIVE state */
+		new_state = CAN_STATE_ERROR_ACTIVE;
 		pdev->bec.txerr = 0;
 		pdev->bec.rxerr = 0;
-		return 0;
 	}
 
 	/* state hasn't changed */
-- 
2.25.1

