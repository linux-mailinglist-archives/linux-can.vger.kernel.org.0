Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D0687BA8
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBBLJS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjBBLJK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFF0F763
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:06 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSi-0006yk-To
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:09:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 009C216D2F8
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:09:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8E89716D29D;
        Thu,  2 Feb 2023 11:08:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c9cce0c8;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Thomas Kopp <Thomas.Kopp@microchip.com>
Subject: [PATCH v2 15/17] can: bittiming: can_calc_bittiming(): clean up SJW handling
Date:   Thu,  2 Feb 2023 12:08:52 +0100
Message-Id: <20230202110854.2318594-16-mkl@pengutronix.de>
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

In the current code, if the user configures a bitrate, a default SJW
value of 1 is used. If the user configures both a bitrate and a SJW
value, can_calc_bittiming() silently limits the SJW value to SJW max
and TSEG2.

We came to the conclusion that if the user provided an invalid SJW
value, it's best to bail out and inform the user [1].

[1] https://lore.kernel.org/all/CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com

Further the ISO 11898-1:2015 standard mandates that "SJW shall be less
than or equal to the minimum of these two items: Phase_Seg1 and
Phase_Seg2." [2] The current code is missing that check.

[2] https://lore.kernel.org/all/BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com

The previous patches introduced
1) can_sjw_set_default() - sets a default value for SJW if unset
2) can_sjw_check() - implements a SJW check against SJW max, Phase
   Seg1 and Phase Seg2. In the error case this function reports the error
   to user space via netlink.

Replace both the open-coded SJW default setting and the open-coded and
insufficient checks of SJW with the helper functions
can_sjw_set_default() and can_sjw_check().

Link: https://lore.kernel.org/all/CAMZ6RqKqhmTgUZiwe5uqUjBDnhhC2iOjZ791+Y845btJYwVDKg@mail.gmail.com
Link: https://lore.kernel.org/all/BL3PR11MB64844E3FC13C55433CDD0B3DFB449@BL3PR11MB6484.namprd11.prod.outlook.com
Suggested-by: Thomas Kopp <Thomas.Kopp@microchip.com>
Suggested-by: Vincent Mailhol <vincent.mailhol@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 46d28f377186..4c9e9c0ceff3 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -76,6 +76,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	unsigned int best_brp = 0;		/* current best value for brp */
 	unsigned int brp, tsegall, tseg, tseg1 = 0, tseg2 = 0;
 	u64 v64;
+	int err;
 
 	/* Use CiA recommended sample points */
 	if (bt->sample_point) {
@@ -154,17 +155,11 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	bt->phase_seg1 = tseg1 - bt->prop_seg;
 	bt->phase_seg2 = tseg2;
 
-	/* check for sjw user settings */
-	if (!bt->sjw || !btc->sjw_max) {
-		bt->sjw = 1;
-	} else {
-		/* bt->sjw is at least 1 -> sanitize upper bound to sjw_max */
-		if (bt->sjw > btc->sjw_max)
-			bt->sjw = btc->sjw_max;
-		/* bt->sjw must not be higher than tseg2 */
-		if (tseg2 < bt->sjw)
-			bt->sjw = tseg2;
-	}
+	can_sjw_set_default(bt);
+
+	err = can_sjw_check(dev, bt, btc, extack);
+	if (err)
+		return err;
 
 	bt->brp = best_brp;
 
-- 
2.39.1


