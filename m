Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7A687B98
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBBLJI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjBBLJH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A09A9EC0
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:01 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSd-0006mh-EQ
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:08:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5B8E916D2B1
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:08:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EAE2A16D286;
        Thu,  2 Feb 2023 11:08:56 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2531a070;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 03/17] can: bittiming: can_fixup_bittiming(): set effective tq
Date:   Thu,  2 Feb 2023 12:08:40 +0100
Message-Id: <20230202110854.2318594-4-mkl@pengutronix.de>
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

The can_fixup_bittiming() function is used to validate the
user-supplied low-level bit timing parameters and calculate the
bitrate prescaler (brp) from the requested time quanta (tq) and the
CAN clock of the controller.

can_fixup_bittiming() selects the best matching integer bit rate
prescaler, which may result in a different time quantum than the value
specified by the user.

Calculate the resulting time quantum and assign it so that the user
sees the effective time quantum.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/bittiming.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 5e111dbbe090..e4917c2f34d3 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -40,6 +40,8 @@ static int can_fixup_bittiming(const struct net_device *dev, struct can_bittimin
 
 	bt->bitrate = priv->clock.freq / (bt->brp * can_bit_time(bt));
 	bt->sample_point = ((CAN_SYNC_SEG + tseg1) * 1000) / can_bit_time(bt);
+	bt->tq = DIV_U64_ROUND_CLOSEST(mul_u32_u32(bt->brp, NSEC_PER_SEC),
+				       priv->clock.freq);
 
 	return 0;
 }
-- 
2.39.1


