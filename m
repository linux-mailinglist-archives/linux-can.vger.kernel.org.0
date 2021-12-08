Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229D46D1B3
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhLHLNf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhLHLNf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:13:35 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA7C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:10:03 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u3so4933199lfl.2
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RfCwksTrgQ8UYlSUx4SdAJS81m1uw/l8lf+uzX2keVA=;
        b=RRzwTmT63q8XIFA2+aQkZ7UjUclqpRVu5J6mYyqlyiGyzAKPbPFHYhPXfXSBdyPTaO
         5QPdoxc3c4I7uBOLxvywfLpfJc9+i9QLlKe6MUruSE3C5iKyQIrJOKE3e60ED3ZIhEY8
         tZ7SVv5e6b9P4IdpupywcuVXx342prMDlwxNn1+PC3s8WGuFAimcOX9jmU7Aa16x8XNG
         w7x6gGGwymMROA3iirMJQiICCd3fh5vepAsLhw+5+BRIfA4RNFJ9hgOAJy+20ZzL86AH
         fNuEnX0f3btEzVMLzEOMPgTd86Iqb41prrj5OPW+Vghxf3tS3r4lEspap4gXs7Tt0oLy
         4cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfCwksTrgQ8UYlSUx4SdAJS81m1uw/l8lf+uzX2keVA=;
        b=ZPCcB/XRFiznyUmpE1pRZqcvK1Ve9Cmi0LomvkU9Ug4Zlf+69Ica0kj6ciYJ0O/+5O
         CODWMH5Do4k/n27sBKcuaB+eQQlPFnvcOZtMZxMUXO4iIA7MQooaCM+ojWd34pS5Tug/
         FPkq5cCEXeL4oA2UyHu3vftS29blr0agHH7bmDe8/V4oitkGU9P+cGR8OXRvwc7oSq9p
         Ay+tZLactPnn1Cfm6rKbsJ02KpQHx9tfpB/HPXXmoHJrBiI9yCTblw0SBdG0ce+C7NFc
         xihpSWIi1eqoQ/5lEnrbE/cyhgPwpvDOVdkiDeQwhumgFbnWT9oPNU4yNNhlNUzH8oJn
         XxIg==
X-Gm-Message-State: AOAM5336utYZucmjcJuNU8o8c5Nj5IL1UqBPgcn8rsKNY79TxV0WUb+b
        x+FHEYAKUabVJRI6MlahQSSrQu9u6tkyE9PX
X-Google-Smtp-Source: ABdhPJy7UO7WpKzwlgPdo1GhQWKCfcYcsTcDsWzCFOpVepGkdAau5erQy5lIQv7CKmcrUM+DYAQdjQ==
X-Received: by 2002:a05:6512:3117:: with SMTP id n23mr47764627lfb.16.1638961801328;
        Wed, 08 Dec 2021 03:10:01 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id q6sm223786lfa.133.2021.12.08.03.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:10:01 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 3/3] can: kvaser_usb: Get CAN clock frequency from device
Date:   Wed,  8 Dec 2021 12:09:40 +0100
Message-Id: <20211208110940.185629-4-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208110940.185629-1-extja@kvaser.com>
References: <20211208110940.185629-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Get the CAN clock frequency from device, since the various Kvaser Leaf
products use different CAN clocks.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - Rebased on [PATCH v5 0/5] fix statistics and payload issues for
    error [1] series.

[1]
https://lore.kernel.org/all/20211207121531.42941-1-mailhol.vincent@wanadoo.fr

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 69 ++++++++++++++++---
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 533e25cb4337..093c092226b6 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -29,10 +29,12 @@
 
 #include "kvaser_usb.h"
 
-/* Forward declaration */
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
+/* Forward declarations */
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_8mhz;
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_16mhz;
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_24mhz;
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_32mhz;
 
-#define CAN_USB_CLOCK			(8 * CAN_MHZ)
 #define MAX_USBCAN_NET_DEVICES		2
 
 /* Command header size */
@@ -81,6 +83,12 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
 
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
@@ -470,6 +478,27 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
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
@@ -485,14 +514,13 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 
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
 
@@ -1220,7 +1248,6 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
 {
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 
-	dev->cfg = &kvaser_usb_leaf_dev_cfg;
 	card_data->ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 
 	return 0;
@@ -1344,9 +1371,33 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_frame_to_cmd = kvaser_usb_leaf_frame_to_cmd,
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
+	.clock = {
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
 	.clock = {
-		.freq = CAN_USB_CLOCK,
+		.freq = 32 * CAN_MHZ,
 	},
 	.timestamp_freq = 1,
 	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
-- 
2.34.1

