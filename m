Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFEC5A364E
	for <lists+linux-can@lfdr.de>; Sat, 27 Aug 2022 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiH0JZy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 27 Aug 2022 05:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiH0JZw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 27 Aug 2022 05:25:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFEB75484
        for <linux-can@vger.kernel.org>; Sat, 27 Aug 2022 02:25:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oRs4a-0001UZ-QY
        for linux-can@vger.kernel.org; Sat, 27 Aug 2022 11:25:48 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 47498D4E6E
        for <linux-can@vger.kernel.org>; Sat, 27 Aug 2022 09:25:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 03948D4E68;
        Sat, 27 Aug 2022 09:25:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 213361f8;
        Sat, 27 Aug 2022 09:25:47 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/2] can: gs_usb: hardware timestamp support
Date:   Sat, 27 Aug 2022 11:25:44 +0200
Message-Id: <20220827092545.2971240-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827092545.2971240-1-mkl@pengutronix.de>
References: <20220827092545.2971240-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for hardware timestamps, if the firmware includes it as a
feature via the GS_CAN_FEATURE_HW_TIMESTAMP flag. Check for this
feature during probe, extend the RX expected length if it is and
enable it during open.

The struct classic_can_ts and struct canfd_ts are copied and extended
to include the µs timestamp following data as defined in the firmware.
The timestamp is then captured and set using skb_hwtstamps() on each
RX.

The frame µs timestamp is provided from a 32 bit 1 MHz timer which
rolls over every 4294 seconds, so a cyclecounter, timecounter, and
delayed worker are used to convert the timer into a proper ns
timestamp - same implementation as commit efd8d98dfb900 ("can:
mcp251xfd: add HW timestamp infrastructure").

Hardware timestamps are added to capabilities as commit
b1f6b93e678f ("can: mcp251xfd: advertise timestamping capabilities and
add ioctl support").

Signed-off-by: John Whittington <git@jbrengineering.co.uk>
Link: https://github.com/candle-usb/candleLight_fw/issues/100
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 149 +++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index baf749c8cda3..0c06f5067241 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -10,12 +10,16 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clocksource.h>
 #include <linux/ethtool.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/signal.h>
+#include <linux/timecounter.h>
+#include <linux/units.h>
 #include <linux/usb.h>
+#include <linux/workqueue.h>
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
@@ -37,6 +41,14 @@
 #define GSUSB_ENDPOINT_IN 1
 #define GSUSB_ENDPOINT_OUT 2
 
+/* Timestamp 32 bit timer runs at 1 MHz (1 µs tick). Worker accounts
+ * for timer overflow (will be after ~71 minutes)
+ */
+#define GSUSB_TIMESTAMP_TIMER_HZ (1 * HZ_PER_MHZ)
+#define GSUSB_TIMESTAMP_WORK_DELAY_SEC 1800
+static_assert(GSUSB_TIMESTAMP_WORK_DELAY_SEC <
+	      CYCLECOUNTER_MASK(32) / GSUSB_TIMESTAMP_TIMER_HZ / 2);
+
 /* Device specific constants */
 enum gs_usb_breq {
 	GS_USB_BREQ_HOST_FORMAT = 0,
@@ -199,6 +211,11 @@ struct classic_can {
 	u8 data[8];
 } __packed;
 
+struct classic_can_ts {
+	u8 data[8];
+	__le32 timestamp_us;
+} __packed;
+
 struct classic_can_quirk {
 	u8 data[8];
 	u8 quirk;
@@ -208,6 +225,11 @@ struct canfd {
 	u8 data[64];
 } __packed;
 
+struct canfd_ts {
+	u8 data[64];
+	__le32 timestamp_us;
+} __packed;
+
 struct canfd_quirk {
 	u8 data[64];
 	u8 quirk;
@@ -224,8 +246,10 @@ struct gs_host_frame {
 
 	union {
 		DECLARE_FLEX_ARRAY(struct classic_can, classic_can);
+		DECLARE_FLEX_ARRAY(struct classic_can_ts, classic_can_ts);
 		DECLARE_FLEX_ARRAY(struct classic_can_quirk, classic_can_quirk);
 		DECLARE_FLEX_ARRAY(struct canfd, canfd);
+		DECLARE_FLEX_ARRAY(struct canfd_ts, canfd_ts);
 		DECLARE_FLEX_ARRAY(struct canfd_quirk, canfd_quirk);
 	};
 } __packed;
@@ -259,6 +283,11 @@ struct gs_can {
 	struct can_bittiming_const bt_const, data_bt_const;
 	unsigned int channel;	/* channel number */
 
+	/* time counter for hardware timestamps */
+	struct cyclecounter cc;
+	struct timecounter tc;
+	struct delayed_work timestamp;
+
 	u32 feature;
 	unsigned int hf_size_tx;
 
@@ -351,6 +380,78 @@ static int gs_cmd_reset(struct gs_can *gsdev)
 	return rc;
 }
 
+static inline int gs_usb_get_sof_timestamp(const struct gs_can *dev,
+					   u32 *sof_timestamp_us)
+{
+	return usb_control_msg_recv(interface_to_usbdev(dev->iface),
+				    usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
+				    GS_USB_BREQ_TIMESTAMP,
+				    USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+				    dev->channel, 0,
+				    sof_timestamp_us, sizeof(*sof_timestamp_us),
+				    USB_CTRL_GET_TIMEOUT,
+				    GFP_KERNEL);
+}
+
+static u64 gs_usb_timestamp_read(const struct cyclecounter *cc)
+{
+	const struct gs_can *dev;
+	u32 timestamp = 0;
+	int err;
+
+	dev = container_of(cc, struct gs_can, cc);
+	err = gs_usb_get_sof_timestamp(dev, &timestamp);
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
+static void gs_usb_timestamp_init(struct gs_can *dev)
+{
+	struct cyclecounter *cc = &dev->cc;
+
+	cc->read = gs_usb_timestamp_read;
+	cc->mask = CYCLECOUNTER_MASK(32);
+	cc->shift = 32 - bits_per(NSEC_PER_SEC / GSUSB_TIMESTAMP_TIMER_HZ);
+	cc->mult = clocksource_hz2mult(GSUSB_TIMESTAMP_TIMER_HZ, cc->shift);
+
+	timecounter_init(&dev->tc, &dev->cc, ktime_get_real_ns());
+
+	INIT_DELAYED_WORK(&dev->timestamp, gs_usb_timestamp_work);
+	schedule_delayed_work(&dev->timestamp,
+			      GSUSB_TIMESTAMP_WORK_DELAY_SEC * HZ);
+}
+
+static void gs_usb_timestamp_stop(struct gs_can *dev)
+{
+	cancel_delayed_work_sync(&dev->timestamp);
+}
+
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
 {
 	struct can_device_stats *can_stats = &dev->can.can_stats;
@@ -428,6 +529,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 				cfd->flags |= CANFD_ESI;
 
 			memcpy(cfd->data, hf->canfd->data, cfd->len);
+
+			/* set hardware timestamp if supported */
+			if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+				gs_usb_set_timestamp(dev, skb,
+						     le32_to_cpu(hf->canfd_ts->timestamp_us));
 		} else {
 			skb = alloc_can_skb(dev->netdev, &cf);
 			if (!skb)
@@ -438,6 +544,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			memcpy(cf->data, hf->classic_can->data, 8);
 
+			/* set hardware timestamp if supported */
+			if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+				gs_usb_set_timestamp(dev, skb,
+						     le32_to_cpu(hf->classic_can_ts->timestamp_us));
+
 			/* ERROR frames tell us information about the controller */
 			if (le32_to_cpu(hf->can_id) & CAN_ERR_FLAG)
 				gs_update_state(dev, cf);
@@ -823,6 +934,10 @@ static int gs_can_open(struct net_device *netdev)
 	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES)
 		flags |= GS_CAN_MODE_TRIPLE_SAMPLE;
 
+	/* if hardware supports timestamps, enable it */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		flags |= GS_CAN_MODE_HW_TIMESTAMP;
+
 	/* finally start device */
 	dm->mode = cpu_to_le32(GS_CAN_MODE_START);
 	dm->flags = cpu_to_le32(flags);
@@ -840,6 +955,10 @@ static int gs_can_open(struct net_device *netdev)
 
 	kfree(dm);
 
+	/* start polling sof timestamp */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_init(dev);
+
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	parent->active_channels++;
@@ -858,6 +977,10 @@ static int gs_can_close(struct net_device *netdev)
 
 	netif_stop_queue(netdev);
 
+	/* Stop polling sof timestamp */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		gs_usb_timestamp_stop(dev);
+
 	/* Stop polling */
 	parent->active_channels--;
 	if (!parent->active_channels) {
@@ -895,6 +1018,7 @@ static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_stop = gs_can_close,
 	.ndo_start_xmit = gs_can_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 };
 
 static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
@@ -946,7 +1070,7 @@ static int gs_usb_set_phys_id(struct net_device *dev,
 
 static const struct ethtool_ops gs_usb_ethtool_ops = {
 	.set_phys_id = gs_usb_set_phys_id,
-	.get_ts_info = ethtool_op_get_ts_info,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 static struct gs_can *gs_make_candev(unsigned int channel,
@@ -1202,15 +1326,13 @@ static int gs_usb_probe(struct usb_interface *intf,
 	}
 
 	init_usb_anchor(&dev->rx_submitted);
-	/* default to classic CAN, switch to CAN-FD if at least one of
-	 * our channels support CAN-FD.
-	 */
-	dev->hf_size_rx = struct_size(hf, classic_can, 1);
 
 	usb_set_intfdata(intf, dev);
 	dev->udev = udev;
 
 	for (i = 0; i < icount; i++) {
+		unsigned int hf_size_rx = 0;
+
 		dev->canch[i] = gs_make_candev(i, intf, dconf);
 		if (IS_ERR_OR_NULL(dev->canch[i])) {
 			/* save error code to return later */
@@ -1228,8 +1350,21 @@ static int gs_usb_probe(struct usb_interface *intf,
 		}
 		dev->canch[i]->parent = dev;
 
-		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD)
-			dev->hf_size_rx = struct_size(hf, canfd, 1);
+		/* set RX packet size based on FD and if hardware
+                * timestamps are supported.
+		*/
+		if (dev->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+				hf_size_rx = struct_size(hf, canfd_ts, 1);
+			else
+				hf_size_rx = struct_size(hf, canfd, 1);
+		} else {
+			if (dev->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+				hf_size_rx = struct_size(hf, classic_can_ts, 1);
+			else
+				hf_size_rx = struct_size(hf, classic_can, 1);
+		}
+		dev->hf_size_rx = max(dev->hf_size_rx, hf_size_rx);
 	}
 
 	kfree(dconf);
-- 
2.35.1


