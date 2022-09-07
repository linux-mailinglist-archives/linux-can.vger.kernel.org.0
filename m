Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F65B01FD
	for <lists+linux-can@lfdr.de>; Wed,  7 Sep 2022 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIGKiz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Sep 2022 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiIGKiw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2022 06:38:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935EF7675A
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 03:38:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oVsSG-0001Iu-VN
        for linux-can@vger.kernel.org; Wed, 07 Sep 2022 12:38:49 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4D0F6DC66C
        for <linux-can@vger.kernel.org>; Wed,  7 Sep 2022 10:38:48 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8A8C0DC661;
        Wed,  7 Sep 2022 10:38:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e2c5c73a;
        Wed, 7 Sep 2022 10:38:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/5] can: bittiming: can_calc_bittiming(): make use of min3()
Date:   Wed,  7 Sep 2022 12:38:42 +0200
Message-Id: <20220907103845.3929288-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907103845.3929288-1-mkl@pengutronix.de>
References: <20220907103845.3929288-1-mkl@pengutronix.de>
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

In can_calc_bittiming() there are several open coded checks to ensure
that SJW is within certain limits. Replace this by a single call to
min3().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index d3caa040614d..ce6bef2444a2 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -158,12 +158,8 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	if (!bt->sjw || !btc->sjw_max) {
 		bt->sjw = 1;
 	} else {
-		/* bt->sjw is at least 1 -> sanitize upper bound to sjw_max */
-		if (bt->sjw > btc->sjw_max)
-			bt->sjw = btc->sjw_max;
-		/* bt->sjw must not be higher than tseg2 */
-		if (tseg2 < bt->sjw)
-			bt->sjw = tseg2;
+		/* sjw must not be higher than sjw_max and tseg2 */
+		bt->sjw = min3(bt->sjw, btc->sjw_max, tseg2);
 	}
 
 	bt->brp = best_brp;
-- 
2.35.1


