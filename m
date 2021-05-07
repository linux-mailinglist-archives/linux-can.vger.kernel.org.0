Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB073762CB
	for <lists+linux-can@lfdr.de>; Fri,  7 May 2021 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhEGJ16 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 May 2021 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbhEGJ16 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 May 2021 05:27:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA522C061344
        for <linux-can@vger.kernel.org>; Fri,  7 May 2021 02:18:43 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lewd8-0000oy-FO
        for linux-can@vger.kernel.org; Fri, 07 May 2021 11:18:42 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 749F861EAB1
        for <linux-can@vger.kernel.org>; Fri,  7 May 2021 09:18:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2834A61EAAD;
        Fri,  7 May 2021 09:18:41 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 6583159c;
        Fri, 7 May 2021 09:18:40 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Sottas Guillaume <Guillaume.Sottas@liebherr.com>
Subject: [PATCH v2] can: isotp: isotp_sendmsg(): fix return error on FC timeout on TX path
Date:   Fri,  7 May 2021 11:18:39 +0200
Message-Id: <20210507091839.1366379-1-mkl@pengutronix.de>
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

When the a large chunk of data send and the receiver does not send a
Flow Control frame back in time, the sendmsg() does not return a error
code, but the number of bytes sent corresponding to the size of the
packet.

If a timeout occurs the isotp_tx_timer_handler() is fired, sets
sk->sk_err and calls the sk->sk_error_report() function. It was
wrongly expected that the error would be propagated to user space in
every case. For isotp_sendmsg() blocking on wait_event_interruptible()
this is not the case.

This patch fixes the problem by checking if sk->sk_err is set and
returning the error to user space.

Link: https://github.com/hartkopp/can-isotp/issues/42
Link: https://github.com/hartkopp/can-isotp/pull/43
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Sottas Guillaume (LMB) <Guillaume.Sottas@liebherr.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1:
- add proper patch descriptiom
- return negative error value

 net/can/isotp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 9f94ad3caee9..d2601717211d 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -954,6 +954,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (wait_tx_done) {
 		/* wait for complete transmission of current pdu */
 		wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
+
+		if (sk->sk_err)
+			return -sk->sk_err;
 	}
 
 	return size;
-- 
2.30.2


