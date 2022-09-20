Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963215BE29B
	for <lists+linux-can@lfdr.de>; Tue, 20 Sep 2022 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiITKEy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 20 Sep 2022 06:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiITKEw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 20 Sep 2022 06:04:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0522509
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 03:04:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oaa7V-0003qq-IY
        for linux-can@vger.kernel.org; Tue, 20 Sep 2022 12:04:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 37A9CE7475
        for <linux-can@vger.kernel.org>; Tue, 20 Sep 2022 10:04:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8184EE746A;
        Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6d962689;
        Tue, 20 Sep 2022 10:04:47 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/3] can: gs_usb: add missing lock to protect struct timecounter::cycle_last
Date:   Tue, 20 Sep 2022 12:04:16 +0200
Message-Id: <20220920100416.959226-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220920100416.959226-1-mkl@pengutronix.de>
References: <20220920100416.959226-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The struct timecounter::cycle_last is a 64 bit variable, read by
timecounter_cyc2time(), and written by timecounter_read(). On 32 bit
architectures this is not atomic.

Add a spinlock to protect access to struct timecounter::cycle_last. In
the gs_usb_timestamp_read() callback the lock is dropped to execute a
sleeping synchronous USB transfer. This is safe, as the variable we
want to protect is accessed during this call.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Cc: John Whittington <git@jbrengineering.co.uk>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 12e7437a9496..fe4116bf925b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -286,6 +286,7 @@ struct gs_can {
 	/* time counter for hardware timestamps */
 	struct cyclecounter cc;
 	struct timecounter tc;
+	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
 	struct delayed_work timestamp;
 
 	u32 feature;
@@ -401,14 +402,18 @@ static inline int gs_usb_get_timestamp(const struct gs_can *dev,
 	return 0;
 }
 
-static u64 gs_usb_timestamp_read(const struct cyclecounter *cc)
+static u64 gs_usb_timestamp_read(const struct cyclecounter *cc) __must_hold(&dev->tc_lock)
 {
-	const struct gs_can *dev;
+	struct gs_can *dev = container_of(cc, struct gs_can, cc);
 	u32 timestamp = 0;
 	int err;
 
-	dev = container_of(cc, struct gs_can, cc);
+	lockdep_assert_held(&dev->tc_lock);
+
+	/* drop lock for synchronous USB transfer */
+	spin_unlock_bh(&dev->tc_lock);
 	err = gs_usb_get_timestamp(dev, &timestamp);
+	spin_lock_bh(&dev->tc_lock);
 	if (err)
 		netdev_err(dev->netdev,
 			   "Error %d while reading timestamp. HW timestamps may be inaccurate.",
@@ -423,19 +428,24 @@ static void gs_usb_timestamp_work(struct work_struct *work)
 	struct gs_can *dev;
 
 	dev = container_of(delayed_work, struct gs_can, timestamp);
+	spin_lock_bh(&dev->tc_lock);
 	timecounter_read(&dev->tc);
+	spin_unlock_bh(&dev->tc_lock);
 
 	schedule_delayed_work(&dev->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
-static void gs_usb_skb_set_timestamp(const struct gs_can *dev,
+static void gs_usb_skb_set_timestamp(struct gs_can *dev,
 				     struct sk_buff *skb, u32 timestamp)
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
 	u64 ns;
 
+	spin_lock_bh(&dev->tc_lock);
 	ns = timecounter_cyc2time(&dev->tc, timestamp);
+	spin_unlock_bh(&dev->tc_lock);
+
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
@@ -448,7 +458,10 @@ static void gs_usb_timestamp_init(struct gs_can *dev)
 	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
 	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
 
+	spin_lock_init(&dev->tc_lock);
+	spin_lock_bh(&dev->tc_lock);
 	timecounter_init(&dev->tc, &dev->cc, ktime_get_real_ns());
+	spin_unlock_bh(&dev->tc_lock);
 
 	INIT_DELAYED_WORK(&dev->timestamp, gs_usb_timestamp_work);
 	schedule_delayed_work(&dev->timestamp,
@@ -485,7 +498,7 @@ static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
 	}
 }
 
-static void gs_usb_set_timestamp(const struct gs_can *dev, struct sk_buff *skb,
+static void gs_usb_set_timestamp(struct gs_can *dev, struct sk_buff *skb,
 				 const struct gs_host_frame *hf)
 {
 	u32 timestamp;
-- 
2.35.1


