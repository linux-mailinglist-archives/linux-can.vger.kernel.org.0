Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F5B456F7E
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 14:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhKSNXl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhKSNXl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 08:23:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37FC06174A
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:39 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id n12so43489424lfe.1
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXrmv6kZgiM6kukoF4az2sBq52ffHlQX37o5eZdMrSo=;
        b=G/aly4EJ7/LpPhUYn/8aykoSMTstw/gP+bGKrtNFtIubLH7M/vvZ2j7L4vtF0SdpIb
         5EuELTLG1S5ZX1jiScOR/Zl9aKIG5aSIy+KB1bMb0eYkulq7iUyq1nd8al0jTm/q6sVJ
         3mIKNEUaV/XbgPksQsZCZhxr3LDiRSiJJAqtUkxJ4VkDQIefImSjthQi6x7OGnPhefUG
         dFBkX4DY7vQYzjhzPy6fe2u+fLAVxNwLqjt8zKOHeO1kv/zYaPNwr8/8/foJiyHGn39c
         4k80hgHW9/P2gAS5KXzl+UkXUEnH3KZwNetiz7r/5/GzKwTFIFyVLBkxH4yVPZ5GFacg
         8gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXrmv6kZgiM6kukoF4az2sBq52ffHlQX37o5eZdMrSo=;
        b=IvKqkOEuzQVEIcjaW2cMN8Yu81aZyaG1FA9GMXLtu8qQP021LNbYyTwcx3pBY+1GOC
         1Qtp6WBMpffPD0REgMUahWn16XWGZiQM6ZiKPsF5KmxafcKHMAhSUzzg1A3YxvBBTvg5
         fNovwMSFPNsFurBuQrkwngsLkMvsgPEdYMwD8JcasBAv/e2UyYyU8DpCAXU4JawXYE0m
         Ea4LDD9+Jt4YThGxBZEwUVAifrfrSsazFftPazmzkOUbfJAzOsRnLkmqbLH86ri4HyDT
         r7qP6G22ADK1vgnjl/FtS37ciaXJWsTAUHKjEVFL1IYyS49bXe4i31i3ZmL+JPfyUN/8
         Z8vg==
X-Gm-Message-State: AOAM531AahKqrjLsg4PyXR076rmzVUddDaXSeHyUkN7aS5Qvs2Mws3FE
        tojkA5h6FSfbeCi8RggO5t0Qnh1dbGdn0Y84
X-Google-Smtp-Source: ABdhPJzu+8HW08bmiI6IyKLB96c4qe6dI+p8kpTyFE8R9EZE/QonYV7vzAQFG2FORESjLI24uXXAeA==
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr34119983lfb.35.1637328037616;
        Fri, 19 Nov 2021 05:20:37 -0800 (PST)
Received: from localhost (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with UTF8SMTPSA id b13sm403923lfv.200.2021.11.19.05.20.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:20:37 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v1 5/5] can: kvaser_usb: Get CAN clock frequency from device
Date:   Fri, 19 Nov 2021 14:19:15 +0100
Message-Id: <20211119131915.2033234-6-extja@kvaser.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211119131915.2033234-1-extja@kvaser.com>
References: <20211119131915.2033234-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Get the CAN clock frequency from device, since the various Kvaser Leaf
products use different CAN clocks.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 69 ++++++++++++++++---
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 506e4b76d119..5153af71c47a 100644
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
@@ -472,6 +480,27 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
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
@@ -487,14 +516,13 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 
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
 
@@ -1226,7 +1254,6 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
 {
 	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
 
-	dev->cfg = &kvaser_usb_leaf_dev_cfg;
 	card_data->ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 
 	return 0;
@@ -1350,9 +1377,33 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
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
2.31.1

