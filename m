Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A832707AF3
	for <lists+linux-can@lfdr.de>; Thu, 18 May 2023 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjERHdR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 18 May 2023 03:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjERHdO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 May 2023 03:33:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8982D53
        for <linux-can@vger.kernel.org>; Thu, 18 May 2023 00:32:52 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pzY7y-00010o-Uc
        for linux-can@vger.kernel.org; Thu, 18 May 2023 09:32:47 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6263A1C7A21
        for <linux-can@vger.kernel.org>; Thu, 18 May 2023 07:32:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id DC3C91C79FE;
        Thu, 18 May 2023 07:32:43 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 39fb9037;
        Thu, 18 May 2023 07:32:42 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/7] can: kvaser_pciefd: Call request_irq() before enabling interrupts
Date:   Thu, 18 May 2023 09:32:37 +0200
Message-Id: <20230518073241.1110453-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518073241.1110453-1-mkl@pengutronix.de>
References: <20230518073241.1110453-1-mkl@pengutronix.de>
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

Make sure the interrupt handler is registered before enabling interrupts.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Cc: stable@vger.kernel.org
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/r/20230516134318.104279-4-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index cdc894d12885..4b8591d48735 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1827,6 +1827,11 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_teardown_can_ctrls;
 
+	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
+			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
+	if (err)
+		goto err_teardown_can_ctrls;
+
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
 
@@ -1847,11 +1852,6 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
-	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
-			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (err)
-		goto err_teardown_can_ctrls;
-
 	err = kvaser_pciefd_reg_candev(pcie);
 	if (err)
 		goto err_free_irq;
-- 
2.39.2


