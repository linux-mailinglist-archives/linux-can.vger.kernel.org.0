Return-Path: <linux-can+bounces-757-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CA908E79
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633F11F27807
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2416C696;
	Fri, 14 Jun 2024 15:15:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C955816C692
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378154; cv=none; b=mjEk81iAncfj2QPXFO4PkQU7unT9nhIHzGFXToBdd78FEcR/NKurqP/gBMyD6GemHlteNBIT2kcXWX0y+kS7hFi+CK9TKNlNKLpF9tPqoGW4mPjjTJhNgILcKij4BIYvAbvxvq9cQXMnLqRFBU5lfyoGIaQWZ46/38HNhxwo8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378154; c=relaxed/simple;
	bh=1mu46dizMbQ6ZFasWOCq71w6biBzEG8jd1h/ztMr5dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFP595utwhK1m2QJyYnjvuLDemiKKTjRILocKakwWEeLTN0frZ6rIKRSWnwtnuXfulzAP0ivX3uTdOC4XDznwdBY/SKBPy/4YQKAIhXLXr28bBhNwajRqSAB/8h37PUx+klNNYuaQkAw9m9DFiC8BtxQFqYC/UBcnGokpYMKTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id 022B2E03AA;
	Fri, 14 Jun 2024 17:15:42 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 7/7] can: kvaser_pciefd: Change name of return code variable
Date: Fri, 14 Jun 2024 17:15:24 +0200
Message-Id: <20240614151524.2718287-8-martin.jocic@kvaser.com>
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

Replace the variable name err used for return codes with the more
generic name ret. An upcoming patch series for adding MSI interrupts
will introduce code which also returns values other than return codes.
Renaming the variable to ret enables using it for both purposes.
This is applied to the whole file to make it consistent.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 56 ++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 8b2c18f2f23b..24871c276b31 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -711,17 +711,17 @@ static void kvaser_pciefd_pwm_start(struct kvaser_pciefd_can *can)
 
 static int kvaser_pciefd_open(struct net_device *netdev)
 {
-	int err;
+	int ret;
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
 
-	err = open_candev(netdev);
-	if (err)
-		return err;
+	ret = open_candev(netdev);
+	if (ret)
+		return ret;
 
-	err = kvaser_pciefd_bus_on(can);
-	if (err) {
+	ret = kvaser_pciefd_bus_on(can);
+	if (ret) {
 		close_candev(netdev);
-		return err;
+		return ret;
 	}
 
 	return 0;
@@ -1032,15 +1032,15 @@ static int kvaser_pciefd_reg_candev(struct kvaser_pciefd *pcie)
 	int i;
 
 	for (i = 0; i < pcie->nr_channels; i++) {
-		int err = register_candev(pcie->can[i]->can.dev);
+		int ret = register_candev(pcie->can[i]->can.dev);
 
-		if (err) {
+		if (ret) {
 			int j;
 
 			/* Unregister all successfully registered devices. */
 			for (j = 0; j < i; j++)
 				unregister_candev(pcie->can[j]->can.dev);
-			return err;
+			return ret;
 		}
 	}
 
@@ -1726,7 +1726,7 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
-	int err;
+	int ret;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
 	void __iomem *irq_en_base;
@@ -1740,37 +1740,37 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	pcie->driver_data = (const struct kvaser_pciefd_driver_data *)id->driver_data;
 	irq_mask = pcie->driver_data->irq_mask;
 
-	err = pci_enable_device(pdev);
-	if (err)
-		return err;
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
 
-	err = pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
-	if (err)
+	ret = pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
+	if (ret)
 		goto err_disable_pci;
 
 	pcie->reg_base = pci_iomap(pdev, 0, 0);
 	if (!pcie->reg_base) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto err_release_regions;
 	}
 
-	err = kvaser_pciefd_setup_board(pcie);
-	if (err)
+	ret = kvaser_pciefd_setup_board(pcie);
+	if (ret)
 		goto err_pci_iounmap;
 
-	err = kvaser_pciefd_setup_dma(pcie);
-	if (err)
+	ret = kvaser_pciefd_setup_dma(pcie);
+	if (ret)
 		goto err_pci_iounmap;
 
 	pci_set_master(pdev);
 
-	err = kvaser_pciefd_setup_can_ctrls(pcie);
-	if (err)
+	ret = kvaser_pciefd_setup_can_ctrls(pcie);
+	if (ret)
 		goto err_teardown_can_ctrls;
 
-	err = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
+	ret = request_irq(pcie->pci->irq, kvaser_pciefd_irq_handler,
 			  IRQF_SHARED, KVASER_PCIEFD_DRV_NAME, pcie);
-	if (err)
+	if (ret)
 		goto err_teardown_can_ctrls;
 
 	iowrite32(KVASER_PCIEFD_SRB_IRQ_DPD0 | KVASER_PCIEFD_SRB_IRQ_DPD1,
@@ -1790,8 +1790,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
 
-	err = kvaser_pciefd_reg_candev(pcie);
-	if (err)
+	ret = kvaser_pciefd_reg_candev(pcie);
+	if (ret)
 		goto err_free_irq;
 
 	return 0;
@@ -1815,7 +1815,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 err_disable_pci:
 	pci_disable_device(pdev);
 
-	return err;
+	return ret;
 }
 
 static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
-- 
2.40.1


