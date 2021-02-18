Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D920831F1DB
	for <lists+linux-can@lfdr.de>; Thu, 18 Feb 2021 22:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBRVzV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 Feb 2021 16:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBRVzU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2021 16:55:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48EC061756
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 13:54:40 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lCrFu-0000kj-Ur
        for linux-can@vger.kernel.org; Thu, 18 Feb 2021 22:54:39 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 73A4A5E44ED
        for <linux-can@vger.kernel.org>; Thu, 18 Feb 2021 21:54:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B50445E44E4;
        Thu, 18 Feb 2021 21:54:36 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5f94f385;
        Thu, 18 Feb 2021 21:54:35 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [net-rfc 2/2] can: isotp: TX-path: ensure that CAN frame flags are initialized
Date:   Thu, 18 Feb 2021 22:54:34 +0100
Message-Id: <20210218215434.1708249-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218215434.1708249-1-mkl@pengutronix.de>
References: <20210218215434.1708249-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The previous patch ensures that the TX flags (struct
can_isotp_ll_options::tx_flags) are 0 for classic CAN frames or a user
configured value for CAN-FD frames.

This patch sets the CAN frames flags unconditionally to the ISO-TP TX
flags, so that they are initialized to a proper value. Otherwise when
running "candump -x" on a classical CAN ISO-TP stream shows wrongly
set "B" and "E" flags.

| $ candump any,0:0,#FFFFFFFF -extA
| [...]
| can0  TX B E  713   [8]  2B 0A 0B 0C 0D 0E 0F 00
| can0  TX B E  713   [8]  2C 01 02 03 04 05 06 07
| can0  TX B E  713   [8]  2D 08 09 0A 0B 0C 0D 0E
| can0  TX B E  713   [8]  2E 0F 00 01 02 03 04 05

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index e32d446c121e..430976485d95 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -215,8 +215,7 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	if (ae)
 		ncf->data[0] = so->opt.ext_address;
 
-	if (so->ll.mtu == CANFD_MTU)
-		ncf->flags = so->ll.tx_flags;
+	ncf->flags = so->ll.tx_flags;
 
 	can_send_ret = can_send(nskb, 1);
 	if (can_send_ret)
@@ -790,8 +789,7 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 		so->tx.sn %= 16;
 		so->tx.bs++;
 
-		if (so->ll.mtu == CANFD_MTU)
-			cf->flags = so->ll.tx_flags;
+		cf->flags = so->ll.tx_flags;
 
 		skb->dev = dev;
 		can_skb_set_owner(skb, sk);
@@ -939,8 +937,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	/* send the first or only CAN frame */
-	if (so->ll.mtu == CANFD_MTU)
-		cf->flags = so->ll.tx_flags;
+	cf->flags = so->ll.tx_flags;
 
 	skb->dev = dev;
 	skb->sk = sk;
-- 
2.30.0


