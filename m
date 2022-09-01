Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7A35A96CC
	for <lists+linux-can@lfdr.de>; Thu,  1 Sep 2022 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiIAM3e (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Sep 2022 08:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiIAM3H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Sep 2022 08:29:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8BF135D39
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 05:28:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p16so6145928lfd.6
        for <linux-can@vger.kernel.org>; Thu, 01 Sep 2022 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mbw9g5uNFjG1+v1u1OFJo1wQZN5NpG+qSdzoBGGD9jQ=;
        b=QU1uLazGfihjKUt74qlTS/9se8UMmJsVZg4lFqDvx5+X6AgDIDJOg458s2gcZ17vcm
         lBoiTm7bQqe+/s9OrorETrm3nZrqo3Vfj15O1OXVRLCmykJ7GdM4+xBeMkR6jDGP/v71
         fChorXtUCsO+s6ipJDFeWBTSVhtLXFt+d+X3nRAjE7XHxXGsM5VSu3tN7HBSi6TDUrgW
         yPuiA7sviUGpOors/a9fbQZbY3QH2VXtR8lVlE65j/dTtiu1Ws0GjQau3y1RHwMHlRWm
         +dn/q4G5RBJZ5F3KYvcJfk+40FI9WIQU0uCISeSlQZrzOC9mY+ZXP2N/Qa0+KEuikTlF
         BsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mbw9g5uNFjG1+v1u1OFJo1wQZN5NpG+qSdzoBGGD9jQ=;
        b=XEfBZ5s3RFa2qnwNhy2n500EGfLGs+Da3IGAjfrdpwmSIa+l3rgFaHVtcGsSzFRArb
         c7i1LwAYZcA40jdsNrL5RQww8hZw24K9lFBBkO0rKqm8MebEcSymhXtxxR7DzXbQgVKE
         c2z8kkcPSH93mxUKihIxl4YztRY8IX17lg30bwtggNj1rtz8kHWg/u/g7GIjif42vftA
         xKZynQu3u6wv4D6L3UdQk6mV0zlZCOgkqZDieReOQxgRqIa9j8pOfdJA2whIX5mz1uOI
         MHNzLQsHcLZ3yHs8oZacW0PE1R3jGI70dhcOFrbu/lixP2oV6++JXJ7EgGdTukeUANpa
         8sKg==
X-Gm-Message-State: ACgBeo3UcGxJdvXfEteMbn7EQD5sVCTEgQDe8gFbyMElCmU8RGF+XVrY
        9jBBfJz08r2HL/3/Bj15VI8t134SdHXydIs5
X-Google-Smtp-Source: AA6agR55lRqIkF2iy4pgjDwoQwqcSSz8rCfjzcgsefy1rtN/HXQ2K9rq1Q9itrNR1mf2EkEKBqv66g==
X-Received: by 2002:a05:6512:ea3:b0:494:6053:ba50 with SMTP id bi35-20020a0565120ea300b004946053ba50mr7276632lfb.91.1662035304169;
        Thu, 01 Sep 2022 05:28:24 -0700 (PDT)
Received: from fb10a0c5d590.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512202c00b00492c2394ea5sm125935lfs.165.2022.09.01.05.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:28:23 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 04/15] can: kvaser_usb: kvaser_usb_leaf: Get capabilities from device
Date:   Thu,  1 Sep 2022 14:27:18 +0200
Message-Id: <20220901122729.271-5-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220901122729.271-1-extja@kvaser.com>
References: <20220901122729.271-1-extja@kvaser.com>
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

Cc: stable@vger.kernel.org
Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v3
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Re-add hard coded capabilities for Leaf M32C devices, to fix regression
   found by Anssi Hannula in v2 [1].

Changes in v2:
  - New in v2. Replaces [PATCH 04/12] can: kvaser_usb: Mark Mini PCIe 2xHS as supporting
 error counters
  - Fixed Anssi's comments; https://lore.kernel.org/linux-can/9742e7ab-3650-74d8-5a44-136555788c08@bitwise.fi/

[1] https://lore.kernel.org/linux-can/b25bc059-d776-146d-0b3c-41aecf4bd9f8@bitwise.fi/

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 144 +++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 9683bc5e8257..9b688fc0b167 100644
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
@@ -1482,7 +1624,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_get_software_info = kvaser_usb_leaf_get_software_info,
 	.dev_get_software_details = NULL,
 	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
-	.dev_get_capabilities = NULL,
+	.dev_get_capabilities = kvaser_usb_leaf_get_capabilities,
 	.dev_set_opt_mode = kvaser_usb_leaf_set_opt_mode,
 	.dev_start_chip = kvaser_usb_leaf_start_chip,
 	.dev_stop_chip = kvaser_usb_leaf_stop_chip,
-- 
2.37.3

