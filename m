Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C541C691
	for <lists+linux-can@lfdr.de>; Wed, 29 Sep 2021 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbhI2OXq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 Sep 2021 10:23:46 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:43352 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244491AbhI2OXp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 Sep 2021 10:23:45 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id ED21C5FFAA;
        Wed, 29 Sep 2021 16:21:29 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2] can: peak_usb: removes unnecessary test on the nullity of a pointer
Date:   Wed, 29 Sep 2021 16:21:11 +0200
Message-Id: <20210929142111.55757-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929142111.55757-1-s.grosjean@peak-system.com>
References: <20210929142111.55757-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since alloc_can_err_skb() puts NULL in cf in the case when skb cannot be
allocated and can_change_state() handles the case when cf is NULL, the test
on the nullity of skb is now unnecessary.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index e206959b3d06..09029a3bad1a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -567,8 +567,7 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 
 	/* allocate an skb to store the error frame */
 	skb = alloc_can_err_skb(netdev, &cf);
-	if (skb)
-		can_change_state(netdev, cf, tx_state, rx_state);
+	can_change_state(netdev, cf, tx_state, rx_state);
 
 	/* things must be done even in case of OOM */
 	if (new_state == CAN_STATE_BUS_OFF)
-- 
2.25.1

