Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C1F1709B
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 07:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfEHF4F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 01:56:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46425 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbfEHF4F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 01:56:05 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hOFYf-0008RO-Q0; Wed, 08 May 2019 07:56:01 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hOFYe-0000mo-AJ; Wed, 08 May 2019 07:56:00 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH] j1939: transport: notify on not ENOBUFS errors
Date:   Wed,  8 May 2019 07:55:59 +0200
Message-Id: <20190508055559.2945-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

j1939_tp_tx_dat() can return critical errors. Even if we currently
can't handle it, it is better to know about them.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4943c390fca3..843c772c0659 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -805,6 +805,7 @@ static int j1939_tp_txnext(struct j1939_session *session)
 			pkt_end = session->pkt.last;
 
 		while (session->pkt.tx < pkt_end) {
+			struct j1939_priv *priv = session->priv;
 			dat[0] = session->pkt.tx - session->pkt.dpo + 1;
 			offset = (session->pkt.tx * 7) - skcb->offset;
 			len =  se_skb->len - offset;
@@ -812,8 +813,14 @@ static int j1939_tp_txnext(struct j1939_session *session)
 				len = 7;
 			memcpy(&dat[1], &tpdat[offset], len);
 			ret = j1939_tp_tx_dat(session, dat, len + 1);
-			if (ret < 0)
+			if (ret < 0) {
+				/* ENOBUS == CAN interface TX queue is full */
+				if (ret != -ENOBUFS)
+					netdev_alert(priv->ndev,
+						     "%s: queue data error: %i\n",
+						     __func__, ret);
 				break;
+			}
 			session->last_txcmd = 0xff;
 			++pkt_done;
 			++session->pkt.tx;
-- 
2.20.1

