Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F8432D6F0
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhCDPnu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 10:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbhCDPnd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 10:43:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8DC061764
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 07:42:49 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHq7j-0003bU-V9
        for linux-can@vger.kernel.org; Thu, 04 Mar 2021 16:42:48 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A2C8C5EDD30
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 15:42:44 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C43CA5EDD11;
        Thu,  4 Mar 2021 15:42:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1e31c629;
        Thu, 4 Mar 2021 15:42:41 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 05/11] can: c_can: replace double assignments by two single ones
Date:   Thu,  4 Mar 2021 16:42:34 +0100
Message-Id: <20210304154240.2747987-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210304154240.2747987-1-mkl@pengutronix.de>
References: <20210304154240.2747987-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch replaces the double assignments by two single ones, to make
checkpatch happy.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 9563fa9a4dcf..eb9b1ab09484 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -715,7 +715,8 @@ static void c_can_do_tx(struct net_device *dev)
 	struct net_device_stats *stats = &dev->stats;
 	u32 idx, obj, pkts = 0, bytes = 0, pend, clr;
 
-	clr = pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
+	pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
+	clr = pend;
 
 	while ((idx = ffs(pend))) {
 		idx--;
@@ -1041,7 +1042,8 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 
 	/* Only read the status register if a status interrupt was pending */
 	if (atomic_xchg(&priv->sie_pending, 0)) {
-		priv->last_status = curr = priv->read_reg(priv, C_CAN_STS_REG);
+		priv->last_status = priv->read_reg(priv, C_CAN_STS_REG);
+		curr = priv->last_status;
 		/* Ack status on C_CAN. D_CAN is self clearing */
 		if (priv->type != BOSCH_D_CAN)
 			priv->write_reg(priv, C_CAN_STS_REG, LEC_UNUSED);
-- 
2.30.1


