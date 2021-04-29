Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7236E81C
	for <lists+linux-can@lfdr.de>; Thu, 29 Apr 2021 11:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhD2JkH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Apr 2021 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhD2JkH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Apr 2021 05:40:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D31CC06138B
        for <linux-can@vger.kernel.org>; Thu, 29 Apr 2021 02:39:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o16so75668720ljp.3
        for <linux-can@vger.kernel.org>; Thu, 29 Apr 2021 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzOPYeNAlPbhSW9cUU9pom9En9tOXtwEtJOxgcbUs4g=;
        b=t3dRmuUyWGUGGR9gDb9ho032BuTtRzF9Z0oF74lQk57LJWb/a3deiObH3697mkS2nh
         CARYnYiZrOQF4X/ngzfeMnYGfHP7Cn3xO2sr26YEaW/FRE3WutiZb1NwEOIl+qNmQMBs
         xGa2yZj+hq2a1H/hm/Upvp/sCdQXklb3LFoAP/ZOlh/IotFtGlg4rk2uutTLtUlgpe62
         MXzAP91njqvzWFAgV6u+p0ZribLYadpncx3orDshtiC6VZZ4tqfJXdDMG/O3BOB40Nkl
         aJD2M4Xfa6WJmgTrtvvtq+L9/ndcE9OKq304N4SJVttQ8YSOLzZViBViZmIYOR/y3bcs
         xSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzOPYeNAlPbhSW9cUU9pom9En9tOXtwEtJOxgcbUs4g=;
        b=ugg+wg2bqVuo5Crm06bOM4dDoWRtM2fxNGXvQj1AmCg+zUSZjZbYreEWzo3QE0GUqn
         vRuVEW59AlVc/z6DU6AkRh4Z+kMXT0VTsxS8OAsezzOCIgdCWk8RkmmIU/Gh2qlwDhXx
         sVJ/hd2dpUyBOLPvt1LhOjJFca52JnFC+LYhfWMPm2H0fWG4BnF64WGSVS++4rNFi2qj
         Vbqu3mylxaC3DINhkC6XBhJczRQ2e85MPLSzKEULHqT2SPqmxYlNxV+IXurWQKA63MEv
         aL9OITnLnwlL/wZGtUvRaKU7FRKekMZIMZGC1rt1UZU3L3F1XO1mWMjdrFXe5h5Su/O6
         a2mw==
X-Gm-Message-State: AOAM531IWBGTqbdMwl18QhtOY0s/uEIJ80PchsOM/vb1qmW+lUSm5jrP
        rIQxklLXDkaXzt8g083zH2S63+Z7V+Z0aH/J
X-Google-Smtp-Source: ABdhPJzetn2VIqPvgDZDXiX+3orZIDmdIBmRmLVWC34uz4V+rKsYM1DpeGZP62dpSsFqEv4sUSQp6g==
X-Received: by 2002:a2e:7819:: with SMTP id t25mr24103908ljc.93.1619689158038;
        Thu, 29 Apr 2021 02:39:18 -0700 (PDT)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id i30sm471071lfc.45.2021.04.29.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:39:17 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 2/2] can: kvaser_usb: Add new Kvaser hydra devices
Date:   Thu, 29 Apr 2021 11:37:30 +0200
Message-Id: <20210429093730.499263-2-extja@kvaser.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210429093730.499263-1-extja@kvaser.com>
References: <20210429093730.499263-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add new Kvaser hydra devices.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 2 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 538f4d9adb91..64196e607409 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -66,7 +66,9 @@ config CAN_KVASER_USB
 	    - Scania VCI2 (if you have the Kvaser logo on top)
 	    - Kvaser BlackBird v2
 	    - Kvaser Leaf Pro HS v2
+	    - Kvaser Hybrid CAN/LIN
 	    - Kvaser Hybrid 2xCAN/LIN
+	    - Kvaser Hybrid Pro CAN/LIN
 	    - Kvaser Hybrid Pro 2xCAN/LIN
 	    - Kvaser Memorator 2xHS v2
 	    - Kvaser Memorator Pro 2xHS v2
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 9a574ec013bc..ae930b91f053 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -87,8 +87,10 @@
 #define USB_U100P_PRODUCT_ID			274
 #define USB_U100S_PRODUCT_ID			275
 #define USB_USBCAN_PRO_4HS_PRODUCT_ID		276
+#define USB_HYBRID_CANLIN_PRODUCT_ID		277
+#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	278
 #define USB_HYDRA_PRODUCT_ID_END \
-	USB_USBCAN_PRO_4HS_PRODUCT_ID
+	USB_HYBRID_PRO_CANLIN_PRODUCT_ID
 
 static inline bool kvaser_is_leaf(const struct usb_device_id *id)
 {
@@ -195,6 +197,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100P_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100S_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_4HS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_CANLIN_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_CANLIN_PRODUCT_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
2.30.0

