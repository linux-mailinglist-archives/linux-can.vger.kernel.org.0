Return-Path: <linux-can+bounces-759-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895BD908E7A
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972D31C251BE
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1F15FA66;
	Fri, 14 Jun 2024 15:15:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C45526AE6
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378156; cv=none; b=GzAx+VwO1i6A1FgesK50fn2H/UdMNHBjZ3oMVKjwyneqxUcNlS/dx3tbHcD8sBD0YS2MA1HF2jpRqX+yOQnUFXTafIB1zMBVBCNGcmeWit+Kj4hnsYr+/aUhmHmxehkilrk/h1JugO7lfIs4mGugso9SrLmPwJrn4tOzjMVk92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378156; c=relaxed/simple;
	bh=rjIPwUQBIjQd9JfKNNC2hSuT60SAooBRdFpnJCipNJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TrQvZIOORIB+vaBciiLmkq3fnxHPqXwQRDwwp3sLDJPyxVFsieTYFU9LPgKUOeFhjTpzLICsgboBLsTAoPWpDE+NQI/AiApywwsHqClnfqm4rdwMg2sgUopgoy76dsViurrRga7peQU2Lvi9k6fCBmx3tg2+oTChLHDd1mlCB3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id EC706E014B;
	Fri, 14 Jun 2024 17:15:41 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 5/7] can: kvaser_pciefd: Add unlikely
Date: Fri, 14 Jun 2024 17:15:22 +0200
Message-Id: <20240614151524.2718287-6-martin.jocic@kvaser.com>
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

Use unlikely for some unexpected errors.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 3d40d7b3d64c..b08084b0a95b 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1619,7 +1619,7 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 	/* Position does not point to the end of the package,
 	 * corrupted packet size?
 	 */
-	if ((*start_pos + size) != pos)
+	if (unlikely((*start_pos + size) != pos))
 		return -EIO;
 
 	/* Point to the next packet header, if any */
@@ -1658,10 +1658,10 @@ static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 			  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 	}
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
-	    irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
-	    irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
-	    irq & KVASER_PCIEFD_SRB_IRQ_DUF1)
+	if (unlikely(irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
+		     irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
+		     irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
+		     irq & KVASER_PCIEFD_SRB_IRQ_DUF1))
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
 	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
-- 
2.40.1


