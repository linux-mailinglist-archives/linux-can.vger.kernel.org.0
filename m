Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9381714A91
	for <lists+linux-can@lfdr.de>; Mon, 29 May 2023 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjE2No5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 May 2023 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjE2No4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 May 2023 09:44:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E27ECF
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so1619122e87.3
        for <linux-can@vger.kernel.org>; Mon, 29 May 2023 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1685367892; x=1687959892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNNdqqUob1SakIS3eb+xfDdXt1uyZAOVpzPP+BwNjjs=;
        b=Y/QQO0t14KXrRTqlC9Mj5TnFn+tMURMfGKY9DUvww143qxqhQElkcJBWLsbIBrRazV
         hfG2TwetUVT5UeLScTJzkIlCtsr3t8/Avx6YQMz+cjxpUkGnEv7FsX5RAgwRGE3/UUPY
         pvQOBAP/Q1RGJ8qLX6VC8d+vd9hUgEUInU4RpR0pBJBvzYZB+rriiSiLzBsgEhaSP439
         VIVutwoTQ07z7frjJFXaw6/onU9GRMDuZpyKa9XxlNInUvNk8ZDJG7L7QkRBUwZBkK6u
         edCVTY1HTSUQJFocfMovpbi5TiYj7vxCyUjKLr4gEdZRkSSvJ4/Lrqw+a6Znec3YYJms
         ZA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367892; x=1687959892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNNdqqUob1SakIS3eb+xfDdXt1uyZAOVpzPP+BwNjjs=;
        b=CLulDQ/x2XLanXjAwkNaKBitqtfj+5gk4/ELdft7vyE3qTv1TlvfyY/+sHXpJ3XGf0
         k/OOC7BEs20fBMq00zaPWz5La0gxLbvp8+BeD29x114I7wMzQ0l2GsQVEhY07V8ANWGw
         xMGauqtDiKOCbhZzG+zhne/iU1qom89tQ8wGZGhbwQojjc7negxDKDEoggQyx43Zp2QT
         SPmaGZe8eG1gEvPrM4ndLoMM/3fHiYbPHLk5iNryGz0gAp2lP9BKzxXnkyGejYgnDjno
         MXzQPHIpvVe7y9ucc4PTdlzftyUnFrL7xvqkvMKdeKF0pM6nYLfzt0sq5uhaAbe3cX80
         0ysQ==
X-Gm-Message-State: AC+VfDzof0Khrk63IuKPr+YEBOZZjM7sO2vn3bLAPPEXdmMNJhI8uGYe
        4fW+mm9NK7Aynamz8VTdvcOLqPofeabZuWQnIDw=
X-Google-Smtp-Source: ACHHUZ5uO01+xWmn3Er/Btr1FFFSNzosBo1wxTNyAzj5QFP1m8EO4S7zq+PDhHB1WIcT7CKbXeKf+A==
X-Received: by 2002:ac2:5a44:0:b0:4f4:ca58:e852 with SMTP id r4-20020ac25a44000000b004f4ca58e852mr3777417lfn.58.1685367892425;
        Mon, 29 May 2023 06:44:52 -0700 (PDT)
Received: from freke.kvaser.se (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id s7-20020a19ad47000000b004ebae99cc1dsm580lfd.159.2023.05.29.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:44:52 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 08/14] can: kvaser_pciefd: Rename device ID defines
Date:   Mon, 29 May 2023 15:42:42 +0200
Message-Id: <20230529134248.752036-9-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230529134248.752036-1-extja@kvaser.com>
References: <20230529134248.752036-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Rename device ID defines to better match the product name of the supported
device.
Use 16 bit hexadecimal values for device IDs.
And format kvaser_pciefd_id_table using clang-format.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 34 ++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 8be27a7dc7e9..bf3fa51069a9 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -33,11 +33,11 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
 
 #define KVASER_PCIEFD_VENDOR 0x1a07
-#define KVASER_PCIEFD_4HS_ID 0x0d
-#define KVASER_PCIEFD_2HS_ID 0x0e
-#define KVASER_PCIEFD_HS_ID 0x0f
-#define KVASER_PCIEFD_MINIPCIE_HS_ID 0x10
-#define KVASER_PCIEFD_MINIPCIE_2HS_ID 0x11
+#define KVASER_PCIEFD_4HS_DEVICE_ID 0x000d
+#define KVASER_PCIEFD_2HS_V2_DEVICE_ID 0x000e
+#define KVASER_PCIEFD_HS_V2_DEVICE_ID 0x000f
+#define KVASER_PCIEFD_MINIPCIE_HS_V2_DEVICE_ID 0x0010
+#define KVASER_PCIEFD_MINIPCIE_2HS_V2_DEVICE_ID 0x0011
 
 /* PCIe IRQ registers */
 #define KVASER_PCIEFD_IRQ_REG 0x40
@@ -282,12 +282,24 @@ static const struct can_bittiming_const kvaser_pciefd_bittiming_const = {
 };
 
 static struct pci_device_id kvaser_pciefd_id_table[] = {
-	{ PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_4HS_ID), },
-	{ PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_2HS_ID), },
-	{ PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_HS_ID), },
-	{ PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_HS_ID), },
-	{ PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_2HS_ID), },
-	{ 0,},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_4HS_DEVICE_ID),
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_2HS_V2_DEVICE_ID),
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_HS_V2_DEVICE_ID),
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_HS_V2_DEVICE_ID),
+	},
+	{
+		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_2HS_V2_DEVICE_ID),
+	},
+	{
+		0,
+	},
 };
 MODULE_DEVICE_TABLE(pci, kvaser_pciefd_id_table);
 
-- 
2.40.0

