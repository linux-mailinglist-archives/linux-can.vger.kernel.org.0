Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768CD56B902
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbiGHL5j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiGHL5i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F79A6B7
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e20so7202435lfq.11
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrbRIpAw7WRaypvOkMEFWKpoiSksexO55+JwGYVkqTI=;
        b=vzQk12BJq0pTqdRDqZ9YBvVfDEHk7/hVr9Lr4egKz8+WW9oNQYpSzF6t96ezvxJO+6
         y9MTq5pzGOovhArl0ai91bi6eQPg81IWY+kG5kCyQI9o3eJRaYLA44q0gdD7YcwaiU6c
         2cDcBye/3NXaC8URiQ1RDnrwswRTb3vnW7S80TpI4H9SmUWvgZzeivF0EJjQ82bd5LrB
         rciPBvdkynSGCGEkUT5O7MrqcDDFCJ4HAU3fmMmS4Qn4tIzBogN4mbG0x4bHk6nVfAX8
         +OrVEII8CD2nlQt6kBx607p9vBx6ft1KH1f+YXH41WRas+Q8nl3nEruuXIxfRtTcLhRe
         GvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrbRIpAw7WRaypvOkMEFWKpoiSksexO55+JwGYVkqTI=;
        b=EJZThR/NtU9IiiLITZ/MyxV3yJleti6eE6ArhnKMxBvG0p1Rnhh27PdAPgdsfjak9m
         CK660jUa6gUhuWQcAhI3HX/cGoo0Fkiw3kbZflongfhGmt0BjFPh6EEWvLfVO53LAICN
         gWXY4WzI/kx54qIzycyYSEcDaR6fKTXZUKFc9Qj9yaj1nIRIS3ILTLxPqN5IGHgrTLwj
         wYjz3cKY9t+2g83wmyWC52yyxakNHFV5srM5Cdv46PnxvUs1chWubOvCVh/BaXzAblZl
         +C4n2JRIfT1nnl1Jxvd76xifgMuVczwdaq8gB11YZ9kYKwAO/SrTsrRWXEUX6xbqop2c
         WIJA==
X-Gm-Message-State: AJIora9E4tYnuTvdroDinkBLTgfa6c7m8Ran5nRs1ZYcd8NCYqiP+8Sy
        c6yAt0lEUN3sJplFX44wD00GUnfFeeN8/g==
X-Google-Smtp-Source: AGRyM1u+8sLOMJEAfmoRun53GO1rkONURiqvm8PgZmYddrWvogiZQVUIIjNtgk8LKzK78XWhp/KrIw==
X-Received: by 2002:a05:6512:3194:b0:47f:a447:4f24 with SMTP id i20-20020a056512319400b0047fa4474f24mr2077819lfe.571.1657281455747;
        Fri, 08 Jul 2022 04:57:35 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:35 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 05/15] can: kvaser_usb: kvaser_usb_leaf: Rename {leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event
Date:   Fri,  8 Jul 2022 13:56:59 +0200
Message-Id: <20220708115709.232815-6-extja@kvaser.com>
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

Prepare for handling CMD_ERROR_EVENT. Rename struct
{leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v2:
  - New in v2.

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 838e072d5d62..3da898c8aede 100644
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
@@ -1129,11 +1129,11 @@ static void kvaser_usb_leaf_usbcan_rx_error(const struct kvaser_usb *dev,
 
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
@@ -1141,13 +1141,13 @@ static void kvaser_usb_leaf_usbcan_rx_error(const struct kvaser_usb *dev,
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
@@ -1164,11 +1164,11 @@ static void kvaser_usb_leaf_leaf_rx_error(const struct kvaser_usb *dev,
 
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
2.36.1

