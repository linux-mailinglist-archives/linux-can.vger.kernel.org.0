Return-Path: <linux-can+bounces-4174-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50235B121A3
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B6247B80FC
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0032EF287;
	Fri, 25 Jul 2025 16:13:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C432F005B
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460027; cv=none; b=DOo4gpQ2/syXs/QEUZZlbJlT1pCS1YUaTKvdr1omyEcS2BWz2gX7a1mvBXKvHUx/dTCgABSpQH4k3TQQBLHn+LFBe1/TuSCBSdrr5F9divGDDMIwxNE0Z9dlD5U2zzzcBxz5B0pvosaXdGn4ZNpy1CKpbMGqjLqcxT8EgPZ7FGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460027; c=relaxed/simple;
	bh=f3Q/xH4hA6jx92kW+wC6xOnFzfU4oJ/vIIwRWD3Rofk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fl+m3HyUlGMNYoSomRbc2wkKW4DzF+EJl/Ytru7di4mzTJZhnh0YZMCVZlqCwMVAzJ29OIJg4lOreg9DLrZcmUzNpY6gxYX7NOZwS/wQq5RTiHRuhK2l5SKmdz56gKk2ETa0kTC76KDafGyNzK/UiZKi8OzkQrsU3x+ND5LOYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3F-0006iq-5q
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3A-00AFbt-1J
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0F1BF4498D2
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F1EA744982C;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c4335483;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 17/27] can: kvaser_usb: Add support to control CAN LEDs on device
Date: Fri, 25 Jul 2025 18:05:27 +0200
Message-ID: <20250725161327.4165174-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

Add support to turn on/off CAN LEDs on device.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123452.41-2-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  9 ++++
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 53 ++++++++++++++++++
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 54 +++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index f6c77eca9f43..032dc1821f04 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -54,6 +54,11 @@ enum kvaser_usb_leaf_family {
 	KVASER_USBCAN,
 };
 
+enum kvaser_usb_led_state {
+	KVASER_USB_LED_ON = 0,
+	KVASER_USB_LED_OFF = 1,
+};
+
 #define KVASER_USB_HYDRA_MAX_CMD_LEN		128
 struct kvaser_usb_dev_card_data_hydra {
 	u8 channel_to_he[KVASER_USB_MAX_NET_DEVICES];
@@ -149,6 +154,7 @@ struct kvaser_usb_net_priv {
  * @dev_get_software_details:	get software details
  * @dev_get_card_info:		get card info
  * @dev_get_capabilities:	discover device capabilities
+ * @dev_set_led:		turn on/off device LED
  *
  * @dev_set_opt_mode:		set ctrlmod
  * @dev_start_chip:		start the CAN controller
@@ -176,6 +182,9 @@ struct kvaser_usb_dev_ops {
 	int (*dev_get_software_details)(struct kvaser_usb *dev);
 	int (*dev_get_card_info)(struct kvaser_usb *dev);
 	int (*dev_get_capabilities)(struct kvaser_usb *dev);
+	int (*dev_set_led)(struct kvaser_usb_net_priv *priv,
+			   enum kvaser_usb_led_state state,
+			   u16 duration_ms);
 	int (*dev_set_opt_mode)(const struct kvaser_usb_net_priv *priv);
 	int (*dev_start_chip)(struct kvaser_usb_net_priv *priv);
 	int (*dev_stop_chip)(struct kvaser_usb_net_priv *priv);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index 8e88b5917796..a4402b4845c6 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -12,6 +12,7 @@
  *    distinguish between ERROR_WARNING and ERROR_ACTIVE.
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
@@ -67,6 +68,8 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt;
 #define CMD_SET_BUSPARAMS_RESP			85
 #define CMD_GET_CAPABILITIES_REQ		95
 #define CMD_GET_CAPABILITIES_RESP		96
+#define CMD_LED_ACTION_REQ			101
+#define CMD_LED_ACTION_RESP			102
 #define CMD_RX_MESSAGE				106
 #define CMD_MAP_CHANNEL_REQ			200
 #define CMD_MAP_CHANNEL_RESP			201
@@ -217,6 +220,22 @@ struct kvaser_cmd_get_busparams_res {
 	u8 reserved[20];
 } __packed;
 
+/* The device has two LEDs per CAN channel
+ * The LSB of action field controls the state:
+ *   0 = ON
+ *   1 = OFF
+ * The remaining bits of action field is the LED index
+ */
+#define KVASER_USB_HYDRA_LED_IDX_MASK GENMASK(31, 1)
+#define KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX 3
+#define KVASER_USB_HYDRA_LEDS_PER_CHANNEL 2
+struct kvaser_cmd_led_action_req {
+	u8 action;
+	u8 padding;
+	__le16 duration_ms;
+	u8 reserved[24];
+} __packed;
+
 /* Ctrl modes */
 #define KVASER_USB_HYDRA_CTRLMODE_NORMAL	0x01
 #define KVASER_USB_HYDRA_CTRLMODE_LISTEN	0x02
@@ -299,6 +318,8 @@ struct kvaser_cmd {
 		struct kvaser_cmd_get_busparams_req get_busparams_req;
 		struct kvaser_cmd_get_busparams_res get_busparams_res;
 
+		struct kvaser_cmd_led_action_req led_action_req;
+
 		struct kvaser_cmd_chip_state_event chip_state_event;
 
 		struct kvaser_cmd_set_ctrlmode set_ctrlmode;
@@ -1390,6 +1411,7 @@ static void kvaser_usb_hydra_handle_cmd_std(const struct kvaser_usb *dev,
 	/* Ignored commands */
 	case CMD_SET_BUSPARAMS_RESP:
 	case CMD_SET_BUSPARAMS_FD_RESP:
+	case CMD_LED_ACTION_RESP:
 		break;
 
 	default:
@@ -1946,6 +1968,36 @@ static int kvaser_usb_hydra_get_capabilities(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_hydra_set_led(struct kvaser_usb_net_priv *priv,
+				    enum kvaser_usb_led_state state,
+				    u16 duration_ms)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_cmd *cmd;
+	size_t cmd_len;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->header.cmd_no = CMD_LED_ACTION_REQ;
+	cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+	kvaser_usb_hydra_set_cmd_dest_he(cmd, dev->card_data.hydra.sysdbg_he);
+	kvaser_usb_hydra_set_cmd_transid(cmd, kvaser_usb_hydra_get_next_transid(dev));
+
+	cmd->led_action_req.duration_ms = cpu_to_le16(duration_ms);
+	cmd->led_action_req.action = state |
+				     FIELD_PREP(KVASER_USB_HYDRA_LED_IDX_MASK,
+						KVASER_USB_HYDRA_LED_YELLOW_CH0_IDX +
+						KVASER_USB_HYDRA_LEDS_PER_CHANNEL * priv->channel);
+
+	ret = kvaser_usb_send_cmd(dev, cmd, cmd_len);
+	kfree(cmd);
+
+	return ret;
+}
+
 static int kvaser_usb_hydra_set_opt_mode(const struct kvaser_usb_net_priv *priv)
 {
 	struct kvaser_usb *dev = priv->dev;
@@ -2149,6 +2201,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 	.dev_get_software_details = kvaser_usb_hydra_get_software_details,
 	.dev_get_card_info = kvaser_usb_hydra_get_card_info,
 	.dev_get_capabilities = kvaser_usb_hydra_get_capabilities,
+	.dev_set_led = kvaser_usb_hydra_set_led,
 	.dev_set_opt_mode = kvaser_usb_hydra_set_opt_mode,
 	.dev_start_chip = kvaser_usb_hydra_start_chip,
 	.dev_stop_chip = kvaser_usb_hydra_stop_chip,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 6a45adcc45bd..a67855521ccc 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2015 Valeo S.A.
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
@@ -81,6 +82,8 @@
 #define CMD_FLUSH_QUEUE_REPLY		68
 #define CMD_GET_CAPABILITIES_REQ	95
 #define CMD_GET_CAPABILITIES_RESP	96
+#define CMD_LED_ACTION_REQ		101
+#define CMD_LED_ACTION_RESP		102
 
 #define CMD_LEAF_LOG_MESSAGE		106
 
@@ -173,6 +176,21 @@ struct kvaser_cmd_busparams {
 	struct kvaser_usb_busparams busparams;
 } __packed;
 
+/* The device has one LED per CAN channel
+ * The LSB of action field controls the state:
+ *   0 = ON
+ *   1 = OFF
+ * The remaining bits of action field is the LED index
+ */
+#define KVASER_USB_LEAF_LED_IDX_MASK GENMASK(31, 1)
+#define KVASER_USB_LEAF_LED_YELLOW_CH0_IDX 2
+struct kvaser_cmd_led_action_req {
+	u8 tid;
+	u8 action;
+	__le16 duration_ms;
+	u8 padding[24];
+} __packed;
+
 struct kvaser_cmd_tx_can {
 	u8 channel;
 	u8 tid;
@@ -359,6 +377,8 @@ struct kvaser_cmd {
 		struct kvaser_cmd_cardinfo cardinfo;
 		struct kvaser_cmd_busparams busparams;
 
+		struct kvaser_cmd_led_action_req led_action_req;
+
 		struct kvaser_cmd_rx_can_header rx_can_header;
 		struct kvaser_cmd_tx_acknowledge_header tx_acknowledge_header;
 
@@ -409,6 +429,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
+	[CMD_LED_ACTION_RESP]		= CMD_SIZE_ANY,
 };
 
 static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
@@ -423,6 +444,8 @@ static const u8 kvaser_usb_leaf_cmd_sizes_usbcan[] = {
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.usbcan.can_error_event),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.usbcan.error_event),
 	[CMD_USBCAN_CLOCK_OVERFLOW_EVENT] = kvaser_fsize(u.usbcan.clk_overflow_event),
+	/* ignored events: */
+	[CMD_LED_ACTION_RESP]		= CMD_SIZE_ANY,
 };
 
 /* Summary of a kvaser error event, for a unified Leaf/Usbcan error
@@ -924,6 +947,34 @@ static int kvaser_usb_leaf_get_capabilities_leaf(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_leaf_set_led(struct kvaser_usb_net_priv *priv,
+				   enum kvaser_usb_led_state state,
+				   u16 duration_ms)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_cmd *cmd;
+	int ret;
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->id = CMD_LED_ACTION_REQ;
+	cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_led_action_req);
+	cmd->u.led_action_req.tid = 0xff;
+
+	cmd->u.led_action_req.duration_ms = cpu_to_le16(duration_ms);
+	cmd->u.led_action_req.action = state |
+				       FIELD_PREP(KVASER_USB_LEAF_LED_IDX_MASK,
+						  KVASER_USB_LEAF_LED_YELLOW_CH0_IDX +
+						  priv->channel);
+
+	ret = kvaser_usb_send_cmd(dev, cmd, cmd->len);
+	kfree(cmd);
+
+	return ret;
+}
+
 static int kvaser_usb_leaf_get_capabilities(struct kvaser_usb *dev)
 {
 	int err = 0;
@@ -1638,6 +1689,8 @@ static void kvaser_usb_leaf_handle_command(struct kvaser_usb *dev,
 		if (dev->driver_info->family != KVASER_LEAF)
 			goto warn;
 		break;
+	case CMD_LED_ACTION_RESP:
+		break;
 
 	default:
 warn:		dev_warn(&dev->intf->dev, "Unhandled command (%d)\n", cmd->id);
@@ -1927,6 +1980,7 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_get_software_details = NULL,
 	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
 	.dev_get_capabilities = kvaser_usb_leaf_get_capabilities,
+	.dev_set_led = kvaser_usb_leaf_set_led,
 	.dev_set_opt_mode = kvaser_usb_leaf_set_opt_mode,
 	.dev_start_chip = kvaser_usb_leaf_start_chip,
 	.dev_stop_chip = kvaser_usb_leaf_stop_chip,
-- 
2.47.2



