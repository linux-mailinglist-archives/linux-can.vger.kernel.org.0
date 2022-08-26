Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D255A260F
	for <lists+linux-can@lfdr.de>; Fri, 26 Aug 2022 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiHZKqh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Aug 2022 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbiHZKqg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Aug 2022 06:46:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46497A763
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 03:46:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oRWrA-0001sX-CP
        for linux-can@vger.kernel.org; Fri, 26 Aug 2022 12:46:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D28B5D2E5C
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 10:46:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 88A2ED2E57;
        Fri, 26 Aug 2022 10:46:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6cebfee7;
        Fri, 26 Aug 2022 10:46:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: gs_usb: hardware timestamp support
Date:   Fri, 26 Aug 2022 12:46:28 +0200
Message-Id: <20220826104629.2837024-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826104629.2837024-1-mkl@pengutronix.de>
References: <20220826104629.2837024-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: John Whittington <git@jbrengineering.co.uk>

Adds support for hardware timestamps if the firmware includes it as a
feature via the GS_CAN_FEATURE_HW_TIMESTAMP flag. Checks for this
feature during probe, extends the RX expected length if it is and
enables it during open.

`classic_can_ts` and `canfd_ts` structs are copied and extended to
include the us timestamp following data as defined in the firmware. The
timestamp is then captured and set using `skb_hwtstamps` on each RX.

The frame us timestamp is provided from a 32 bit 1 MHz timer which would
roll over after 4294 seconds so a cyclecounter, timecounter and delayed
worker are used to convert the timer into a proper ns timestamp - same
implementation as efd8d98dfb900 ("can: mcp251xfd: add HW timestamp
infrastructure").

Hardware timestamps are added to capabilities as b1f6b93e678fb ("can:
mcp251xfd: advertise timestamping capabilities")

Signed-off-by: John Whittington <git@jbrengineering.co.uk>
Link: https://github.com/candle-usb/candleLight_fw/issues/100
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 142 ++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index baf749c8cda3..0d6729f12946 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -16,6 +16,9 @@
 #include <linux/netdevice.h>
 #include <linux/signal.h>
 #include <linux/usb.h>
+#include <linux/timecounter.h>
+#include <linux/workqueue.h>
+#include <linux/clocksource.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -37,6 +40,13 @@
 #define GSUSB_ENDPOINT_IN 1
 #define GSUSB_ENDPOINT_OUT 2
 
+/* Timestamp 32 bit timer runs at 1 MHz (1 us tick). Worker accounts for timer
+ * overflow (will be after ~71 minutes) */
+#define GSUSB_TIMESTAMP_TIMER_HZ 1e6
+#define GSUSB_TIMESTAMP_WORK_DELAY_SEC 1800
+static_assert(GSUSB_TIMESTAMP_WORK_DELAY_SEC <
+	      CYCLECOUNTER_MASK(32) / GSUSB_TIMESTAMP_TIMER_HZ / 2);
+
 /* Device specific constants */
 enum gs_usb_breq {
 	GS_USB_BREQ_HOST_FORMAT = 0,
@@ -199,6 +209,11 @@ struct classic_can {
 	u8 data[8];
 } __packed;
 
+struct classic_can_ts {
+	u8 data[8];
+	u32 timestamp_us;
+} __packed;
+
 struct classic_can_quirk {
 	u8 data[8];
 	u8 quirk;
@@ -208,6 +223,11 @@ struct canfd {
 	u8 data[64];
 } __packed;
 
+struct canfd_ts {
+	u8 data[64];
+	u32 timestamp_us;
+} __packed;
+
 struct canfd_quirk {
 	u8 data[64];
 	u8 quirk;
@@ -225,7 +245,9 @@ struct gs_host_frame {
 	union {
 		DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
 		DECLARE_FLEX_ARRAY(struct classic_can_quirk, classic_can_quirk);
+		DECLARE_FLEX_ARRAY(struct classic_can_ts, classic_can_ts);
 		DECLARE_FLEX_ARRAY(struct canfd, canfd);
+		DECLARE_FLEX_ARRAY(struct canfd_ts, canfd_ts);
 		DECLARE_FLEX_ARRAY(struct canfd_quirk, canfd_quirk);
 	};
 } __packed;
@@ -259,6 +281,11 @@ struct gs_can {
 	struct can_bittiming_const bt_const, data_bt_const;
 	unsigned int channel;	/* channel number */
 
+	/* time counter for hardware timestamps */
+	struct cyclecounter cc;
+	struct timecounter tc;
+	struct delayed_work timestamp;
+
 	u32 feature;
 	unsigned int hf_size_tx;
 
@@ -351,6 +378,83 @@ static int gs_cmd_reset(struct gs_can *gsdev)
 	return rc;
 }
 
+static int gs_usb_get_sof_timestamp(struct net_device *netdev,
+				    u32 *sof_timestamp_us)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+	int rc;
+
+	rc = usb_control_msg_recv(interface_to_usbdev(dev->iface),
+			     usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
+			     GS_USB_BREQ_TIMESTAMP,
+			     USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+			     dev->channel, 0,
+			     sof_timestamp_us, sizeof(*sof_timestamp_us),
+			     USB_CTRL_GET_TIMEOUT,
+			     GFP_KERNEL);
+
+	return (rc > 0) ? 0 : rc;
+}
+
+static u64 gs_usb_timestamp_read(const struct cyclecounter *cc)
+{
+	const struct gs_can *dev;
+	u32 timestamp = 0;
+	int err;
+
+	dev = container_of(cc, struct gs_can, cc);
+	err = gs_usb_get_sof_timestamp(dev->netdev, &timestamp);
+	if (err)
+		netdev_err(dev->netdev,
+			   "Error %d while reading timestamp. HW timestamps may be inaccurate.",
+			   err);
+
+	return timestamp;
+}
+
+static void gs_usb_set_timestamp(struct gs_can *dev,
+				 struct sk_buff *skb, u32 timestamp)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+	u64 ns;
+
+	ns = timecounter_cyc2time(&dev->tc, timestamp);
+	hwtstamps->hwtstamp = ns_to_ktime(ns);
+}
+
+static void gs_usb_timestamp_work(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct gs_can *dev;
+
+	dev = container_of(delayed_work, struct gs_can, timestamp);
+	timecounter_read(&dev->tc);
+
+	schedule_delayed_work(&dev->timestamp,
+			      GSUSB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+}
+
+void gs_usb_timestamp_init(struct gs_can *dev)
+{
+	struct cyclecounter *cc = &dev->cc;
+
+	cc->read = gs_usb_timestamp_read;
+	cc->mask = CYCLECOUNTER_MASK(32);
+	cc->shift = 1;
+	cc->mult = clocksource_hz2mult(GSUSB_TIMESTAMP_TIMER_HZ, cc->shift);
+
+	timecounter_init(&dev->tc, &dev->cc, ktime_get_real_ns());
+
+	INIT_DELAYED_WORK(&dev->timestamp, gs_usb_timestamp_work);
+	schedule_delayed_work(&dev->timestamp,
+			      GSUSB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+}
+
+void gs_usb_timestamp_stop(struct gs_can *dev)
+{
+	cancel_delayed_work_sync(&dev->timestamp);
+}
+
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
 {
 	struct can_device_stats *can_stats = &dev->can.can_stats;
@@ -428,6 +532,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 				cfd->flags |= CANFD_ESI;
 
 			memcpy(cfd->data, hf->canfd->data, cfd->len);
+
+			/* set hardware timestamp if supported */
+			if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+				gs_usb_set_timestamp(dev, skb, le32_to_cpu(hf->canfd_ts->timestamp_us));
+			}
 		} else {
 			skb = alloc_can_skb(dev->netdev, &cf);
 			if (!skb)
@@ -438,6 +547,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			memcpy(cf->data, hf->classic_can->data, 8);
 
+			/* set hardware timestamp if supported */
+			if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+				gs_usb_set_timestamp(dev, skb, le32_to_cpu(hf->classic_can_ts->timestamp_us));
+			}
+
 			/* ERROR frames tell us information about the controller */
 			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
 				gs_update_state(dev, cf);
@@ -814,6 +928,10 @@ static int gs_can_open(struct net_device *netdev)
 	else if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		flags |= GS_CAN_MODE_LISTEN_ONLY;
 
+	/* if hardware supports timestamps, enable it */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		flags |= GS_CAN_MODE_HW_TIMESTAMP;
+
 	/* Controller is not allowed to retry TX
 	 * this mode is unavailable on atmels uc3c hardware
 	 */
@@ -838,6 +956,10 @@ static int gs_can_open(struct net_device *netdev)
 		return rc;
 	}
 
+	/* start polling sof timestamp */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_init(dev);
+
 	kfree(dm);
 
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
@@ -869,6 +991,10 @@ static int gs_can_close(struct net_device *netdev)
 					  dev->rxbuf_dma[i]);
 	}
 
+	/* Stop polling sof timestamp */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(dev);
+
 	/* Stop sending URBs */
 	usb_kill_anchored_urbs(&dev->tx_submitted);
 	atomic_set(&dev->active_tx_urbs, 0);
@@ -895,6 +1021,7 @@ static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_stop = gs_can_close,
 	.ndo_start_xmit = gs_can_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 };
 
 static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
@@ -946,7 +1073,7 @@ static int gs_usb_set_phys_id(struct net_device *dev,
 
 static const struct ethtool_ops gs_usb_ethtool_ops = {
 	.set_phys_id = gs_usb_set_phys_id,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 static struct gs_can *gs_make_candev(unsigned int channel,
@@ -1228,8 +1355,17 @@ static int gs_usb_probe(struct usb_interface *intf,
 		}
 		dev->canch[i]->parent = dev;
 
-		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD)
-			dev->hf_size_rx = struct_size(hf, canfd, 1);
+		/* set rx packet size based on FD and if hardware timestamps are
+		 * supported.
+		 */
+		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+				dev->hf_size_rx = struct_size(hf, canfd_ts, 1);
+			else
+				dev->hf_size_rx = struct_size(hf, canfd, 1);
+		} else if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+			dev->hf_size_rx = struct_size(hf, classic_can_ts, 1);
+		}
 	}
 
 	kfree(dconf);
-- 
2.35.1


