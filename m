Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE20454987
	for <lists+linux-can@lfdr.de>; Wed, 17 Nov 2021 16:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhKQPFH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Nov 2021 10:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhKQPFG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Nov 2021 10:05:06 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC83C061570
        for <linux-can@vger.kernel.org>; Wed, 17 Nov 2021 07:02:08 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id E9C4C2003AE;
        Wed, 17 Nov 2021 16:02:02 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 5/6] can: peak_usb: replace unregister_netdev() with unregister_candev()
Date:   Wed, 17 Nov 2021 16:01:31 +0100
Message-Id: <20211117150132.37056-6-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117150132.37056-1-s.grosjean@peak-system.com>
References: <20211117150132.37056-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index a83ac4672123..ad9f435fc57e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -925,7 +925,7 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		dev->state &= ~PCAN_USB_STATE_CONNECTED;
 		strlcpy(name, netdev->name, IFNAMSIZ);
 
-		unregister_netdev(netdev);
+		unregister_candev(netdev);
 
 		kfree(dev->cmd_buf);
 		dev->next_siblings = NULL;
-- 
2.25.1

