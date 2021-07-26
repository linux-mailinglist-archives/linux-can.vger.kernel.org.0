Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6337F3D5B0B
	for <lists+linux-can@lfdr.de>; Mon, 26 Jul 2021 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhGZNbf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Jul 2021 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhGZNb1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Jul 2021 09:31:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6EAC0613CF
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 07:11:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m81Kk-0000iY-Ba
        for linux-can@vger.kernel.org; Mon, 26 Jul 2021 16:11:54 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id DB276658184
        for <linux-can@vger.kernel.org>; Mon, 26 Jul 2021 14:11:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 8218265815A;
        Mon, 26 Jul 2021 14:11:46 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ea98d188;
        Mon, 26 Jul 2021 14:11:45 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 02/46] can: j1939: fix checkpatch warnings
Date:   Mon, 26 Jul 2021 16:11:00 +0200
Message-Id: <20210726141144.862529-3-mkl@pengutronix.de>
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

This patch fixes a checkpatch warning about a long line and wrong
indention.

Cc: Robin van der Gracht <robin@protonic.nl>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20210616102811.2449426-2-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c3946c355882..d47caffb687d 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -808,7 +808,8 @@ static int j1939_session_tx_dat(struct j1939_session *session)
 		if (offset + len > se_skb->len) {
 			netdev_err_once(priv->ndev,
 					"%s: 0x%p: requested data outside of queued buffer: offset %i, len %i, pkt.tx: %i\n",
-					__func__, session, skcb->offset, se_skb->len , session->pkt.tx);
+					__func__, session, skcb->offset,
+					se_skb->len , session->pkt.tx);
 			ret = -EOVERFLOW;
 			goto out_free;
 		}
@@ -1092,7 +1093,7 @@ j1939_session_deactivate_activate_next(struct j1939_session *session)
 }
 
 static void __j1939_session_cancel(struct j1939_session *session,
-				 enum j1939_xtp_abort err)
+				   enum j1939_xtp_abort err)
 {
 	struct j1939_priv *priv = session->priv;
 
-- 
2.30.2


