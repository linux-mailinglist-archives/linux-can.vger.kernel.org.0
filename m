Return-Path: <linux-can+bounces-760-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 770CA908E8C
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210381F218AE
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8858F15DBB5;
	Fri, 14 Jun 2024 15:20:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0494376F1
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378413; cv=none; b=jWCMG3xFUpRy4v+0kKu5SAFJ9Xpyo2KlOXuWiAF/GI/SBRRCeDF5kNR+35HcCAfkajGcGNjbBGP8ep5lbttq6VgJVzTt8uJ44ZLfMQ3IyQzz/tmKHc8h0hDU4HCkWxQUK/9Cd4eGOYcsvQQTF2RpvzICtELwCeyMN3c9VF6ho9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378413; c=relaxed/simple;
	bh=/ozOzHTmkD3NtmU3F6k0ZJwO2Oq9kV9kH6YRfJm/SAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cU7qQQeh+Vj9+rfeh8NA80mBOnUy+qrxf8EwRLSfj+EF4GsXNpC/uEZW7+AW65T+FxDynhpdguCdIYFMnQQywTo2o3i+KgSC+IKB1knOze4lovp+Ez7WXrs5c7eXHNJZChDYfDI5r6eBu8MXZSZOZz5mtSxksFhJSuW3dQU36n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id DAC8DE0437;
	Fri, 14 Jun 2024 17:20:10 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 2/2] can: kvaser_pciefd: Add MSI interrupts
Date: Fri, 14 Jun 2024 17:20:08 +0200
Message-Id: <20240614152008.2730746-3-martin.jocic@kvaser.com>
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

Use MSI interrupts with fallback to legacy interrupts.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 63b4d2a4c7ce..53b82e11f7f3 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1774,11 +1774,24 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_teardown_can_ctrls;

-	ret = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
-			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (ret)
+	ret = pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_LEGACY | PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_info(&pcie->pci->dev, "Failed to allocate IRQ vectors.\n");
 		goto err_teardown_can_ctrls;
+	}
+
+	ret = pci_irq_vector(pcie->pci, 0);
+	if (ret < 0)
+		goto err_free_msi;
+
+	pcie->pci->irq = ret;

+	ret = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
+			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
+	if (ret) {
+		dev_info(&pcie->pci->dev, "Failed to request IRQ %d\n", pcie->pci->irq);
+		goto err_free_msi;
+	}
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);

@@ -1807,6 +1820,10 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	iowrite32(0, irq_en_base);
 	free_irq(pcie->pci->irq, pcie);

+err_free_msi:
+	if (pcie->pci->msi_enabled)
+		pci_free_irq_vectors(pcie->pci);
+
 err_teardown_can_ctrls:
 	kvaser_pciefd_teardown_can_ctrls(pcie);
 	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
--
2.40.1


