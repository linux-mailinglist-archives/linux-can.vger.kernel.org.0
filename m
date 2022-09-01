Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815B5A96CF
	for <lists+linux-can@lfdr.de>; Thu,  1 Sep 2022 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiIAM3g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Sep 2022 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiIAM3P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Sep 2022 08:29:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3595612AE2F
        for <linux-can@vger.kernel.org>; Thu,  1 Sep 2022 05:28:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so24146102lfu.5
        for <linux-can@vger.kernel.org>; Thu, 01 Sep 2022 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=oIdLjRM80HxDAcZwXRHYVv7Ld3ThpD0DswHneMsrVPo=;
        b=bk7TqpMQ0l40HMZLV/TEmwytaUDpYiXfX6tXYJA3tlxfJzHXN3tobXcqNdHggfHy1j
         hnJZKvigl4ZpUrtewwMQRF7ETnPRwux1JzTpiRIWadcnKmbmp0MG3hRBhAQSDdy6LkJp
         oJUF0flqRpEiIfGo/8u848j9uyOo0sDXtl+Jw+5ClaSG30PsWUroNlV5o59+mIAPeLJN
         +eyj4R6A8M15E3KWGBhSfMb9epvoqMhDGsawLCIV8q2DVcABTjNBoBVSuBMFaP2cH9Ml
         iELrsZ8jV06gbbRRrGk+H0smruJ101/wzIpDGy6RQHkwbkXtEpGGPF4H7PSWUgPQZoP5
         nzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oIdLjRM80HxDAcZwXRHYVv7Ld3ThpD0DswHneMsrVPo=;
        b=w4NHZyvWsR2/ONIT3g9xO/pPuD+AmQaRKr3w4ywyZXRA+OTIZP1QluSaXozUSmyelL
         +7vsMF00TTHt4geGRLXSVp+P0ATTx1fBKEVv+4LPc4bmcFiFD+6I/Dc/BfKfsgh0LOe0
         g8eGv6fr7pOSAAEUEZdkMWonRBRAvNgS4Dc/2NnQl97Fpfo4u7QgTAyqb+yxlKMsMkBM
         4RkC6wzLexo+lbxcvVdaItfEoxQ4DgODRo276bBY4nLB+hli1WCOnBcuQ2A6P7CoZ+Dn
         wEjy3B4MKJTi++1PYXY6OSEn5RhQkdplo93kJX6h1FX6oCDRH7dC5nMtGaDrBeYfH9EM
         fEiw==
X-Gm-Message-State: ACgBeo3IJaDCfNjyTq6Ee1shqoLT+lZm7ntn06gImJ4SDsuqw7b+WJpi
        cT2Si/nYggPNCdF+Jz0dljm+YCcAWZUBdWfK
X-Google-Smtp-Source: AA6agR7OiRQ7UwGHqQxTZ7WPh9frMX+ossUh7SP9TYRaDhKRZCyic2CAskKo1JdeA9KyV+4HZ8y66A==
X-Received: by 2002:a05:6512:a8c:b0:491:d4b8:47c9 with SMTP id m12-20020a0565120a8c00b00491d4b847c9mr10079509lfu.258.1662035305691;
        Thu, 01 Sep 2022 05:28:25 -0700 (PDT)
Received: from fb10a0c5d590.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512202c00b00492c2394ea5sm125935lfs.165.2022.09.01.05.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:28:25 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v3 06/15] can: kvaser_usb: kvaser_usb_leaf: Handle CMD_ERROR_EVENT
Date:   Thu,  1 Sep 2022 14:27:20 +0200
Message-Id: <20220901122729.271-7-extja@kvaser.com>
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

The device will send an error event command, to indicate certain errors.
This indicates a misbehaving driver, and should never occur.

Cc: stable@vger.kernel.org
Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Co-developed-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
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
index 24c474e9d579..cd5b67f48534 100644
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
2.37.3

