Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C1F70D961
	for <lists+linux-can@lfdr.de>; Tue, 23 May 2023 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjEWJp0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 May 2023 05:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjEWJpV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 May 2023 05:45:21 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB6719B
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:11 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af24ee004dso52157971fa.0
        for <linux-can@vger.kernel.org>; Tue, 23 May 2023 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google; t=1684835049; x=1687427049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNNdqqUob1SakIS3eb+xfDdXt1uyZAOVpzPP+BwNjjs=;
        b=mJw5hn32CXpFlG+SYM0XNjv7Oga25RNbGNCPURxTh4s4yE1tY4x0AXW1JERwl/S6Ph
         IkgFHLzwpJKrjriVo0CuO9F9jKdIAm2UXtcOh3bQLe7ifV2412TKzwnbptYsd29Tb7/i
         4Y0/RZfwA0lr0FpWQUw69RkQlqVCHDjFDCKgm+jztawYInnR70wIyIP67VBSXkz+e6wj
         8wAVbdapmSZfe2RuG1V2THYtXBnBwQgDHhVVt7gIprJgFMBd6ZjtFTKBKlOc0AW1GBIE
         p5HvSyOsM+/P0oZLIdZeLNkqTvtNdwRSjsHBPYfGWM6mT3K27NLZsPHfba9AWxVpATeX
         4MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835049; x=1687427049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNNdqqUob1SakIS3eb+xfDdXt1uyZAOVpzPP+BwNjjs=;
        b=NzuQgmpKRRdriuIZZ+uHXe2aEQ+5zHsRQFYL47qmOEdxfzW6imkxkGGb7qD7ff0W4l
         9zGq/tbm584Oti8jEVvsBngBvAEoW3b4rO/IIUUUdke91hY0VmtKSUwzV3StMoM0vhzG
         BdtKREo6w24zrUGOMgYDscy4qv4UtWr35zCsLaK1gpZu7Nw7+VxFOt+Gnb7KSm6qn2fu
         I51cA6IfqZyuKpCY4IC1H1AdSAEtxGpFhJWYfgAKK6LUAJIPFL7W+1C+q0MjXHufv+Lq
         XE7PU/LhnrfvLazL7yavRmczcx2WX5DHZdoHc7/FHB+DvgppoOqnyydjUQdNw85oy6Ue
         8/Mw==
X-Gm-Message-State: AC+VfDyppuZ1y3BC93fqRbq9baKMpmhtK2YhEA9Yj1svjay90f940bc0
        G56Ljn/aumlZ3RN7UjuuqmHwjc3W4f+xAuUoAHI=
X-Google-Smtp-Source: ACHHUZ6JqazTkYnqa4chhf6X4lBrk1FZalAAGgUfdHzPGqTDvjLFSLwjqTi5OPBrh3bh+gVwbe10Hw==
X-Received: by 2002:a2e:2c15:0:b0:2ac:bd28:d457 with SMTP id s21-20020a2e2c15000000b002acbd28d457mr4810014ljs.14.1684835049804;
        Tue, 23 May 2023 02:44:09 -0700 (PDT)
Received: from archyz.. (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002ac87c15fd4sm1535551ljh.95.2023.05.23.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 02:44:09 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH 08/12] can: kvaser_pciefd: Rename device ID defines
Date:   Tue, 23 May 2023 11:43:46 +0200
Message-Id: <20230523094354.83792-9-extja@kvaser.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230523094354.83792-1-extja@kvaser.com>
References: <20230523094354.83792-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

