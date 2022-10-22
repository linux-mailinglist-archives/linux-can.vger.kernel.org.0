Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FDE608FC4
	for <lists+linux-can@lfdr.de>; Sat, 22 Oct 2022 23:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJVVge (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 22 Oct 2022 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJVVgd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2022 17:36:33 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF8F88E4
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 14:36:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id A227E240026
        for <linux-can@vger.kernel.org>; Sat, 22 Oct 2022 23:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1666474590; bh=Rdg3Dk720bZcsCwIKraMHLoTve9M+hyAuv1GMNKzUGs=;
        h=From:To:Cc:Subject:Date:From;
        b=HonvxabyPRLAfiM+vAB1f1CZd+ybUMT0khB8XFtUqWVs0Xo6U4mj3/ZyriZiGMhXQ
         4fwwUgeFkK/0PBW62gQV6adFOkibMcifP7xRTZO+/xKR8ImXirlZ9rusHu3dYn79mr
         PrmHF80FKs0DVfnM5KKMWGJb6l3GTpu1VG8QAMnywrE7BGnXfus29Er2GlJGfUp3Jx
         xam0dArAf+TdzXNa5IHUQC4q3nIY+jTOrOO1XASJ4eSPljBdeiF/MT/vCP7WKbMKt3
         U/s2pWCAZHubqn1DwtIMGIr63RCXHL3Qbv/TbFM9P9yPPbJiY9WuiNDUchnaF7dn9p
         UUT5Yxbs/m1uQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MvvmG1SG3z9rxD;
        Sat, 22 Oct 2022 23:36:30 +0200 (CEST)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH 7/7] can: peak_usb: align user device id format in log with sysfs attribute
Date:   Sat, 22 Oct 2022 21:35:35 +0000
Message-Id: <20221022213535.8495-8-lukas.magel@posteo.net>
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

Previously, the user device id was printed to the kernel log in decimal
upon connecting a new PEAK device. This behavior is inconsistent with
the hexadecimal format of the user device id sysfs attribute. This patch
updates the log message to output the id in hexadecimal.

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index fbefd4f05e08..8bb9a3fa686c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -1028,8 +1028,8 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* get device number early */
 	dev->adapter->dev_get_user_devid(dev, &dev->user_devid);
 
-	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
-			peak_usb_adapter->name, ctrl_idx, dev->user_devid);
+	netdev_info(netdev, "attached to %s channel %u (device %08Xh)\n",
+		    peak_usb_adapter->name, ctrl_idx, dev->user_devid);
 
 	return 0;
 
-- 
2.37.2

