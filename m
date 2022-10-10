Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7975E5FA3B0
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJJSxK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJJSxJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:53:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A9786DA
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bs14so1352256ljb.9
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVz3Pb6RLEOWagYqgkX2z6J8VqWPr8qZG/KrH9GVrsY=;
        b=jHesy3f8JBMD+ca2m4p7XL4Mgil1gEvlBAPDM+1F8WmxH2oaO+GpxenyOOx+ALty4W
         jInAKdgn5JTCIR4EJ48Tx/tKswd6U4UPKbMJoulEDhJTmkNCLifTucrkhVPJEpKJayEm
         03WTP1Ih8cPwUsgnJFT0I71JJyyH1T6929n5c5LbFB16ruNqrg9uZIyCDumLoJT1KA9M
         N4gy12myy4m1jmqQosKudafy3MGz4OcqYsjeho3KQqRqtEl4baxKVUb29MmITOjZUPyR
         +T9qoM2zLb+PDBPjOQL/r5dgeEjsv8hGDxVg/wIesEfJf0/I5Fj7+jCnwimKS9vvNrj8
         /r5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVz3Pb6RLEOWagYqgkX2z6J8VqWPr8qZG/KrH9GVrsY=;
        b=Z4SZYRHvlI2QRO5PsWaBG8ep6Yi3+cIBc50Fk0D1aK7GY9aSlK3QoISAfcum9wYqDb
         F3n1+gI79yTc6aSyTPr97A5+376d5/dIY0kTPIsm693oWycVz5b1N1xURDZHQCI3X26n
         bpmkVeZlH/O74BCvpB0kmLBSaVlpaNJ1XR84VE70faNkAb3bhMyBWERiENiis8dy9Oh1
         nopNUWbio94Lj2ewZPUTgAiMme//Tq75nYoJO91XR23eJ0OCQrUTxTu1tPz2Q99iipXN
         d2aG9XFCxjat3HvrG5KnzTm4ObXVn6rlWo9QJFX+HGywvuqVaUscwHtdAwT40REP1lsN
         Hyhg==
X-Gm-Message-State: ACrzQf2Zo9XDu0/cjagUsjVGe7GUZV4xxdCByr0ZzsJi2wHHOG+Qg25N
        2Yv0QfhYvjYo5tfZh4McJ4524TZnCoeEfw==
X-Google-Smtp-Source: AMsMyM6xvW6kPh1kG4VhlgqhFTfNH83ZAZpDH6SRaJX+vzBchz5Rm8/PnplPH4d6PnDky3C/iEMUug==
X-Received: by 2002:a05:651c:19a6:b0:26c:4a66:aa42 with SMTP id bx38-20020a05651c19a600b0026c4a66aa42mr8071496ljb.231.1665427986786;
        Mon, 10 Oct 2022 11:53:06 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:53:06 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 04/11] can: kvaser_usb: kvaser_usb_leaf: Handle CMD_ERROR_EVENT
Date:   Mon, 10 Oct 2022 20:52:30 +0200
Message-Id: <20221010185237.319219-5-extja@kvaser.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221010185237.319219-1-extja@kvaser.com>
References: <20221010185237.319219-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The device will send an error event command, to indicate certain errors.
This indicates a misbehaving driver, and should never occur.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Co-developed-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v5:
 - Split series and rebased on linux-can-next
 - Remove stable from CC

Changes in v4:
 - No changes

Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add Tested-by Anssi Hannula

Changes in v2:
  - New in v2. Replaces parts of [PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus params
 setup

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index a1d4ac8d4a08..5d96ab85d04c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -70,6 +70,7 @@
 #define CMD_GET_CARD_INFO_REPLY		35
 #define CMD_GET_SOFTWARE_INFO		38
 #define CMD_GET_SOFTWARE_INFO_REPLY	39
+#define CMD_ERROR_EVENT			45
 #define CMD_FLUSH_QUEUE			48
 #define CMD_TX_ACKNOWLEDGE		50
 #define CMD_CAN_ERROR_EVENT		51
@@ -258,6 +259,28 @@ struct usbcan_cmd_can_error_event {
 	__le16 time;
 } __packed;
 
+/* CMD_ERROR_EVENT error codes */
+#define KVASER_USB_LEAF_ERROR_EVENT_TX_QUEUE_FULL 0x8
+#define KVASER_USB_LEAF_ERROR_EVENT_PARAM 0x9
+
+struct leaf_cmd_error_event {
+	u8 tid;
+	u8 error_code;
+	__le16 timestamp[3];
+	__le16 padding;
+	__le16 info1;
+	__le16 info2;
+} __packed;
+
+struct usbcan_cmd_error_event {
+	u8 tid;
+	u8 error_code;
+	__le16 info1;
+	__le16 info2;
+	__le16 timestamp;
+	__le16 padding;
+} __packed;
+
 struct kvaser_cmd_ctrl_mode {
 	u8 tid;
 	u8 channel;
@@ -321,6 +344,7 @@ struct kvaser_cmd {
 			struct leaf_cmd_chip_state_event chip_state_event;
 			struct leaf_cmd_can_error_event can_error_event;
 			struct leaf_cmd_log_message log_message;
+			struct leaf_cmd_error_event error_event;
 			struct kvaser_cmd_cap_req cap_req;
 			struct kvaser_cmd_cap_res cap_res;
 		} __packed leaf;
@@ -330,6 +354,7 @@ struct kvaser_cmd {
 			struct usbcan_cmd_rx_can rx_can;
 			struct usbcan_cmd_chip_state_event chip_state_event;
 			struct usbcan_cmd_can_error_event can_error_event;
+			struct usbcan_cmd_error_event error_event;
 		} __packed usbcan;
 
 		struct kvaser_cmd_tx_can tx_can;
@@ -353,6 +378,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.can_error_event),
 	[CMD_GET_CAPABILITIES_RESP]	= kvaser_fsize(u.leaf.cap_res),
+	[CMD_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
 };
@@ -367,6 +393,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
+	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
 	/* ignored events: */
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
 };
@@ -1304,6 +1331,74 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 	netif_rx(skb);
 }
 
+static void kvaser_usb_leaf_error_event_parameter(const struct kvaser_usb *dev,
+						  const struct kvaser_cmd *cmd)
+{
+	u16 info1 = 0;
+
+	switch (dev->driver_info->family) {
+	case KVASER_LEAF:
+		info1 = le16_to_cpu(cmd->u.leaf.error_event.info1);
+		break;
+	case KVASER_USBCAN:
+		info1 = le16_to_cpu(cmd->u.usbcan.error_event.info1);
+		break;
+	}
+
+	/* info1 will contain the offending cmd_no */
+	switch (info1) {
+	case CMD_SET_CTRL_MODE:
+		dev_warn(&dev->intf->dev,
+			 "CMD_SET_CTRL_MODE error in parameter\n");
+		break;
+
+	case CMD_SET_BUS_PARAMS:
+		dev_warn(&dev->intf->dev,
+			 "CMD_SET_BUS_PARAMS error in parameter\n");
+		break;
+
+	default:
+		dev_warn(&dev->intf->dev,
+			 "Unhandled parameter error event cmd_no (%u)\n",
+			 info1);
+		break;
+	}
+}
+
+static void kvaser_usb_leaf_error_event(const struct kvaser_usb *dev,
+					const struct kvaser_cmd *cmd)
+{
+	u8 error_code = 0;
+
+	switch (dev->driver_info->family) {
+	case KVASER_LEAF:
+		error_code = cmd->u.leaf.error_event.error_code;
+		break;
+	case KVASER_USBCAN:
+		error_code = cmd->u.usbcan.error_event.error_code;
+		break;
+	}
+
+	switch (error_code) {
+	case KVASER_USB_LEAF_ERROR_EVENT_TX_QUEUE_FULL:
+		/* Received additional CAN message, when firmware TX queue is
+		 * already full. Something is wrong with the driver.
+		 * This should never happen!
+		 */
+		dev_err(&dev->intf->dev,
+			"Received error event TX_QUEUE_FULL\n");
+		break;
+	case KVASER_USB_LEAF_ERROR_EVENT_PARAM:
+		kvaser_usb_leaf_error_event_parameter(dev, cmd);
+		break;
+
+	default:
+		dev_warn(&dev->intf->dev,
+			 "Unhandled error event (%d)\n", error_code);
+		break;
+	}
+}
+
 static void kvaser_usb_leaf_start_chip_reply(const struct kvaser_usb *dev,
 					     const struct kvaser_cmd *cmd)
 {
@@ -1382,6 +1477,10 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 		kvaser_usb_leaf_tx_acknowledge(dev, cmd);
 		break;
 
+	case CMD_ERROR_EVENT:
+		kvaser_usb_leaf_error_event(dev, cmd);
+		break;
+
 	/* Ignored commands */
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
 		if (dev->driver_info->family != KVASER_USBCAN)
-- 
2.38.0

