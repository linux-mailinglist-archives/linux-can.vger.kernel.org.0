Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578054D441E
	for <lists+linux-can@lfdr.de>; Thu, 10 Mar 2022 10:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbiCJKAN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 10 Mar 2022 05:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbiCJKAI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 05:00:08 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1810DA42
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 01:59:06 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 389042003D3;
        Thu, 10 Mar 2022 10:59:03 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 3/8 v3] can: peak_usb: correction of a wrong field name
Date:   Thu, 10 Mar 2022 10:58:36 +0100
Message-Id: <20220310095841.9134-4-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095841.9134-1-s.grosjean@peak-system.com>
References: <20220310095841.9134-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This field read from the PCAN-USB Pro device's flash memory contains a
user value rather than a serial number.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4a62cf34acb0..6c1f7f8c8f45 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -439,7 +439,7 @@ static int pcan_usb_pro_get_user_devid(struct peak_usb_device *dev,
 		return err;
 
 	pdn = (struct pcan_usb_pro_devid *)pc;
-	*device_id = le32_to_cpu(pdn->serial_num);
+	*device_id = le32_to_cpu(pdn->dev_num);
 
 	return err;
 }
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 5d4cf14eb9d9..a34e0fc021c9 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -112,7 +112,7 @@ struct __packed pcan_usb_pro_devid {
 	u8 data_type;
 	u8 channel;
 	__le16 dummy;
-	__le32 serial_num;
+	__le32 dev_num;
 };
 
 #define PCAN_USBPRO_LED_DEVICE		0x00
-- 
2.25.1

