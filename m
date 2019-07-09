Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBEEA6331B
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfGII7T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34523 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfGII7T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:19 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085W-HK; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000ij-Fb; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 15/34] j1939: socket: no need to check for (J1939_SOCK_BOUND | J1939_SOCK_CONNECTED)
Date:   Tue,  9 Jul 2019 10:58:50 +0200
Message-Id: <20190709085909.1413-15-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709085909.1413-1-o.rempel@pengutronix.de>
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

We can't have J1939_SOCK_CONNECTED without J1939_SOCK_BOUND. So, it is
enough to test for J1939_SOCK_BOUND.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 39df867cfe84..89174b517b28 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -253,7 +253,7 @@ static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
 				    const struct j1939_sk_buff_cb *skcb)
 {
-	if (!(jsk->state & (J1939_SOCK_BOUND | J1939_SOCK_CONNECTED)))
+	if (!(jsk->state & J1939_SOCK_BOUND))
 		return false;
 
 	if (skcb->insock == &jsk->sk && !(jsk->state & J1939_SOCK_RECV_OWN))
-- 
2.20.1

