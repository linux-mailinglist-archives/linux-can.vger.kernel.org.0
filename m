Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4926B1C3
	for <lists+linux-can@lfdr.de>; Wed, 16 Sep 2020 00:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgIOWgF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Sep 2020 18:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgIOWfo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Sep 2020 18:35:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86529C06121C
        for <linux-can@vger.kernel.org>; Tue, 15 Sep 2020 15:35:34 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kIJXw-0002Tb-K8; Wed, 16 Sep 2020 00:35:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 13/37] can: dev: can_bus_off(): print scheduling of restart if activated
Date:   Wed, 16 Sep 2020 00:35:03 +0200
Message-Id: <20200915223527.1417033-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915223527.1417033-1-mkl@pengutronix.de>
References: <20200915223527.1417033-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If a CAN device goes into bus-off and has automatic restart enabled, inform
user that a automatic restart is scheduled after the configured delay.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index e0caf969e342..3c40bba71d5b 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -639,7 +639,11 @@ void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	netdev_info(dev, "bus-off\n");
+	if (priv->restart_ms)
+		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
+			    priv->restart_ms);
+	else
+		netdev_info(dev, "bus-off\n");
 
 	netif_carrier_off(dev);
 
-- 
2.28.0

