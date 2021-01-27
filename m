Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3654F3056E9
	for <lists+linux-can@lfdr.de>; Wed, 27 Jan 2021 10:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhA0J1q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jan 2021 04:27:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38103 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhA0JZi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jan 2021 04:25:38 -0500
X-Greylist: delayed 1631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 04:25:37 EST
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1l4h23-00085d-CD
        for linux-can@vger.kernel.org; Wed, 27 Jan 2021 10:22:35 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 482385CF0EE
        for <linux-can@vger.kernel.org>; Wed, 27 Jan 2021 09:22:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id C9F5B5CF0D1;
        Wed, 27 Jan 2021 09:22:28 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ec185e80;
        Wed, 27 Jan 2021 09:22:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 03/12] can: dev: export can_get_state_str() function
Date:   Wed, 27 Jan 2021 10:22:18 +0100
Message-Id: <20210127092227.2775573-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210127092227.2775573-1-mkl@pengutronix.de>
References: <20210127092227.2775573-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The can_get_state_str() function is also relevant to the drivers. Export the
symbol and make it visible in the can/dev.h header.

Link: https://lore.kernel.org/r/20210119170355.12040-1-mailhol.vincent@wanadoo.fr
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/dev.c | 3 ++-
 include/linux/can/dev.h   | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 01e4a194f187..d9281ae853f8 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -74,7 +74,7 @@ static int can_rx_state_to_frame(struct net_device *dev, enum can_state state)
 	}
 }
 
-static const char *can_get_state_str(const enum can_state state)
+const char *can_get_state_str(const enum can_state state)
 {
 	switch (state) {
 	case CAN_STATE_ERROR_ACTIVE:
@@ -95,6 +95,7 @@ static const char *can_get_state_str(const enum can_state state)
 
 	return "<unknown>";
 }
+EXPORT_SYMBOL_GPL(can_get_state_str);
 
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state)
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 7faf6a37d5b2..ac4d83a1ab81 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -123,6 +123,7 @@ void unregister_candev(struct net_device *dev);
 int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
 
+const char *can_get_state_str(const enum can_state state);
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state);
 
-- 
2.29.2


