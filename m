Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603375AC0B8
	for <lists+linux-can@lfdr.de>; Sat,  3 Sep 2022 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiICSZ4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 3 Sep 2022 14:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiICSZy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 3 Sep 2022 14:25:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87341D0F
        for <linux-can@vger.kernel.org>; Sat,  3 Sep 2022 11:25:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq23so7675584lfb.7
        for <linux-can@vger.kernel.org>; Sat, 03 Sep 2022 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2guWXayN5Aha8e9cVHEj/6a/i24Y3H2G0ROJ2VxOFLI=;
        b=naXagG1KpPxyxWmRVRof4BgU2dHKKn1IdFZd4LH+6qPAe/Y9fu3f5X1bqW2Rw1o9U+
         05m1WfUwu3GTgrpLYe58K3okiuicm4fl4kwQ05huXCl5Nm8y4z1b8Q8bbMZQfNIBcuoi
         QNb9VbHadLI6FUPDSXKQ/ipwLlbl7lJZTNKFo08m/y6GAi/LlA5RAhFidNEV3fx1BFBn
         64P232icuZ5c2+7BsUuxJlOHxzGQlQkNJPbHXIHuqfZuNfbGFaA8daP+1qZnAkTuiZFM
         4kvzQ81YPRM+3meUXuTjKsx1rALabMhIyxtKc6l6HlEAhGLhGzsiZYF/5KsTTarAhNhu
         Fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2guWXayN5Aha8e9cVHEj/6a/i24Y3H2G0ROJ2VxOFLI=;
        b=U/IubKmRvtbX/pIuyefsOynrn2KLhLFUWS8yK7NxFE9zptRIOOnNo4NjPwIwwzTYxz
         UUam9SkQNgQZmCJohG3CuXfBkAOT1uzlYvo5RXKgE4CknXbX2h4CH4drhgzLfRMeG9WS
         K7Znmd6R4PNHvQsK/IL3DL14/yEoRyCCZDA/4ObyBYYrIfFegNPYZjDn7MHmz6sfcg9Z
         UCPDrAS2RaMvJVq89qXAp4IhNzXtvzHEC54UpRpSpq5GwENbVvMEOjLT4mILJZDFub/p
         QL9oCnK7MDFnoDFljkWUgayYIBwRevPI2KKd8u1daaJ1mVlYdHpT/JxRW9+Uy6CItxdB
         +otw==
X-Gm-Message-State: ACgBeo3owmayPjb9TE0sKPH2kZgYVvdd76KbukCYEEK/Ws0EfzQzVbsQ
        Dfw2o+kY31SaWwLTHtYMJAO1OON8I9Opu5ht
X-Google-Smtp-Source: AA6agR7cukpmvNHBvSKc3c1yY1Hx2N7cHgaZjl9NkWOjLdUz7MJ6rmme8V+XIVPgIlKRPBuNPXgktA==
X-Received: by 2002:a05:6512:3b2c:b0:494:7661:1a01 with SMTP id f44-20020a0565123b2c00b0049476611a01mr8030759lfv.58.1662229551083;
        Sat, 03 Sep 2022 11:25:51 -0700 (PDT)
Received: from f6a14fef6d45.. (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id u18-20020ac24c32000000b00492f6ddba59sm658330lfq.75.2022.09.03.11.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 11:25:50 -0700 (PDT)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>, stable@vger.kernel.org,
        Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH v4 15/15] can: kvaser_usb: Compare requested bittiming parameters with actual parameters in do_set_{,data}_bittiming
Date:   Sat,  3 Sep 2022 20:25:59 +0200
Message-Id: <20220903182559.189-15-extja@kvaser.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220903182559.189-1-extja@kvaser.com>
References: <20220903182559.189-1-extja@kvaser.com>
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

The device will respond with a CMD_ERROR_EVENT command, with error_code
KVASER_USB_{LEAF,HYDRA}_ERROR_EVENT_PARAM, if the CMD_SET_BUSPARAMS_REQ
contains invalid bittiming parameters.
However, this command does not contain any channel reference.

To check if the CMD_SET_BUSPARAMS_REQ was successful, redback and compare
the requested bittiming parameters with the device reported parameters.

Cc: stable@vger.kernel.org
Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Tested-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Co-developed-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
Changes in v4:
 - No changes

Changes in v3:
 - Rebased on 1d5eeda23f36 ("can: kvaser_usb: advertise timestamping capabilities and add ioctl support")
 - Add stable to CC
 - Add Tested-by Anssi Hannula

Changes in v2:
  - New in v2. Replaces parts of [PATCH 09/12] can: kvaser_usb_leaf: Fix silently failing bus params
 setup

 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  15 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  96 ++++++++++-
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 150 +++++++++++++++---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  |  64 ++++++--
 4 files changed, 284 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index 040885c7d0c4..8c4c2f00fb9f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -119,9 +119,12 @@ struct kvaser_usb_net_priv {
 	struct net_device *netdev;
 	int channel;
 
-	struct completion start_comp, stop_comp, flush_comp;
+	struct completion start_comp, stop_comp, flush_comp,
+			  get_busparams_comp;
 	struct usb_anchor tx_submitted;
 
+	struct kvaser_usb_busparams busparams_nominal, busparams_data;
+
 	spinlock_t tx_contexts_lock; /* lock for active_tx_contexts */
 	int active_tx_contexts;
 	struct kvaser_usb_tx_urb_context tx_contexts[];
@@ -131,7 +134,9 @@ struct kvaser_usb_net_priv {
  * struct kvaser_usb_dev_ops - Device specific functions
  * @dev_set_mode:		used for can.do_set_mode
  * @dev_set_bittiming:		used for can.do_set_bittiming
+ * @dev_get_busparams:		readback arbitration busparams
  * @dev_set_data_bittiming:	used for can.do_set_data_bittiming
+ * @dev_get_data_busparams:	readback data busparams
  * @dev_get_berr_counter:	used for can.do_get_berr_counter
  *
  * @dev_setup_endpoints:	setup USB in and out endpoints
@@ -153,8 +158,12 @@ struct kvaser_usb_net_priv {
  */
 struct kvaser_usb_dev_ops {
 	int (*dev_set_mode)(struct net_device *netdev, enum can_mode mode);
-	int (*dev_set_bittiming)(struct net_device *netdev);
-	int (*dev_set_data_bittiming)(struct net_device *netdev);
+	int (*dev_set_bittiming)(const struct net_device *netdev,
+				 const struct kvaser_usb_busparams *busparams);
+	int (*dev_get_busparams)(struct kvaser_usb_net_priv *priv);
+	int (*dev_set_data_bittiming)(const struct net_device *netdev,
+				      const struct kvaser_usb_busparams *busparams);
+	int (*dev_get_data_busparams)(struct kvaser_usb_net_priv *priv);
 	int (*dev_get_berr_counter)(const struct net_device *netdev,
 				    struct can_berr_counter *bec);
 	int (*dev_setup_endpoints)(struct kvaser_usb *dev);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 19df05887166..989e75351062 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -440,10 +440,6 @@ static int kvaser_usb_open(struct net_device *netdev)
 	if (err)
 		return err;
 
-	err = kvaser_usb_setup_rx_urbs(dev);
-	if (err)
-		goto error;
-
 	err = ops->dev_set_opt_mode(priv);
 	if (err)
 		goto error;
@@ -534,6 +530,93 @@ static int kvaser_usb_close(struct net_device *netdev)
 	return 0;
 }
 
+static int kvaser_usb_set_bittiming(struct net_device *netdev)
+{
+	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
+	struct kvaser_usb *dev = priv->dev;
+	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
+	struct can_bittiming *bt = &priv->can.bittiming;
+
+	struct kvaser_usb_busparams busparams;
+	int tseg1 = bt->prop_seg + bt->phase_seg1;
+	int tseg2 = bt->phase_seg2;
+	int sjw = bt->sjw;
+	int err = -EOPNOTSUPP;
+
+	busparams.bitrate = cpu_to_le32(bt->bitrate);
+	busparams.sjw = (u8)sjw;
+	busparams.tseg1 = (u8)tseg1;
+	busparams.tseg2 = (u8)tseg2;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		busparams.nsamples = 3;
+	else
+		busparams.nsamples = 1;
+
+	err = ops->dev_set_bittiming(netdev, &busparams);
+	if (err)
+		return err;
+
+	err = kvaser_usb_setup_rx_urbs(priv->dev);
+	if (err)
+		return err;
+
+	err = ops->dev_get_busparams(priv);
+	if (err) {
+		/* Treat EOPNOTSUPP as success */
+		if (err == -EOPNOTSUPP)
+			err = 0;
+		return err;
+	}
+
+	if (memcmp(&busparams, &priv->busparams_nominal,
+		   sizeof(priv->busparams_nominal)) != 0)
+		err = -EINVAL;
+
+	return err;
+}
+
+static int kvaser_usb_set_data_bittiming(struct net_device *netdev)
+{
+	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
+	struct kvaser_usb *dev = priv->dev;
+	const struct kvaser_usb_dev_ops *ops = dev->driver_info->ops;
+	struct can_bittiming *dbt = &priv->can.data_bittiming;
+
+	struct kvaser_usb_busparams busparams;
+	int tseg1 = dbt->prop_seg + dbt->phase_seg1;
+	int tseg2 = dbt->phase_seg2;
+	int sjw = dbt->sjw;
+	int err;
+
+	if (!ops->dev_set_data_bittiming ||
+	    !ops->dev_get_data_busparams)
+		return -EOPNOTSUPP;
+
+	busparams.bitrate = cpu_to_le32(dbt->bitrate);
+	busparams.sjw = (u8)sjw;
+	busparams.tseg1 = (u8)tseg1;
+	busparams.tseg2 = (u8)tseg2;
+	busparams.nsamples = 1;
+
+	err = ops->dev_set_data_bittiming(netdev, &busparams);
+	if (err)
+		return err;
+
+	err = kvaser_usb_setup_rx_urbs(priv->dev);
+	if (err)
+		return err;
+
+	err = ops->dev_get_data_busparams(priv);
+	if (err)
+		return err;
+
+	if (memcmp(&busparams, &priv->busparams_data,
+		   sizeof(priv->busparams_data)) != 0)
+		err = -EINVAL;
+
+	return err;
+}
+
 static void kvaser_usb_write_bulk_callback(struct urb *urb)
 {
 	struct kvaser_usb_tx_urb_context *context = urb->context;
@@ -734,6 +817,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	init_completion(&priv->start_comp);
 	init_completion(&priv->stop_comp);
 	init_completion(&priv->flush_comp);
+	init_completion(&priv->get_busparams_comp);
 	priv->can.ctrlmode_supported = 0;
 
 	priv->dev = dev;
@@ -746,7 +830,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	priv->can.state = CAN_STATE_STOPPED;
 	priv->can.clock.freq = dev->cfg->clock.freq;
 	priv->can.bittiming_const = dev->cfg->bittiming_const;
-	priv->can.do_set_bittiming = ops->dev_set_bittiming;
+	priv->can.do_set_bittiming = kvaser_usb_set_bittiming;
 	priv->can.do_set_mode = ops->dev_set_mode;
 	if ((driver_info->quirks & KVASER_USB_QUIRK_HAS_TXRX_ERRORS) ||
 	    (priv->dev->card_data.capabilities & KVASER_USB_CAP_BERR_CAP))
@@ -758,7 +842,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 		priv->can.data_bittiming_const = dev->cfg->data_bittiming_const;
-		priv->can.do_set_data_bittiming = ops->dev_set_data_bittiming;
+		priv->can.do_set_data_bittiming = kvaser_usb_set_data_bittiming;
 	}
 
 	netdev->flags |= IFF_ECHO;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index b8ae29872217..52ef76bd9bdb 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -45,6 +45,8 @@ static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_rt;
 
 /* Minihydra command IDs */
 #define CMD_SET_BUSPARAMS_REQ			16
+#define CMD_GET_BUSPARAMS_REQ			17
+#define CMD_GET_BUSPARAMS_RESP			18
 #define CMD_GET_CHIP_STATE_REQ			19
 #define CMD_CHIP_STATE_EVENT			20
 #define CMD_SET_DRIVERMODE_REQ			21
@@ -196,13 +198,26 @@ struct kvaser_cmd_chip_state_event {
 #define KVASER_USB_HYDRA_BUS_MODE_CANFD_ISO	0x01
 #define KVASER_USB_HYDRA_BUS_MODE_NONISO	0x02
 struct kvaser_cmd_set_busparams {
-	struct kvaser_usb_busparams busparams_arb;
+	struct kvaser_usb_busparams busparams_nominal;
 	u8 reserved0[4];
 	struct kvaser_usb_busparams busparams_data;
 	u8 canfd_mode;
 	u8 reserved1[7];
 } __packed;
 
+/* Busparam type */
+#define KVASER_USB_HYDRA_BUSPARAM_TYPE_CAN	0x00
+#define KVASER_USB_HYDRA_BUSPARAM_TYPE_CANFD	0x01
+struct kvaser_cmd_get_busparams_req {
+	u8 type;
+	u8 reserved[27];
+} __packed;
+
+struct kvaser_cmd_get_busparams_res {
+	struct kvaser_usb_busparams busparams;
+	u8 reserved[20];
+} __packed;
+
 /* Ctrl modes */
 #define KVASER_USB_HYDRA_CTRLMODE_NORMAL	0x01
 #define KVASER_USB_HYDRA_CTRLMODE_LISTEN	0x02
@@ -273,6 +288,8 @@ struct kvaser_cmd {
 		struct kvaser_cmd_error_event error_event;
 
 		struct kvaser_cmd_set_busparams set_busparams_req;
+		struct kvaser_cmd_get_busparams_req get_busparams_req;
+		struct kvaser_cmd_get_busparams_res get_busparams_res;
 
 		struct kvaser_cmd_chip_state_event chip_state_event;
 
@@ -355,6 +372,10 @@ struct kvaser_cmd_ext {
 	} __packed;
 } __packed;
 
+struct kvaser_usb_net_hydra_priv {
+	int pending_get_busparams_type;
+};
+
 static const struct can_bittiming_const kvaser_usb_hydra_kcan_bittiming_c = {
 	.name = "kvaser_usb_kcan",
 	.tseg1_min = 1,
@@ -832,6 +853,39 @@ static void kvaser_usb_hydra_flush_queue_reply(const struct kvaser_usb *dev,
 	complete(&priv->flush_comp);
 }
 
+static void kvaser_usb_hydra_get_busparams_reply(const struct kvaser_usb *dev,
+						 const struct kvaser_cmd *cmd)
+{
+	struct kvaser_usb_net_priv *priv;
+	struct kvaser_usb_net_hydra_priv *hydra;
+
+	priv = kvaser_usb_hydra_net_priv_from_cmd(dev, cmd);
+	if (!priv)
+		return;
+
+	hydra = priv->sub_priv;
+	if (!hydra)
+		return;
+
+	switch (hydra->pending_get_busparams_type) {
+	case KVASER_USB_HYDRA_BUSPARAM_TYPE_CAN:
+		memcpy(&priv->busparams_nominal, &cmd->get_busparams_res.busparams,
+		       sizeof(priv->busparams_nominal));
+		break;
+	case KVASER_USB_HYDRA_BUSPARAM_TYPE_CANFD:
+		memcpy(&priv->busparams_data, &cmd->get_busparams_res.busparams,
+		       sizeof(priv->busparams_nominal));
+		break;
+	default:
+		dev_warn(&dev->intf->dev, "Unknown get_busparams_type %d\n",
+			 hydra->pending_get_busparams_type);
+		break;
+	}
+	hydra->pending_get_busparams_type = -1;
+
+	complete(&priv->get_busparams_comp);
+}
+
 static void
 kvaser_usb_hydra_bus_status_to_can_state(const struct kvaser_usb_net_priv *priv,
 					 u8 bus_status,
@@ -1318,6 +1372,10 @@ static void kvaser_usb_hydra_handle_cmd_std(const struct kvaser_usb *dev,
 		kvaser_usb_hydra_state_event(dev, cmd);
 		break;
 
+	case CMD_GET_BUSPARAMS_RESP:
+		kvaser_usb_hydra_get_busparams_reply(dev, cmd);
+		break;
+
 	case CMD_ERROR_EVENT:
 		kvaser_usb_hydra_error_event(dev, cmd);
 		break;
@@ -1514,15 +1572,58 @@ static int kvaser_usb_hydra_set_mode(struct net_device *netdev,
 	return err;
 }
 
-static int kvaser_usb_hydra_set_bittiming(struct net_device *netdev)
+static int kvaser_usb_hydra_get_busparams(struct kvaser_usb_net_priv *priv,
+					  int busparams_type)
+{
+	struct kvaser_usb *dev = priv->dev;
+	struct kvaser_usb_net_hydra_priv *hydra = priv->sub_priv;
+	struct kvaser_cmd *cmd;
+	int err;
+
+	if (!hydra)
+		return -EINVAL;
+
+	cmd = kcalloc(1, sizeof(struct kvaser_cmd), GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->header.cmd_no = CMD_GET_BUSPARAMS_REQ;
+	kvaser_usb_hydra_set_cmd_dest_he
+		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
+	kvaser_usb_hydra_set_cmd_transid
+				(cmd, kvaser_usb_hydra_get_next_transid(dev));
+	cmd->get_busparams_req.type = busparams_type;
+	hydra->pending_get_busparams_type = busparams_type;
+
+	reinit_completion(&priv->get_busparams_comp);
+
+	err = kvaser_usb_send_cmd(dev, cmd, kvaser_usb_hydra_cmd_size(cmd));
+	if (err)
+		return err;
+
+	if (!wait_for_completion_timeout(&priv->get_busparams_comp,
+					 msecs_to_jiffies(KVASER_USB_TIMEOUT)))
+		return -ETIMEDOUT;
+
+	return err;
+}
+
+static int kvaser_usb_hydra_get_nominal_busparams(struct kvaser_usb_net_priv *priv)
+{
+	return kvaser_usb_hydra_get_busparams(priv, KVASER_USB_HYDRA_BUSPARAM_TYPE_CAN);
+}
+
+static int kvaser_usb_hydra_get_data_busparams(struct kvaser_usb_net_priv *priv)
+{
+	return kvaser_usb_hydra_get_busparams(priv, KVASER_USB_HYDRA_BUSPARAM_TYPE_CANFD);
+}
+
+static int kvaser_usb_hydra_set_bittiming(const struct net_device *netdev,
+					  const struct kvaser_usb_busparams *busparams)
 {
 	struct kvaser_cmd *cmd;
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
-	struct can_bittiming *bt = &priv->can.bittiming;
 	struct kvaser_usb *dev = priv->dev;
-	int tseg1 = bt->prop_seg + bt->phase_seg1;
-	int tseg2 = bt->phase_seg2;
-	int sjw = bt->sjw;
 	int err;
 
 	cmd = kcalloc(1, sizeof(struct kvaser_cmd), GFP_KERNEL);
@@ -1530,11 +1631,8 @@ static int kvaser_usb_hydra_set_bittiming(struct net_device *netdev)
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_SET_BUSPARAMS_REQ;
-	cmd->set_busparams_req.busparams_arb.bitrate = cpu_to_le32(bt->bitrate);
-	cmd->set_busparams_req.busparams_arb.sjw = (u8)sjw;
-	cmd->set_busparams_req.busparams_arb.tseg1 = (u8)tseg1;
-	cmd->set_busparams_req.busparams_arb.tseg2 = (u8)tseg2;
-	cmd->set_busparams_req.busparams_arb.nsamples = 1;
+	memcpy(&cmd->set_busparams_req.busparams_nominal, busparams,
+	       sizeof(cmd->set_busparams_req.busparams_nominal));
 
 	kvaser_usb_hydra_set_cmd_dest_he
 		(cmd, dev->card_data.hydra.channel_to_he[priv->channel]);
@@ -1548,15 +1646,12 @@ static int kvaser_usb_hydra_set_bittiming(struct net_device *netdev)
 	return err;
 }
 
-static int kvaser_usb_hydra_set_data_bittiming(struct net_device *netdev)
+static int kvaser_usb_hydra_set_data_bittiming(const struct net_device *netdev,
+					       const struct kvaser_usb_busparams *busparams)
 {
 	struct kvaser_cmd *cmd;
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
-	struct can_bittiming *dbt = &priv->can.data_bittiming;
 	struct kvaser_usb *dev = priv->dev;
-	int tseg1 = dbt->prop_seg + dbt->phase_seg1;
-	int tseg2 = dbt->phase_seg2;
-	int sjw = dbt->sjw;
 	int err;
 
 	cmd = kcalloc(1, sizeof(struct kvaser_cmd), GFP_KERNEL);
@@ -1564,11 +1659,8 @@ static int kvaser_usb_hydra_set_data_bittiming(struct net_device *netdev)
 		return -ENOMEM;
 
 	cmd->header.cmd_no = CMD_SET_BUSPARAMS_FD_REQ;
-	cmd->set_busparams_req.busparams_data.bitrate = cpu_to_le32(dbt->bitrate);
-	cmd->set_busparams_req.busparams_data.sjw = (u8)sjw;
-	cmd->set_busparams_req.busparams_data.tseg1 = (u8)tseg1;
-	cmd->set_busparams_req.busparams_data.tseg2 = (u8)tseg2;
-	cmd->set_busparams_req.busparams_data.nsamples = 1;
+	memcpy(&cmd->set_busparams_req.busparams_data, busparams,
+	       sizeof(cmd->set_busparams_req.busparams_data));
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
@@ -1675,6 +1767,19 @@ static int kvaser_usb_hydra_init_card(struct kvaser_usb *dev)
 	return 0;
 }
 
+static int kvaser_usb_hydra_init_channel(struct kvaser_usb_net_priv *priv)
+{
+	struct kvaser_usb_net_hydra_priv *hydra;
+
+	hydra = devm_kzalloc(&priv->dev->intf->dev, sizeof(*hydra), GFP_KERNEL);
+	if (!hydra)
+		return -ENOMEM;
+
+	priv->sub_priv = hydra;
+
+	return 0;
+}
+
 static int kvaser_usb_hydra_get_software_info(struct kvaser_usb *dev)
 {
 	struct kvaser_cmd cmd;
@@ -2019,10 +2124,13 @@ kvaser_usb_hydra_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
 const struct kvaser_usb_dev_ops kvaser_usb_hydra_dev_ops = {
 	.dev_set_mode = kvaser_usb_hydra_set_mode,
 	.dev_set_bittiming = kvaser_usb_hydra_set_bittiming,
+	.dev_get_busparams = kvaser_usb_hydra_get_nominal_busparams,
 	.dev_set_data_bittiming = kvaser_usb_hydra_set_data_bittiming,
+	.dev_get_data_busparams = kvaser_usb_hydra_get_data_busparams,
 	.dev_get_berr_counter = kvaser_usb_hydra_get_berr_counter,
 	.dev_setup_endpoints = kvaser_usb_hydra_setup_endpoints,
 	.dev_init_card = kvaser_usb_hydra_init_card,
+	.dev_init_channel = kvaser_usb_hydra_init_channel,
 	.dev_get_software_info = kvaser_usb_hydra_get_software_info,
 	.dev_get_software_details = kvaser_usb_hydra_get_software_details,
 	.dev_get_card_info = kvaser_usb_hydra_get_card_info,
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index bb59ee01a093..1c2f99ce4c6c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -57,6 +57,8 @@
 #define CMD_RX_EXT_MESSAGE		14
 #define CMD_TX_EXT_MESSAGE		15
 #define CMD_SET_BUS_PARAMS		16
+#define CMD_GET_BUS_PARAMS		17
+#define CMD_GET_BUS_PARAMS_REPLY	18
 #define CMD_GET_CHIP_STATE		19
 #define CMD_CHIP_STATE_EVENT		20
 #define CMD_SET_CTRL_MODE		21
@@ -376,6 +378,7 @@ static const u8 kvaser_usb_leaf_cmd_sizes_leaf[] = {
 	[CMD_CHIP_STATE_EVENT]		= kvaser_fsize(u.leaf.chip_state_event),
 	[CMD_CAN_ERROR_EVENT]		= kvaser_fsize(u.leaf.can_error_event),
 	[CMD_GET_CAPABILITIES_RESP]	= kvaser_fsize(u.leaf.cap_res),
+	[CMD_GET_BUS_PARAMS_REPLY]	= kvaser_fsize(u.busparams),
 	[CMD_ERROR_EVENT]		= kvaser_fsize(u.leaf.error_event),
 	/* ignored events: */
 	[CMD_FLUSH_QUEUE_REPLY]		= CMD_SIZE_ANY,
@@ -1486,6 +1489,25 @@ static void kvaser_usb_leaf_stop_chip_reply(const struct kvaser_usb *dev,
 	complete(&priv->stop_comp);
 }
 
+static void kvaser_usb_leaf_get_busparams_reply(const struct kvaser_usb *dev,
+						const struct kvaser_cmd *cmd)
+{
+	struct kvaser_usb_net_priv *priv;
+	u8 channel = cmd->u.busparams.channel;
+
+	if (channel >= dev->nchannels) {
+		dev_err(&dev->intf->dev,
+			"Invalid channel number (%d)\n", channel);
+		return;
+	}
+
+	priv = dev->nets[channel];
+	memcpy(&priv->busparams_nominal, &cmd->u.busparams.busparams,
+	       sizeof(priv->busparams_nominal));
+
+	complete(&priv->get_busparams_comp);
+}
+
 static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 					   const struct kvaser_cmd *cmd)
 {
@@ -1528,6 +1550,10 @@ static void kvaser_usb_leaf_handle_command(const struct kvaser_usb *dev,
 		kvaser_usb_leaf_error_event(dev, cmd);
 		break;
 
+	case CMD_GET_BUS_PARAMS_REPLY:
+		kvaser_usb_leaf_get_busparams_reply(dev, cmd);
+		break;
+
 	/* Ignored commands */
 	case CMD_USBCAN_CLOCK_OVERFLOW_EVENT:
 		if (dev->driver_info->family != KVASER_USBCAN)
@@ -1705,10 +1731,10 @@ static void kvaser_usb_leaf_remove_channel(struct kvaser_usb_net_priv *priv)
 		cancel_delayed_work_sync(&leaf->chip_state_req_work);
 }
 
-static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
+static int kvaser_usb_leaf_set_bittiming(const struct net_device *netdev,
+					 const struct kvaser_usb_busparams *busparams)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
-	struct can_bittiming *bt = &priv->can.bittiming;
 	struct kvaser_usb *dev = priv->dev;
 	struct kvaser_cmd *cmd;
 	int rc;
@@ -1721,15 +1747,8 @@ static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 	cmd->len = CMD_HEADER_LEN + sizeof(struct kvaser_cmd_busparams);
 	cmd->u.busparams.channel = priv->channel;
 	cmd->u.busparams.tid = 0xff;
-	cmd->u.busparams.busparams.bitrate = cpu_to_le32(bt->bitrate);
-	cmd->u.busparams.busparams.sjw = bt->sjw;
-	cmd->u.busparams.busparams.tseg1 = bt->prop_seg + bt->phase_seg1;
-	cmd->u.busparams.busparams.tseg2 = bt->phase_seg2;
-
-	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		cmd->u.busparams.busparams.nsamples = 3;
-	else
-		cmd->u.busparams.busparams.nsamples = 1;
+	memcpy(&cmd->u.busparams.busparams, busparams,
+	       sizeof(cmd->u.busparams.busparams));
 
 	rc = kvaser_usb_send_cmd(dev, cmd, cmd->len);
 
@@ -1737,6 +1756,27 @@ static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 	return rc;
 }
 
+static int kvaser_usb_leaf_get_busparams(struct kvaser_usb_net_priv *priv)
+{
+	int err;
+
+	if (priv->dev->driver_info->family == KVASER_USBCAN)
+		return -EOPNOTSUPP;
+
+	reinit_completion(&priv->get_busparams_comp);
+
+	err = kvaser_usb_leaf_send_simple_cmd(priv->dev, CMD_GET_BUS_PARAMS,
+					      priv->channel);
+	if (err)
+		return err;
+
+	if (!wait_for_completion_timeout(&priv->get_busparams_comp,
+					 msecs_to_jiffies(KVASER_USB_TIMEOUT)))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int kvaser_usb_leaf_set_mode(struct net_device *netdev,
 				    enum can_mode mode)
 {
@@ -1801,7 +1841,9 @@ static int kvaser_usb_leaf_setup_endpoints(struct kvaser_usb *dev)
 const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_set_mode = kvaser_usb_leaf_set_mode,
 	.dev_set_bittiming = kvaser_usb_leaf_set_bittiming,
+	.dev_get_busparams = kvaser_usb_leaf_get_busparams,
 	.dev_set_data_bittiming = NULL,
+	.dev_get_data_busparams = NULL,
 	.dev_get_berr_counter = kvaser_usb_leaf_get_berr_counter,
 	.dev_setup_endpoints = kvaser_usb_leaf_setup_endpoints,
 	.dev_init_card = kvaser_usb_leaf_init_card,
-- 
2.37.3

