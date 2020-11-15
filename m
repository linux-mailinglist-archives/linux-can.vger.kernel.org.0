Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF2F2B363C
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 17:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgKOQbb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 11:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgKOQba (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 11:31:30 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9EAC0613D1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:30 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 74so21370167lfo.5
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aFfqs6hRo3I+FITlIMvep8whzD31ubHUBmS0a2ILvJs=;
        b=QCkfx8zJLn75g2vjkaiDLWjcgO8Pkcnw5rGH8Al2yUp7FHlA0oJnO2Pgw9mua+A5r0
         qPJ7m6WjIWuXqDRYZsA6Ly89l3V8M+7rP5V4T2zPAJtK2TEUncGWZ5KWhqPf+nRezvdv
         TI2UqLaZ8hp7PohU9e75zKxfoTSCAsqmIefGI6OKTrKK3IUqUord8izA+p76gS6nvkDE
         32RIfeXncC+J2bNFxdWG5I9VH4Un2x9ewDYuPQ9lszasYClx4SOwtyx4jf7Obve+PEX3
         H+Ut6soC9gBJQv9o6ZSqIv6R2NMjyfEfJshJ382T2WnMe7CYbjbuhJqD//vBwi4q9erA
         kzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aFfqs6hRo3I+FITlIMvep8whzD31ubHUBmS0a2ILvJs=;
        b=tXsUtXxe3GeylIfAGTry6AA2JE6poZzhHfhttvIfeKk9RAlhaeIMvPhO0tssyQkSVz
         fIcIEy3/ULNcfn0FpAX2sMkczOin06uVFH/z6dzx4AaWndF6aRj2vTCWDvolW19gqOXb
         Bd2WzRq9Ia4vs9bVPOxurHql7BHEwzokI+hyCqCAUR6gj3/yp8FquWGsYyVGKr7CTeSV
         YGf3k85ojEehKjL7T6QPwdE34NLtkB6lD8TNSsDxKeJlWUO8b1k8WlxZwVwUAbcT0Ei1
         GmS4ziPKcKULtDao2C1F6KHbkD+v58on8+f6mOWk+5IkcF/kFpbSu1ewWpaP/jOr/cs6
         59ig==
X-Gm-Message-State: AOAM531cuySeVOI1dnVLc0fHHJuIn+VZTMA9kQioKfzHLGb6CqjX8gkM
        Fwi2xkm8AiK5i7bg+alPMQMD/3Ebhxg=
X-Google-Smtp-Source: ABdhPJzF8lcqQkxv2CbUSx8CB3TP1jCUIWBIWdXYcYqJZhYdU1UcVh9rqlmm8aHBJM/RhrKxi6XhAQ==
X-Received: by 2002:ac2:505b:: with SMTP id a27mr3804073lfm.172.1605457888861;
        Sun, 15 Nov 2020 08:31:28 -0800 (PST)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b12sm2419462ljj.133.2020.11.15.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 08:31:28 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 6/6] can: kvaser_usb: Add new Kvaser hydra devices
Date:   Sun, 15 Nov 2020 17:30:27 +0100
Message-Id: <20201115163027.16851-6-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115163027.16851-1-jimmyassarsson@gmail.com>
References: <20201115163027.16851-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add new Kvaser hydra devices.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 3 +++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 161f15e5218d..c1e5d5b570b6 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -74,6 +74,9 @@ config CAN_KVASER_USB
 	    - Kvaser USBcan Light 4xHS
 	    - Kvaser USBcan Pro 2xHS v2
 	    - Kvaser USBcan Pro 5xHS
+	    - Kvaser U100
+	    - Kvaser U100P
+	    - Kvaser U100S
 	    - ATI Memorator Pro 2xHS v2
 	    - ATI USBcan Pro 2xHS v2
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b7d20320961a..a9b3f12bc2ef 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -83,8 +83,11 @@
 #define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	268
 #define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	269
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	270
+#define USB_U100_PRODUCT_ID			273
+#define USB_U100P_PRODUCT_ID			274
+#define USB_U100S_PRODUCT_ID			275
 #define USB_HYDRA_PRODUCT_ID_END \
-	USB_HYBRID_PRO_CANLIN_PRODUCT_ID
+	USB_U100S_PRODUCT_ID
 
 static inline bool kvaser_is_leaf(const struct usb_device_id *id)
 {
@@ -187,6 +190,9 @@ static const struct usb_device_id kvaser_usb_table[] = {
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_CANLIN_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100P_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100S_PRODUCT_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.29.2

