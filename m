Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31605FA3AF
	for <lists+linux-can@lfdr.de>; Mon, 10 Oct 2022 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJJSxI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Oct 2022 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJJSxH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Oct 2022 14:53:07 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C8786DF
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bs14so1352178ljb.9
        for <linux-can@vger.kernel.org>; Mon, 10 Oct 2022 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OKmAMv/q7brZ97pAvk+p9hBXTANrc+y2bysH4nFRy8=;
        b=AuAu4PtFiS+5hJarCod+tuLAsQ/C7jQAWi57CaFpS7dU9+3w0BvHcl1N87r3PfvZtc
         nLsLC81G/TjYJap2nvVUndYj691w8rMPMoqUyANHvvAnYdi2a60ZaOZZY3TEQ+hnV+vx
         fSD2xDkvKDZC7EpPetwC1eQUcFA6Qer1BtHZ3cDu0gsQs2Rak306QRT6YtXJcary88zP
         FEZSZ5h0JIxT4Gf1tXjSCIgeGtjZZAmz+Fq/sWSfl+rFtkhAJGKFlv8VvXMOr9qC6Osh
         RnnXnC9+hPvb/c0YEUs1qmP1yLoLpykyM77wGq8utsd/zg2BI1hEdFo06qAOoaLw6Gih
         jpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OKmAMv/q7brZ97pAvk+p9hBXTANrc+y2bysH4nFRy8=;
        b=sHI9hA4VmlDXlw7f2zL63SrsjfxgKBV2tf9mVi09uyeLzLiI3GNt7JknCzFvaxKQpR
         TECS0tbyJzW5gsN4cZtF5lB3R1XYTSRHtPBq62BxMsM03Og4LQxJ82eRKY9+rS1TUvI3
         mJELQd25MbSe8F1Qy4EfYj5GCtKVLyWK1c+ulVZz6LpOyc1QAfIm8H3UrwtFyUgTgQ8i
         Ly/ir+2CBLiyxvChgqwBGPSMvM75Lj15PsucZ9paNwerRFqeegLEjzJp6tk9ylGWjtHd
         B04DgKamFX7Ep1NXHSJz8l2NPH1tgbNbFdJxTQ0Wf9DP+Os8ZfqJFByDU18ESn5aVkur
         eQvg==
X-Gm-Message-State: ACrzQf12WD42g/znhein7U9okOYcA2U7Pf8ww/Xi+76ZWt9NJr4jYYtg
        IKqv9q5LLyewOd0pT5VCfLB4y4kw9Z8D9Q==
X-Google-Smtp-Source: AMsMyM4CP0RkUVoNEUlAErIVgVfbf6+Sch9TXp7xwIwvficuUXYH0jfYFy0BkYSRkomjtoKZCGRx+w==
X-Received: by 2002:a05:651c:221f:b0:26c:6872:6804 with SMTP id y31-20020a05651c221f00b0026c68726804mr7933334ljq.390.1665427984880;
        Mon, 10 Oct 2022 11:53:04 -0700 (PDT)
Received: from archyz.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512070400b004a2386b8ce6sm1517769lfs.207.2022.10.10.11.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:53:04 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH can-next v5 03/11] can: kvaser_usb: kvaser_usb_leaf: Rename {leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event
Date:   Mon, 10 Oct 2022 20:52:29 +0200
Message-Id: <20221010185237.319219-4-extja@kvaser.com>
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

Prepare for handling CMD_ERROR_EVENT. Rename struct
{leaf,usbcan}_cmd_error_event to {leaf,usbcan}_cmd_can_error_event.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
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
  - New in v2.

 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 33ff62cd1729..a1d4ac8d4a08 100644
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
2.38.0

