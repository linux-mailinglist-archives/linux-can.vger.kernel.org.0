Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F746D6D6
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 16:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhLHPZd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbhLHPZd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 10:25:33 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102B1C061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 07:22:01 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id b40so6215793lfv.10
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAfkpdRzvM+1VvTAgWQ9/eKSR3dq43o+kbaF88B5gLo=;
        b=FHKpZxldpJrdV3y7H+hJVAtSNGpjiR2ucyLvY5z2CoNs+/APpX5EDSkKgRBbRxOPRp
         n7LBq93Qok93GW9I++nvMrf76Nu0LK8w7SApTj7+aqqlNULmx7Q8iajJhaqxF8aUurpO
         vN31OzmtLga7D0lORX75NvChSLzDTyTDckdd7Mc8YH7ncI0THA/RxwJwCD5AufVuQKQw
         3BggIyYGjku6hnKudygggNWO58fdx2ajdAmmc716pP6FPGrovuNwZxYrlE7E1947LWTf
         w+6tmR2qafU0dHe1Yd6n29vJGJwmOm1zugO0lXGsrlOUXIVvqLs1FvT52lgXcfqVDvZX
         +kLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAfkpdRzvM+1VvTAgWQ9/eKSR3dq43o+kbaF88B5gLo=;
        b=sFtUN7Fwk8HIQrN1dqDEf+ZVXuFOJANG90u/xI9DTTrSv9Fnt5lu5X5UheCiYFRaV1
         4gCzwatuDqoO/iV5/5MkTdqgjd+eYF8flHPJPLM4QZ0GVHIIKJTZgLE/GH8B+ve+sKJG
         3S+uILhJKRKMOwYKEXGmjRVNYOhcrv730ZO9qKEnOEvYtfMTMtbj1/f6H/y7tRHuWh/v
         asNkYEMd2sW+umXO3thDcG9PP44WnNyPhCEkyz4YziPtmFG5pFAvjLb35UPIUBhbuOvV
         3OJvBdfOpgRDZ7G/SYnHY46S2smGmAQF6x3HB6ZRtQyFmsKKhAwjz2uoGF2VrLDcpP+U
         YL3Q==
X-Gm-Message-State: AOAM530TeqnOLIhxSz4Hs/fAgrN1wIlnhBidHbbT9hoevlb4uV3BBPHf
        yaLUInHH2vNvhmlihbInvBhNGz/YrXMAiXbA
X-Google-Smtp-Source: ABdhPJxVW1ZKGrnwza0lu294m/+orRWu6XBfWPWOVT60jFDq3y3mIzdlX3KX6XvDpmW9ppdfRD/E6A==
X-Received: by 2002:a19:c308:: with SMTP id t8mr83683lff.621.1638976919312;
        Wed, 08 Dec 2021 07:21:59 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id m20sm279263lfu.241.2021.12.08.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 07:21:58 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v5 2/2] can: kvaser_usb: get CAN clock frequency from device
Date:   Wed,  8 Dec 2021 16:21:22 +0100
Message-Id: <20211208152122.250852-2-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208152122.250852-1-extja@kvaser.com>
References: <20211208152122.250852-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN clock frequency is used when calculating the CAN bittiming parameters.
When wrong clock frequency is used, the device may end up with wrong
bittiming parameters, depending on user requested bittiming parameters.

To avoid this, get the CAN clock frequency from the device.
Various existing Kvaser Leaf products use different CAN clocks.

Link: https://lore.kernel.org/all/20211208115607.202859-5-extja@kvaser.com
Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v5:
  - Rephrase commit message.

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 101 +++++++++++++-----
 1 file changed, 73 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 59ba7c7beec0..f7af1bf5ab46 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -28,10 +28,6 @@
 
 #include "kvaser_usb.h"
 
-/* Forward declaration */
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
-
-#define CAN_USB_CLOCK			8000000
 #define MAX_USBCAN_NET_DEVICES		2
 
 /* Command header size */
@@ -80,6 +76,12 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
 
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
@@ -340,6 +342,50 @@ struct kvaser_usb_err_summary {
 	};
 };
 
+static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
+	.name = "kvaser_usb",
+	.tseg1_min = KVASER_USB_TSEG1_MIN,
+	.tseg1_max = KVASER_USB_TSEG1_MAX,
+	.tseg2_min = KVASER_USB_TSEG2_MIN,
+	.tseg2_max = KVASER_USB_TSEG2_MAX,
+	.sjw_max = KVASER_USB_SJW_MAX,
+	.brp_min = KVASER_USB_BRP_MIN,
+	.brp_max = KVASER_USB_BRP_MAX,
+	.brp_inc = KVASER_USB_BRP_INC,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_8mhz = {
+	.clock = {
+		.freq = 8000000,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_16mhz = {
+	.clock = {
+		.freq = 16000000,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_24mhz = {
+	.clock = {
+		.freq = 24000000,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg_32mhz = {
+	.clock = {
+		.freq = 32000000,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
 static void *
 kvaser_usb_leaf_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
 			     const struct sk_buff *skb, int *frame_len,
@@ -471,6 +517,27 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
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
@@ -486,14 +553,13 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 
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
 
@@ -1225,24 +1291,11 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
 {
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 
-	dev->cfg = &kvaser_usb_leaf_dev_cfg;
 	card_data->ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 
 	return 0;
 }
 
-static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
-	.name = "kvaser_usb",
-	.tseg1_min = KVASER_USB_TSEG1_MIN,
-	.tseg1_max = KVASER_USB_TSEG1_MAX,
-	.tseg2_min = KVASER_USB_TSEG2_MIN,
-	.tseg2_max = KVASER_USB_TSEG2_MAX,
-	.sjw_max = KVASER_USB_SJW_MAX,
-	.brp_min = KVASER_USB_BRP_MIN,
-	.brp_max = KVASER_USB_BRP_MAX,
-	.brp_inc = KVASER_USB_BRP_INC,
-};
-
 static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
@@ -1348,11 +1401,3 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_read_bulk_callback = kvaser_usb_leaf_read_bulk_callback,
 	.dev_frame_to_cmd = kvaser_usb_leaf_frame_to_cmd,
 };
-
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg = {
-	.clock = {
-		.freq = CAN_USB_CLOCK,
-	},
-	.timestamp_freq = 1,
-	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
-};
-- 
2.34.1

