Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFA1687BA4
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBBLJQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjBBLJJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91221C15C
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSh-0006wp-Ng
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:09:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D88FE16D2EA
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:08:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 37FBE16D292;
        Thu,  2 Feb 2023 11:08:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6ccfe1c8;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 10/17] can: bittiming: factor out can_sjw_set_default() and can_sjw_check()
Date:   Thu,  2 Feb 2023 12:08:47 +0100
Message-Id: <20230202110854.2318594-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202110854.2318594-1-mkl@pengutronix.de>
References: <20230202110854.2318594-1-mkl@pengutronix.de>
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

Factor out the functionality of assigning a SJW default value into
can_sjw_set_default() and the checking the SJW limits into
can_sjw_check().

This functions will be improved and called from a different function
in the following patches.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/bittiming.c | 30 ++++++++++++++++++++++++++----
 include/linux/can/bittiming.h   |  5 +++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 0b0b8c767c5b..101de1b3bf30 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -6,6 +6,24 @@
 
 #include <linux/can/dev.h>
 
+void can_sjw_set_default(struct can_bittiming *bt)
+{
+	if (bt->sjw)
+		return;
+
+	/* If user space provides no sjw, use 1 as default */
+	bt->sjw = 1;
+}
+
+int can_sjw_check(const struct net_device *dev, const struct can_bittiming *bt,
+		  const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
+{
+	if (bt->sjw > btc->sjw_max)
+		return -ERANGE;
+
+	return 0;
+}
+
 /* Checks the validity of the specified bit-timing parameters prop_seg,
  * phase_seg1, phase_seg2 and sjw and tries to determine the bitrate
  * prescaler value brp. You can find more information in the header
@@ -18,12 +36,16 @@ static int can_fixup_bittiming(const struct net_device *dev, struct can_bittimin
 	const struct can_priv *priv = netdev_priv(dev);
 	unsigned int tseg1;
 	u64 brp64;
+	int err;
+
+	can_sjw_set_default(bt);
+
+	err = can_sjw_check(dev, bt, btc, extack);
+	if (err)
+		return err;
 
 	tseg1 = bt->prop_seg + bt->phase_seg1;
-	if (!bt->sjw)
-		bt->sjw = 1;
-	if (bt->sjw > btc->sjw_max ||
-	    tseg1 < btc->tseg1_min || tseg1 > btc->tseg1_max ||
+	if (tseg1 < btc->tseg1_min || tseg1 > btc->tseg1_max ||
 	    bt->phase_seg2 < btc->tseg2_min || bt->phase_seg2 > btc->tseg2_max)
 		return -ERANGE;
 
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 53d693ae5397..6cb2ae308e3f 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -138,6 +138,11 @@ can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 }
 #endif /* CONFIG_CAN_CALC_BITTIMING */
 
+void can_sjw_set_default(struct can_bittiming *bt);
+
+int can_sjw_check(const struct net_device *dev, const struct can_bittiming *bt,
+		  const struct can_bittiming_const *btc, struct netlink_ext_ack *extack);
+
 int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		      const struct can_bittiming_const *btc,
 		      const u32 *bitrate_const,
-- 
2.39.1


