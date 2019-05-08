Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA5179D8
	for <lists+linux-can@lfdr.de>; Wed,  8 May 2019 15:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfEHNFW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 May 2019 09:05:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45767 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfEHNFV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2019 09:05:21 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG7-0005RA-BH; Wed, 08 May 2019 15:05:19 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hOMG6-0004rt-E8; Wed, 08 May 2019 15:05:18 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v3 3/3] j1939: check supported  recv*() flags
Date:   Wed,  8 May 2019 15:05:16 +0200
Message-Id: <20190508130516.3954-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508130516.3954-1-o.rempel@pengutronix.de>
References: <20190508130516.3954-1-o.rempel@pengutronix.de>
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
 net/can/j1939/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 658ee798e794..ea272dcb6682 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -622,6 +622,9 @@ static int j1939_sk_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct j1939_sk_buff_cb *skcb;
 	int ret = 0;
 
+	if (flags & ~(MSG_DONTWAIT | MSG_ERRQUEUE))
+		return -EINVAL;
+
 	if (flags & MSG_ERRQUEUE)
 		return sock_recv_errqueue(sock->sk, msg, size, SOL_CAN_J1939,
 					  SCM_J1939_ERRQUEUE);
-- 
2.20.1

