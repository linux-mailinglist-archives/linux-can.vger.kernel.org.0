Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684F32EBD0
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCENCg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 08:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhCENCY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 08:02:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF840C061574
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 05:02:24 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIA63-0006SY-CJ
        for linux-can@vger.kernel.org; Fri, 05 Mar 2021 14:02:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 3D71D5EE86F
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:02:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 870C65EE83F;
        Fri,  5 Mar 2021 13:02:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 304d8655;
        Fri, 5 Mar 2021 13:02:13 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 10/12] can: c_can: use 32-bit write to set arbitration register
Date:   Fri,  5 Mar 2021 14:02:09 +0100
Message-Id: <20210305130211.2860914-11-mkl@pengutronix.de>
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

The arbitration register is already set up with 32-bit writes in the
other parts of the code except for this point.

Link: https://lore.kernel.org/r/20210302215435.18286-5-dariobin@libero.it
Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 3c2cc9dbf5ad..4bb8a7bcac50 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -291,8 +291,7 @@ static void c_can_inval_msg_object(struct net_device *dev, int iface, int obj)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), 0);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), 0);
+	priv->write_reg32(priv, C_CAN_IFACE(ARB1_REG, iface), 0);
 	c_can_inval_tx_object(dev, iface, obj);
 }
 
-- 
2.30.1


