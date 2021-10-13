Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A62442C0F8
	for <lists+linux-can@lfdr.de>; Wed, 13 Oct 2021 15:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhJMNJB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Oct 2021 09:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhJMNJB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Oct 2021 09:09:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6084C061570
        for <linux-can@vger.kernel.org>; Wed, 13 Oct 2021 06:06:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1madyC-0005rs-DL
        for linux-can@vger.kernel.org; Wed, 13 Oct 2021 15:06:56 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8BECD692431
        for <linux-can@vger.kernel.org>; Wed, 13 Oct 2021 13:06:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 616FE69242E;
        Wed, 13 Oct 2021 13:06:55 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6fb1af4d;
        Wed, 13 Oct 2021 13:06:55 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Gary Bisson <bisson.gary@gmail.com>
Subject: [PATCH] can: bittiming: can_fixup_bittiming(): change type of tseg1 and alltseg to unsigned int
Date:   Wed, 13 Oct 2021 15:06:53 +0200
Message-Id: <20211013130653.1513627-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

All timing calculation is done with unsigned integers, so change type
of tseg1 and alltseg to unsigned int, too.

Link: https://github.com/linux-can/can-utils/pull/314
Reported-by: Gary Bisson <bisson.gary@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/bittiming.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/bittiming.c b/drivers/net/can/dev/bittiming.c
index f49170eadd54..b1b5a82f0829 100644
--- a/drivers/net/can/dev/bittiming.c
+++ b/drivers/net/can/dev/bittiming.c
@@ -209,7 +209,7 @@ static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt,
 			       const struct can_bittiming_const *btc)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	int tseg1, alltseg;
+	unsigned int tseg1, alltseg;
 	u64 brp64;
 
 	tseg1 = bt->prop_seg + bt->phase_seg1;
-- 
2.33.0


