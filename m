Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841AE3321CD
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 10:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbhCIJT2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 04:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCIJTU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 04:19:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11303C06174A
        for <linux-can@vger.kernel.org>; Tue,  9 Mar 2021 01:19:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e10so14349383wro.12
        for <linux-can@vger.kernel.org>; Tue, 09 Mar 2021 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qX3zq7pg+l1Hty2u81A/ziSs9V0j8N9GHTZv3aWvmNs=;
        b=A38oD0kNArCMLWjwrlIJ6qGkHfsPIjYfeualpi5SB4g3c4AwGgzu9GyUK7SDuG3AbT
         OKitOCGDB56pb9SaL+gyPuCM/XU1SebpzmpOqXrMFZThrSfmG5lifBx5k7yeKEoP0i47
         VDeP44RIRa8HYixUVmNygZjN8H8tFQR3+aVis58mgdCGpBcN0yrm3xjvDgJiqUz8Kl62
         W9BaVI/sYIQSBoLEHiPAEHcTvZC97TYnax05TS2nG/CHayBSaxiTqyJS8XK5zrNn+WjH
         GZWSAA7OwsrzUKFHsAbqqtLYT6MCGTJRHNlJkXzh68wu6EAT7DZ1vKMtMl9JA2hQnzcE
         Lg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qX3zq7pg+l1Hty2u81A/ziSs9V0j8N9GHTZv3aWvmNs=;
        b=Rtbobzz4miNh9BmFDGheklROZto0te7t6WtIZ6u46CsHjuUtjHsww7dg9EoIA5b/Qm
         cNWoM4lxJQhjZMLtyUjtsqKTViqETlx4p/2cAFxGxMFVDwf1WqYmfj4lrL0GiGJFkXc7
         NCN7FVMrUHMWRo+wW9MM8TPVbNepepS8kk+yiiZagZ7j/EStYqOCLeqBTf0rFKwur3gx
         JI2EBjiVA1Eg5kNHPan8UAFzWV0k/aPSHu5w5wo38XDCkqZJT5cUrM2ZcCOBBSjnxHcC
         1HDdjghXSjCG8o8ION4tcmvQkUGEByP6+HA+WBEzNK5Sej5/d9DQO/9Ax1vgygT6A/o9
         JE4g==
X-Gm-Message-State: AOAM5337OJGMQ15MyO2Ch/nGsCpQFpNgSuLYDNeoPzYx4Eiv+D4Paf0W
        KXqe8LVbA3MJ4SHeU2PzlgBON7TM/ck=
X-Google-Smtp-Source: ABdhPJyfJfxGaETMdqezvOGMPCVzQ4mcFbFbqAJyKPvsiUH5IBoEg4IdxYBQ0gQlxkdFy3UpvUdAcw==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr26815926wre.386.1615281558908;
        Tue, 09 Mar 2021 01:19:18 -0800 (PST)
Received: from localhost.localdomain (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id r26sm3098022wmn.28.2021.03.09.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 01:19:18 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_usb: Add support for USBcan Pro 4xHS
Date:   Tue,  9 Mar 2021 10:17:24 +0100
Message-Id: <20210309091724.31262-2-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309091724.31262-1-jimmyassarsson@gmail.com>
References: <20210309091724.31262-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add support for Kvaser USBcan Pro 4xHS.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index c1e5d5b570b6..538f4d9adb91 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -73,6 +73,7 @@ config CAN_KVASER_USB
 	    - Kvaser Memorator Pro 5xHS
 	    - Kvaser USBcan Light 4xHS
 	    - Kvaser USBcan Pro 2xHS v2
+	    - Kvaser USBcan Pro 4xHS
 	    - Kvaser USBcan Pro 5xHS
 	    - Kvaser U100
 	    - Kvaser U100P
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 2b7efd296758..4e97da8434ab 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -86,8 +86,9 @@
 #define USB_U100_PRODUCT_ID			273
 #define USB_U100P_PRODUCT_ID			274
 #define USB_U100S_PRODUCT_ID			275
+#define USB_USBCAN_PRO_4HS_PRODUCT_ID		276
 #define USB_HYDRA_PRODUCT_ID_END \
-	USB_U100S_PRODUCT_ID
+	USB_USBCAN_PRO_4HS_PRODUCT_ID
 
 static inline bool kvaser_is_leaf(const struct usb_device_id *id)
 {
@@ -193,6 +194,7 @@ static const struct usb_device_id kvaser_usb_table[] = {
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100P_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100S_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_4HS_PRODUCT_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.30.0

