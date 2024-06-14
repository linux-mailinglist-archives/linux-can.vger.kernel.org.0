Return-Path: <linux-can+bounces-762-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D6908EB9
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D99B2B426
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962CC15ECC8;
	Fri, 14 Jun 2024 15:20:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E12628B
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378413; cv=none; b=OhKLdmlkJfQVYSlRrHCz9+ajjwig6RoPi4EdZZoFEn3iEa7GTttroPZKNxppjcuDd9Qbdsz7mmSSMDBp0vUO3kBBCgvCUd8gEhFAxD8kjjRdGPyV8a3nVzaxGUjcXcU8nFTCDaRIRA6DtU9BYTXqFEDX2di0sIkItLH/5YXQWbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378413; c=relaxed/simple;
	bh=NhXIrkOTMwwX8cexcUoNoTv0xE8ufFjZ8lrYhdcFxwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CMAGStrXEPCZEqHWiO9ODMHgtE+qtx3XcqpkhH3s+glLsedo4itD7GQbcxVMW93wa/vrHhlu9y78FvnAfJSWg4thlQNQnJEbmSR5Dd8/8C44MsFAHpgSPs+cErz9Ulkwx/arWFKJvhb8WPxVua5G1M6oqqLdTkevM7T5I5pFhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id D6DEEE0433;
	Fri, 14 Jun 2024 17:20:10 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 1/2] can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
Date: Fri, 14 Jun 2024 17:20:07 +0200
Message-Id: <20240614152008.2730746-2-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240614152008.2730746-1-martin.jocic@kvaser.com>
References: <20240614152008.2730746-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new interrupt is triggered by resetting the DMA RX buffers.
Since MSI interrupts are faster than legacy interrupts, the reset
of the DMA buffers must be moved to the very end of the ISR,
otherwise a new MSI interrupt will be masked by the current one.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 24871c276b31..63b4d2a4c7ce 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1640,23 +1640,15 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
 	u32 irq = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
 		kvaser_pciefd_read_buffer(pcie, 0);
-		/* Reset DMA buffer 0 */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
 		kvaser_pciefd_read_buffer(pcie, 1);
-		/* Reset DMA buffer 1 */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
 
 	if (unlikely(irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
@@ -1665,6 +1657,7 @@ static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
 	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
+	return irq;
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1692,19 +1685,32 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
+	u32 srb_irq = 0;
 	int i;
 
 	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
 	if (pci_irq & irq_mask->kcan_rx0)
-		kvaser_pciefd_receive_irq(pcie);
+		srb_irq = kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
 		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
+		/* Reset DMA buffer 0, may trigger new interrupt */
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
+			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
+	}
+
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
+		/* Reset DMA buffer 1, may trigger new interrupt */
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
+			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.40.1


