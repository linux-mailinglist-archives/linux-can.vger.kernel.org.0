Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B53D49F6
	for <lists+linux-can@lfdr.de>; Sat, 24 Jul 2021 22:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhGXUHj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 24 Jul 2021 16:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhGXUHi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 24 Jul 2021 16:07:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111FAC061757
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 13:48:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1m7OZ6-0004gg-FP
        for linux-can@vger.kernel.org; Sat, 24 Jul 2021 22:48:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 5C87B65715A
        for <linux-can@vger.kernel.org>; Sat, 24 Jul 2021 20:48:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id AFFB965714E;
        Sat, 24 Jul 2021 20:48:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 08623f72;
        Sat, 24 Jul 2021 20:48:04 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH can-next 2/3] can: rx-offload: can_rx_offload_irq_finish(): directly call napi_schedule()
Date:   Sat, 24 Jul 2021 22:47:45 +0200
Message-Id: <20210724204745.736053-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724204745.736053-1-mkl@pengutronix.de>
References: <20210724204745.736053-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Instead of calling can_rx_offload_schedule() call napi_schedule()
directly. As this was the last use of can_rx_offload_schedule() remove
this helper function.

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/rx-offload.c | 2 +-
 include/linux/can/rx-offload.h   | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index d0bdb6db3a57..82ade3aa5c13 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -295,7 +295,7 @@ void can_rx_offload_irq_finish(struct can_rx_offload *offload)
 		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
 			   __func__, queue_len);
 
-	can_rx_offload_schedule(offload);
+	napi_schedule(&offload->napi);
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_irq_finish);
 
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index d71c938e17d0..516f64df0ebc 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -53,11 +53,6 @@ void can_rx_offload_irq_finish(struct can_rx_offload *offload);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
 
-static inline void can_rx_offload_schedule(struct can_rx_offload *offload)
-{
-	napi_schedule(&offload->napi);
-}
-
 static inline void can_rx_offload_disable(struct can_rx_offload *offload)
 {
 	napi_disable(&offload->napi);
-- 
2.30.2


