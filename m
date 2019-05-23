Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4384927980
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfEWJlw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 05:41:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42553 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbfEWJlu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 05:41:50 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEI-0001Fy-Pa; Thu, 23 May 2019 11:41:42 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hTkEH-000444-CE; Thu, 23 May 2019 11:41:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 05/17] j1939: socket: use min_t where possible
Date:   Thu, 23 May 2019 11:41:27 +0200
Message-Id: <20190523094139.15517-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523094139.15517-1-o.rempel@pengutronix.de>
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
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
 net/can/j1939/socket.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index be2d32452b64..68f1ccc44109 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -844,10 +844,8 @@ static int j1939_sk_send_multi(struct j1939_priv *priv,  struct sock *sk,
 	while (todo_size) {
 		struct j1939_sk_buff_cb *skcb;
 
-		if (todo_size > J1939_MAX_TP_PACKET_SIZE)
-			segment_size = J1939_MAX_TP_PACKET_SIZE;
-		else
-			segment_size = todo_size;
+		segment_size = min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
+				     todo_size);
 
 		/* Allocate skb for one segment */
 		skb = j1939_sk_alloc_skb(priv->ndev, sk, msg, segment_size,
-- 
2.20.1

