Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B843CC0C
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfFKMsV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37969 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfFKMsU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:20 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Et-My; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005Sk-SS; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 15/16] j1939: transport: don't care about (E)TP commands less then 8 byte
Date:   Tue, 11 Jun 2019 14:48:13 +0200
Message-Id: <20190611124814.19908-16-o.rempel@pengutronix.de>
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

Currently all known commands have PGN in the payload. If size is too
small, there is no space for PGN and we can't create properly formatted
abort message.
So, instead of producing bogus abort messages, just ignore unknown or
boggy packages.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 2a167f7807bc..5fe919cead29 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1651,10 +1651,8 @@ int j1939_tp_recv(struct j1939_priv *priv, struct sk_buff *skb)
 	case J1939_ETP_PGN_CTL:
 		skcb->addr.type = J1939_ETP;
 	case J1939_TP_PGN_CTL: /* falltrough */
-		if (skb->len < 8) {
-			j1939_xtp_rx_bad_message(priv, skb);
-			break;
-		}
+		if (skb->len < 8)
+			return 0; /* Don't care. Nothing to extract here */
 
 		j1939_tp_cmd_recv(priv, skb);
 		break;
-- 
2.20.1

