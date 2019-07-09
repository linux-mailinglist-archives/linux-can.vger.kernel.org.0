Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111ED6331C
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGII7T (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 04:59:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38361 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfGII7T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 04:59:19 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxw-00085Q-HI; Tue, 09 Jul 2019 10:59:12 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hklxv-0000cT-8G; Tue, 09 Jul 2019 10:59:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 09/34] j1939: transport: do not send CTS or EOMA if no more receiver exist
Date:   Tue,  9 Jul 2019 10:58:44 +0200
Message-Id: <20190709085909.1413-9-o.rempel@pengutronix.de>
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
 net/can/j1939/transport.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 30d3e60c0e23..d7b9da858f62 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -802,10 +802,14 @@ static int j1939_xtp_txnext_transmiter(struct j1939_session *session)
 
 static int j1939_session_tx_cts(struct j1939_session *session)
 {
+	struct j1939_priv *priv = session->priv;
 	unsigned int pkt, len;
 	int ret;
 	u8 dat[8];
 
+	if (!j1939_sk_recv_match(priv, &session->skcb))
+		return -ENOENT;
+
 	len = session->pkt.total - session->pkt.rx;
 	len = min3(len, session->pkt.block, j1939_tp_block ?: 255);
 	memset(dat, 0xff, sizeof(dat));
@@ -841,9 +845,13 @@ static int j1939_session_tx_cts(struct j1939_session *session)
 
 static int j1939_session_tx_eoma(struct j1939_session *session)
 {
+	struct j1939_priv *priv = session->priv;
 	u8 dat[8];
 	int ret;
 
+	if (!j1939_sk_recv_match(priv, &session->skcb))
+		return -ENOENT;
+
 	memset(dat, 0xff, sizeof(dat));
 
 	if (session->skcb.addr.type == J1939_ETP) {
-- 
2.20.1

