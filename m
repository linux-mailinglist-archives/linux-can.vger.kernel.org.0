Return-Path: <linux-can+bounces-798-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A69110A3
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 20:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72791C250FC
	for <lists+linux-can@lfdr.de>; Thu, 20 Jun 2024 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D001B4C3F;
	Thu, 20 Jun 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="tnj7lF4j"
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652FF1B4C3A
	for <linux-can@vger.kernel.org>; Thu, 20 Jun 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907293; cv=none; b=C6yxIywloHfh9qxcrPn9TQablXXXT3i8A4ed2ciuUH8Hund8ZpFe7R/Ildhd0J4RPvmAid8UE8No2yhEUoVgikMUZzOMvaBuRX8fzoQy3pqPnstQgHQH3Xpjq4whE+THaX2ffz0IDpR/KtdIa2vosX+IKHsy0r/ee3jZBsba7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907293; c=relaxed/simple;
	bh=i76dKGrabS8MdgNdEBd27+tHDUygfpBlRBe1VaIr2Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVS1rlv70mc3kdi8XAoLB9tetFwKF8rxYV/J8jGBTHYHQ/ViqdJJs2ChYfwokm08ihStv3Yl0aL72ybwsWY52wKubdrWvibDmWL58A+xm9k7Yu5eIfNwSBymnPZ3Sho34OLXOpSEur02OxuHy6RCulX22d8GgpaG1KtuZay85m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=tnj7lF4j; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id 27FE7E0149;
	Thu, 20 Jun 2024 20:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1718907233; bh=i76dKGrabS8MdgNdEBd27+tHDUygfpBlRBe1VaIr2Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnj7lF4jTV5nkmzGopGAIldrHBKlWIKzFCKXuYt6SMNr2l+dvDREhLcnPw1QnNxZM
	 d0bXnpU2DdV56JLrrOzdDeXUvLiHp8WvwiaWaygIyOCfmRufsHj9EwfY+gXqgMwq8f
	 iDc2UWIZl0yjFZkxVl5Y1/bFHSPxVePx1DQpsSjcdnauHWMKFNFP3STP0GLfdK6NhK
	 BP/zwLL/uMJ4H/+7vieSNEg3dAHWEPR/P43SbCuxozSXVypiSzEJhE/z/vZPyRj/p4
	 +NWOt8h1o6FFm1Iq1/UKKogYjtF3PSs/8iWtRMU97vg+byZlrjiP6GZsfKlDqwtUta
	 uCkxtyQ/OhxlA==
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH v2 2/2] can: kvaser_pciefd: Add MSI interrupts
Date: Thu, 20 Jun 2024 20:13:20 +0200
Message-Id: <20240620181320.235465-3-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240620181320.235465-1-martin.jocic@kvaser.com>
References: <20240620181320.235465-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use MSI interrupts with fallback to INTx interrupts.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---

 Changes since v1:
  * Implemented review comments from Jimmy Assarsson:
    - Add missing pci_free_irq_vectors() in kvaser_pciefd_remove()
    - Replace dev_info() with dev_err() when reporting errors

  * Implemented review comment from Marc Kleine-Budde:
    - Replace deprecated #define PCI_IRQ_LEGACY with PCI_IRQ_INTX

Thank you for your comments.

/Martin

 drivers/net/can/kvaser_pciefd.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index b4ffd56fdeff..5aed2521ccd1 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1774,11 +1774,24 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_teardown_can_ctrls;
 
-	ret = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
-			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (ret)
+	ret = pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_INTX | PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_err(&pcie->pci->dev, "Failed to allocate IRQ vectors.\n");
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
+		dev_err(&pcie->pci->dev, "Failed to request IRQ %d\n", pcie->pci->irq);
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
@@ -1852,7 +1869,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	free_irq(pcie->pci->irq, pcie);
-
+	pci_free_irq_vectors(pcie->pci);
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.40.1


