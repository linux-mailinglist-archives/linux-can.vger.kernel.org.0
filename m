Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AA25449C9
	for <lists+linux-can@lfdr.de>; Thu,  9 Jun 2022 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiFILOb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 9 Jun 2022 07:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiFILOa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Jun 2022 07:14:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F91D42
        for <linux-can@vger.kernel.org>; Thu,  9 Jun 2022 04:14:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nzG7P-0000AE-AP
        for linux-can@vger.kernel.org; Thu, 09 Jun 2022 13:14:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id D0BD590052
        for <linux-can@vger.kernel.org>; Thu,  9 Jun 2022 11:14:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9426090050;
        Thu,  9 Jun 2022 11:14:26 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0706d792;
        Thu, 9 Jun 2022 11:14:26 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [PATCH] xilinx_can: fix typo prescalar -> prescaler
Date:   Thu,  9 Jun 2022 13:14:24 +0200
Message-Id: <20220609111424.3819039-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
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

This patch fixes the typo prescalar -> prescaler.

Reported-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc: Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 70dcb45078bf..393b2d9f9d2a 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -51,7 +51,7 @@ enum xcan_reg {
 
 	/* only on CAN FD cores */
 	XCAN_F_BRPR_OFFSET	= 0x088, /* Data Phase Baud Rate
-					  * Prescalar
+					  * Prescaler
 					  */
 	XCAN_F_BTR_OFFSET	= 0x08C, /* Data Phase Bit Timing */
 	XCAN_TRR_OFFSET		= 0x0090, /* TX Buffer Ready Request */
@@ -430,7 +430,7 @@ static int xcan_set_bittiming(struct net_device *ndev)
 		return -EPERM;
 	}
 
-	/* Setting Baud Rate prescalar value in BRPR Register */
+	/* Setting Baud Rate prescaler value in BRPR Register */
 	btr0 = (bt->brp - 1);
 
 	/* Setting Time Segment 1 in BTR Register */
@@ -447,7 +447,7 @@ static int xcan_set_bittiming(struct net_device *ndev)
 
 	if (priv->devtype.cantype == XAXI_CANFD ||
 	    priv->devtype.cantype == XAXI_CANFD_2_0) {
-		/* Setting Baud Rate prescalar value in F_BRPR Register */
+		/* Setting Baud Rate prescaler value in F_BRPR Register */
 		btr0 = dbt->brp - 1;
 		if (can_tdc_is_enabled(&priv->can)) {
 			if (priv->devtype.cantype == XAXI_CANFD)
-- 
2.35.1


