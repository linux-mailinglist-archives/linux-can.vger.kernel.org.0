Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273AB7BAC4
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2019 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfGaHe2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Jul 2019 03:34:28 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:46796 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfGaHe2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Jul 2019 03:34:28 -0400
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id E260610089E18;
        Wed, 31 Jul 2019 15:26:02 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id D3DFC20424204;
        Wed, 31 Jul 2019 15:26:02 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Yn4t54Gn1gxB; Wed, 31 Jul 2019 15:26:02 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id A7EE420424202;
        Wed, 31 Jul 2019 15:26:02 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] net/can/usb/peak_usb: force the string buffer NULL-terminated
Date:   Wed, 31 Jul 2019 15:25:59 +0800
Message-Id: <20190731072559.29406-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

strncpy() does not ensure NULL-termination when the input string
size equals to the destination buffer size IFNAMSIZ.
The output string is passed to dev_info() which relies on
the NULL-termination.

Use strlcpy() instead.

This issue is identified by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 458154c9b482..4c2cda5ecf3f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -855,7 +855,7 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 
 		dev_prev_siblings = dev->prev_siblings;
 		dev->state &= ~PCAN_USB_STATE_CONNECTED;
-		strncpy(name, netdev->name, IFNAMSIZ);
+		strlcpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_netdev(netdev);
 
-- 
2.11.0

