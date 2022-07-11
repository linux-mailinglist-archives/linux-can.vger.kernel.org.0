Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B227F56564E
	for <lists+linux-can@lfdr.de>; Mon,  4 Jul 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiGDNAD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jul 2022 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGDNAB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2022 09:00:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7999596
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 06:00:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8LgE-0003Bp-RI
        for linux-can@vger.kernel.org; Mon, 04 Jul 2022 14:59:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id B420DA7C18
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 12:59:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 9446EA7C14;
        Mon,  4 Jul 2022 12:59:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1746e7e6;
        Mon, 4 Jul 2022 12:59:57 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/5] can: slcan: clean up if/else
Date:   Mon,  4 Jul 2022 14:59:54 +0200
Message-Id: <20220704125954.1587880-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704125954.1587880-1-mkl@pengutronix.de>
References: <20220704125954.1587880-1-mkl@pengutronix.de>
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

Remove braces after if() for single statement blocks, also remove else
after return() in if() block.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/slcan/slcan-core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 09f76a62c7f1..ac2c60f330fe 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -469,19 +469,19 @@ static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
 		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    (sl->rcount > 4))  {
+		    sl->rcount > 4)
 			slc_bump(sl);
-		}
+
 		sl->rcount = 0;
 	} else {
 		if (!test_bit(SLF_ERROR, &sl->flags))  {
 			if (sl->rcount < SLC_MTU)  {
 				sl->rbuff[sl->rcount++] = s;
 				return;
-			} else {
-				sl->dev->stats.rx_over_errors++;
-				set_bit(SLF_ERROR, &sl->flags);
 			}
+
+			sl->dev->stats.rx_over_errors++;
+			set_bit(SLF_ERROR, &sl->flags);
 		}
 	}
 }
@@ -1104,9 +1104,8 @@ static void __exit slcan_exit(void)
 			continue;
 
 		sl = netdev_priv(dev);
-		if (sl->tty) {
+		if (sl->tty)
 			netdev_err(dev, "tty discipline still running\n");
-		}
 
 		slc_close(dev);
 		unregister_candev(dev);
-- 
2.35.1


