Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF2C3A9743
	for <lists+linux-can@lfdr.de>; Wed, 16 Jun 2021 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhFPKac (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhFPKa2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 06:30:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56819C061767
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 03:28:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ltSmS-0005DZ-Ph
        for linux-can@vger.kernel.org; Wed, 16 Jun 2021 12:28:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 8F4A463D18C
        for <linux-can@vger.kernel.org>; Wed, 16 Jun 2021 10:28:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 7E71663D166;
        Wed, 16 Jun 2021 10:28:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id c36d3231;
        Wed, 16 Jun 2021 10:28:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [can-next-rfc 5/9] can: j1939: j1939_xtp_rx_dat_one(): use separate pointer for session skb control buffer
Date:   Wed, 16 Jun 2021 12:28:07 +0200
Message-Id: <20210616102811.2449426-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616102811.2449426-1-mkl@pengutronix.de>
References: <20210616102811.2449426-1-mkl@pengutronix.de>
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index d6b78da2a986..bbac0e321716 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1747,7 +1747,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	struct j1939_priv *priv = session->priv;
-	struct j1939_sk_buff_cb *skcb;
+	struct j1939_sk_buff_cb *skcb, *se_skcb;
 	struct sk_buff *se_skb;
 	const u8 *dat;
 	u8 *tpdat;
@@ -1798,8 +1798,8 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 		goto out_session_cancel;
 	}
 
-	skcb = j1939_skb_to_cb(se_skb);
-	offset = packet * 7 - skcb->offset;
+	se_skcb = j1939_skb_to_cb(se_skb);
+	offset = packet * 7 - se_skcb->offset;
 	nbytes = se_skb->len - offset;
 	if (nbytes > 7)
 		nbytes = 7;
@@ -1827,7 +1827,7 @@ static void j1939_xtp_rx_dat_one(struct j1939_session *session,
 	if (packet == session->pkt.rx)
 		session->pkt.rx++;
 
-	if (skcb->addr.type != J1939_ETP &&
+	if (se_skcb->addr.type != J1939_ETP &&
 	    j1939_cb_is_broadcast(&session->skcb)) {
 		if (session->pkt.rx >= session->pkt.total)
 			final = true;
-- 
2.30.2


