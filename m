Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A2436D48D
	for <lists+linux-can@lfdr.de>; Wed, 28 Apr 2021 11:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhD1JKE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 28 Apr 2021 05:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhD1JKE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Apr 2021 05:10:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E0EC06138A
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 02:09:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lbgC6-0005OH-9G
        for linux-can@vger.kernel.org; Wed, 28 Apr 2021 11:09:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 41A476186B2
        for <linux-can@vger.kernel.org>; Wed, 28 Apr 2021 09:09:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id B4A086186AE;
        Wed, 28 Apr 2021 09:09:16 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c28809de;
        Wed, 28 Apr 2021 09:09:15 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: isotp: return -ECOMM on FC timeout on TX path
Date:   Wed, 28 Apr 2021 11:09:14 +0200
Message-Id: <20210428090914.252967-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: "Sottas Guillaume (LMB)" <Guillaume.Sottas@liebherr.com>

Link: https://github.com/hartkopp/can-isotp/pull/43
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Not-Signed-off-by: Sottas Guillaume (LMB) <Guillaume.Sottas@liebherr.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Hello,

for better reviewing I'm posting Sottas's patch here. While porting to
current net/master I've fixed up the indention.

regards,
Marc

 net/can/isotp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9f94ad3caee9..d02e8f1f240f 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -110,6 +110,11 @@ MODULE_ALIAS("can-proto-6");
 #define ISOTP_FC_WT 1		/* wait */
 #define ISOTP_FC_OVFLW 2	/* overflow */
 
+enum {
+	ISOTP_ERR_NO_ERROR = 0,
+	ISOTP_ERR_FC_TIMEOUT,
+};
+
 enum {
 	ISOTP_IDLE = 0,
 	ISOTP_WAIT_FIRST_FC,
@@ -122,6 +127,7 @@ struct tpcon {
 	int idx;
 	int len;
 	u8 state;
+	u8 error;
 	u8 bs;
 	u8 sn;
 	u8 ll_dl;
@@ -756,6 +762,10 @@ static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk->sk_error_report(sk);
 
+		/* set error flag in order to consume it later in the
+		 * isotp_sendmsg function */
+		so->tx.error = ISOTP_ERR_FC_TIMEOUT;
+
 		/* reset tx state */
 		so->tx.state = ISOTP_IDLE;
 		wake_up_interruptible(&so->wait);
@@ -954,6 +964,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
 		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+
+		/* check if an error has been raised in the timer
+		 * function handler */
+		if (so->tx.error == ISOTP_ERR_FC_TIMEOUT) {
+			so->tx.error = ISOTP_ERR_NO_ERROR;
+			return -ECOMM;
+		}
 	}
 
 	return size;
@@ -1371,6 +1388,9 @@ static int isotp_init(struct sock *sk)
 	so->tx.state = ISOTP_IDLE;
 
 	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+
+	so->tx.error = ISOTP_ERR_NO_ERROR;
+	so->rx.error = ISOTP_ERR_NO_ERROR;
 	so->rxtimer.function = isotp_rx_timer_handler;
 	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	so->txtimer.function = isotp_tx_timer_handler;
-- 
2.30.2


