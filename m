Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089E56B919
	for <lists+linux-can@lfdr.de>; Fri,  8 Jul 2022 14:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiGHL5w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Jul 2022 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiGHL5v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Jul 2022 07:57:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5109B184
        for <linux-can@vger.kernel.org>; Fri,  8 Jul 2022 04:57:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 19so4789122ljz.4
        for <linux-can@vger.kernel.org>; Fri, 08 Jul 2022 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21v4YTo5ZTCKJF4jo1GXWOeyCoOpDVQm8wDzVwfwuMw=;
        b=TOW1PKxmfXZstDDdAPMwlFLXzwP/8U3dozVf3+E/hqTKYcLenGEMiamuDix60bXlqF
         yihTA7p184arR+lzMU5aCf7ref396e+rUcUXX/Vd9sljEpqRh5eV63ec4AFAAxTvGrgW
         BRvZJCMAO8mlfr9cSFmPlmVVF/GPRYd2g8Mxo4om6oL1K7iYHtmXBP3eG7vWBJK4aHL/
         hRcZPX1AAUdJ6BvfYTXB7ybye7FZuhyARvti4woW1tMKbAjr+cr80lDkBFOm21dYhfXi
         fPVblekAfRY/Nu99TWGJV87FC3cCh0vRu0+zFGNpkeHmDOCPIQ3nCNMUanLOT+T+doa8
         1FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21v4YTo5ZTCKJF4jo1GXWOeyCoOpDVQm8wDzVwfwuMw=;
        b=CCo33UfpHt+nhr9iJJVy3UR71Cx0bAgkNS1h3I+n7z63hPuiYV4r4LtrujnDMD7yAx
         DTrCgU87PJ37NA5+bIrJi+s2bw+wddYy34qKhKG836GEjI4W8qdmKH/f143rYAOz4I1b
         W6RgESHPM4UFlnK9CuSP/iRyvOivh0R50nO3YQx5q3df8NQeQcxIyFpctAZYGEgyGhH3
         D8FY7G0CajTj6K9AgrAwch0rudAhDjUsTznL4WCZh13DPvIZaGg2V3JL3zIZw5x2yXvU
         5XfpQQ2KtwVcYqQ0+ac8jha9n1txldeHL+wDb50tCuhOSDsxTl3Y2sNocqe8ghiVZBVL
         gACg==
X-Gm-Message-State: AJIora+k3d84VZx75mFtNKaMpuP9ny3IElSTDF1hw9BU3LC0dn/UA3ez
        gY4aZpBS2i//J6tk7hZjRubElIirvoz9MQ==
X-Google-Smtp-Source: AGRyM1uzrZOlWiQz7oMZloEQKp3IhGg4A8eW5p/IHPk/MpaAdbAD5+Jb0kezw2A6+pVI9V4s0/EkKA==
X-Received: by 2002:a05:651c:1a0c:b0:25b:f5f6:d42 with SMTP id by12-20020a05651c1a0c00b0025bf5f60d42mr1761686ljb.49.1657281467318;
        Fri, 08 Jul 2022 04:57:47 -0700 (PDT)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e9ec7000000b0025a724f2935sm7336199ljk.137.2022.07.08.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 04:57:47 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v2 10/15] can: kvaser_usb_leaf: Fix improved state not being reported
Date:   Fri,  8 Jul 2022 13:57:04 +0200
Message-Id: <20220708115709.232815-11-extja@kvaser.com>
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

From: Anssi Hannula <anssi.hannula@bitwise.fi>

The tested 0bfd:0017 Kvaser Memorator Professional HS/HS FW 2.0.50 and
0bfd:0124 Kvaser Mini PCI Express 2xHS FW 4.18.778 do not seem to send
any unsolicited events when error counters decrease or when the device
transitions from ERROR_PASSIVE to ERROR_ACTIVE (or WARNING).

This causes the interface to e.g. indefinitely stay in the ERROR_PASSIVE
state.

Fix that by asking for chip state (inc. counters) event every 0.5 secs
when error counters are non-zero.

Since there are non-error-counter devices, also always poll in
ERROR_PASSIVE even if the counters show zero.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
Changes in v2:
  - Rebased on b3b6df2c56d8 ("can: kvaser_usb: kvaser_usb_leaf: fix bittiming limits")
  - Rephrase commit message regarding non-error-counter devices.

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  7 +++
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 19 +++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 58 +++++++++++++++++++
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index d018cb5adf83..2d7430477319 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -103,6 +103,9 @@ struct kvaser_usb_net_priv {
 	struct can_priv can;
 	struct can_berr_counter bec;
 
+	/* subdriver-specific data */
+	void *sub_priv;
+
 	struct kvaser_usb *dev;
 	struct net_device *netdev;
 	int channel;
@@ -124,6 +127,8 @@ struct kvaser_usb_net_priv {
  *
  * @dev_setup_endpoints:	setup USB in and out endpoints
  * @dev_init_card:		initialize card
+ * @dev_init_channel:		initialize channel
+ * @dev_remove_channel:		uninitialize channel
  * @dev_get_software_info:	get software info
  * @dev_get_software_details:	get software details
  * @dev_get_card_info:		get card info
@@ -145,6 +150,8 @@ struct kvaser_usb_dev_ops {
 				    struct can_berr_counter *bec);
 	int (*dev_setup_endpoints)(struct kvaser_usb *dev);
 	int (*dev_init_card)(struct kvaser_usb *dev);
+	int (*dev_init_channel)(struct kvaser_usb_net_priv *priv);
+	void (*dev_remove_channel)(struct kvaser_usb_net_priv *priv);
 	int (*dev_get_software_info)(struct kvaser_usb *dev);
 	int (*dev_get_software_details)(struct kvaser_usb *dev);
 	int (*dev_get_card_info)(struct kvaser_usb *dev);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 17d4bbcee831..6e218105f986 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -652,6 +652,7 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
 
 static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 {
+	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
 	int i;
 
 	for (i = 0; i < dev->nchannels; i++) {
@@ -667,6 +668,9 @@ static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 		if (!dev->nets[i])
 			continue;
 
+		if (ops->dev_remove_channel)
+			ops->dev_remove_channel(dev->nets[i]);
+
 		free_candev(dev->nets[i]->netdev);
 	}
 }
@@ -734,17 +738,26 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	dev->nets[channel] = priv;
 
+	if (ops->dev_init_channel) {
+		err = ops->dev_init_channel(priv);
+		if (err)
+			goto err;
+	}
+
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&dev->intf->dev, "Failed to register CAN device\n");
-		free_candev(netdev);
-		dev->nets[channel] = NULL;
-		return err;
+		goto err;
 	}
 
 	netdev_dbg(netdev, "device registered\n");
 
 	return 0;
+
+err:
+	free_candev(netdev);
+	dev->nets[channel] = NULL;
+	return err;
 }
 
 static int kvaser_usb_probe(struct usb_interface *intf,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 22deb74c7d42..03f6b84c50ad 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/units.h>
 #include <linux/usb.h>
+#include <linux/workqueue.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -56,6 +57,7 @@
 #define CMD_RX_EXT_MESSAGE		14
 #define CMD_TX_EXT_MESSAGE		15
 #define CMD_SET_BUS_PARAMS		16
+#define CMD_GET_CHIP_STATE		19
 #define CMD_CHIP_STATE_EVENT		20
 #define CMD_SET_CTRL_MODE		21
 #define CMD_RESET_CHIP			24
@@ -421,6 +423,12 @@ struct kvaser_usb_err_summary {
 	};
 };
 
+struct kvaser_usb_net_leaf_priv {
+	struct kvaser_usb_net_priv *net;
+
+	struct delayed_work chip_state_req_work;
+};
+
 static const struct can_bittiming_const kvaser_usb_leaf_m16c_bittiming_const = {
 	.name = "kvaser_usb_ucii",
 	.tseg1_min = 4,
@@ -943,6 +951,16 @@ static int kvaser_usb_leaf_simple_cmd_async(struct kvaser_usb_net_priv *priv,
 	return err;
 }
 
+static void kvaser_usb_leaf_chip_state_req_work(struct work_struct *work)
+{
+	struct kvaser_usb_net_leaf_priv *leaf =
+		container_of(work, struct kvaser_usb_net_leaf_priv,
+			     chip_state_req_work.work);
+	struct kvaser_usb_net_priv *priv = leaf->net;
+
+	kvaser_usb_leaf_simple_cmd_async(priv, CMD_GET_CHIP_STATE);
+}
+
 static void
 kvaser_usb_leaf_rx_error_update_can_state(struct kvaser_usb_net_priv *priv,
 					const struct kvaser_usb_err_summary *es,
@@ -1014,6 +1032,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	struct sk_buff *skb;
 	struct net_device_stats *stats;
 	struct kvaser_usb_net_priv *priv;
+	struct kvaser_usb_net_leaf_priv *leaf;
 	enum can_state old_state, new_state;
 
 	if (es->channel >= dev->nchannels) {
@@ -1023,6 +1042,7 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	}
 
 	priv = dev->nets[es->channel];
+	leaf = priv->sub_priv;
 	stats = &priv->netdev->stats;
 
 	/* Update all of the CAN interface's state and error counters before
@@ -1039,6 +1059,14 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	kvaser_usb_leaf_rx_error_update_can_state(priv, es, &tmp_cf);
 	new_state = priv->can.state;
 
+	/* If there are errors, request status updates periodically as we do
+	 * not get automatic notifications of improved state.
+	 */
+	if (new_state < CAN_STATE_BUS_OFF &&
+	    (es->rxerr || es->txerr || new_state == CAN_STATE_ERROR_PASSIVE))
+		schedule_delayed_work(&leaf->chip_state_req_work,
+				      msecs_to_jiffies(500));
+
 	skb = alloc_can_err_skb(priv->netdev, &cf);
 	if (!skb) {
 		stats->rx_dropped++;
@@ -1570,10 +1598,13 @@ static int kvaser_usb_leaf_start_chip(struct kvaser_usb_net_priv *priv)
 
 static int kvaser_usb_leaf_stop_chip(struct kvaser_usb_net_priv *priv)
 {
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
 	int err;
 
 	reinit_completion(&priv->stop_comp);
 
+	cancel_delayed_work(&leaf->chip_state_req_work);
+
 	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_STOP_CHIP,
 					      priv->channel);
 	if (err)
@@ -1620,6 +1651,31 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_leaf_init_channel(struct kvaser_usb_net_priv *priv)
+{
+	struct kvaser_usb_net_leaf_priv *leaf;
+
+	leaf = devm_kzalloc(&priv->dev->intf->dev, sizeof(*leaf), GFP_KERNEL);
+	if (!leaf)
+		return -ENOMEM;
+
+	leaf->net = priv;
+	INIT_DELAYED_WORK(&leaf->chip_state_req_work,
+			  kvaser_usb_leaf_chip_state_req_work);
+
+	priv->sub_priv = leaf;
+
+	return 0;
+}
+
+static void kvaser_usb_leaf_remove_channel(struct kvaser_usb_net_priv *priv)
+{
+	struct kvaser_usb_net_leaf_priv *leaf = priv->sub_priv;
+
+	if (leaf)
+		cancel_delayed_work_sync(&leaf->chip_state_req_work);
+}
+
 static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
@@ -1717,6 +1773,8 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_get_berr_counter = kvaser_usb_leaf_get_berr_counter,
 	.dev_setup_endpoints = kvaser_usb_leaf_setup_endpoints,
 	.dev_init_card = kvaser_usb_leaf_init_card,
+	.dev_init_channel = kvaser_usb_leaf_init_channel,
+	.dev_remove_channel = kvaser_usb_leaf_remove_channel,
 	.dev_get_software_info = kvaser_usb_leaf_get_software_info,
 	.dev_get_software_details = NULL,
 	.dev_get_card_info = kvaser_usb_leaf_get_card_info,
-- 
2.36.1

