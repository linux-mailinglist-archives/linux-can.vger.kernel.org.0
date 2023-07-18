Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEE758063
	for <lists+linux-can@lfdr.de>; Tue, 18 Jul 2023 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjGRPGI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 18 Jul 2023 11:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjGRPGH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Jul 2023 11:06:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9B210CB
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 08:06:05 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLmH5-0003aL-Fh
        for linux-can@vger.kernel.org; Tue, 18 Jul 2023 17:06:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id C4E9A1F4369
        for <linux-can@vger.kernel.org>; Tue, 18 Jul 2023 15:06:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1BC651F435E;
        Tue, 18 Jul 2023 15:06:02 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 27ff51e6;
        Tue, 18 Jul 2023 15:06:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 18 Jul 2023 17:05:50 +0200
Subject: [PATCH v2 3/3] can: gs_usb: convert to NAPI/rx-offload to avoid
 OoO reception
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230718-gs_usb-rx-offload-v2-3-716e542d14d5@pengutronix.de>
References: <20230718-gs_usb-rx-offload-v2-0-716e542d14d5@pengutronix.de>
In-Reply-To: <20230718-gs_usb-rx-offload-v2-0-716e542d14d5@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=7400; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=GMIVqkSH4/NgFOJ2YqloPtsqsTQx8H4l40zk5bKXINo=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBktqpW7DUSdto3nOrmFM2oor5tNXuSvRWBdYSFA
 dP6FKEwjleJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZLaqVgAKCRC+UBxKKooE
 6Df8B/sGlIfeT57WA7vDk5fC7nQuk/1NTUDxAnQ6FqGt4YOtCpdehAbAg0SolIeTUGxelIDyVJs
 zetcMknKFS3Cpawaj20yBLC81tiDDcR5dTsYsxwD8GSkvbNWVlNwjVeaQVvnuNpvHdoFnNUdS61
 +7r/fN+uyZuD8I+wLGVHD2otktjR6CdNbsw1KaN8gFhvKgWphZsG88+XxxZgr/yaL0MBHer7ffa
 aXTqcuj+Hwr89QVF1osBrvv47Mq9FrQk4qUD0ECu47VKG/K9cm1a2GYaOo83gGt7OpDR2krRcZF
 bn08K6GQd5P+jB+Mg6JZ3OkfzYCnMwYC5PS/y7DfPg0lmv++
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The driver used to pass received CAN frames/skbs to the network stack
with netif_rx(). In netif_rx() the skbs are queued to the local CPU.
If IRQs are handled in round robin, OoO packets may occur.

To avoid out-of-order reception convert the driver from netif_rx() to
NAPI.

For USB devices with timestamping support use the rx-offload helper
can_rx_offload_queue_timestamp() for the RX, and
can_rx_offload_get_echo_skb_queue_timestamp() for the TX path. Devices
without timestamping support use can_rx_offload_queue_tail() for RX,
and can_rx_offload_get_echo_skb_queue_tail() for the TX path.

Link: https://lore.kernel.org/all/559D628C.5020100@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/Kconfig  |  1 +
 drivers/net/can/usb/gs_usb.c | 85 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 58fcd2b34820..d1450722cb3c 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -52,6 +52,7 @@ config CAN_F81604
 
 config CAN_GS_USB
 	tristate "Geschwister Schneider UG and candleLight compatible interfaces"
+	select CAN_RX_OFFLOAD
 	help
 	  This driver supports the Geschwister Schneider and
 	  bytewerk.org candleLight compatible
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 6caf3974e028..95b0fdb602c8 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013-2016 Geschwister Schneider Technologie-,
  * Entwicklungs- und Vertriebs UG (Haftungsbeschränkt).
  * Copyright (C) 2016 Hubert Denkmair
+ * Copyright (c) 2023 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
  *
  * Many thanks to all socketcan devs!
  */
@@ -24,6 +25,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/can/rx-offload.h>
 
 /* Device specific constants */
 #define USB_GS_USB_1_VENDOR_ID 0x1d50
@@ -282,6 +284,8 @@ struct gs_host_frame {
 #define GS_MAX_TX_URBS 10
 /* Only launch a max of GS_MAX_RX_URBS usb requests at a time. */
 #define GS_MAX_RX_URBS 30
+#define GS_NAPI_WEIGHT 32
+
 /* Maximum number of interfaces the driver supports per device.
  * Current hardware only supports 3 interfaces. The future may vary.
  */
@@ -295,6 +299,7 @@ struct gs_tx_context {
 struct gs_can {
 	struct can_priv can; /* must be the first member */
 
+	struct can_rx_offload offload;
 	struct gs_usb *parent;
 
 	struct net_device *netdev;
@@ -506,20 +511,59 @@ static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
 	}
 }
 
-static void gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
-				 const struct gs_host_frame *hf)
+static u32 gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
+				const struct gs_host_frame *hf)
 {
 	u32 timestamp;
 
-	if (!(dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP))
-		return;
-
 	if (hf->flags & GS_CAN_FLAG_FD)
 		timestamp = le32_to_cpu(hf->canfd_ts->timestamp_us);
 	else
 		timestamp = le32_to_cpu(hf->classic_can_ts->timestamp_us);
 
-	gs_usb_skb_set_timestamp(dev, skb, timestamp);
+	if (skb)
+		gs_usb_skb_set_timestamp(dev, skb, timestamp);
+
+	return timestamp;
+}
+
+static void gs_usb_rx_offload(struct gs_can *dev, struct sk_buff *skb,
+			      const struct gs_host_frame *hf)
+{
+	struct can_rx_offload *offload = &dev->offload;
+	int rc;
+
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		const u32 ts = gs_usb_set_timestamp(dev, skb, hf);
+
+		rc = can_rx_offload_queue_timestamp(offload, skb, ts);
+	} else {
+		rc = can_rx_offload_queue_tail(offload, skb);
+	}
+
+	if (rc)
+		dev->netdev->stats.rx_fifo_errors++;
+}
+
+static unsigned int
+gs_usb_get_echo_skb(struct gs_can *dev, struct sk_buff *skb,
+		    const struct gs_host_frame *hf)
+{
+	struct can_rx_offload *offload = &dev->offload;
+	const u32 echo_id = hf->echo_id;
+	unsigned int len;
+
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+		const u32 ts = gs_usb_set_timestamp(dev, skb, hf);
+
+		len = can_rx_offload_get_echo_skb_queue_timestamp(offload, echo_id,
+								  ts, NULL);
+	} else {
+		len = can_rx_offload_get_echo_skb_queue_tail(offload, echo_id,
+							     NULL);
+	}
+
+	return len;
 }
 
 static void gs_usb_receive_bulk_callback(struct urb *urb)
@@ -592,12 +636,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 				gs_update_state(dev, cf);
 		}
 
-		gs_usb_set_timestamp(dev, skb, hf);
-
-		stats->rx_packets++;
-		stats->rx_bytes += hf->can_dlc;
-
-		netif_rx(skb);
+		gs_usb_rx_offload(dev, skb, hf);
 	} else { /* echo_id == hf->echo_id */
 		if (hf->echo_id >= GS_MAX_TX_URBS) {
 			netdev_err(netdev,
@@ -617,12 +656,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		}
 
 		skb = dev->can.echo_skb[hf->echo_id];
-		gs_usb_set_timestamp(dev, skb, hf);
-
 		stats->tx_packets++;
-		stats->tx_bytes += can_get_echo_skb(netdev, hf->echo_id,
-						    NULL);
-
+		stats->tx_bytes += gs_usb_get_echo_skb(dev, skb, hf);
 		gs_free_tx_context(txc);
 
 		atomic_dec(&dev->active_tx_urbs);
@@ -641,9 +676,12 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->len = CAN_ERR_DLC;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-		netif_rx(skb);
+
+		gs_usb_rx_offload(dev, skb, hf);
 	}
 
+	can_rx_offload_irq_finish(&dev->offload);
+
 resubmit_urb:
 	usb_fill_bulk_urb(urb, parent->udev,
 			  usb_rcvbulkpipe(parent->udev, GS_USB_ENDPOINT_IN),
@@ -857,6 +895,8 @@ static int gs_can_open(struct net_device *netdev)
 			dev->hf_size_tx = struct_size(hf, classic_can, 1);
 	}
 
+	can_rx_offload_enable(&dev->offload);
+
 	if (!parent->active_channels) {
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_init(parent);
@@ -965,6 +1005,7 @@ static int gs_can_open(struct net_device *netdev)
 			gs_usb_timestamp_stop(parent);
 	}
 
+	can_rx_offload_disable(&dev->offload);
 	close_candev(netdev);
 
 	return rc;
@@ -1037,6 +1078,8 @@ static int gs_can_close(struct net_device *netdev)
 		dev->tx_context[rc].echo_id = GS_MAX_TX_URBS;
 	}
 
+	can_rx_offload_disable(&dev->offload);
+
 	/* close the netdev */
 	close_candev(netdev);
 
@@ -1336,6 +1379,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.data_bittiming_const = &dev->data_bt_const;
 	}
 
+	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	rc = register_candev(dev->netdev);
@@ -1343,11 +1387,13 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev_err(&intf->dev,
 			"Couldn't register candev for channel %d (%pe)\n",
 			channel, ERR_PTR(rc));
-		goto out_free_candev;
+		goto out_can_rx_offload_del;
 	}
 
 	return dev;
 
+out_can_rx_offload_del:
+	can_rx_offload_del(&dev->offload);
 out_free_candev:
 	free_candev(dev->netdev);
 	return ERR_PTR(rc);
@@ -1356,6 +1402,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 static void gs_destroy_candev(struct gs_can *dev)
 {
 	unregister_candev(dev->netdev);
+	can_rx_offload_del(&dev->offload);
 	free_candev(dev->netdev);
 }
 

-- 
2.40.1


