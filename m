Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D7C3D5B2A
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhGZNcU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 09:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhGZNbi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:31:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694FC061796
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:12:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81Kv-00012m-3E
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:12:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3B06E6581BD
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:11:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 178D0658161;
        Mon, 26 Jul 2021 14:11:47 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2da52f5d;
        Mon, 26 Jul 2021 14:11:45 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 06/46] can: j1939: j1939_xtp_rx_dat_one(): use separate pointer for session skb control buffer
Date:   Mon, 26 Jul 2021 16:11:04 +0200
Message-Id: <20210726141144.862529-7-mkl@pengutronix.de>
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

In the j1939_xtp_rx_dat_one() function, there are 2 variables (skb and
se_skb) holding a skb. The control buffer of the skbs is accessed one
after the other, but using the same "skcb" variable.

To avoid confusion introduce a new variable "se_skcb" to access the
se_skb's control buffer as done in the rest of this file, too.

Cc: Robin van der Gracht <robin@protonic.nl>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20210616102811.2449426-6-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8de69c7681c4..efdf79de3db6 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1771,7 +1771,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	struct j1939_priv *priv = session->priv;
-	struct j1939_sk_buff_cb *skcb;
+	struct j1939_sk_buff_cb *skcb, *se_skcb;
 	struct sk_buff *se_skb = NULL;
 	const u8 *dat;
 	u8 *tpdat;
@@ -1822,8 +1822,8 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 		goto out_session_cancel;
 	}
 
-	skcb = j1939_skb_to_cb(se_skb);
-	offset = packet * 7 - skcb->offset;
+	se_skcb = j1939_skb_to_cb(se_skb);
+	offset = packet * 7 - se_skcb->offset;
 	nbytes = se_skb->len - offset;
 	if (nbytes > 7)
 		nbytes = 7;
@@ -1851,7 +1851,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	if (packet == session->pkt.rx)
 		session->pkt.rx++;
 
-	if (skcb->addr.type != J1939_ETP &&
+	if (se_skcb->addr.type != J1939_ETP &&
 	    j1939_cb_is_broadcast(&session->skcb)) {
 		if (session->pkt.rx >= session->pkt.total)
 			final = true;
-- 
2.30.2


