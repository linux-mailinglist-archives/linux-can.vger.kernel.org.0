Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93F6341F53
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCSO1o (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 10:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSO1I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 10:27:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D07C06175F
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 07:27:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lNG5g-0006Ru-BF
        for linux-can@vger.kernel.org; Fri, 19 Mar 2021 15:27:04 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 0EC185FAAA1
        for <linux-can@vger.kernel.org>; Fri, 19 Mar 2021 14:27:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 474275FAA98;
        Fri, 19 Mar 2021 14:27:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0c3673fe;
        Fri, 19 Mar 2021 14:27:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: skb: can_free_echo_skb(): don't crash the kernel if can_priv::echo_skb is accessed out of bounds
Date:   Fri, 19 Mar 2021 15:26:59 +0100
Message-Id: <20210319142700.305648-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210319142700.305648-1-mkl@pengutronix.de>
References: <20210319142700.305648-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

A out of bounds access to "struct can_priv::echo_skb" leads to a
kernel crash. Better print a sensible warning message instead and try
to recover.

This patch is similar to:

| e7a6994d043a ("can: dev: __can_get_echo_skb(): Don't crash the kernel
|               if can_priv::echo_skb is accessed out of bounds")

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 22b0472a5fad..2256391ddbb3 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -157,7 +157,11 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	BUG_ON(idx >= priv->echo_skb_max);
+	if (idx >= priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return;
+	}
 
 	if (priv->echo_skb[idx]) {
 		dev_kfree_skb_any(priv->echo_skb[idx]);
-- 
2.30.2


