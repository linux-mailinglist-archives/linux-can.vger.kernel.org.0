Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FA63337
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfGIJAS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 05:00:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56283 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGIJAS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 05:00:18 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085J-H2; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000ZW-0B; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 02/34] j1939: transport: make const what is possible
Date:   Tue,  9 Jul 2019 10:58:37 +0200
Message-Id: <20190709085909.1413-2-o.rempel@pengutronix.de>
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

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/transport.c  | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index eeefa2f0cbc9..612ed17864d0 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -161,7 +161,7 @@ struct j1939_sk_buff_cb {
 	priority_t priority;
 };
 
-static inline struct j1939_sk_buff_cb *j1939_skb_to_cb(struct sk_buff *skb)
+static inline struct j1939_sk_buff_cb *j1939_skb_to_cb(const struct sk_buff *skb)
 {
 	BUILD_BUG_ON(sizeof(struct j1939_sk_buff_cb) > sizeof(skb->cb));
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe9ab330f761..b10352fafe84 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -365,19 +365,19 @@ static struct sk_buff *j1939_session_skb_find(struct j1939_session *session)
 /* see if we are receiver
  * returns 0 for broadcasts, although we will receive them
  */
-static inline int j1939_tp_im_receiver(struct j1939_sk_buff_cb *skcb)
+static inline int j1939_tp_im_receiver(const struct j1939_sk_buff_cb *skcb)
 {
 	return skcb->dst_flags & J1939_ECU_LOCAL;
 }
 
 /* see if we are sender */
-static inline int j1939_tp_im_transmitter(struct j1939_sk_buff_cb *skcb)
+static inline int j1939_tp_im_transmitter(const struct j1939_sk_buff_cb *skcb)
 {
 	return skcb->src_flags & J1939_ECU_LOCAL;
 }
 
 /* see if we are involved as either receiver or transmitter */
-static int j1939_tp_im_involved(struct j1939_sk_buff_cb *skcb, bool swap)
+static int j1939_tp_im_involved(const struct j1939_sk_buff_cb *skcb, bool swap)
 {
 	if (swap)
 		return j1939_tp_im_receiver(skcb);
@@ -506,7 +506,7 @@ static void j1939_skbcb_swap(struct j1939_sk_buff_cb *skcb)
 }
 
 static struct sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
-					   struct j1939_sk_buff_cb *re_skcb,
+					   const struct j1939_sk_buff_cb *re_skcb,
 					   bool ctl,
 					   bool swap_src_dst)
 {
@@ -564,7 +564,7 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
 }
 
 static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
-			       struct j1939_sk_buff_cb *re_skcb,
+			       const struct j1939_sk_buff_cb *re_skcb,
 			       bool swap_src_dst, pgn_t pgn, const u8 *dat)
 {
 	struct sk_buff *skb;
@@ -597,7 +597,7 @@ static inline int j1939_tp_tx_ctl(struct j1939_session *session,
 }
 
 static int j1939_xtp_tx_abort(struct j1939_priv *priv,
-			      struct j1939_sk_buff_cb *re_skcb,
+			      const struct j1939_sk_buff_cb *re_skcb,
 			      bool swap_src_dst,
 			      enum j1939_xtp_abort err,
 			      pgn_t pgn)
-- 
2.20.1

