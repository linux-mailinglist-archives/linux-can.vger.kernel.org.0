Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84B3579AD7
	for <lists+linux-can@lfdr.de>; Tue, 19 Jul 2022 14:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiGSMUg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Jul 2022 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiGSMUI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 08:20:08 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36A5A2E5
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 05:07:26 -0700 (PDT)
Received: from stf-laptop.peak-system.com (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 392F720058E;
        Tue, 19 Jul 2022 14:06:54 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/3] can: peak_usb: correction of an initially misnamed field name
Date:   Tue, 19 Jul 2022 14:06:31 +0200
Message-Id: <20220719120632.26774-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719120632.26774-1-s.grosjean@peak-system.com>
References: <20220719120632.26774-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_FAIL,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The data structure returned from the USB device contains a number flashed
by the user and not the serial number of the device.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index ebe087f258e3..457887113e75 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -439,7 +439,7 @@ static int pcan_usb_pro_get_device_id(struct peak_usb_device *dev,
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
2.34.1

