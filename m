Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D780848FE
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2019 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfHGJzs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 7 Aug 2019 05:55:48 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44751 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbfHGJzr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Aug 2019 05:55:47 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfY-0005F7-HN; Wed, 07 Aug 2019 11:55:44 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hvIfX-0001iQ-6O; Wed, 07 Aug 2019 11:55:43 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 3/5] j1939: add comments for locks
Date:   Wed,  7 Aug 2019 11:55:39 +0200
Message-Id: <20190807095541.2544-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807095541.2544-1-o.rempel@pengutronix.de>
References: <20190807095541.2544-1-o.rempel@pengutronix.de>
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
 net/can/j1939/j1939-priv.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index feb6bc64db0a..5881e4c86b44 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -81,8 +81,10 @@ struct j1939_priv {
 
 	unsigned int tp_max_packet_size;
 
-	struct list_head j1939_socks;
+	/* lock for j1939_socks list */
 	spinlock_t j1939_socks_lock;
+	struct list_head j1939_socks;
+
 	struct kref rx_kref;
 };
 
@@ -226,6 +228,7 @@ struct j1939_session {
 	struct list_head active_session_list_entry;
 	struct list_head sk_session_queue_entry;
 	struct kref kref;
+	/* session lock */
 	spinlock_t lock;
 	struct sock *sk;
 
@@ -306,6 +309,7 @@ struct j1939_sock {
 	atomic_t skb_pending;
 	wait_queue_head_t waitq;
 
+	/* lock for the sk_session_queue list */
 	spinlock_t sk_session_queue_lock;
 	struct list_head sk_session_queue;
 };
-- 
2.20.1

