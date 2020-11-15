Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC12B363A
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgKOQb1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 11:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgKOQb0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 11:31:26 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0EC0613D1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:25 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id i17so15883303ljd.3
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvxoqq1cIMNgNVsOoQAtU5A1gHfjVc18FVtIRbtzgVw=;
        b=UCBI7IWfnViruk4O/B+mj6oEnNFwj9D+52fZKuxhZoNhFhbCoPd30iGcgPoMrhMU4i
         e+1nWLspwFU0o84FOA21sBd9m1Zs7R7sF7CPu3Xe1yZQE4OlQoZNpyZx0fCGtGQ5GFw9
         CEfN6xTmS+5Mxt3diJerrxhTOSMG4cy7Dc3mIm0Is9JY47lgCIp+jN3fmGQvSsug+qZW
         AeB1JtfEADNZJccW8ene04NqAV0Mkxf5CBTpzkKB0ELa0rMMEfjj7ISKlqjvYA4ZsnwN
         iQBB2TIv3U8J+QD5yp0mJZEoRLp4iFE4Fc8u/CHeXJgF+NnNjzy/ushoy7bz2LvozQ97
         AyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvxoqq1cIMNgNVsOoQAtU5A1gHfjVc18FVtIRbtzgVw=;
        b=IdRWWb0kFtpi/CdP97l5h/4FRy42z01LzVhK4D4a/7m29gYo4yqlB2gFc2muA9N/PY
         Kk1vztBhjfyp7Ml0RwdOk6KmkEE/YAN3LlkYyhoEPRJh6EMJkgTsuz3hFGdlwiXTRBc3
         Kl66OI/quhMOaeKR1BBDpKys42gO96dtK/45eHMD0hTPKHkqZOLAYuxrhTA8y9kYasTl
         9Q71SC5IyEfdcM9o+RnoGzzBjIEFlDpGFRnQlSze+TDaBeAEad0rdmBQrz9ZtTg8AZOt
         miLjQnsMds2oqHcyEJ56MR1gb2rFDZautI3/vZ0A5VlwJ6I7H/eovZPdK/zZ3amYj4vS
         CPpw==
X-Gm-Message-State: AOAM531BRn7thE9VEFRR++yYNbVDW0xu90vknQ3wtJXCV9Szm5f9pQ7W
        QbHOEFmpciDq4jCthz813FSqvM0AClE=
X-Google-Smtp-Source: ABdhPJz9Ks8twXoUX8WShFeDp5eMYCOaCA6NZasIPGw1I2R8tTSjUyxfZEfTTBl/EdWCGZOwuXLq1w==
X-Received: by 2002:a2e:8590:: with SMTP id b16mr4411778lji.454.1605457883498;
        Sun, 15 Nov 2020 08:31:23 -0800 (PST)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b12sm2419462ljj.133.2020.11.15.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 08:31:23 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 4/6] can: kvaser_usb: Add new Kvaser Leaf v2 devices
Date:   Sun, 15 Nov 2020 17:30:25 +0100
Message-Id: <20201115163027.16851-4-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115163027.16851-1-jimmyassarsson@gmail.com>
References: <20201115163027.16851-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add new Kvaser Leaf v2 devices.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/Kconfig                      | 2 ++
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index bcb331b0c958..161f15e5218d 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -52,7 +52,9 @@ config CAN_KVASER_USB
 	    - Kvaser Leaf Light "China"
 	    - Kvaser BlackBird SemiPro
 	    - Kvaser USBcan R
+	    - Kvaser USBcan R v2
 	    - Kvaser Leaf Light v2
+	    - Kvaser Leaf Light R v2
 	    - Kvaser Mini PCI Express HS
 	    - Kvaser Mini PCI Express 2xHS
 	    - Kvaser USBcan Light 2xHS
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 091c8209af92..b7d20320961a 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -58,8 +58,11 @@
 #define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	290
 #define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		291
 #define USB_MINI_PCIE_2HS_PRODUCT_ID		292
+#define USB_USBCAN_R_V2_PRODUCT_ID		294
+#define USB_LEAF_LIGHT_R_V2_PRODUCT_ID		295
+#define USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID	296
 #define USB_LEAF_PRODUCT_ID_END \
-	USB_MINI_PCIE_2HS_PRODUCT_ID
+	USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID
 
 /* Kvaser USBCan-II devices product ids */
 #define USB_USBCAN_REVB_PRODUCT_ID		2
@@ -157,6 +160,9 @@ static const struct usb_device_id kvaser_usb_table[] = {
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_2HS_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_R_V2_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_R_V2_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM2_PRODUCT_ID) },
 
 	/* USBCANII USB product IDs */
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN2_PRODUCT_ID),
-- 
2.29.2

