Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AA456C426
	for <lists+linux-can@lfdr.de>; Sat,  9 Jul 2022 01:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbiGHSsn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 14:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbiGHSsm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 14:48:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93448E0E2
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 11:48:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i18so37705665lfu.8
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1cmJ2WtfZUT2Xh7Tu+RMdJwVDjQlvCW3wETiBnVngWk=;
        b=f6rV/Sie9zpRhf8cuFLyuklqy52MUNs6kKpLRc8moBGOWqcb/zIKbKRrTYQGGROclm
         yvaIxOp/oITbdrWYLrWXXSshPZwQEf5cH4vGcH4R2wlfcKzpqL4CXE55t7c8Ttmo1S4m
         zd0oAhF9VY7syviZaZmYl1ojlX0hEbSH5QDRd201BHytRrN8mzoV69q2EhfyoOvThtN6
         80+postydl/gFQquPu6CQMle2hdU0d022XmbbWpwcrVO8eJ+GAX2gHe7/+uNxsHCMCVv
         VZSXcllfHF5bbAWQs7ig99+XI3ZqF0cOQsA7iazJeAujzX8B+bkqytbLpZeR65wkEzkg
         MKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1cmJ2WtfZUT2Xh7Tu+RMdJwVDjQlvCW3wETiBnVngWk=;
        b=38L7LlSAjEgTtplN+UqJ3VoMDCEU0YC04yy+HysAum+/8ctEfx36PxckPNO/PAYFUe
         UxZyUTX6RGq0MhQ0+4sHbelerbqX7kEbv7dIBqteTIb/DwH5WaO00WiODceiGQK59rJj
         /AUK+XJA95jFbzHPMU5rza0UeSUWGYnRe5OcysYGQ7JIi311uF54f9ogUOQGSNpr5NDg
         MI7Qu50AD7NMGYNFzNdMaL9K0TjdrLQUlqv26wZY1Uclp9tmFV0+N7wXpMNjM6XYK/30
         Si/DqeH54Qk+Bwi8kDUIN0O5D1YddkcjzHB5NWrisuS42q1sCz/yA3jaNRimEMb1uLFI
         hq2g==
X-Gm-Message-State: AJIora8q4ODrN0XpdK0ZbLQXvXga/aamfZICrC1FYPv/y8vEU9Yk+N7n
        e56HI0Gw//IAwy/kRlx0TfGDAbIgLHYdgg==
X-Google-Smtp-Source: AGRyM1uQU5FGe5xduSe2s9E0fwMN1yMnf27SJcSP7oEvu97Vzo7JH9jl6jcX1ZtSKIX508pOff+/zw==
X-Received: by 2002:a19:650b:0:b0:47f:7dd0:5ec6 with SMTP id z11-20020a19650b000000b0047f7dd05ec6mr3149098lfb.149.1657306118931;
        Fri, 08 Jul 2022 11:48:38 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id u19-20020ac258d3000000b0048639c05ffdsm1618605lfo.107.2022.07.08.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:48:38 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     stable@vger.kernel.org, linux-can@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 5.10 2/3] can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression
Date:   Fri,  8 Jul 2022 20:48:18 +0200
Message-Id: <20220708184819.281103-3-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708184819.281103-1-extja@kvaser.com>
References: <20220708184819.281103-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

commit e6c80e601053ffdac5709f11ff3ec1e19ed05f7b upstream.

The firmware of M32C based Leaf devices expects bittiming parameters
calculated for 16MHz clock. Since we use the actual clock frequency of
the device, the device may end up with wrong bittiming parameters,
depending on user requested parameters.

This regression affects M32C based Leaf devices with non-16MHz clock.

Fixes: 854a2bede1f0 ("can: kvaser_usb: get CAN clock frequency from device")
Link: https://lore.kernel.org/all/20220603083820.800246-3-extja@kvaser.com
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  1 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 29 ++++++++++++-------
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 25 ++++++++++------
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 2e358e20d3d9..478e2eeec136 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -38,6 +38,7 @@
 /* Kvaser USB device quirks */
 #define KVASER_USB_QUIRK_HAS_SILENT_MODE	BIT(0)
 #define KVASER_USB_QUIRK_HAS_TXRX_ERRORS	BIT(1)
+#define KVASER_USB_QUIRK_IGNORE_CLK_FREQ	BIT(2)
 
 /* Device capabilities */
 #define KVASER_USB_CAP_BERR_CAP			0x01
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index ae43c423a8ce..416763fd1f11 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -92,26 +92,33 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
-	.quirks = 0,
+	.quirks = KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
-	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS,
+	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
+		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
 	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
+static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
+	.quirks = 0,
+	.ops = &kvaser_usb_leaf_dev_ops,
+};
+
 static const struct usb_device_id kvaser_usb_table[] = {
-	/* Leaf USB product IDs */
+	/* Leaf M32C USB product IDs */
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_DEVEL_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_PRODUCT_ID),
@@ -152,16 +159,18 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_CAN_R_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+
+	/* Leaf i.MX28 USB product IDs */
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leafimx },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leafimx },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leafimx },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_2HS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leafimx },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leafimx },
 
 	/* USBCANII USB product IDs */
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN2_PRODUCT_ID),
@@ -190,7 +199,7 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_PRO_2HS_V2_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_2CANLIN_PRODUCT_ID),
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_CANLIN_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_hydra },
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index fb51f80012a0..b8c2f2c30050 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -525,16 +525,23 @@ static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 	dev->fw_version = le32_to_cpu(softinfo->fw_version);
 	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
 
-	switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
-	case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
+	if (dev->driver_info->quirks & KVASER_USB_QUIRK_IGNORE_CLK_FREQ) {
+		/* Firmware expects bittiming parameters calculated for 16MHz
+		 * clock, regardless of the actual clock
+		 */
 		dev->cfg = &kvaser_usb_leaf_dev_cfg_16mhz;
-		break;
-	case KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK:
-		dev->cfg = &kvaser_usb_leaf_dev_cfg_24mhz;
-		break;
-	case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
-		dev->cfg = &kvaser_usb_leaf_dev_cfg_32mhz;
-		break;
+	} else {
+		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
+		case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_dev_cfg_16mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_dev_cfg_24mhz;
+			break;
+		case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
+			dev->cfg = &kvaser_usb_leaf_dev_cfg_32mhz;
+			break;
+		}
 	}
 }
 
-- 
2.36.1

