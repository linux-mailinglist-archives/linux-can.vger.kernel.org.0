Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F760DD5B
	for <lists+linux-can@lfdr.de>; Wed, 26 Oct 2022 10:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiJZIlm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 26 Oct 2022 04:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiJZIk4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 26 Oct 2022 04:40:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5993E43618
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 01:40:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1onbxW-0006rd-VP
        for linux-can@vger.kernel.org; Wed, 26 Oct 2022 10:40:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C159C10A113
        for <linux-can@vger.kernel.org>; Wed, 26 Oct 2022 08:40:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D514710A0D1;
        Wed, 26 Oct 2022 08:40:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a1766996;
        Wed, 26 Oct 2022 08:40:09 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Anssi Hannula <anssi.hannula@bitwise.fi>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/29] can: kvaser_usb: kvaser_usb_leaf: Rename {leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event
Date:   Wed, 26 Oct 2022 10:39:56 +0200
Message-Id: <20221026084007.1583333-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221026084007.1583333-1-mkl@pengutronix.de>
References: <20221026084007.1583333-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Prepare for handling CMD_ERROR_EVENT. Rename struct
{leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/all/20221010185237.319219-4-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index c87b13dc1048..f34ca9a850aa 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -234,7 +234,7 @@ struct kvaser_cmd_tx_acknowledge_header {
 	u8 tid;
 } __packed;
 
-struct leaf_cmd_error_event {
+struct leaf_cmd_can_error_event {
 	u8 tid;
 	u8 flags;
 	__le16 time[3];
@@ -246,7 +246,7 @@ struct leaf_cmd_error_event {
 	u8 error_factor;
 } __packed;
 
-struct usbcan_cmd_error_event {
+struct usbcan_cmd_can_error_event {
 	u8 tid;
 	u8 padding;
 	u8 tx_errors_count_ch0;
@@ -319,7 +319,7 @@ struct kvaser_cmd {
 			struct leaf_cmd_softinfo softinfo;
 			struct leaf_cmd_rx_can rx_can;
 			struct leaf_cmd_chip_state_event chip_state_event;
-			struct leaf_cmd_error_event error_event;
+			struct leaf_cmd_can_error_event can_error_event;
 			struct leaf_cmd_log_message log_message;
 			struct kvaser_cmd_cap_req cap_req;
 			struct kvaser_cmd_cap_res cap_res;
@@ -329,7 +329,7 @@ struct kvaser_cmd {
 			struct usbcan_cmd_softinfo softinfo;
 			struct usbcan_cmd_rx_can rx_can;
 			struct usbcan_cmd_chip_state_event chip_state_event;
-			struct usbcan_cmd_error_event error_event;
+			struct usbcan_cmd_can_error_event can_error_event;
 		} __packed usbcan;
 
 		struct kvaser_cmd_tx_can tx_can;
@@ -351,7 +351,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.leaf.rx_can),
 	[CMD_LEAF_LOG_MESSAGE]		= kvaser_fsize(u.leaf.log_message),
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
-	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
+	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.can_error_event),
 	[CMD_GET_CAPABILITIES_RESP]	= kvaser_fsize(u.leaf.cap_res),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
@@ -366,7 +366,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_RX_STD_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_RX_EXT_MESSAGE]		= kvaser_fsize(u.usbcan.rx_can),
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
-	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
+	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	/* ignored events: */
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = CMD_SIZE_ANY,
 };
@@ -1132,11 +1132,11 @@ static void kvaser_usb_leaf_usbcan_rx_error(const struct kvaser_usb *dev,
 
 	case CMD_CAN_ERROR_EVENT:
 		es.channel = 0;
-		es.status = cmd->u.usbcan.error_event.status_ch0;
-		es.txerr = cmd->u.usbcan.error_event.tx_errors_count_ch0;
-		es.rxerr = cmd->u.usbcan.error_event.rx_errors_count_ch0;
+		es.status = cmd->u.usbcan.can_error_event.status_ch0;
+		es.txerr = cmd->u.usbcan.can_error_event.tx_errors_count_ch0;
+		es.rxerr = cmd->u.usbcan.can_error_event.rx_errors_count_ch0;
 		es.usbcan.other_ch_status =
-			cmd->u.usbcan.error_event.status_ch1;
+			cmd->u.usbcan.can_error_event.status_ch1;
 		kvaser_usb_leaf_usbcan_conditionally_rx_error(dev, &es);
 
 		/* The USBCAN firmware supports up to 2 channels.
@@ -1144,13 +1144,13 @@ static void kvaser_usb_leaf_usbcan_rx_error(const struct kvaser_usb *dev,
 		 */
 		if (dev->nchannels == MAX_USBCAN_NET_DEVICES) {
 			es.channel = 1;
-			es.status = cmd->u.usbcan.error_event.status_ch1;
+			es.status = cmd->u.usbcan.can_error_event.status_ch1;
 			es.txerr =
-				cmd->u.usbcan.error_event.tx_errors_count_ch1;
+				cmd->u.usbcan.can_error_event.tx_errors_count_ch1;
 			es.rxerr =
-				cmd->u.usbcan.error_event.rx_errors_count_ch1;
+				cmd->u.usbcan.can_error_event.rx_errors_count_ch1;
 			es.usbcan.other_ch_status =
-				cmd->u.usbcan.error_event.status_ch0;
+				cmd->u.usbcan.can_error_event.status_ch0;
 			kvaser_usb_leaf_usbcan_conditionally_rx_error(dev, &es);
 		}
 		break;
@@ -1167,11 +1167,11 @@ static void kvaser_usb_leaf_leaf_rx_error(const struct kvaser_usb *dev,
 
 	switch (cmd->id) {
 	case CMD_CAN_ERROR_EVENT:
-		es.channel = cmd->u.leaf.error_event.channel;
-		es.status = cmd->u.leaf.error_event.status;
-		es.txerr = cmd->u.leaf.error_event.tx_errors_count;
-		es.rxerr = cmd->u.leaf.error_event.rx_errors_count;
-		es.leaf.error_factor = cmd->u.leaf.error_event.error_factor;
+		es.channel = cmd->u.leaf.can_error_event.channel;
+		es.status = cmd->u.leaf.can_error_event.status;
+		es.txerr = cmd->u.leaf.can_error_event.tx_errors_count;
+		es.rxerr = cmd->u.leaf.can_error_event.rx_errors_count;
+		es.leaf.error_factor = cmd->u.leaf.can_error_event.error_factor;
 		break;
 	case CMD_LEAF_LOG_MESSAGE:
 		es.channel = cmd->u.leaf.log_message.channel;
-- 
2.35.1


