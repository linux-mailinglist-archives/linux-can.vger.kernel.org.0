Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6856C565653
	for <lists+linux-can@lfdr.de>; Mon,  4 Jul 2022 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiGDNAD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jul 2022 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiGDNAB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2022 09:00:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8699EA1BF
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 06:00:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8LgE-0003Bd-WF
        for linux-can@vger.kernel.org; Mon, 04 Jul 2022 14:59:59 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 97D55A7C15
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 12:59:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E600A7C0D;
        Mon,  4 Jul 2022 12:59:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 07c76312;
        Mon, 4 Jul 2022 12:59:57 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/5] can: slcan: fix whitespace issues
Date:   Mon,  4 Jul 2022 14:59:52 +0200
Message-Id: <20220704125954.1587880-4-mkl@pengutronix.de>
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

Add and remove whitespace to make checkpatch happy.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/slcan/slcan-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index b81681f8094f..8b3aa6215420 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -74,7 +74,7 @@ module_param(maxdev, int, 0);
 MODULE_PARM_DESC(maxdev, "Maximum number of slcan interfaces");
 
 /* maximum rx buffer len: extended CAN frame with timestamp */
-#define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r")+1)
+#define SLC_MTU (sizeof("T1111222281122334455667788EA5F\r") + 1)
 
 #define SLC_CMD_LEN 1
 #define SLC_SFF_ID_LEN 3
@@ -624,7 +624,7 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	netif_stop_queue(sl->dev);
-	slc_encaps(sl, (struct can_frame *) skb->data); /* encaps & send */
+	slc_encaps(sl, (struct can_frame *)skb->data); /* encaps & send */
 	spin_unlock(&sl->lock);
 
 out:
@@ -804,7 +804,7 @@ static void slcan_receive_buf(struct tty_struct *tty,
 			      const unsigned char *cp, const char *fp,
 			      int count)
 {
-	struct slcan *sl = (struct slcan *) tty->disc_data;
+	struct slcan *sl = (struct slcan *)tty->disc_data;
 
 	if (!sl || sl->magic != SLCAN_MAGIC || !netif_running(sl->dev))
 		return;
@@ -976,7 +976,7 @@ static int slcan_open(struct tty_struct *tty)
  */
 static void slcan_close(struct tty_struct *tty)
 {
-	struct slcan *sl = (struct slcan *) tty->disc_data;
+	struct slcan *sl = (struct slcan *)tty->disc_data;
 
 	/* First make sure we're connected. */
 	if (!sl || sl->magic != SLCAN_MAGIC || sl->tty != tty)
@@ -1006,7 +1006,7 @@ static void slcan_hangup(struct tty_struct *tty)
 static int slcan_ioctl(struct tty_struct *tty, unsigned int cmd,
 		       unsigned long arg)
 {
-	struct slcan *sl = (struct slcan *) tty->disc_data;
+	struct slcan *sl = (struct slcan *)tty->disc_data;
 	unsigned int tmp;
 
 	/* First make sure we're connected. */
-- 
2.35.1


