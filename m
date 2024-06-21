Return-Path: <linux-can+bounces-816-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605A6911E1C
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA371C21F56
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4892172BA9;
	Fri, 21 Jun 2024 08:02:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE4171660
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956938; cv=none; b=MJX8Oto/n2Kd67ZuDlMGdVhtvZB0B2ouSUWD7pcSkyNBp5pw8BjAgyD8E6U5UWJ7crowYi83jHkoecmkAlJtX28XgVOe7IMV50fyqCggPA3QO2A3b6H9+J/Az5MEC4r28hpxqy8RdeveRjnwac2Yj/rbX1FXryEm7uGDFPEITOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956938; c=relaxed/simple;
	bh=YZUT1QvvyW5nhTW+PO3cqMeaEbG/mSnNDnSL6a0FAN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OexAuhKX0Iy21cD0iKaJhQfwcjf0BeUmS2eCzuLVQRwjOzUAAYT+OAdyx2f72E3yWhXGCOZztoygKqxdW+39qPwOZY8eJvbXSa2xeITqX3b3XGvbgJTBCU6IQGX0aCxegzflD7DbVmumqGRJY/3ehxa029OxN8//8KTE/zHv41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDo-00046t-PD
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDk-003tMh-8E
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D24FD2EE445
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 1B0062EE3B9;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4e5b3d74;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 19/24] can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR
Date: Fri, 21 Jun 2024 09:48:39 +0200
Message-ID: <20240621080201.305471-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Martin Jocic <martin.jocic@kvaser.com>

A new interrupt is triggered by resetting the DMA RX buffers.
Since MSI interrupts are faster than legacy interrupts, the reset
of the DMA buffers must be moved to the very end of the ISR,
otherwise a new MSI interrupt will be masked by the current one.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240620181320.235465-2-martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 24871c276b31..b4ffd56fdeff 100644
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
2.43.0



