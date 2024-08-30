Return-Path: <linux-can+bounces-1245-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16499665DC
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 17:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E885281E12
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388E1B653B;
	Fri, 30 Aug 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="nYKFvCOs"
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B81B6524
	for <linux-can@vger.kernel.org>; Fri, 30 Aug 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032296; cv=none; b=nyR7ymn036aRMjsH8V33Ka7sXRH5uideHrMEAvnTQh9BYoaY8IVUQNyoky2ka8+HG3zTgyM20/HVX0mBds3hszQ8LWJevCFb3pdYe5lOVdazWoIvzIEz0ItwSnZ2SQ7j8B8ZNM03Ter5vOiFCxFwENBGgN1CIEys0CHMoxgw5FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032296; c=relaxed/simple;
	bh=3g8dYj+mGnfLO8RX7JCSSUV4iPfsmr89G2OgcrCJYYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVjkdZPf82YMC0HqIOTRSJZ57hqT1NB8asxZmeQjVkkqgdkY4cy94rDDEy098OFeYDXa/dF1M5FqFv+onUu7urzJdDuZxd+SUDWTpZ/2uFUvsk4OxOT6uG7/eOz5UQ/XH76IYcoK0IGJ9lZqJIj71x5YmvSMNprT7ytzsuNHYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=nYKFvCOs; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id 1A896E014A;
	Fri, 30 Aug 2024 17:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1725031891; bh=3g8dYj+mGnfLO8RX7JCSSUV4iPfsmr89G2OgcrCJYYc=;
	h=From:To:Cc:Subject:Date:From;
	b=nYKFvCOs/4cORPE32ma7mhEZXDtqoxWI6VDJa4nSC45FMgdnGcLblUg3Ja/lyOLsV
	 2Pg5zoxJ7lX1ScoBB4Z9avrLpLfMYnkEklHtf996YohlVjGcFWDlZ/oqW+O2pCAjEI
	 y5bEQFAyZD+BlQ8VnRYfGn/KnL4bQxBfgvPArbG3BRuRKL/I3cdcpHzrMkSZ3dmp8a
	 HTUMpoLca4IvE9F7Oilgiy8rYIGjKLfmGERvlZlXW9CWqMefq/1ou9zgvAHS26ZVfv
	 KVXWXKaGZgWN77Q7tA1MZ4CB7ITz0MUhP8ioRthZjo6KaF9j3PPgB8ixL89ZrqrMAj
	 pYCGeLxSY90Hg==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH v2] can: kvaser_pciefd: Use a single write when releasing RX buffers
Date: Fri, 30 Aug 2024 17:31:13 +0200
Message-ID: <20240830153113.2081440-1-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kvaser's PCIe cards uses the KCAN FPGA IP block which has dual 4K buffers for
incoming messages shared by all (currently up to eight) channels. While the
driver processes messages in one buffer, new incoming messages are stored in
the other and so on.

The design of KCAN is such that a buffer must be fully read and then released.
Releasing a buffer will make the FPGA switch buffers. If the other buffer
contains at least one incoming message the FPGA will also instantly issue a
new interrupt, if not the interrupt will be issued after receiving the first
new message.

With IRQx interrupts, it takes a little time for the interrupt to happen,
enough for any previous ISR call to do it's business and return, but MSI
interrupts are way faster so this time is reduced to almost nothing.

So with MSI, releasing the buffer HAS to be the very last action of the ISR
before returning, otherwise the new interrupt might be "masked" by the kernel
because the previous ISR call hasn't returned. And the interrupts are edge-
triggered so we cannot loose one, or the ping-pong reading process will stop.

This is why this patch modifies the driver to use a single write to the SRB_CMD
register before returning.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
Changes in v2:
* Added explanation to commit message text as requested, no code change!

 drivers/net/can/kvaser_pciefd.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index a60d9efd5f8d..9ffc3ffb4e8f 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1686,6 +1686,7 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
 	u32 srb_irq = 0;
+	u32 srb_release = 0;
 	int i;

 	if (!(pci_irq & irq_mask->all))
@@ -1699,17 +1700,14 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}

-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
-		/* Reset DMA buffer 0, may trigger new interrupt */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
+		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;

-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
-		/* Reset DMA buffer 1, may trigger new interrupt */
-		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
-			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
-	}
+	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
+
+	if (srb_release)
+		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);

 	return IRQ_HANDLED;
 }
--
2.43.0


