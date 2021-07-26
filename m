Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00D83D5B28
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 16:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhGZNcT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhGZNbk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:31:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B23C0617A3
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:12:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81Kw-000160-Sk
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:12:06 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6F2646581BF
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:11:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E17A365815E;
        Mon, 26 Jul 2021 14:11:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id d0e38aa4;
        Mon, 26 Jul 2021 14:11:45 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 05/46] can: j1939: j1939_session_tx_dat(): use consistent name se_skcb for session skb control buffer
Date:   Mon, 26 Jul 2021 16:11:03 +0200
Message-Id: <20210726141144.862529-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726141144.862529-1-mkl@pengutronix.de>
References: <20210726141144.862529-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch changes the name of the "skcb" variable in
j1939_session_tx_dat() to "se_skcb" as it's the session skb's control
buffer. The same name is used in other functions for the session skb's
control buffer.

Cc: Robin van der Gracht <robin@protonic.nl>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20210616102811.2449426-5-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 56c239698834..8de69c7681c4 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -776,7 +776,7 @@ static int j1939_session_tx_dpo(struct j1939_session *session)
 static int j1939_session_tx_dat(struct j1939_session *session)
 {
 	struct j1939_priv *priv = session->priv;
-	struct j1939_sk_buff_cb *skcb;
+	struct j1939_sk_buff_cb *se_skcb;
 	int offset, pkt_done, pkt_end;
 	unsigned int len, pdelay;
 	struct sk_buff *se_skb;
@@ -788,7 +788,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 	if (!se_skb)
 		return -ENOBUFS;
 
-	skcb = j1939_skb_to_cb(se_skb);
+	se_skcb = j1939_skb_to_cb(se_skb);
 	tpdat = se_skb->data;
 	ret = 0;
 	pkt_done = 0;
@@ -800,7 +800,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 
 	while (session->pkt.tx < pkt_end) {
 		dat[0] = session->pkt.tx - session->pkt.dpo + 1;
-		offset = (session->pkt.tx * 7) - skcb->offset;
+		offset = (session->pkt.tx * 7) - se_skcb->offset;
 		len =  se_skb->len - offset;
 		if (len > 7)
 			len = 7;
@@ -808,7 +808,7 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 		if (offset + len > se_skb->len) {
 			netdev_err_once(priv->ndev,
 					"%s: 0x%p: requested data outside of queued buffer: offset %i, len %i, pkt.tx: %i\n",
-					__func__, session, skcb->offset,
+					__func__, session, se_skcb->offset,
 					se_skb->len , session->pkt.tx);
 			ret = -EOVERFLOW;
 			goto out_free;
-- 
2.30.2


