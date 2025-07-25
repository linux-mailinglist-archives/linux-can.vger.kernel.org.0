Return-Path: <linux-can+bounces-4162-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C25B1219D
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35BF1CE093B
	for <lists+linux-can@lfdr.de>; Fri, 25 Jul 2025 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22F2EFDB3;
	Fri, 25 Jul 2025 16:13:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB62EF9C3
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460022; cv=none; b=T2fPzKKescHQqVlAzQbAK/b2IXN7Z9onTynlZAp7Y2m3KLy3rLTtv4Miiel7edXx3UrRGdpve4UvcNa9TFWfiJ2unvo1rBatSid9rPbLouhm7Rcnzln1PPQD5dw4ea0AuwhPkSwYc8DW5NYWB24H8BbD+0JDecTVRX/Xs3YUs4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460022; c=relaxed/simple;
	bh=Kg3OlIlZSeOzKRNsHELTyXjhaoaEgrpQq3X5HUQeJ5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6r47wM8CzprUxD/RZQMoZ1jCZbmoB0KlvA4lA4siV9P8LD7cyaECv8O3GdMdydNIL57q3ufpiyqHLBVhVo3Q6Tfn7DQtRV1+EuBdIBXiKzshbmB+gNvcJJkmbUO8hw2bj63dNpOI0jibHVfiTkiTtTBo1JDpDAyPw5P/IuoRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL3B-0006dV-FG
	for linux-can@vger.kernel.org; Fri, 25 Jul 2025 18:13:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ufL38-00AFYA-0v
	for linux-can@vger.kernel.org;
	Fri, 25 Jul 2025 18:13:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 330DA44987E
	for <linux-can@vger.kernel.org>; Fri, 25 Jul 2025 16:13:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AD4B2449823;
	Fri, 25 Jul 2025 16:13:30 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a0d264f6;
	Fri, 25 Jul 2025 16:13:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/27] can: kvaser_pciefd: Add devlink support
Date: Fri, 25 Jul 2025 18:05:23 +0200
Message-ID: <20250725161327.4165174-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725161327.4165174-1-mkl@pengutronix.de>
References: <20250725161327.4165174-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Add devlink support at device level.

Example output:
  $ devlink dev
  pci/0000:07:00.0
  pci/0000:08:00.0
  pci/0000:09:00.0

  $ devlink dev info
  pci/0000:07:00.0:
    driver kvaser_pciefd
  pci/0000:08:00.0:
    driver kvaser_pciefd
  pci/0000:09:00.0:
    driver kvaser_pciefd

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250725123230.8-8-extja@kvaser.com
[mkl: kvaser_pciefd_remove(): fix use-after-free]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig                           |  1 +
 drivers/net/can/kvaser_pciefd/Makefile            |  2 +-
 drivers/net/can/kvaser_pciefd/kvaser_pciefd.h     |  2 ++
 .../net/can/kvaser_pciefd/kvaser_pciefd_core.c    | 15 ++++++++++++---
 .../net/can/kvaser_pciefd/kvaser_pciefd_devlink.c | 11 +++++++++++
 5 files changed, 27 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index d58fab0161b3..d43d56694667 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -154,6 +154,7 @@ config CAN_JANZ_ICAN3
 config CAN_KVASER_PCIEFD
 	depends on PCI
 	tristate "Kvaser PCIe FD cards"
+	select NET_DEVLINK
 	help
 	  This is a driver for the Kvaser PCI Express CAN FD family.
 
diff --git a/drivers/net/can/kvaser_pciefd/Makefile b/drivers/net/can/kvaser_pciefd/Makefile
index ea1bf1000760..8c5b8cdc6b5f 100644
--- a/drivers/net/can/kvaser_pciefd/Makefile
+++ b/drivers/net/can/kvaser_pciefd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CAN_KVASER_PCIEFD) += kvaser_pciefd.o
-kvaser_pciefd-y = kvaser_pciefd_core.o
+kvaser_pciefd-y = kvaser_pciefd_core.o kvaser_pciefd_devlink.o
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
index 55bb7e078340..34ba393d6093 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd.h
@@ -13,6 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/types.h>
+#include <net/devlink.h>
 
 #define KVASER_PCIEFD_MAX_CAN_CHANNELS 8UL
 #define KVASER_PCIEFD_DMA_COUNT 2U
@@ -87,4 +88,5 @@ struct kvaser_pciefd {
 	struct kvaser_pciefd_fw_version fw_version;
 };
 
+extern const struct devlink_ops kvaser_pciefd_devlink_ops;
 #endif /* _KVASER_PCIEFD_H */
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index 97cbe07c4ee3..86509a2d2b90 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -1751,14 +1751,16 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int ret;
+	struct devlink *devlink;
 	struct device *dev = &pdev->dev;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	devlink = devlink_alloc(&kvaser_pciefd_devlink_ops, sizeof(*pcie), dev);
+	if (!devlink)
 		return -ENOMEM;
 
+	pcie = devlink_priv(devlink);
 	pci_set_drvdata(pdev, pcie);
 	pcie->pci = pdev;
 	pcie->driver_data = (const struct kvaser_pciefd_driver_data *)id->driver_data;
@@ -1766,7 +1768,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		return ret;
+		goto err_free_devlink;
 
 	ret = pci_request_regions(pdev, KVASER_PCIEFD_DRV_NAME);
 	if (ret)
@@ -1830,6 +1832,8 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_irq;
 
+	devlink_register(devlink);
+
 	return 0;
 
 err_free_irq:
@@ -1853,6 +1857,9 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 err_disable_pci:
 	pci_disable_device(pdev);
 
+err_free_devlink:
+	devlink_free(devlink);
+
 	return ret;
 }
 
@@ -1876,9 +1883,11 @@ static void kvaser_pciefd_remove(struct pci_dev *pdev)
 	for (i = 0; i < pcie->nr_channels; ++i)
 		free_candev(pcie->can[i]->can.dev);
 
+	devlink_unregister(priv_to_devlink(pcie));
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+	devlink_free(priv_to_devlink(pcie));
 }
 
 static struct pci_driver kvaser_pciefd = {
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
new file mode 100644
index 000000000000..7c2040ed53d7
--- /dev/null
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_devlink.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* kvaser_pciefd devlink functions
+ *
+ * Copyright (C) 2025 KVASER AB, Sweden. All rights reserved.
+ */
+#include "kvaser_pciefd.h"
+
+#include <net/devlink.h>
+
+const struct devlink_ops kvaser_pciefd_devlink_ops = {
+};
-- 
2.47.2



