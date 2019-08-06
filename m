Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1728883201
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2019 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfHFM7S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 6 Aug 2019 08:59:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59423 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFM7S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 6 Aug 2019 08:59:18 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz37-0002wK-7l; Tue, 06 Aug 2019 14:58:45 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1huz36-0003rs-NZ; Tue, 06 Aug 2019 14:58:44 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: [PATCH v1 6/6] j1939: transport: j1939_xtp_rx_dat_one: add sanity check for j1939_session_skb_find()
Date:   Tue,  6 Aug 2019 14:58:40 +0200
Message-Id: <20190806125840.5634-7-o.rempel@pengutronix.de>
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

j1939_session_skb_find() may return NULL.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 9872082254c4..cda1db7a46a1 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1703,6 +1703,12 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 		goto out_session_unlock;
 	}
 	se_skb = j1939_session_skb_find(session);
+	if (!se_skb) {
+		netdev_warn(priv->ndev, "%s: 0x%p: no skb found\n", __func__,
+			    session);
+		goto out_session_unlock;
+	}
+
 	skcb = j1939_skb_to_cb(se_skb);
 	offset = packet * 7 - skcb->offset;
 	nbytes = se_skb->len - offset;
-- 
2.20.1

