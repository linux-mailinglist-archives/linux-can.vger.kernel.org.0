Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6E687B9C
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBBLJK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjBBLJH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41046F74C
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSd-0006mj-K7
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:08:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6068316D2B2
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:08:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 0021416D287;
        Thu,  2 Feb 2023 11:08:56 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 52a34c04;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 04/17] can: bittiming: can_get_bittiming(): use direct return and remove unneeded else
Date:   Thu,  2 Feb 2023 12:08:41 +0100
Message-Id: <20230202110854.2318594-5-mkl@pengutronix.de>
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

Clean up the code flow a bit, don't assign err variable but directly
return. Remove the unneeded else, too.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/bittiming.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index e4917c2f34d3..263e46a1f648 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -67,22 +67,18 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		      const u32 *bitrate_const,
 		      const unsigned int bitrate_const_cnt)
 {
-	int err;
-
 	/* Depending on the given can_bittiming parameter structure the CAN
 	 * timing parameters are calculated based on the provided bitrate OR
 	 * alternatively the CAN timing parameters (tq, prop_seg, etc.) are
 	 * provided directly which are then checked and fixed up.
 	 */
 	if (!bt->tq && bt->bitrate && btc)
-		err = can_calc_bittiming(dev, bt, btc);
-	else if (bt->tq && !bt->bitrate && btc)
-		err = can_fixup_bittiming(dev, bt, btc);
-	else if (!bt->tq && bt->bitrate && bitrate_const)
-		err = can_validate_bitrate(dev, bt, bitrate_const,
-					   bitrate_const_cnt);
-	else
-		err = -EINVAL;
+		return can_calc_bittiming(dev, bt, btc);
+	if (bt->tq && !bt->bitrate && btc)
+		return can_fixup_bittiming(dev, bt, btc);
+	if (!bt->tq && bt->bitrate && bitrate_const)
+		return can_validate_bitrate(dev, bt, bitrate_const,
+					    bitrate_const_cnt);
 
-	return err;
+	return -EINVAL;
 }
-- 
2.39.1


