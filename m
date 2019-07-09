Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09F363317
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfGII7S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36633 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGII7R (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:17 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085K-H1; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000a0-1n; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 03/34] j1939: transport: remove unused priv
Date:   Tue,  9 Jul 2019 10:58:38 +0200
Message-Id: <20190709085909.1413-3-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index b10352fafe84..e0c8fb469d96 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1064,7 +1064,6 @@ j1939_xtp_rx_eoma(struct j1939_session *session, struct sk_buff *skb)
 static void
 j1939_xtp_rx_cts(struct j1939_session *session, struct sk_buff *skb)
 {
-	struct j1939_priv *priv = session->priv;
 	enum j1939_xtp_abort err = J1939_XTP_ABORT_FAULT;
 	unsigned int pkt;
 	const u8 *dat;
-- 
2.20.1

