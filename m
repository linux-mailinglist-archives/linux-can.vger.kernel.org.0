Return-Path: <linux-can+bounces-818-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45454911E27
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8C0B2106F
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7C173333;
	Fri, 21 Jun 2024 08:02:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48317106F
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956939; cv=none; b=L4ges6zfxkia+zDcyCc3O5VbBLg6Ruzsg8B4l9Kam3gCe4uE81JhR2S7wGqT1hZ1C+2oCLjns6IXX9sSG9lP5/95O5oNC8m/F/56rdz7puyphQNqS+h+3+UUlI/LVQUOPFlgExPV0TYwGjt6Opa69RZ7UZXf4i1C2X7UinHAn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956939; c=relaxed/simple;
	bh=sLTWxLMRIAdqB71nC3rNemJfUxTcKdLc7k+nyizpYsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2lQt85V907Zbn/cj6ZxzedB15UpvAaKPVai/MRMs8smh2dFDU6VYu/tJ56+PtLn+bB9t7sgPWZ4a0pqaW/lUYxWD4TqBt6hulHSnyB6n6xV3Dfaes5lFUPWAhcEiNQ5CXxNiIOanKEUtb/iP9n13/LfSeUePo1QOxEymABa9Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDp-00048J-Fo
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDl-003tOE-Kw
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:09 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4E7242EE45C
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:09 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 035772EE3B5;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2b7485de;
	Fri, 21 Jun 2024 08:02:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Jocic <martin.jocic@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/24] can: kvaser_pciefd: Change name of return code variable
Date: Fri, 21 Jun 2024 09:48:38 +0200
Message-ID: <20240621080201.305471-19-mkl@pengutronix.de>
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

Replace the variable name err used for return codes with the more
generic name ret. An upcoming patch series for adding MSI interrupts
will introduce code which also returns values other than return codes.
Renaming the variable to ret enables using it for both purposes.
This is applied to the whole file to make it consistent.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
Link: https://lore.kernel.org/all/20240614151524.2718287-8-martin.jocic@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.43.0



