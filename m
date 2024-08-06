Return-Path: <linux-can+bounces-1139-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671A948A7F
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C081C233D8
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7016A1BD4FF;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CED1BBBF5
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930469; cv=none; b=Lvf4LDvUjvi9BcpiqIINcTptlkOrejZLw6fX5pNCByYnBRzZp5aMFejYvSwBcKqJ74Ohbi9OYv5Q2KcqlfBXshALXVAwo7GvCSHZE73s/5yNM4K2g3gfDX17X968IMWQJTQlR/N0G2vgb4ExCGjiAEXuFliyxSMFud/Rd4nPh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930469; c=relaxed/simple;
	bh=jyr7dOEveaAgWfENt55205BqYC5kndAJG8GVppki218=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3NFxxwwARZwQL48otGEnxwNmCiHPnDDK/FbG2kjuqeNZEIJZyqaVvrJ5SZRHkxF9hafmwygYrHsNDByVc6Glm/Lzv5lL0qCStZFgw++HekkswNFmG07nJegqBPPwIQqWey+jroaFPQnSgX2Fy8teAuuLj32Zjk6s4nhtSQrtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEv1-00048V-6v
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuw-004tul-Ng
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 39E89317A13
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 08A0F317997;
	Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e1042784;
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
Subject: [PATCH net-next 17/20] can: kvaser_usb: leaf: Add hardware timestamp support to usbcan devices
Date: Tue,  6 Aug 2024 09:42:08 +0200
Message-ID: <20240806074731.1905378-18-mkl@pengutronix.de>
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

Add hardware timestamp support for all usbcan based devices (M16C).
The usbcan firmware is slightly different compared to the other Kvaser USB
interfaces:
  - The timestamp is provided by a 32-bit counter, with 10us resolution.
    Hence, the hardware timestamp will wrap after less than 12 hours.
  - Each Rx CAN or Tx ACK command only contains the 16-bits LSB of the
    timestamp counter.
  - The 16-bits MSB are sent in an asynchronous event (command), if any
    change occurred in the MSB since the last event.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20240701154936.92633-13-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  3 ++-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index b5d762d38d5d..576ddf932f47 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -100,7 +100,8 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_usbcan = {
 	.quirks = KVASER_USB_QUIRK_HAS_TXRX_ERRORS |
-		  KVASER_USB_QUIRK_HAS_SILENT_MODE,
+		  KVASER_USB_QUIRK_HAS_SILENT_MODE |
+		  KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.family = KVASER_USBCAN,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 465707174f2e..6b9122ab1464 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -121,6 +121,7 @@
 
 /* USBCanII timestamp */
 #define KVASER_USB_USBCAN_CLK_OVERFLOW_MASK GENMASK(31, 16)
+#define KVASER_USB_USBCAN_TIMESTAMP_FACTOR 10
 
 struct kvaser_cmd_simple {
 	u8 tid;
@@ -536,6 +537,15 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_imx_dev_cfg_32mhz = {
 	.bittiming_const = &kvaser_usb_flexc_bittiming_const,
 };
 
+static inline ktime_t kvaser_usb_usbcan_timestamp_to_ktime(const struct kvaser_usb *dev,
+							   __le16 timestamp)
+{
+	u64 ticks = le16_to_cpu(timestamp) |
+		    dev->card_data.usbcan_timestamp_msb;
+
+	return kvaser_usb_ticks_to_ktime(dev->cfg, ticks * KVASER_USB_USBCAN_TIMESTAMP_FACTOR);
+}
+
 static int kvaser_usb_leaf_verify_size(const struct kvaser_usb *dev,
 				       const struct kvaser_cmd *cmd)
 {
@@ -978,6 +988,7 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 		hwtstamp = kvaser_usb_timestamp48_to_ktime(dev->cfg, cmd->u.leaf.tx_ack.time);
 		break;
 	case KVASER_USBCAN:
+		hwtstamp = kvaser_usb_usbcan_timestamp_to_ktime(dev, cmd->u.usbcan.tx_ack.time);
 		break;
 	}
 
@@ -1398,6 +1409,7 @@ static void kvaser_usb_leaf_rx_can_msg(const struct kvaser_usb *dev,
 		break;
 	case KVASER_USBCAN:
 		rx_data = cmd->u.usbcan.rx_can.data;
+		hwtstamp = kvaser_usb_usbcan_timestamp_to_ktime(dev, cmd->u.usbcan.rx_can.time);
 		break;
 	}
 
-- 
2.43.0



