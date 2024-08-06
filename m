Return-Path: <linux-can+bounces-1143-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12A948A87
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7D91F25AC7
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0561BE841;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6F1BD015
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930469; cv=none; b=hDz8QVkIzD5Xl3vx0W7qwTBFG3WU68ggTR3WK2j2egDDi+dUFl4bNEtZp9YDkOiZPWuFqyg8jD9my+LaFU56r/YaFYJAFgvf/PKFutmrlFWmOePZ+N6NzwXIqtWIQyT3mMWAIF0Wse4Khpn+0BLmoMBV9IQMf/B1+3//vaxOskU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930469; c=relaxed/simple;
	bh=QF6v3foMJxHygYArPtDp7P9AWPK3YC1rTcILqo0vV2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2eVAbnHPHzqjLF9Ib0rH0asu+J/TFL1xW3TVtqStQLQIJKq3nMRcPOmqwEJkWoOXRpnTzC7jYR27VG7eD5nIs8V+DHgxn6FDQbANIShUJusyZuq2gNayRMG0Y7UPUHySYJS2Qn1Q2IzmY+idBV1lOAEjCjBL0d6ROuxqKjBRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv2-0004A9-JR
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:44 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuy-004two-7b
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E6CDA317A28
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E21E9317992;
	Tue, 06 Aug 2024 07:47:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id caf83b2f;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/20] can: kvaser_usb: leaf: Store MSB of timestamp
Date: Tue,  6 Aug 2024 09:42:07 +0200
Message-ID: <20240806074731.1905378-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Jimmy Assarsson <extja@kvaser.com>

Store MSB of timestamp, provided from the device via the clock overflow
event, for usbcan devices (M16C).

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-12-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h      |  1 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 4256a0caae20..591f707d2895 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -70,6 +70,7 @@ struct kvaser_usb_dev_card_data {
 	u32 ctrlmode_supported;
 	u32 capabilities;
 	struct kvaser_usb_dev_card_data_hydra hydra;
+	u32 usbcan_timestamp_msb;
 };
 
 /* Context for an outstanding, not yet ACKed, transmission */
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 2c0313c8f63e..465707174f2e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -119,6 +119,9 @@
 /* Extended CAN identifier flag */
 #define KVASER_EXTENDED_FRAME		BIT(31)
 
+/* USBCanII timestamp */
+#define KVASER_USB_USBCAN_CLK_OVERFLOW_MASK GENMASK(31, 16)
+
 struct kvaser_cmd_simple {
 	u8 tid;
 	u8 channel;
@@ -418,7 +421,6 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.usbcan.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
-	/* ignored events: */
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
 };
 
@@ -1573,7 +1575,7 @@ static void kvaser_usb_leaf_get_busparams_reply(const struct kvaser_usb *dev,
 	complete(&priv->get_busparams_comp);
 }
 
-static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
+static void kvaser_usb_leaf_handle_command(struct kvaser_usb *dev,
 					   const struct kvaser_cmd *cmd)
 {
 	if (kvaser_usb_leaf_verify_size(dev, cmd) < 0)
@@ -1619,12 +1621,15 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 		kvaser_usb_leaf_get_busparams_reply(dev, cmd);
 		break;
 
-	/* Ignored commands */
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
 		if (dev->driver_info->family != KVASER_USBCAN)
 			goto warn;
+		dev->card_data.usbcan_timestamp_msb =
+					le32_to_cpu(cmd->u.usbcan.clk_overflow_event.time) &
+					KVASER_USB_USBCAN_CLK_OVERFLOW_MASK;
 		break;
 
+	/* Ignored commands */
 	case CMD_FLUSH_QUEUE_REPLY:
 		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
-- 
2.43.0



