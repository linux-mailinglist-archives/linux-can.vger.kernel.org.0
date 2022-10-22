Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEFA608FC1
	for <lists+linux-can@lfdr.de>; Sat, 22 Oct 2022 23:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJVVg2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Oct 2022 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJVVg1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2022 17:36:27 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1EFF6C04
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 14:36:26 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A0DB3240027
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666474585; bh=zsozNLZQfpqyEyw7QOkvmnTBNQ55peO7dPaqNUyBqpA=;
        h=From:To:Cc:Subject:Date:From;
        b=jr4gxsdZVjAkZQG7W4mWmLG+36aQX7n6lB0WSKcw+bP4/qkKCHsm6eR4L8pF6GyQK
         rUpgjgAPkNp7+HPGctoT8nkdHcJXt7o4nG0FhKDHzwi04B9b9PBrV4D6rJi9uYO3z+
         CgyoZ3PfdWZYpCQ+qNjObmSLKu801e95aaYCKg31gNmQK24rgaLUEXXFJLwHxwWYf0
         QP5wFICxuOlUoC3KMOqdoQIf+hCtcuwL8tabC5TA1+w8ej4KP6FcjdtZ4u601f0rFc
         cxJhdDZqSv95fEV0i2qVgAoFGsfTpZ1nMwBEk0ig+MU9ttVwyd0/ZTLwiQs2WUn0sN
         mBR8nTH5V06VQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Mvvm912MLz9rxH;
        Sat, 22 Oct 2022 23:36:25 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 4/7] can: peak_usb: replace unregister_netdev() with unregister_candev()
Date:   Sat, 22 Oct 2022 21:35:32 +0000
Message-Id: <20221022213535.8495-5-lukas.magel@posteo.net>
In-Reply-To: <20221022213535.8495-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20221022213535.8495-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch changes call to unregister_netdev() with unregister_candev().

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index ca282b0aa9a5..b010b546f6d1 100644
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
2.37.2

