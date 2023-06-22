Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9357399A8
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFVI2B (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjFVI1y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3BD1FDF
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:32 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFf0-000349-LV
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:22 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 75CA91DF42B
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id E5D521DF3C7;
        Thu, 22 Jun 2023 08:27:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 20daf74d;
        Thu, 22 Jun 2023 08:27:01 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 28/33] can: kvaser_pciefd: Change return type for kvaser_pciefd_{receive,transmit,set_tx}_irq()
Date:   Thu, 22 Jun 2023 10:26:53 +0200
Message-Id: <20230622082658.571150-29-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Change return type to void for kvaser_pciefd_transmit_irq(),
kvaser_pciefd_receive_irq() and kvaser_pciefd_set_tx_irq().
These functions always return zero.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-10-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index bf3fa51069a9..feef044c6b0a 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -338,7 +338,7 @@ static void kvaser_pciefd_disable_err_gen(struct kvaser_pciefd_can *can)
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
-static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
+static void kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 {
 	u32 msk;
 
@@ -349,8 +349,6 @@ static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 	      KVASER_PCIEFD_KCAN_IRQ_TAR;
 
 	iowrite32(msk, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-
-	return 0;
 }
 
 static inline void kvaser_pciefd_set_skb_timestamp(const struct kvaser_pciefd *pcie,
@@ -1456,7 +1454,7 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static int kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
 	u32 irq;
 
@@ -1482,10 +1480,9 @@ static int kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
 	iowrite32(irq, pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
-	return 0;
 }
 
-static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
+static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 {
 	u32 irq = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 
@@ -1503,7 +1500,6 @@ static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 		netdev_err(can->can.dev, "Rx FIFO overflow\n");
 
 	iowrite32(irq, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	return 0;
 }
 
 static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
-- 
2.40.1


