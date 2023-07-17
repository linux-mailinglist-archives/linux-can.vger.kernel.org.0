Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7A756B53
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGQSJu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 14:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGQSJt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 14:09:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9ABE56
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 11:09:46 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qLSfI-00087L-Tr
        for linux-can@vger.kernel.org; Mon, 17 Jul 2023 20:09:44 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 2C8301F3969
        for <linux-can@vger.kernel.org>; Mon, 17 Jul 2023 18:09:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A7D1C1F3949;
        Mon, 17 Jul 2023 18:09:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7464c584;
        Mon, 17 Jul 2023 18:09:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        stable@vger.kernel.org, John Whittington <git@jbrengineering.co.uk>
Subject: [PATCH net 4/5] can: gs_usb: fix time stamp counter initialization
Date:   Mon, 17 Jul 2023 20:09:37 +0200
Message-Id: <20230717180938.230816-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717180938.230816-1-mkl@pengutronix.de>
References: <20230717180938.230816-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
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

If the gs_usb device driver is unloaded (or unbound) before the
interface is shut down, the USB stack first calls the struct
usb_driver::disconnect and then the struct net_device_ops::ndo_stop
callback.

In gs_usb_disconnect() all pending bulk URBs are killed, i.e. no more
RX'ed CAN frames are send from the USB device to the host. Later in
gs_can_close() a reset control message is send to each CAN channel to
remove the controller from the CAN bus. In this race window the USB
device can still receive CAN frames from the bus and internally queue
them to be send to the host.

At least in the current version of the candlelight firmware, the queue
of received CAN frames is not emptied during the reset command. After
loading (or binding) the gs_usb driver, new URBs are submitted during
the struct net_device_ops::ndo_open callback and the candlelight
firmware starts sending its already queued CAN frames to the host.

However, this scenario was not considered when implementing the
hardware timestamp function. The cycle counter/time counter
infrastructure is set up (gs_usb_timestamp_init()) after the USBs are
submitted, resulting in a NULL pointer dereference if
timecounter_cyc2time() (via the call chain:
gs_usb_receive_bulk_callback() -> gs_usb_set_timestamp() ->
gs_usb_skb_set_timestamp()) is called too early.

Move the gs_usb_timestamp_init() function before the URBs are
submitted to fix this problem.

For a comprehensive solution, we need to consider gs_usb devices with
more than 1 channel. The cycle counter/time counter infrastructure is
setup per channel, but the RX URBs are per device. Once gs_can_open()
of _a_ channel has been called, and URBs have been submitted, the
gs_usb_receive_bulk_callback() can be called for _all_ available
channels, even for channels that are not running, yet. As cycle
counter/time counter has not set up, this will again lead to a NULL
pointer dereference.

Convert the cycle counter/time counter from a "per channel" to a "per
device" functionality. Also set it up, before submitting any URBs to
the device.

Further in gs_usb_receive_bulk_callback(), don't process any URBs for
not started CAN channels, only resubmit the URB.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Closes: https://github.com/candle-usb/candleLight_fw/issues/137#issuecomment-1623532076
Cc: stable@vger.kernel.org
Cc: John Whittington <git@jbrengineering.co.uk>
Link: https://lore.kernel.org/all/20230716-gs_usb-fix-time-stamp-counter-v1-2-9017cefcd9d5@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 101 ++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 85b7b59c8426..f418066569fc 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -303,12 +303,6 @@ struct gs_can {
 	struct can_bittiming_const bt_const, data_bt_const;
 	unsigned int channel;	/* channel number */
 
-	/* time counter for hardware timestamps */
-	struct cyclecounter cc;
-	struct timecounter tc;
-	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
-	struct delayed_work timestamp;
-
 	u32 feature;
 	unsigned int hf_size_tx;
 
@@ -325,6 +319,13 @@ struct gs_usb {
 	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
+
+	/* time counter for hardware timestamps */
+	struct cyclecounter cc;
+	struct timecounter tc;
+	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
+	struct delayed_work timestamp;
+
 	unsigned int hf_size_rx;
 	u8 active_channels;
 };
@@ -388,15 +389,15 @@ static int gs_cmd_reset(struct gs_can *dev)
 				    GFP_KERNEL);
 }
 
-static inline int gs_usb_get_timestamp(const struct gs_can *dev,
+static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 				       u32 *timestamp_p)
 {
 	__le32 timestamp;
 	int rc;
 
-	rc = usb_control_msg_recv(dev->udev, 0, GS_USB_BREQ_TIMESTAMP,
+	rc = usb_control_msg_recv(parent->udev, 0, GS_USB_BREQ_TIMESTAMP,
 				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
-				  dev->channel, 0,
+				  0, 0,
 				  &timestamp, sizeof(timestamp),
 				  USB_CTRL_GET_TIMEOUT,
 				  GFP_KERNEL);
@@ -410,20 +411,20 @@ static inline int gs_usb_get_timestamp(const struct gs_can *dev,
 
 static u64 gs_usb_timestamp_read(const struct cyclecounter *cc) __must_hold(&dev->tc_lock)
 {
-	struct gs_can *dev = container_of(cc, struct gs_can, cc);
+	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
 	u32 timestamp = 0;
 	int err;
 
-	lockdep_assert_held(&dev->tc_lock);
+	lockdep_assert_held(&parent->tc_lock);
 
 	/* drop lock for synchronous USB transfer */
-	spin_unlock_bh(&dev->tc_lock);
-	err = gs_usb_get_timestamp(dev, &timestamp);
-	spin_lock_bh(&dev->tc_lock);
+	spin_unlock_bh(&parent->tc_lock);
+	err = gs_usb_get_timestamp(parent, &timestamp);
+	spin_lock_bh(&parent->tc_lock);
 	if (err)
-		netdev_err(dev->netdev,
-			   "Error %d while reading timestamp. HW timestamps may be inaccurate.",
-			   err);
+		dev_err(&parent->udev->dev,
+			"Error %d while reading timestamp. HW timestamps may be inaccurate.",
+			err);
 
 	return timestamp;
 }
@@ -431,14 +432,14 @@ static u64 gs_usb_timestamp_read(const struct cyclecounter *cc) __must_hold(&dev
 static void gs_usb_timestamp_work(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
-	struct gs_can *dev;
+	struct gs_usb *parent;
 
-	dev = container_of(delayed_work, struct gs_can, timestamp);
-	spin_lock_bh(&dev->tc_lock);
-	timecounter_read(&dev->tc);
-	spin_unlock_bh(&dev->tc_lock);
+	parent = container_of(delayed_work, struct gs_usb, timestamp);
+	spin_lock_bh(&parent->tc_lock);
+	timecounter_read(&parent->tc);
+	spin_unlock_bh(&parent->tc_lock);
 
-	schedule_delayed_work(&dev->timestamp,
+	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
@@ -446,37 +447,38 @@ static void gs_usb_skb_set_timestamp(struct gs_can *dev,
 				     struct sk_buff *skb, u32 timestamp)
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+	struct gs_usb *parent = dev->parent;
 	u64 ns;
 
-	spin_lock_bh(&dev->tc_lock);
-	ns = timecounter_cyc2time(&dev->tc, timestamp);
-	spin_unlock_bh(&dev->tc_lock);
+	spin_lock_bh(&parent->tc_lock);
+	ns = timecounter_cyc2time(&parent->tc, timestamp);
+	spin_unlock_bh(&parent->tc_lock);
 
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void gs_usb_timestamp_init(struct gs_can *dev)
+static void gs_usb_timestamp_init(struct gs_usb *parent)
 {
-	struct cyclecounter *cc = &dev->cc;
+	struct cyclecounter *cc = &parent->cc;
 
 	cc->read = gs_usb_timestamp_read;
 	cc->mask = CYCLECOUNTER_MASK(32);
 	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
 	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
 
-	spin_lock_init(&dev->tc_lock);
-	spin_lock_bh(&dev->tc_lock);
-	timecounter_init(&dev->tc, &dev->cc, ktime_get_real_ns());
-	spin_unlock_bh(&dev->tc_lock);
+	spin_lock_init(&parent->tc_lock);
+	spin_lock_bh(&parent->tc_lock);
+	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
+	spin_unlock_bh(&parent->tc_lock);
 
-	INIT_DELAYED_WORK(&dev->timestamp, gs_usb_timestamp_work);
-	schedule_delayed_work(&dev->timestamp,
+	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
+	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
-static void gs_usb_timestamp_stop(struct gs_can *dev)
+static void gs_usb_timestamp_stop(struct gs_usb *parent)
 {
-	cancel_delayed_work_sync(&dev->timestamp);
+	cancel_delayed_work_sync(&parent->timestamp);
 }
 
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
@@ -560,6 +562,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (!netif_device_present(netdev))
 		return;
 
+	if (!netif_running(netdev))
+		goto resubmit_urb;
+
 	if (hf->echo_id == -1) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(dev->netdev, &cfd);
@@ -856,6 +861,9 @@ static int gs_can_open(struct net_device *netdev)
 	}
 
 	if (!parent->active_channels) {
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			gs_usb_timestamp_init(parent);
+
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -926,13 +934,9 @@ static int gs_can_open(struct net_device *netdev)
 		flags |= GS_CAN_MODE_FD;
 
 	/* if hardware supports timestamps, enable it */
-	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		flags |= GS_CAN_MODE_HW_TIMESTAMP;
 
-		/* start polling timestamp */
-		gs_usb_timestamp_init(dev);
-	}
-
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -942,8 +946,6 @@ static int gs_can_open(struct net_device *netdev)
 				  GFP_KERNEL);
 	if (rc) {
 		netdev_err(netdev, "Couldn't start device (err=%d)\n", rc);
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(dev);
 		dev->can.state = CAN_STATE_STOPPED;
 
 		goto out_usb_kill_anchored_urbs;
@@ -960,9 +962,13 @@ static int gs_can_open(struct net_device *netdev)
 out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
-	if (!parent->active_channels)
+	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&dev->tx_submitted);
 
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			gs_usb_timestamp_stop(parent);
+	}
+
 	close_candev(netdev);
 
 	return rc;
@@ -1011,14 +1017,13 @@ static int gs_can_close(struct net_device *netdev)
 
 	netif_stop_queue(netdev);
 
-	/* stop polling timestamp */
-	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-		gs_usb_timestamp_stop(dev);
-
 	/* Stop polling */
 	parent->active_channels--;
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			gs_usb_timestamp_stop(parent);
 	}
 
 	/* Stop sending URBs */
-- 
2.40.1


