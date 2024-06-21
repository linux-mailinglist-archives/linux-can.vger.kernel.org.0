Return-Path: <linux-can+bounces-819-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CCC911E29
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F8B1F26C38
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D717333F;
	Fri, 21 Jun 2024 08:02:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184C171E47
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956939; cv=none; b=a1U3+VTeU5jpWbVuczYxcmXhf278aexyOsV4gESWPh5a81HauT5U+HXil1W4x+HGViePhdcOBpnsAJAfChRaP7//9S3CAhIXVpOARMIRXpI61QtgfNki0gbZ0gKJb9nG/SdoTnUkFSY09oGeG9Gv7jc2gtcIjFVPLPM8FmCpZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956939; c=relaxed/simple;
	bh=X1hOZBbei9T1VuKc2ZrGeJR83NX8l+OVKSLL1ZRY65M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrIVwkCExcczxC2SerY8nLHNfRcqxtT1vPp9JPzbmB6DYED+nS+lXO6HJezJRiIv5caSUGcx/Jx1lFKAqduuPa9QcPVGlbQLcythyffUwkjGg9kNsdiziYndbfcDDGxw7mSIAO9hZao4C99qbqiwlT0y3/EuvF52Zxypev0SE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDq-00048X-4A
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDl-003tON-Tb
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:09 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 8FE632EE45F
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:09 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 34D222EE3BD;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 121b0391;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 20/24] can: kvaser_pciefd: Add MSI interrupts
Date: Fri, 21 Jun 2024 09:48:40 +0200
Message-ID: <20240621080201.305471-21-mkl@pengutronix.de>
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

Use MSI interrupts with fallback to INTx interrupts.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240620181320.235465-3-martin.jocic@kvaser.com
[mkl: kvaser_pciefd_probe(): call pci_free_irq_vectors() unconditionally]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index b4ffd56fdeff..a60d9efd5f8d 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1774,11 +1774,24 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_teardown_can_ctrls;
 
+	ret = pci_alloc_irq_vectors(pcie->pci, 1, 1, PCI_IRQ_INTX | PCI_IRQ_MSI);
+	if (ret < 0) {
+		dev_err(&pcie->pci->dev, "Failed to allocate IRQ vectors.\n");
+		goto err_teardown_can_ctrls;
+	}
+
+	ret = pci_irq_vector(pcie->pci, 0);
+	if (ret < 0)
+		goto err_pci_free_irq_vectors;
+
+	pcie->pci->irq = ret;
+
 	ret = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
 			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (ret)
-		goto err_teardown_can_ctrls;
-
+	if (ret) {
+		dev_err(&pcie->pci->dev, "Failed to request IRQ %d\n", pcie->pci->irq);
+		goto err_pci_free_irq_vectors;
+	}
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
@@ -1807,6 +1820,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	iowrite32(0, irq_en_base);
 	free_irq(pcie->pci->irq, pcie);
 
+err_pci_free_irq_vectors:
+	pci_free_irq_vectors(pcie->pci);
+
 err_teardown_can_ctrls:
 	kvaser_pciefd_teardown_can_ctrls(pcie);
 	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
@@ -1852,7 +1868,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	free_irq(pcie->pci->irq, pcie);
-
+	pci_free_irq_vectors(pcie->pci);
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.43.0



