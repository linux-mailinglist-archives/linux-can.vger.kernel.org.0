Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A859566CFE6
	for <lists+linux-can@lfdr.de>; Mon, 16 Jan 2023 21:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjAPUMB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 16 Jan 2023 15:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjAPUL7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 16 Jan 2023 15:11:59 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCDA23D95
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 12:11:57 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B903F24025A
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2023 21:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1673899915; bh=+uE24Ak0eKodWFYfRsVkR+AWzq716mPgrY50OFmHUhw=;
        h=From:To:Cc:Subject:Date:From;
        b=prjc0HXwpOWp3jGY+4RxDsCghZEuTANcP1omA5/t4Nutw/3C+Amn0PM2uqShyurTf
         wWu/tYspRbUNu2peF2HaWEqwN76UxDj1fuwkF2qVx9XfGUW6vtaFt91SjEZEIGfxf1
         dQmg3FnpfuLDyjSIFruFHhWDt/oLp99uw5W+X6VRRY5Nyj+CxAa3mWcyob4+Jh2SJh
         i+wdyzBmOl2PPsmaxtwmrA7RVm6b9rlZMaM1nOYZNMLQXoW8oVpWbRwCle5Scx8rEX
         +J+9ilYBSjXJLaXl09NygQncp2NOr6A7c+6cTGqJO7QQSRjjs8NBOUgO0tWlcY37Ow
         ckJL4RSqdNcJw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nwjpz1BvGz9rxG;
        Mon, 16 Jan 2023 21:11:55 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 4/8] can: peak_usb: replace unregister_netdev() with unregister_candev()
Date:   Mon, 16 Jan 2023 20:09:28 +0000
Message-Id: <20230116200932.157769-5-lukas.magel@posteo.net>
In-Reply-To: <20230116200932.157769-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20230116200932.157769-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch changes the call to unregister_netdev() in
peak_usb_disconnect() with unregister_candev().

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 54e2481cce30..4eff4b4706b9 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -963,7 +963,7 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 		dev->state &= ~PCAN_USB_STATE_CONNECTED;
 		strscpy(name, netdev->name, IFNAMSIZ);
 
-		unregister_netdev(netdev);
+		unregister_candev(netdev);
 
 		kfree(dev->cmd_buf);
 		dev->next_siblings = NULL;
-- 
2.38.1

