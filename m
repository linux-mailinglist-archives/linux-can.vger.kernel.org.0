Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A89E3CC15
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfFKMsZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39723 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388591AbfFKMsZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:25 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Ek-My; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005QA-Jh; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 06/16] j1939: transport: remove j1939_fix_cb()
Date:   Tue, 11 Jun 2019 14:48:04 +0200
Message-Id: <20190611124814.19908-7-o.rempel@pengutronix.de>
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

MSG_SYN is not supported any more.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 19014c4811bc..d3d23277f03b 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -207,11 +207,6 @@ static int j1939_xtp_abort_to_errno(struct j1939_priv *priv,
 	return EPROTO;
 }
 
-static inline void j1939_fix_cb(struct j1939_sk_buff_cb *skcb)
-{
-	skcb->msg_flags &= ~MSG_SYN;
-}
-
 static inline void j1939_session_list_lock(struct j1939_priv *priv)
 {
 	spin_lock_bh(&priv->active_session_list_lock);
@@ -534,7 +529,6 @@ static struct sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 
 	memcpy(skb->cb, re_skcb, sizeof(skb->cb));
 	skcb = j1939_skb_to_cb(skb);
-	j1939_fix_cb(skcb);
 	if (swap_src_dst)
 		j1939_skbcb_swap(skcb);
 
@@ -1181,7 +1175,6 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
-	j1939_fix_cb(skcb);
 	skcb->addr.pgn = pgn;
 
 	session = j1939_session_new(priv, skb, skb->len);
-- 
2.20.1

