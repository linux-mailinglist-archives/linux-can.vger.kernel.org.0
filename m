Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5CF64B0BB
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 09:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiLMIEo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 03:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiLMIEl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 03:04:41 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA44212630
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 00:04:38 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 93844240029
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1670918677; bh=+uE24Ak0eKodWFYfRsVkR+AWzq716mPgrY50OFmHUhw=;
        h=From:To:Cc:Subject:Date:From;
        b=qlQKGJnpc3RmvLVr/A4AuPrAxHxjYZrJ5A5/uZlvJCi3lyTqkev90g6MLoHJ5g2Wu
         iO+JGSFy3xHEL9vij6f7dugF8VbxSq+x7M86DFnYc+wsFguij0A1ECRbCczj5ZBo/0
         d3a2cUbUsUj13dKlbHBYsUhski6Ou0RXYOTyPePRX7sYpPiAeHcEIfXFfy7gqxL0B0
         +t/72z8NVxtgem+KBzsvQ3RBQd5S4Ro0RQgAefriPNRC2B3xeHOsjYZ+aUt0IfydiQ
         4gCyjIhhzgVocR1reFAUmFBuYB3c4enVn8C+OiOYSJF7XxaDlCyD38X6ugPX97b8h2
         ZjVoCZY/owLYw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NWWHT0hR4z6tmL;
        Tue, 13 Dec 2022 09:04:37 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 4/8] can: peak_usb: replace unregister_netdev() with unregister_candev()
Date:   Tue, 13 Dec 2022 08:03:06 +0000
Message-Id: <20221213080309.9013-5-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
Reply-To: Lukas Magel <lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

