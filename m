Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4651F612A46
	for <lists+linux-can@lfdr.de>; Sun, 30 Oct 2022 12:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJ3LB6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 30 Oct 2022 07:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJ3LB5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 30 Oct 2022 07:01:57 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2D3314
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 04:01:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CAC1E24002A
        for <linux-can@vger.kernel.org>; Sun, 30 Oct 2022 12:01:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1667127715; bh=a0JF3RSNcWgen8merCTn27rg01euZs3PKRl2vZv659Y=;
        h=From:To:Cc:Subject:Date:From;
        b=P/z7EoFBZwh52TCiNqqTGv4H35qis700a3r7VWDNVM0zFv3njaoAaYv7aAOWWYGmg
         h3CC16OzmRCXKz0sVD82LdhQ7N9lh4wjNfhEnuijk3D7NZPz4S7zC2qPT08I049sA8
         7HeqEw1YtWDsr4A+WR95hr4VL737hhpsodQHaaejhv/x4cT7rgtcwK5yTOztoPPws9
         DHKbecTNTWHPqJVOAfj66SZQShECQMtS+FbCUrfmu8cnuC1gY58tiubxrwUzBXSPQC
         yMGQb+E6mNFgZ4DGl70Ivg+HDqrUnEwKydAHX3ibRCMUgLHAlZXcrjUnujch3thl3T
         yjvHaHGRO7HTQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4N0YJM2lycz9rxF;
        Sun, 30 Oct 2022 12:01:55 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v2 7/7] can: peak_usb: align user device id format in log with sysfs attribute
Date:   Sun, 30 Oct 2022 10:59:39 +0000
Message-Id: <20221030105939.87658-8-lukas.magel@posteo.net>
In-Reply-To: <20221030105939.87658-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
 <20221030105939.87658-1-lukas.magel@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index e558746a0252..731bd6553cfc 100644
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

