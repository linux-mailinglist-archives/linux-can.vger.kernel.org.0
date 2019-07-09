Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5B563328
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfGII7X (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36693 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfGII7W (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:22 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085U-H1; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000fo-Cp; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 13/34] j1939: socket: drop sanity check for ifindex
Date:   Tue,  9 Jul 2019 10:58:48 +0200
Message-Id: <20190709085909.1413-13-o.rempel@pengutronix.de>
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
 net/can/j1939/socket.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 19e662574b5f..39df867cfe84 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -272,14 +272,9 @@ static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
 static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 {
 	const struct j1939_sk_buff_cb *oskcb = j1939_skb_to_cb(oskb);
-	const struct can_skb_priv *oskb_prv = can_skb_prv(oskb);
 	struct j1939_sk_buff_cb *skcb;
 	struct sk_buff *skb;
 
-	if (jsk->ifindex != oskb_prv->ifindex)
-		/* this socket does not take packets from this iface */
-		return;
-
 	if (!j1939_sk_recv_match_one(jsk, oskcb))
 		return;
 
-- 
2.20.1

