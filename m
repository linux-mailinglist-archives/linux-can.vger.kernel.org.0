Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6D612A43
	for <lists+linux-can@lfdr.de>; Sun, 30 Oct 2022 12:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ3LBz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 30 Oct 2022 07:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJ3LBy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 30 Oct 2022 07:01:54 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9362FBF2
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 04:01:53 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4C9D7240103
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 12:01:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1667127712; bh=bSfSxEHF46avH7a13jV3ecyBRvo6A71O//BabrWzF5U=;
        h=From:To:Cc:Subject:Date:From;
        b=iWbcusc35TS/MJIup5sBWRRbvKCGzT2+woIlt2Lmd4rUItYCiKn9dcI8QdjhcVHyL
         gvLRh0fT6ImJ6sx+mVY4N/DhjQ1jNTNo8C8wm090afpv4+Dp2tLCbPQ9+BYBu8CAqP
         JoJxHFcZsMh5GJ6W1VJ6tys3dP8OKKGC9hVyz4CMacBln6PADmx6sr/ZDz5xCKhDNY
         0G4w+0TaGgzlC9N46ujmIj9Zd7YlrLDkTi+T3SUwE88+jHhZJ3/FWGBk54IGR/I9Yp
         vdaKWfYnBGPeU744oAmJq5FDfNlUo9HP/lut515Gdmv7gD9zMa4AwjN8JhJE1s3qNa
         3fntFO/vVXJmg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4N0YJH57Kvz9rxK;
        Sun, 30 Oct 2022 12:01:51 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v2 4/7] can: peak_usb: replace unregister_netdev() with unregister_candev()
Date:   Sun, 30 Oct 2022 10:59:36 +0000
Message-Id: <20221030105939.87658-5-lukas.magel@posteo.net>
In-Reply-To: <20221030105939.87658-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20221030105939.87658-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch changes call to unregister_netdev() with unregister_candev().

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
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

