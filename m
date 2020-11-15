Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319672B3639
	for <lists+linux-can@lfdr.de>; Sun, 15 Nov 2020 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKOQbX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 15 Nov 2020 11:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgKOQbX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2020 11:31:23 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0156C0613D1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:22 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id i17so15883220ljd.3
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2020 08:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjXHFb2jBUiQqfmJFwik2xZmVc3xNDewEq7mGihhwWg=;
        b=IPo/1xcvxCfJsbn9mdhzV0tQGLsUsYAXhrQRwqLmFTlmjSqWmY1p3nJD8nFCemqe4s
         0wEszKADY3DXgwzoXSUm9rCr4bsNW55nm64HMMLK8B59/8NVUy0h36NZOsz2Ir72LBRH
         YmZvfL05a52T2sOl7dwMq2KJn2DlTm084FHSbsoeJChNsK7zOZ9mY+MqMTOty/iecjkb
         emTa25xEOT1JPg4rhJRYBEf/sWNxEzPwShE4KaDtDT+pLwWGSiEUvgdDOKpa5BbjZhCe
         8Vp3P4P+h9hBRzOcyPn/QMjGD5oRODx1wdCiQNI9qORADElJK1yQWVssMx/4M6vyY6VR
         gumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjXHFb2jBUiQqfmJFwik2xZmVc3xNDewEq7mGihhwWg=;
        b=pwp9aCa49vHw71FUquJ5B60UpygsAeZBDqz5XqXZzA1YqdEb5e/XYohLzHU617phrE
         F1R/tD1n7JMTLn9hOXtXvfJQHlnp4ttOk+17mk0Xv2Mxmaf+cAcKtmU1zhGkxWn01h/W
         76VLM0uXFqtmc34NdL1sfWfksCyqZy0zf0eFsJ5VvQPDBESXO63RS8ZGrcU0gSrTMu65
         rWNXlDrsLLc7/fPLeFiYTPEyWRgFtPCAYBgY1apCWSbNugM38r1fcI4y0Q2q5jLbZE7m
         tHM4H6y2f7ARx1P0bUAbWoIiSgyyK01FN8xG9ywtFm3B1zmBH5cBXXAap0sJ+KU55DOv
         OEoQ==
X-Gm-Message-State: AOAM533lUYybgnBzL47VQr1DEQigUJybwPds/y9ttwQET9GsZ+ogDlQE
        RAPkn4z4SmaWdccAr8tbbaXdwXlspuU=
X-Google-Smtp-Source: ABdhPJyoa2VW4Dv+h/eMQ3v8Uqi84+ks+8zgSF4io5TrcFYpyzVQiToE1Ju8IzB7tJDwn0U38n/YFw==
X-Received: by 2002:a2e:99cb:: with SMTP id l11mr1903069ljj.249.1605457881278;
        Sun, 15 Nov 2020 08:31:21 -0800 (PST)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b12sm2419462ljj.133.2020.11.15.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 08:31:20 -0800 (PST)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 3/6] can: kvaser_usb: Add USB_{LEAF,HYDRA}_PRODUCT_ID_END defines
Date:   Sun, 15 Nov 2020 17:30:24 +0100
Message-Id: <20201115163027.16851-3-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115163027.16851-1-jimmyassarsson@gmail.com>
References: <20201115163027.16851-1-jimmyassarsson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Add USB_{LEAF,HYDRA}_PRODUCT_ID_END defines, representing the last USB PID
entry in respectively family. This removes the need to update the
kvaser_is_{leaf,hydra}() functions whenever new devices are added.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 0f1d3e807d63..091c8209af92 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -58,6 +58,8 @@
 #define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	290
 #define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		291
 #define USB_MINI_PCIE_2HS_PRODUCT_ID		292
+#define USB_LEAF_PRODUCT_ID_END \
+	USB_MINI_PCIE_2HS_PRODUCT_ID
 
 /* Kvaser USBCan-II devices product ids */
 #define USB_USBCAN_REVB_PRODUCT_ID		2
@@ -78,13 +80,15 @@
 #define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	268
 #define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	269
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	270
+#define USB_HYDRA_PRODUCT_ID_END \
+	USB_HYBRID_PRO_CANLIN_PRODUCT_ID
 
 static inline bool kvaser_is_leaf(const struct usb_device_id *id)
 {
 	return (id->idProduct >= USB_LEAF_DEVEL_PRODUCT_ID &&
 		id->idProduct <= USB_CAN_R_PRODUCT_ID) ||
 		(id->idProduct >= USB_LEAF_LITE_V2_PRODUCT_ID &&
-		 id->idProduct <= USB_MINI_PCIE_2HS_PRODUCT_ID);
+		 id->idProduct <= USB_LEAF_PRODUCT_ID_END);
 }
 
 static inline bool kvaser_is_usbcan(const struct usb_device_id *id)
@@ -96,7 +100,7 @@ static inline bool kvaser_is_usbcan(const struct usb_device_id *id)
 static inline bool kvaser_is_hydra(const struct usb_device_id *id)
 {
 	return id->idProduct >= USB_BLACKBIRD_V2_PRODUCT_ID &&
-	       id->idProduct <= USB_HYBRID_PRO_CANLIN_PRODUCT_ID;
+	       id->idProduct <= USB_HYDRA_PRODUCT_ID_END;
 }
 
 static const struct usb_device_id kvaser_usb_table[] = {
-- 
2.29.2

