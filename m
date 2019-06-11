Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153363CC17
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388619AbfFKMs0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52939 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbfFKMsZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Ej-N0; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005Pi-IN; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 05/16] j1939: transport: handle skb_clone() error in j1939_tp_txtimer()
Date:   Tue, 11 Jun 2019 14:48:03 +0200
Message-Id: <20190611124814.19908-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611124814.19908-1-o.rempel@pengutronix.de>
References: <20190611124814.19908-1-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index cd68b98fee92..19014c4811bc 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -883,10 +883,16 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 		struct sk_buff *se_skb = j1939_session_skb_find(session);
 
 		if (se_skb) {
-			ret = j1939_send_one(priv,
-					     skb_clone(se_skb, GFP_ATOMIC));
-			if (!ret)
-				j1939_session_deactivate_activate_next(session);
+			struct sk_buff *skb;
+
+			skb = skb_clone(se_skb, GFP_ATOMIC);
+			if (skb) {
+				ret = j1939_send_one(priv, skb);
+				if (!ret)
+					j1939_session_deactivate_activate_next(session);
+			} else {
+				ret = session->err = -ENOMEM;
+			}
 		}
 	} else {
 		ret = j1939_tp_txnext(session);
@@ -908,7 +914,8 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 	} else if (ret) {
 		netdev_alert(priv->ndev, "%s: tx aborted with unknown reason: %i\n",
 			     __func__, ret);
-		j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
+		if (session->skcb.addr.type != J1939_SIMPLE)
+			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
 	} else {
 		session->tx_retry = 0;
 	}
-- 
2.20.1

