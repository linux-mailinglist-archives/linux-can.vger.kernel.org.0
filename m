Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0D687BA0
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBBLJN (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBBLJJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB73EFA2
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSh-0006vw-EI
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:09:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D962616D2EB
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:08:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 5013616D294;
        Thu,  2 Feb 2023 11:08:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 50724d52;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 11/17] can: bittiming: can_fixup_bittiming(): report error via netlink and harmonize error value
Date:   Thu,  2 Feb 2023 12:08:48 +0100
Message-Id: <20230202110854.2318594-12-mkl@pengutronix.de>
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

Check each bit timing parameter first individually against their
limits and report a meaningful error message via netlink to the user
space.

In case of an error, return -EINVAL instead of -ERANGE, this
corresponds better to the actual meaning of the error value.

Suggested-by: Vincent Mailhol <vincent.mailhol@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/bittiming.c | 38 +++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 101de1b3bf30..727dcd52cc2c 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -33,22 +33,38 @@ static int can_fixup_bittiming(const struct net_device *dev, struct can_bittimin
 			       const struct can_bittiming_const *btc,
 			       struct netlink_ext_ack *extack)
 {
+	const unsigned int tseg1 = bt->prop_seg + bt->phase_seg1;
 	const struct can_priv *priv = netdev_priv(dev);
-	unsigned int tseg1;
 	u64 brp64;
 	int err;
 
+	if (tseg1 < btc->tseg1_min) {
+		NL_SET_ERR_MSG_FMT(extack, "prop-seg + phase-seg1: %u less than tseg1-min: %u",
+				   tseg1, btc->tseg1_min);
+		return -EINVAL;
+	}
+	if (tseg1 > btc->tseg1_max) {
+		NL_SET_ERR_MSG_FMT(extack, "prop-seg + phase-seg1: %u greater than tseg1-max: %u",
+				   tseg1, btc->tseg1_max);
+		return -EINVAL;
+	}
+	if (bt->phase_seg2 < btc->tseg2_min) {
+		NL_SET_ERR_MSG_FMT(extack, "phase-seg2: %u less than tseg2-min: %u",
+				   bt->phase_seg2, btc->tseg2_min);
+		return -EINVAL;
+	}
+	if (bt->phase_seg2 > btc->tseg2_max) {
+		NL_SET_ERR_MSG_FMT(extack, "phase-seg2: %u greater than tseg2-max: %u",
+				   bt->phase_seg2, btc->tseg2_max);
+		return -EINVAL;
+	}
+
 	can_sjw_set_default(bt);
 
 	err = can_sjw_check(dev, bt, btc, extack);
 	if (err)
 		return err;
 
-	tseg1 = bt->prop_seg + bt->phase_seg1;
-	if (tseg1 < btc->tseg1_min || tseg1 > btc->tseg1_max ||
-	    bt->phase_seg2 < btc->tseg2_min || bt->phase_seg2 > btc->tseg2_max)
-		return -ERANGE;
-
 	brp64 = (u64)priv->clock.freq * (u64)bt->tq;
 	if (btc->brp_inc > 1)
 		do_div(brp64, btc->brp_inc);
@@ -58,8 +74,16 @@ static int can_fixup_bittiming(const struct net_device *dev, struct can_bittimin
 		brp64 *= btc->brp_inc;
 	bt->brp = (u32)brp64;
 
-	if (bt->brp < btc->brp_min || bt->brp > btc->brp_max)
+	if (bt->brp < btc->brp_min) {
+		NL_SET_ERR_MSG_FMT(extack, "resulting brp: %u less than brp-min: %u",
+				   bt->brp, btc->brp_min);
 		return -EINVAL;
+	}
+	if (bt->brp > btc->brp_max) {
+		NL_SET_ERR_MSG_FMT(extack, "resulting brp: %u greater than brp-max: %u",
+				   bt->brp, btc->brp_max);
+		return -EINVAL;
+	}
 
 	bt->bitrate = priv->clock.freq / (bt->brp * can_bit_time(bt));
 	bt->sample_point = ((CAN_SYNC_SEG + tseg1) * 1000) / can_bit_time(bt);
-- 
2.39.1


