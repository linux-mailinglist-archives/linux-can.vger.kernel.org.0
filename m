Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8635656564A
	for <lists+linux-can@lfdr.de>; Mon,  4 Jul 2022 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiGDNAD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jul 2022 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiGDNAB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2022 09:00:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486227650
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 06:00:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o8LgE-0003Bn-Po
        for linux-can@vger.kernel.org; Mon, 04 Jul 2022 14:59:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9F30BA7C17
        for <linux-can@vger.kernel.org>; Mon,  4 Jul 2022 12:59:57 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 893A8A7C10;
        Mon,  4 Jul 2022 12:59:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9b4c8b74;
        Mon, 4 Jul 2022 12:59:57 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/5] can: slcan: convert comparison to NULL into !val
Date:   Mon,  4 Jul 2022 14:59:53 +0200
Message-Id: <20220704125954.1587880-5-mkl@pengutronix.de>
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

All comparison to NULL could be written "!val", convert them to make
checkpatch happy.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/slcan/slcan-core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 8b3aa6215420..09f76a62c7f1 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -618,7 +618,7 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 		netdev_warn(dev, "xmit: iface is down\n");
 		goto out;
 	}
-	if (sl->tty == NULL) {
+	if (!sl->tty) {
 		spin_unlock(&sl->lock);
 		goto out;
 	}
@@ -707,7 +707,7 @@ static int slc_open(struct net_device *dev)
 	unsigned char cmd[SLC_MTU];
 	int err, s;
 
-	if (sl->tty == NULL)
+	if (!sl->tty)
 		return -ENODEV;
 
 	/* The baud rate is not set with the command
@@ -834,7 +834,7 @@ static void slc_sync(void)
 
 	for (i = 0; i < maxdev; i++) {
 		dev = slcan_devs[i];
-		if (dev == NULL)
+		if (!dev)
 			break;
 
 		sl = netdev_priv(dev);
@@ -854,9 +854,8 @@ static struct slcan *slc_alloc(void)
 
 	for (i = 0; i < maxdev; i++) {
 		dev = slcan_devs[i];
-		if (dev == NULL)
+		if (!dev)
 			break;
-
 	}
 
 	/* Sorry, too many, all slots in use */
@@ -902,7 +901,7 @@ static int slcan_open(struct tty_struct *tty)
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 
-	if (tty->ops->write == NULL)
+	if (!tty->ops->write)
 		return -EOPNOTSUPP;
 
 	/* RTnetlink lock is misused here to serialize concurrent
@@ -924,7 +923,7 @@ static int slcan_open(struct tty_struct *tty)
 	/* OK.  Find a free SLCAN channel to use. */
 	err = -ENFILE;
 	sl = slc_alloc();
-	if (sl == NULL)
+	if (!sl)
 		goto err_exit;
 
 	sl->tty = tty;
@@ -1071,7 +1070,7 @@ static void __exit slcan_exit(void)
 	unsigned long timeout = jiffies + HZ;
 	int busy = 0;
 
-	if (slcan_devs == NULL)
+	if (!slcan_devs)
 		return;
 
 	/* First of all: check for active disciplines and hangup them.
-- 
2.35.1


