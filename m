Return-Path: <linux-can+bounces-758-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1B908E91
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9979B2D911
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7165214F9C5;
	Fri, 14 Jun 2024 15:15:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4115A861
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378155; cv=none; b=uxGa7sIN1N/eTbHa0XuQNvuT7topnR95FwuYGN09ZXowduEr1pX5dEHcAuPKtJXa60nQ+MzT82DywHZW0A2N2PCAcfJmzWf8jdFZtnkSI6UsxDSscjN1EujQzEqes0U3JfyW/BkQk9LVBBpR9VA/ffzT+H7C4X6gip1CE6AFmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378155; c=relaxed/simple;
	bh=v/GC5OLSvkxMYg8D0PX/oSwyh//1M8cz1HlL/WOpQsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dmp0YcyyX65kFFiH9Slqt7fdBEk9lQVryA/kLOkdtJ8OfWgxwKWAI8e5k+EGcUECe/NvF2LGpt0RFDdnFHp2SvCtL/VIynxSdfzicsXpiJ4hwDJ2fc04dUqrwZYsY79mcP9KE6aJMX83V+5d8k72LUfMF7Ki1pOBNkV5q+vpSFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id EF87AE03A9;
	Fri, 14 Jun 2024 17:15:41 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 6/7] can: kvaser_pciefd: Rename board_irq to pci_irq
Date: Fri, 14 Jun 2024 17:15:23 +0200
Message-Id: <20240614151524.2718287-7-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240614151524.2718287-1-martin.jocic@kvaser.com>
References: <20240614151524.2718287-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the variable name board_irq in the ISR to pci_irq to
be more specific and to match the macro by which it is read.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index b08084b0a95b..8b2c18f2f23b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1691,17 +1691,17 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 {
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
-	u32 board_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
+	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
 	int i;
 
-	if (!(board_irq & irq_mask->all))
+	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
-	if (board_irq & irq_mask->kcan_rx0)
+	if (pci_irq & irq_mask->kcan_rx0)
 		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
-		if (board_irq & irq_mask->kcan_tx[i])
+		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-- 
2.40.1


