Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5C3E28E9
	for <lists+linux-can@lfdr.de>; Fri,  6 Aug 2021 12:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhHFKv4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Aug 2021 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbhHFKvx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Aug 2021 06:51:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F8C061798
        for <linux-can@vger.kernel.org>; Fri,  6 Aug 2021 03:51:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mBxRq-0002gR-Gw
        for linux-can@vger.kernel.org; Fri, 06 Aug 2021 12:51:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AFB4F661E3F
        for <linux-can@vger.kernel.org>; Fri,  6 Aug 2021 10:51:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3D571661E3C;
        Fri,  6 Aug 2021 10:51:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 78ce961e;
        Fri, 6 Aug 2021 10:51:28 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Dario Binacchi <dariobin@libero.it>
Subject: [PATCH] can: c_can: c_can_do_tx(): fix typo in comment
Date:   Fri,  6 Aug 2021 12:51:27 +0200
Message-Id: <20210806105127.103302-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch fixes a typo in the comment in c_can_do_tx().

Fixes: eddf67115040 ("can: c_can: add a comment about IF_RX interface's use")
Cc: Dario Binacchi <dariobin@libero.it>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index 7588f70ca0fe..e65bd7a9cf1d 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -712,7 +712,7 @@ static void c_can_do_tx(struct net_device *dev)
 
 		/* We use IF_RX interface instead of IF_TX because we
 		 * are called from c_can_poll(), which runs inside
-		 * NAPI. We are not trasmitting.
+		 * NAPI. We are not transmitting.
 		 */
 		c_can_inval_tx_object(dev, IF_RX, obj);
 		can_get_echo_skb(dev, idx, NULL);
-- 
2.30.2


