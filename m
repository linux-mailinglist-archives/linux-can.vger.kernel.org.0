Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5556B90D
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiGHL5i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiGHL5h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:37 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E092E9A6B9
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so4251751ljb.13
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LgaXTCU8WnrGs6lY6kVgJ4wTT+ECbr1Jw/qQGtjy2c=;
        b=G4oPTSDwMOcIprLk2DNw6XliQwj/VdAoi4oj1RJJt514aba7cNpC/i5ZoKafwcDnYt
         SZ/7UNGb1KG7fGJtbPI4vSxdvpYCLAKguGh8axK7L+0RvPvKZuKzYssIpBfDmxNCYqES
         6D9FaacxRFXEB3rUbdBIovcVduokuCzCI3lkXDxBys5hbvL/FbEb12QXf5QRHd8M/IaW
         Tq9PTkgXndqT7kSA8DbQk5UOODYM+WbmpZUPHCob0zFGygjyndhGu1cX9GE/AvYDzjM4
         5o7SPnzdx6yBPZhxm1/SiIo7tNxL6jCSo6X5/618yej0vEr+muBMOBJ5tJLZ6zWsjD6d
         SGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LgaXTCU8WnrGs6lY6kVgJ4wTT+ECbr1Jw/qQGtjy2c=;
        b=HorqWbMT6i53bwU8mFACoMaufeEqqi1gBa9Ai/VXjE+qZy4zcgEfdkfSSSIIc01Ot5
         LpNpSzBmO7lOKFoUszaGdUcjPR1Qukj1mFJWwRYfH8yqou7q9/RhYK1O/OL5R02bwJei
         LtwYCr9cO+IFJ9l1UUbIe86dA1N3nUKlq81uF2wJO5Pv3Qa7vngy8RS5rPmHEPFtbs4Z
         aydtZWiUkOY6WTjXNmr9xW0V5SvXLHct7/pRYrnedfl9gKSLzE016g+ftKcVh2RiA/ur
         ETar/LAAiCKJAstEhhEfCrDz/AffrBYZcE0jSIa0t90u1p0ZqmBIpawYohmnwRtQwtWU
         nWwg==
X-Gm-Message-State: AJIora/L5/qmMbUIsfSJZjWBplHFtOUjMmDDTyvnfoRNcP4DDQ4mQfat
        uudDE5F1yRb6H62RHROKr8lRHVNubkaR1g==
X-Google-Smtp-Source: AGRyM1uisBBqynLP1VwtEFm31Z1fVdZr9DFyL4+ggvGwJmoj7Fq2KNkSnkWFwhzEu07Z+2++C3rEdQ==
X-Received: by 2002:a2e:934f:0:b0:250:a7bc:2b8f with SMTP id m15-20020a2e934f000000b00250a7bc2b8fmr1833567ljh.512.1657281454197;
        Fri, 08 Jul 2022 04:57:34 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:33 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 04/15] can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device
Date:   Fri,  8 Jul 2022 13:56:58 +0200
Message-Id: <20220708115709.232815-5-extja@kvaser.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708115709.232815-1-extja@kvaser.com>
References: <20220708115709.232815-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Use the CMD_GET_CAPABILITIES_REQ command to query the device for certain
capabilities. We are only interested in LISTENONLY mode and wither the
device reports CAN error counters.

And remove hard coded capabilities for all Leaf devices.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - New in v2. Replaces [PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting
 error counters
  - Fixed Anssi's comments; https://lore.kernel.org/linux-can/9742e7ab-3650-74d8-5a44-136555788c08@bitwise.fi/

 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  49 +++---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 144 +++++++++++++++++-
 2 files changed, 160 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 5caf6e802fc9..d1401a2d23e9 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -106,21 +106,6 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf = {
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
-static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err = {
-	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
-	.family = KVASER_LEAF,
-	.ops = &kvaser_usb_leaf_dev_ops,
-};
-
-static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_listen = {
-	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
-		  KVASER_USB_QUIRK_IGNORE_CLK_FREQ,
-	.family = KVASER_LEAF,
-	.ops = &kvaser_usb_leaf_dev_ops,
-};
-
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
 	.quirks = 0,
 	.ops = &kvaser_usb_leaf_dev_ops,
@@ -133,41 +118,41 @@ static const struct usb_device_id kvaser_usb_table[] = {
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_SWC_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_LIN_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_LS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_SPRO_SWC_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_DEVEL_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSHS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_UPRO_HSHS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_GI_PRODUCT_ID),
 		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_PRO_OBDII_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err_listen },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MEMO2_HSLS_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_CH_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_BLACKBIRD_SPRO_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_MERCURY_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_OEM_LEAF_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_CAN_R_PRODUCT_ID),
-		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf_err },
+		.driver_info = (kernel_ulong_t)&kvaser_usb_driver_info_leaf },
 
 	/* Leaf i.MX28 USB product IDs */
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID),
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 4a82550bdda9..838e072d5d62 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -74,6 +74,8 @@
 #define CMD_TX_ACKNOWLEDGE		50
 #define CMD_CAN_ERROR_EVENT		51
 #define CMD_FLUSH_QUEUE_REPLY		68
+#define CMD_GET_CAPABILITIES_REQ	95
+#define CMD_GET_CAPABILITIES_RESP	96
 
 #define CMD_LEAF_LOG_MESSAGE		106
 
@@ -83,6 +85,8 @@
 #define KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK BIT(5)
 #define KVASER_USB_LEAF_SWOPTION_FREQ_24_MHZ_CLK BIT(6)
 
+#define KVASER_USB_LEAF_SWOPTION_EXT_CAP BIT(12)
+
 /* error factors */
 #define M16C_EF_ACKE			BIT(0)
 #define M16C_EF_CRCE			BIT(1)
@@ -278,6 +282,28 @@ struct leaf_cmd_log_message {
 	u8 data[8];
 } __packed;
 
+/* Sub commands for cap_req and cap_res */
+#define KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE 0x02
+#define KVASER_USB_LEAF_CAP_CMD_ERR_REPORT 0x05
+struct kvaser_cmd_cap_req {
+	__le16 padding0;
+	__le16 cap_cmd;
+	__le16 padding1;
+	__le16 channel;
+} __packed;
+
+/* Status codes for cap_res */
+#define KVASER_USB_LEAF_CAP_STAT_OK 0x00
+#define KVASER_USB_LEAF_CAP_STAT_NOT_IMPL 0x01
+#define KVASER_USB_LEAF_CAP_STAT_UNAVAIL 0x02
+struct kvaser_cmd_cap_res {
+	__le16 padding;
+	__le16 cap_cmd;
+	__le16 status;
+	__le32 mask;
+	__le32 value;
+} __packed;
+
 struct kvaser_cmd {
 	u8 len;
 	u8 id;
@@ -295,6 +321,8 @@ struct kvaser_cmd {
 			struct leaf_cmd_chip_state_event chip_state_event;
 			struct leaf_cmd_error_event error_event;
 			struct leaf_cmd_log_message log_message;
+			struct kvaser_cmd_cap_req cap_req;
+			struct kvaser_cmd_cap_res cap_res;
 		} __packed leaf;
 
 		union {
@@ -324,6 +352,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_LEAF_LOG_MESSAGE]		= kvaser_fsize(u.leaf.log_message),
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
+	[CMD_GET_CAPABILITIES_RESP]	= kvaser_fsize(u.leaf.cap_res),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
 };
@@ -606,6 +635,9 @@ static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 	dev->fw_version = le32_to_cpu(softinfo->fw_version);
 	dev->max_tx_urbs = le16_to_cpu(softinfo->max_outstanding_tx);
 
+	if (sw_options & KVASER_USB_LEAF_SWOPTION_EXT_CAP)
+		dev->card_data.capabilities |= KVASER_USB_CAP_EXT_CAP;
+
 	if (dev->driver_info->quirks & KVASER_USB_QUIRK_IGNORE_CLK_FREQ) {
 		/* Firmware expects bittiming parameters calculated for 16MHz
 		 * clock, regardless of the actual clock
@@ -693,6 +725,116 @@ static int kvaser_usb_leaf_get_card_info(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_leaf_get_single_capability(struct kvaser_usb *dev,
+						 u16 cap_cmd_req, u16 *status)
+{
+	struct kvaser_usb_dev_card_data *card_data = &dev->card_data;
+	struct kvaser_cmd *cmd;
+	u32 value = 0;
+	u32 mask = 0;
+	u16 cap_cmd_res;
+	int err;
+	int i;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->id = CMD_GET_CAPABILITIES_REQ;
+	cmd->u.leaf.cap_req.cap_cmd = cpu_to_le16(cap_cmd_req);
+	cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_cap_req);
+
+	err = kvaser_usb_send_cmd(dev, cmd, cmd->len);
+	if (err)
+		goto end;
+
+	err = kvaser_usb_leaf_wait_cmd(dev, CMD_GET_CAPABILITIES_RESP, cmd);
+	if (err)
+		goto end;
+
+	*status = le16_to_cpu(cmd->u.leaf.cap_res.status);
+
+	if (*status != KVASER_USB_LEAF_CAP_STAT_OK)
+		goto end;
+
+	cap_cmd_res = le16_to_cpu(cmd->u.leaf.cap_res.cap_cmd);
+	switch (cap_cmd_res) {
+	case KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE:
+	case KVASER_USB_LEAF_CAP_CMD_ERR_REPORT:
+		value = le32_to_cpu(cmd->u.leaf.cap_res.value);
+		mask = le32_to_cpu(cmd->u.leaf.cap_res.mask);
+		break;
+	default:
+		dev_warn(&dev->intf->dev, "Unknown capability command %u\n",
+			 cap_cmd_res);
+		break;
+	}
+
+	for (i = 0; i < dev->nchannels; i++) {
+		if (BIT(i) & (value & mask)) {
+			switch (cap_cmd_res) {
+			case KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE:
+				card_data->ctrlmode_supported |=
+						CAN_CTRLMODE_LISTENONLY;
+				break;
+			case KVASER_USB_LEAF_CAP_CMD_ERR_REPORT:
+				card_data->capabilities |=
+						KVASER_USB_CAP_BERR_CAP;
+				break;
+			}
+		}
+	}
+
+end:
+	kfree(cmd);
+
+	return err;
+}
+
+static int kvaser_usb_leaf_get_capabilities_leaf(struct kvaser_usb *dev)
+{
+	int err;
+	u16 status;
+
+	if (!(dev->card_data.capabilities & KVASER_USB_CAP_EXT_CAP)) {
+		dev_info(&dev->intf->dev,
+			 "No extended capability support. Upgrade device firmware.\n");
+		return 0;
+	}
+
+	err = kvaser_usb_leaf_get_single_capability(dev,
+						    KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE,
+						    &status);
+	if (err)
+		return err;
+	if (status)
+		dev_info(&dev->intf->dev,
+			 "KVASER_USB_LEAF_CAP_CMD_LISTEN_MODE failed %u\n",
+			 status);
+
+	err = kvaser_usb_leaf_get_single_capability(dev,
+						    KVASER_USB_LEAF_CAP_CMD_ERR_REPORT,
+						    &status);
+	if (err)
+		return err;
+	if (status)
+		dev_info(&dev->intf->dev,
+			 "KVASER_USB_LEAF_CAP_CMD_ERR_REPORT failed %u\n",
+			 status);
+
+	return 0;
+}
+
+static int kvaser_usb_leaf_get_capabilities(struct kvaser_usb *dev)
+{
+	int err = 0;
+
+	if (dev->driver_info->family == KVASER_LEAF)
+		err = kvaser_usb_leaf_get_capabilities_leaf(dev);
+
+	return err;
+}
+
 static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 					   const struct kvaser_cmd *cmd)
 {
@@ -1479,7 +1621,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_get_software_info = kvaser_usb_leaf_get_software_info,
 	.dev_get_software_details = NULL,
 	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
-	.dev_get_capabilities = NULL,
+	.dev_get_capabilities = kvaser_usb_leaf_get_capabilities,
 	.dev_set_opt_mode = kvaser_usb_leaf_set_opt_mode,
 	.dev_start_chip = kvaser_usb_leaf_start_chip,
 	.dev_stop_chip = kvaser_usb_leaf_stop_chip,
-- 
2.36.1

