Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F97AFADC2
	for <lists+linux-can@lfdr.de>; Wed, 13 Nov 2019 10:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKMJ4S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 13 Nov 2019 04:56:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59535 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfKMJ4A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Nov 2019 04:56:00 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iUpNW-0006Nh-A3; Wed, 13 Nov 2019 10:55:58 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 7/9] can: j1939: transport: j1939_cancel_active_session(): use hrtimer_try_to_cancel() instead of hrtimer_cancel()
Date:   Wed, 13 Nov 2019 10:55:48 +0100
Message-Id: <20191113095550.26527-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113095550.26527-1-mkl@pengutronix.de>
References: <20191113095550.26527-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

This part of the code protected by lock used in the hrtimer as well.
Using hrtimer_cancel() will trigger dead lock.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index afc2adfd97e4..0c62b8fc4b20 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -2039,7 +2039,11 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 				 &priv->active_session_list,
 				 active_session_list_entry) {
 		if (!sk || sk == session->sk) {
-			j1939_session_timers_cancel(session);
+			if (hrtimer_try_to_cancel(&session->txtimer) == 1)
+				j1939_session_put(session);
+			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
+				j1939_session_put(session);
+
 			session->err = ESHUTDOWN;
 			j1939_session_deactivate_locked(session);
 		}
-- 
2.24.0

