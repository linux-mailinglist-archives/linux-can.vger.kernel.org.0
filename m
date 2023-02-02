Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E3687BA5
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBBLJR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjBBLJK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAFC9EEB
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSi-0006yc-QJ
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:09:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id F0D4E16D2F7
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:09:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id A314316D2A1;
        Thu,  2 Feb 2023 11:08:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4619dc7d;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 16/17] can: bittiming: can_calc_bittiming(): convert from netdev_err() to NL_SET_ERR_MSG_FMT()
Date:   Thu,  2 Feb 2023 12:08:53 +0100
Message-Id: <20230202110854.2318594-17-mkl@pengutronix.de>
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

Replace the netdev_err() by NL_SET_ERR_MSG_FMT() to better inform the
user about the problem. While there, use %u to print unsigned values
and improve error message a bit.

In case of an error, return -EINVAL instead of -EDOM, this corresponds
better to the actual meaning of the error value.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 4c9e9c0ceff3..3809c148fb88 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -134,13 +134,14 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		do_div(v64, bt->bitrate);
 		bitrate_error = (u32)v64;
 		if (bitrate_error > CAN_CALC_MAX_ERROR) {
-			netdev_err(dev,
-				   "bitrate error %d.%d%% too high\n",
-				   bitrate_error / 10, bitrate_error % 10);
-			return -EDOM;
+			NL_SET_ERR_MSG_FMT(extack,
+					   "bitrate error: %u.%u%% too high",
+					   bitrate_error / 10, bitrate_error % 10);
+			return -EINVAL;
 		}
-		netdev_warn(dev, "bitrate error %d.%d%%\n",
-			    bitrate_error / 10, bitrate_error % 10);
+		NL_SET_ERR_MSG_FMT(extack,
+				   "bitrate error: %u.%u%%",
+				   bitrate_error / 10, bitrate_error % 10);
 	}
 
 	/* real sample point */
-- 
2.39.1


