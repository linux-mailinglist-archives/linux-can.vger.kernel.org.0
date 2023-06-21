Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095FD738509
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjFUN3d (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 09:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjFUN3c (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 09:29:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00EF1997
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 06:29:25 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBxtj-0006a6-Sm
        for linux-can@vger.kernel.org; Wed, 21 Jun 2023 15:29:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 9DBBE1DE8C8
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 13:29:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 2CAF31DE86C;
        Wed, 21 Jun 2023 13:29:17 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1ce4bd59;
        Wed, 21 Jun 2023 13:29:16 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Judith Mendez <jm@ti.com>
Subject: [PATCH net-next 09/33] can: m_can: fix coding style
Date:   Wed, 21 Jun 2023 15:28:50 +0200
Message-Id: <20230621132914.412546-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch aligns code to match open parenthesis and removes a
trailing whitespace.

Fixes: eb38c2053b67 ("can: rx-offload: rename can_rx_offload_queue_sorted() -> can_rx_offload_queue_timestamp()")
Fixes: f5071d9e729d ("can: m_can: m_can_handle_bus_errors(): add support for handling DLEC error on CAN-FD frames")
Reported-by: Judith Mendez <jm@ti.com>
Link: https://lore.kernel.org/all/20230523062410.1984098-1-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a5003435802b..c5af92bcc9c9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -469,7 +469,7 @@ static void m_can_receive_skb(struct m_can_classdev *cdev,
 		int err;
 
 		err = can_rx_offload_queue_timestamp(&cdev->offload, skb,
-						  timestamp);
+						     timestamp);
 		if (err)
 			stats->rx_fifo_errors++;
 	} else {
@@ -895,7 +895,7 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
 			netdev_dbg(dev, "Arbitration phase error detected\n");
 			work_done += m_can_handle_lec_err(dev, lec);
 		}
-		
+
 		if (is_lec_err(dlec)) {
 			netdev_dbg(dev, "Data phase error detected\n");
 			work_done += m_can_handle_lec_err(dev, dlec);
-- 
2.40.1


