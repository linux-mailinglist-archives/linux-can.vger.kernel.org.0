Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9032D6F5
	for <lists+linux-can@lfdr.de>; Thu,  4 Mar 2021 16:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhCDPoV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Mar 2021 10:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbhCDPoF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Mar 2021 10:44:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8FC0613D8
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 07:42:50 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lHq7l-0003cs-IN
        for linux-can@vger.kernel.org; Thu, 04 Mar 2021 16:42:49 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 104DB5EDD37
        for <linux-can@vger.kernel.org>; Thu,  4 Mar 2021 15:42:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 29A085EDD16;
        Thu,  4 Mar 2021 15:42:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9cb95617;
        Thu, 4 Mar 2021 15:42:42 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v5 08/11] can: c_can: c_can_rx_object_get(): fix indentation
Date:   Thu,  4 Mar 2021 16:42:37 +0100
Message-Id: <20210304154240.2747987-9-mkl@pengutronix.de>
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

From: Dario Binacchi <dariobin@libero.it>

Commit 524369e2391f ("can: c_can: remove obsolete STRICT_FRAME_ORDERING Kconfig option")
left behind wrong indentation, fix it.

Link: https://lore.kernel.org/r/20210302215435.18286-3-dariobin@libero.it
Signed-off-by: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e0c57cab7ab2..ce4efc88a841 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -774,7 +774,7 @@ static u32 c_can_adjust_pending(u32 pend)
 static inline void c_can_rx_object_get(struct net_device *dev,
 				       struct c_can_priv *priv, u32 obj)
 {
-		c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
+	c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
 }
 
 static inline void c_can_rx_finalize(struct net_device *dev,
-- 
2.30.1


