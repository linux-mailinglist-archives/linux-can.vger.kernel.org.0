Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63B687BA2
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 12:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBBLJP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 06:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjBBLJJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 06:09:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909339777
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 03:09:05 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pNXSh-0006wZ-KF
        for linux-can@vger.kernel.org; Thu, 02 Feb 2023 12:09:03 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D9BCC16D2EC
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 11:08:59 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 615C916D296;
        Thu,  2 Feb 2023 11:08:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 422fd49e;
        Thu, 2 Feb 2023 11:08:56 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Thomas Kopp <thomas.kopp@microchip.com>, kernel@pengutronix.de,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Mark Bath <mark@baggywrinkle.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 12/17] can: bittiming: can_sjw_check(): report error via netlink and harmonize error value
Date:   Thu,  2 Feb 2023 12:08:49 +0100
Message-Id: <20230202110854.2318594-13-mkl@pengutronix.de>
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

If the user space has supplied an invalid SJW value (greater than the
maximum SJW value), report -EINVAL instead of -ERANGE, this better
matches the actual meaning of the error value.

Additionally report an error message via netlink to the user space.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/bittiming.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index 727dcd52cc2c..0a2a9b12565f 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -18,8 +18,11 @@ void can_sjw_set_default(struct can_bittiming *bt)
 int can_sjw_check(const struct net_device *dev, const struct can_bittiming *bt,
 		  const struct can_bittiming_const *btc, struct netlink_ext_ack *extack)
 {
-	if (bt->sjw > btc->sjw_max)
-		return -ERANGE;
+	if (bt->sjw > btc->sjw_max) {
+		NL_SET_ERR_MSG_FMT(extack, "sjw: %u greater than max sjw: %u",
+				   bt->sjw, btc->sjw_max);
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 
2.39.1


