Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100CC36E81B
	for <lists+linux-can@lfdr.de>; Thu, 29 Apr 2021 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhD2JkD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 29 Apr 2021 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhD2JkA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Apr 2021 05:40:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33554C06138B
        for <linux-can@vger.kernel.org>; Thu, 29 Apr 2021 02:39:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a36so64847330ljq.8
        for <linux-can@vger.kernel.org>; Thu, 29 Apr 2021 02:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3SP0lHfP9YT6WjjYc2XJn8gNeseipbmTunWo3yW2uI=;
        b=Lk5fQdlQr+F0fFe28ObFPkF1+4Ox1SupK7YWaBeclakN5dZ2cov5DMeCqod1Liu6ZP
         hJkPjGfV+JpG8xwvBiM5wrucXnH7Kvd7nq0b4IrwqpUcXyFAhFTF81D7bpTU04xLorIi
         CDr7EQ8vPJeZZq5YZNbV/MSMvmquXc6iqzPaa8BBx1hOIzt82ZQTOgu0WpzkVdB4jC/j
         eoea36OLt2jbrgAKd3ZoC3R0CW/EjIq9t8u7sk7JsZtvlIl6BWZ1xon/juRjmw3y4i/b
         88fQ6E8234nGmmfczZoHf4eekiM1D3qpzjtl8CrKN8pOqLr50ukXDZOalDqH2CdL6EVy
         6c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3SP0lHfP9YT6WjjYc2XJn8gNeseipbmTunWo3yW2uI=;
        b=t+SZHpZbSzNRA+WHzh41Ixd+y9qP53WEXHN2WxlDcPokthsgu4D8vXF5UN3vKCv2rX
         pesZKmRWCz+F8MDivMqei6xHmCxhvYw9KTKScT24XIlR84cB0p9Ox52V7xunhEqRcVu3
         JzispwT29qIqwW0ItodNURCr9wMQt2wNlYIp5Nz7ROqVYNtWMpjj59f+5SQc4sANkXWN
         2Ir+NLTZ0YCoJnPG+HSI1RxZ37z3v47vFo7ABs2RIMNPRBedcxmgxe+vLCPvszoCyxi8
         S5A8k7yqo3dD6U02YyYL9zYi584erRmY4BjkWmwhKWFDOmO8rDdp9/UfgJMWEcVHGRV5
         jvCQ==
X-Gm-Message-State: AOAM531cvmtyujVszg5UTojwGaZB7MZsbHV04ktxO9cxlw11GCtAf0cp
        dwPBEfxzII+h9ZZrZ5tQm7B0jJa1d/jYZ5Lk
X-Google-Smtp-Source: ABdhPJxKtNQ/H4l0kXFPx0boVmSjTNWFPlkmouusvX3hhgBy55lJC7YjN1P9xJ3VQ+MPuvXNaclm5w==
X-Received: by 2002:a05:651c:b20:: with SMTP id b32mr23547969ljr.42.1619689151797;
        Thu, 29 Apr 2021 02:39:11 -0700 (PDT)
Received: from jimmy-desk-arch.kvaser.se (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id i30sm471071lfc.45.2021.04.29.02.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:39:11 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 1/2] can: kvaser_usb: Rename define USB_HYBRID_{,PRO_}CANLIN_PRODUCT_ID
Date:   Thu, 29 Apr 2021 11:37:29 +0200
Message-Id: <20210429093730.499263-1-extja@kvaser.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Rename define USB_HYBRID_{,PRO_}CANLIN_PRODUCT_ID to
USB_HYBRID_{,PRO_}2CANLIN_PRODUCT_ID, to reflect the channel count.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 4e97da8434ab..9a574ec013bc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -79,10 +79,10 @@
 #define USB_USBCAN_PRO_2HS_V2_PRODUCT_ID	264
 #define USB_MEMO_2HS_PRODUCT_ID			265
 #define USB_MEMO_PRO_2HS_V2_PRODUCT_ID		266
-#define USB_HYBRID_CANLIN_PRODUCT_ID		267
+#define USB_HYBRID_2CANLIN_PRODUCT_ID		267
 #define USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID	268
 #define USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID	269
-#define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	270
+#define USB_HYBRID_PRO_2CANLIN_PRODUCT_ID	270
 #define USB_U100_PRODUCT_ID			273
 #define USB_U100P_PRODUCT_ID			274
 #define USB_U100S_PRODUCT_ID			275
@@ -187,10 +187,10 @@ static const struct usb_device_id kvaser_usb_table[] = {
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_PRO_2HS_V2_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_2HS_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO_PRO_2HS_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_CANLIN_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_2CANLIN_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_USBCAN_PRO_2HS_V2_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_ATI_MEMO_PRO_2HS_V2_PRODUCT_ID) },
-	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_CANLIN_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_HYBRID_PRO_2CANLIN_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100P_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_U100S_PRODUCT_ID) },
-- 
2.30.0

