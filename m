Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D4A831FE
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfHFM6s (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 08:58:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59153 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfHFM6r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 08:58:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz37-0002wJ-7l; Tue, 06 Aug 2019 14:58:45 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz36-0003ri-Mf; Tue, 06 Aug 2019 14:58:44 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 5/6] j1939: transport: remove SKBTX_ANY_TSTAMP from simple skb
Date:   Tue,  6 Aug 2019 14:58:39 +0200
Message-Id: <20190806125840.5634-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806125840.5634-1-o.rempel@pengutronix.de>
References: <20190806125840.5634-1-o.rempel@pengutronix.de>
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

We put our own statistic to the error queue

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 2d1511a64c55..9872082254c4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1046,6 +1046,7 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
 			skb = skb_clone(se_skb, GFP_ATOMIC);
 			if (skb) {
 				can_skb_set_owner(skb, se_skb->sk);
+				skb_shinfo(skb)->tx_flags &= ~SKBTX_ANY_TSTAMP;
 
 				j1939_tp_set_rxtimeout(session,
 						       J1939_XTP_ABORT_TIMEOUT_MS);
-- 
2.20.1

