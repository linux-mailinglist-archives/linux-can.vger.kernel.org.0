Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC987448
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2019 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405641AbfHIIgF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 9 Aug 2019 04:36:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45381 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405668AbfHIIgA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Aug 2019 04:36:00 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NQ-00059G-IL; Fri, 09 Aug 2019 10:35:56 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hw0NO-0004QP-Rn; Fri, 09 Aug 2019 10:35:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 15/21] j1939: set proper error value for simple session timeout
Date:   Fri,  9 Aug 2019 10:35:47 +0200
Message-Id: <20190809083553.16687-16-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809083553.16687-1-o.rempel@pengutronix.de>
References: <20190809083553.16687-1-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 0af861485649..9bb9fbcf5754 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1146,7 +1146,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 		/* The message is probably stuck in the CAN controller and can
 		 * be send as soon as CAN bus is in working state again.
 		 */
-		session->err = -ENETUNREACH;
+		session->err = -ETIME;
 		j1939_session_deactivate(session);
 	} else {
 		netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
-- 
2.20.1

