Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6264864B0BE
	for <lists+linux-can@lfdr.de>; Tue, 13 Dec 2022 09:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiLMIEr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 13 Dec 2022 03:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiLMIEp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Dec 2022 03:04:45 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA4412630
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 00:04:44 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C7369240105
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2022 09:04:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1670918682; bh=p16IEsCAxBqDSoQrOUzfDo5DWwkPuXoVAHxrztwGuQA=;
        h=From:To:Cc:Subject:Date:From;
        b=Uu4c1gT+ZmBDPuDUjV8VVixa5m0vR+Hy4b6awhT4u9oWzy7AVHouomJRdcv3JXr+5
         OTNlnqIe7lNjinWBIstICDX1QcSlLy9NJUJrsLsH995POKdSXZfJfTly9Cc15tV4XR
         wmCrKVgqhHsSqqZb4Ukr9kjZArofarA6ox16tCC+jajwHjCpyOmNp59VbLuNiOJyuF
         lJ+oElfld4KzzNW81zvojMpcrYgqD/dfHYDGEw78veCVHMtdsQgML7/AzaslO0/lnU
         kpS5bhAEkE/owLKXmF7r5HXXYMQXInda0vEsokefgghmjPS3ybNx5iTxMfqRhdqwPz
         hACZUSMgkyI4A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NWWHY38kHz6tm6;
        Tue, 13 Dec 2022 09:04:41 +0100 (CET)
From:   Lukas Magel <lukas.magel@posteo.net>
To:     linux-can@vger.kernel.org
Cc:     Lukas Magel <lukas.magel@posteo.net>
Subject: [PATCH v3 7/8] can: peak_usb: align CAN channel ID format in log with sysfs attribute
Date:   Tue, 13 Dec 2022 08:03:09 +0000
Message-Id: <20221213080309.9013-8-lukas.magel@posteo.net>
In-Reply-To: <20220801080446.36374-1-lukas.magel@posteo.net>
References: <20220801080446.36374-1-lukas.magel@posteo.net>
Reply-To: Lukas Magel <lukas.magel@posteo.net>
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

Previously, the CAN channel ID was printed to the kernel log in decimal
upon connecting a new PEAK device. This behavior is inconsistent with
the hexadecimal format of the CAN channel ID sysfs attribute. This patch
updates the log message to output the id in hexadecimal.

Signed-off-by: Lukas Magel <lukas.magel@posteo.net>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 89ad5fda19c6..926d1359f433 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -1029,8 +1029,8 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	/* get CAN channel id early */
 	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
 
-	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
-			peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
+	netdev_info(netdev, "attached to %s channel %u (device 0x%08X)\n",
+		    peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);
 
 	return 0;
 
-- 
2.38.1

