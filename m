Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14C3CC12
	for <lists+linux-can@lfdr.de>; Tue, 11 Jun 2019 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfFKMsY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jun 2019 08:48:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbfFKMsX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2019 08:48:23 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCH-0006Ef-N0; Tue, 11 Jun 2019 14:48:17 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hagCG-0005OV-Ek; Tue, 11 Jun 2019 14:48:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 01/16] j1939: transport: rename pending to active
Date:   Tue, 11 Jun 2019 14:47:59 +0200
Message-Id: <20190611124814.19908-2-o.rempel@pengutronix.de>
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

This list is used actually for active sessions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 88fe995a9716..7decc38a4d46 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1155,14 +1155,14 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 int j1939_session_activate(struct j1939_session *session)
 {
 	struct j1939_priv *priv = session->priv;
-	struct j1939_session *pending;
+	struct j1939_session *active;
 	int ret = 0;
 
 	j1939_session_list_lock(priv);
-	pending = j1939_session_get_by_skcb_locked(priv, &priv->active_session_list,
+	active = j1939_session_get_by_skcb_locked(priv, &priv->active_session_list,
 						   &session->skcb, false);
-	if (pending) {
-		j1939_session_put(pending);
+	if (active) {
+		j1939_session_put(active);
 		ret = -EAGAIN;
 	} else {
 		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
-- 
2.20.1

