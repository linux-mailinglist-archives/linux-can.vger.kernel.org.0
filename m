Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4546D2D7
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhLHMAA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 07:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhLHL77 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:59:59 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A9C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:56:27 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id bn20so3487865ljb.8
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myRdTKjjfoUfWmMWlJosISN93mrPYjY3SJDsSNn8XHI=;
        b=KAsXECvXkUHcuDUX/tpp4jqwDWQXC3uzToPD5qrDSbBolH0QbxDzxoUPGIj6n/ckPi
         5HrhrmC3YmzZg+azrp/rWsCaYxlYgJsxDS7t1lnwzSq/AcHsYWszor5rFYKnFi4mNF+5
         S6BYHDARX6lNfehm64ozZ4Bch1S0RaLBmxvcJaiD77ZprWNS4q7dsHI/91LWnaJSuUCL
         dLW6Coch+sYdr8Qdwa7a/fZo/mAyX3gcXWADvJuzaotGL7ZTHsPRPplbNj+TrJLOfaCo
         MGKtPSrGbm+AiSYnaJTzKJjk8DhgRKrBWNxl4qTSw6R1OVEP2TM3lif+c7bX26k0yGQb
         bJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myRdTKjjfoUfWmMWlJosISN93mrPYjY3SJDsSNn8XHI=;
        b=g3ItK36Ly9XNDZTtaFIxbKsavbyJDh9L9F9wfZy2/uoLAitaVJ4C1u9EmY1ik+Q7Hb
         xlQe+NSTKtWdzXijX+7ZYkAxZdlozBTzbVLZPv6SBV+EBZ8J3LVtamtc1UPnt6wGveNA
         sJ+/sKGo0Ge+VTKDptHMnvJGcOZg5Bfb7m2c27wmkWAhJa4UcC6UxHpQyZ1VLqomWsIB
         9ZT2aunBX9QvYFXpDrUBOkqrPSQDjhQ6LoO9/97Eg9EMggmLDGCRTIJ4zaEs/ZtQ+eXD
         zRhB3+3FDPTv0A5c8hfIbK0aL0H7jD1gToCAbuMeCBQjx8iMQiW5ThdSvi3qfvViZ6A7
         R4Dg==
X-Gm-Message-State: AOAM531wfmNQA5QfPjeKTytl0FSQQB45QmmDg6hNXCZtQBULesCxbgGk
        3h61KChYwLuLU+N6fSmmAsH4zhMOdTsRZOm2
X-Google-Smtp-Source: ABdhPJwjJRZWBf6rKiV+ADYJv0FZY5WMmG1CJf/PWuRKBBEALrqZcywDdglP/+xORij4p/vmiEfAFg==
X-Received: by 2002:a2e:9112:: with SMTP id m18mr50517191ljg.45.1638964586176;
        Wed, 08 Dec 2021 03:56:26 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id c25sm256977lja.38.2021.12.08.03.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:56:25 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 4/4] can: kvaser_usb: Get CAN clock frequency from device
Date:   Wed,  8 Dec 2021 12:56:07 +0100
Message-Id: <20211208115607.202859-5-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208115607.202859-1-extja@kvaser.com>
References: <20211208115607.202859-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Get the CAN clock frequency from device, since the various Kvaser Leaf
products use different CAN clocks.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3:
  - Rearranged kvaser_usb_leaf_dev_cfg_{8,16,24,32}mhz and removed forward declarations.

Changes in v2:
  - Rebased on [PATCH v5 0/5] fix statistics and payload issues for
    error [1] series.

[1]
https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 62 ++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index bd5d469a9c3c..3fe72fb861ef 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -29,7 +29,6 @@
 
 #include "kvaser_usb.h"
 
-#define CAN_USB_CLOCK			(8 * CAN_MHZ)
 #define MAX_USBCAN_NET_DEVICES		2
 
 /* Command header size */
@@ -78,6 +77,12 @@
 
 #define CMD_LEAF_LOG_MESSAGE		106
 
+/* Leaf frequency options */
+#define KVASER_USB_LEAF_SWOPTION_FREQ_MASK 0x60
+#define KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK 0
+#define KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK BIT(5)
+#define KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK BIT(6)
+
 /* error factors */
 #define M16C_EF_ACKE			BIT(0)
 #define M16C_EF_CRCE			BIT(1)
@@ -350,9 +355,33 @@ static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
 	.brp_inc = KVASER_USB_BRP_INC,
 };
 
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg = {
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_8mhz = {
+	.clock = {
+		.freq = 8 * CAN_MHZ,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_16mhz = {
 	.clock = {
-		.freq = CAN_USB_CLOCK,
+		.freq = 16 * CAN_MHZ,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_24mhz = {
+	.clock = {
+		.freq = 24 * CAN_MHZ,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_32mhz = {
+	.clock = {
+		.freq = 32 * CAN_MHZ,
 	},
 	.timestamp_freq = 1,
 	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
@@ -487,6 +516,27 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
 	return rc;
 }
 
+static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
+						   const struct leaf_cmd_softinfo *softinfo)
+{
+	u32 sw_options = le32_to_cpu(softinfo->sw_options);
+
+	dev->fw_version = le32_to_cpu(softinfo->fw_version);
+	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
+
+	switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
+	case KVASER_USB_LEAF_SWOPTION_FREQ_16_MHZ_CLK:
+		dev->cfg = &kvaser_usb_leaf_dev_cfg_16mhz;
+		break;
+	case KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK:
+		dev->cfg = &kvaser_usb_leaf_dev_cfg_24mhz;
+		break;
+	case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
+		dev->cfg = &kvaser_usb_leaf_dev_cfg_32mhz;
+		break;
+	}
+}
+
 static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 {
 	struct kvaser_cmd cmd;
@@ -502,14 +552,13 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 
 	switch (dev->card_data.leaf.family) {
 	case KVASER_LEAF:
-		dev->fw_version = le32_to_cpu(cmd.u.leaf.softinfo.fw_version);
-		dev->max_tx_urbs =
-			le16_to_cpu(cmd.u.leaf.softinfo.max_outstanding_tx);
+		kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.softinfo);
 		break;
 	case KVASER_USBCAN:
 		dev->fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
 		dev->max_tx_urbs =
 			le16_to_cpu(cmd.u.usbcan.softinfo.max_outstanding_tx);
+		dev->cfg = &kvaser_usb_leaf_dev_cfg_8mhz;
 		break;
 	}
 
@@ -1237,7 +1286,6 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
 {
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 
-	dev->cfg = &kvaser_usb_leaf_dev_cfg;
 	card_data->ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 
 	return 0;
-- 
2.34.1

