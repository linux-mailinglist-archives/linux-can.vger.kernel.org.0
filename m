Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C684F9EF5
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbiDHVMn (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 17:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiDHVMf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 17:12:35 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Apr 2022 14:10:27 PDT
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 600E917B8B9
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 14:10:27 -0700 (PDT)
Received: from localhost.localdomain ([93.35.164.10])
        by Aruba Outgoing Smtp  with ESMTPSA
        id cvr9nij0B79nYcvrAnFy5E; Fri, 08 Apr 2022 23:09:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1649452164; bh=zvVK/aJmzUqFc4aX2Dp9ESZBj1t6/6l/2t/r1bpWoG8=;
        h=From:To:Subject:Date:MIME-Version;
        b=L21JO5iG0Fhef2yr2Qcc5pWHZeS3Mkdd9OBNd3kQOieKuX/W7UwwjZ1scCBBUNBfF
         RG0g6pO5wT6pXrHzp5FNltvVqAf6gPDX9y/f/jRpUrl4sQmoStX6wwbIYGvHHHelU+
         wQTMj+m9d5CeuuBjey/kjbSLKbtgs2lxhhrfUDu/K34DxY+AMNBZSmAlOZ4iwAgBse
         jn0sB0+BfrDee1IXJocuFgPy7alpStAGTvrFKQ6WJHU85WswKEvoNacbSuP5HuhDCs
         FAmxW8auQcnc47NpS2RfYoU8hVmM8/V/ja7uBqYwzGbawOTT+ZuMLQlO7jkGX4sCag
         xUUHFy72G46ZQ==
From:   Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
Subject: [PATCH 2/2] can: j1939: make sure that sent CTL frames are marked as TX
Date:   Fri,  8 Apr 2022 23:09:10 +0200
Message-Id: <20220408210910.16137-3-devid.filoni@egluetechnologies.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408210910.16137-1-devid.filoni@egluetechnologies.com>
References: <20220408210910.16137-1-devid.filoni@egluetechnologies.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDs1cPSwuRdiCSLtLZyqg37B4TVJbz+ZxjWCtbMZPzJozG1yKobeZbVpzXO0x9SmaEyQtcDImFttjQcqnnnv1TM3NjUCsPZE7tkOZi/JsM1kNMO6IfCb
 IFFxc4/vAv66/aVNKIOmayo1RBwRlGJOm1JViFkm7PxJH55q5fT5V6Ujg2wvrXOsRGzjXmDUm4Xrt+IOEvkqCny711VJk4svtjAC08PGbq0o4urnbh2i0o7Z
 pgmC719EQuQsFhZMjb/PLNR7t+kqtueK7+5ghMe5nICdd292A41SY2BprEDK7jVSDb79YwTHkGceCVccT7yGBR2SocN4zQ+K52CLS72/IXvXq8sSFFxI7rTJ
 8qAlmjUPegJgTcWd2Ky6Sdmpooc/pA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fixes: 9d71dd0 ("can: add support of SAE J1939 protocol")
Signed-off-by: Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
---
 net/can/j1939/transport.c | 55 +++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 030f5fe901e1..b8368f9c78c2 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -648,6 +648,7 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
 }
 
 static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
+			       struct sock *re_sk,
 			       const struct j1939_sk_buff_cb *re_skcb,
 			       bool swap_src_dst, pgn_t pgn, const u8 *dat)
 {
@@ -661,6 +662,8 @@ static int j1939_xtp_do_tx_ctl(struct j1939_priv *priv,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	can_skb_set_owner(skb, re_sk);
+
 	skdat = skb_put(skb, 8);
 	memcpy(skdat, dat, 5);
 	skdat[5] = (pgn >> 0);
@@ -674,13 +677,26 @@ static inline int j1939_tp_tx_ctl(struct j1939_session *session,
 				  bool swap_src_dst, const u8 *dat)
 {
 	struct j1939_priv *priv = session->priv;
+	struct sk_buff *se_skb = j1939_session_skb_get(session);
+	struct sock *se_skb_sk = NULL;
+	int ret;
+
+	if (se_skb)
+		se_skb_sk = se_skb->sk;
 
-	return j1939_xtp_do_tx_ctl(priv, &session->skcb,
-				   swap_src_dst,
-				   session->skcb.addr.pgn, dat);
+	ret = j1939_xtp_do_tx_ctl(priv, se_skb_sk, &session->skcb,
+				  swap_src_dst,
+				  session->skcb.addr.pgn, dat);
+
+	if (ret)
+		kfree_skb(se_skb);
+	else
+		consume_skb(se_skb);
+	return ret;
 }
 
 static int j1939_xtp_tx_abort(struct j1939_priv *priv,
+			      struct sock *re_sk,
 			      const struct j1939_sk_buff_cb *re_skcb,
 			      bool swap_src_dst,
 			      enum j1939_xtp_abort err,
@@ -694,7 +710,7 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
 	memset(dat, 0xff, sizeof(dat));
 	dat[0] = J1939_TP_CMD_ABORT;
 	dat[1] = err;
-	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
+	return j1939_xtp_do_tx_ctl(priv, re_sk, re_skcb, swap_src_dst, pgn, dat);
 }
 
 void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
@@ -1117,6 +1133,8 @@ static void __j1939_session_cancel(struct j1939_session *session,
 				   enum j1939_xtp_abort err)
 {
 	struct j1939_priv *priv = session->priv;
+	struct sk_buff *se_skb;
+	struct sock *se_skb_sk = NULL;
 
 	WARN_ON_ONCE(!err);
 	lockdep_assert_held(&session->priv->active_session_list_lock);
@@ -1125,9 +1143,15 @@ static void __j1939_session_cancel(struct j1939_session *session,
 	session->state = J1939_SESSION_WAITING_ABORT;
 	/* do not send aborts on incoming broadcasts */
 	if (!j1939_cb_is_broadcast(&session->skcb)) {
-		j1939_xtp_tx_abort(priv, &session->skcb,
-				   !session->transmission,
-				   err, session->skcb.addr.pgn);
+		se_skb = j1939_session_skb_get(session);
+		if (se_skb)
+			se_skb_sk = se_skb->sk;
+		if (j1939_xtp_tx_abort(priv, se_skb_sk, &session->skcb,
+				       !session->transmission,
+				       err, session->skcb.addr.pgn))
+			kfree_skb(se_skb);
+		else
+			consume_skb(se_skb);
 	}
 
 	if (session->sk)
@@ -1274,6 +1298,8 @@ static bool j1939_xtp_rx_cmd_bad_pgn(struct j1939_session *session,
 	const struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	pgn_t pgn = j1939_xtp_ctl_to_pgn(skb->data);
 	struct j1939_priv *priv = session->priv;
+	struct sk_buff *se_skb;
+	struct sock *se_skb_sk = NULL;
 	enum j1939_xtp_abort abort = J1939_XTP_NO_ABORT;
 	u8 cmd = skb->data[0];
 
@@ -1318,8 +1344,15 @@ static bool j1939_xtp_rx_cmd_bad_pgn(struct j1939_session *session,
 
 	netdev_warn(priv->ndev, "%s: 0x%p: CMD 0x%02x with PGN 0x%05x for running session with different PGN 0x%05x.\n",
 		    __func__, session, cmd, pgn, session->skcb.addr.pgn);
-	if (abort != J1939_XTP_NO_ABORT)
-		j1939_xtp_tx_abort(priv, skcb, true, abort, pgn);
+	if (abort != J1939_XTP_NO_ABORT) {
+		se_skb = j1939_session_skb_get(session);
+		if (se_skb)
+			se_skb_sk = se_skb->sk;
+		if (j1939_xtp_tx_abort(priv, se_skb_sk, skcb, true, abort, pgn))
+			kfree_skb(se_skb);
+		else
+			consume_skb(se_skb);
+	}
 
 	return true;
 }
@@ -1625,13 +1658,13 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	}
 
 	if (abort != J1939_XTP_NO_ABORT) {
-		j1939_xtp_tx_abort(priv, &skcb, true, abort, pgn);
+		j1939_xtp_tx_abort(priv, skb->sk, &skcb, true, abort, pgn);
 		return NULL;
 	}
 
 	session = j1939_session_fresh_new(priv, len, &skcb);
 	if (!session) {
-		j1939_xtp_tx_abort(priv, &skcb, true,
+		j1939_xtp_tx_abort(priv, skb->sk, &skcb, true,
 				   J1939_XTP_ABORT_RESOURCE, pgn);
 		return NULL;
 	}
-- 
2.25.1

