Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25A132EBCE
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhCENCg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 08:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhCENCZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 08:02:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C7C061761
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 05:02:24 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIA63-0006Sd-IK
        for linux-can@vger.kernel.org; Fri, 05 Mar 2021 14:02:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 4BC335EE870
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:02:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 21F755EE83C;
        Fri,  5 Mar 2021 13:02:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7db7d7c6;
        Fri, 5 Mar 2021 13:02:13 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 09/12] can: c_can: add a comment about IF_RX interface's use
Date:   Fri,  5 Mar 2021 14:02:08 +0100
Message-Id: <20210305130211.2860914-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305130211.2860914-1-mkl@pengutronix.de>
References: <20210305130211.2860914-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dario Binacchi <dariobin@libero.it>

After reading the commit 640916db2bf7 ("can: c_can: Make it SMP safe")
it may sound strange to see the IF_RX interface used by the
can_inval_tx_object function. A comment was added to avoid any
misunderstanding.

Link: https://lore.kernel.org/r/20210302215435.18286-4-dariobin@libero.it
Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index ce4efc88a841..3c2cc9dbf5ad 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -722,6 +722,11 @@ static void c_can_do_tx(struct net_device *dev)
 		idx--;
 		pend &= ~(1 << idx);
 		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+
+		/* We use IF_RX interface instead of IF_TX because we
+		 * are called from c_can_poll(), which runs inside
+		 * NAPI. We are not trasmitting.
+		 */
 		c_can_inval_tx_object(dev, IF_RX, obj);
 		can_get_echo_skb(dev, idx, NULL);
 		bytes += priv->dlc[idx];
-- 
2.30.1


