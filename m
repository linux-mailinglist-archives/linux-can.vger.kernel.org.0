Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACDC2A10E2
	for <lists+linux-can@lfdr.de>; Fri, 30 Oct 2020 23:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJ3WbY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 30 Oct 2020 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgJ3WbY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 30 Oct 2020 18:31:24 -0400
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8E20C0613D5;
        Fri, 30 Oct 2020 15:31:23 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 09UMTx0E034595;
        Fri, 30 Oct 2020 23:29:59 +0100 (CET)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 09UMTwpi019523;
        Fri, 30 Oct 2020 23:29:58 +0100
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 09UMTw61019522;
        Fri, 30 Oct 2020 23:29:58 +0100
From:   Pavel Pisa <pisa@cmp.felk.cvut.cz>
To:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        "Marc Kleine-Budde" <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        David Miller <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Carsten Emde <c.emde@osadl.org>, armbru@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marin Jerabek <martin.jerabek01@gmail.com>,
        Ondrej Ille <ondrej.ille@gmail.com>,
        Jiri Novak <jnovak@fel.cvut.cz>,
        Jaroslav Beran <jara.beran@gmail.com>,
        Petr Porazil <porazil@pikron.com>, Pavel Machek <pavel@ucw.cz>,
        Drew Fustini <pdp7pdp7@gmail.com>,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v7 4/6] can: ctucanfd: CTU CAN FD open-source IP core - PCI bus support.
Date:   Fri, 30 Oct 2020 23:19:26 +0100
Message-Id: <f508d40e259f70e2244dff1a20e8bdb9c34a31d8.1604095004.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1604095004.git.pisa@cmp.felk.cvut.cz>
References: <cover.1604095004.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 09UMTx0E034595
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.222, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.28,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1604701801.90261@aGXp3KtL5V2sxzlsKdoFWw
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

PCI bus adaptation for CTU CAN FD open-source IP core.

The project providing FPGA design for Intel EP4CGX15 based DB4CGX15
PCIe board with PiKRON.com designed transceiver riser shield is available
at https://gitlab.fel.cvut.cz/canbus/pcie-ctucanfd .

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Martin Jerabek <martin.jerabek01@gmail.com>
Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
---
 drivers/net/can/ctucanfd/Kconfig        |  10 +
 drivers/net/can/ctucanfd/Makefile       |   2 +
 drivers/net/can/ctucanfd/ctucanfd_pci.c | 316 ++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 drivers/net/can/ctucanfd/ctucanfd_pci.c

diff --git a/drivers/net/can/ctucanfd/Kconfig b/drivers/net/can/ctucanfd/Kconfig
index 8210a5fcd444..039df460cf0c 100644
--- a/drivers/net/can/ctucanfd/Kconfig
+++ b/drivers/net/can/ctucanfd/Kconfig
@@ -10,3 +10,13 @@ config CAN_CTUCANFD
 	  from project (https://gitlab.fel.cvut.cz/canbus/pcie-ctucanfd) and
 	  on Intel SoC from project (https://gitlab.fel.cvut.cz/canbus/intel-soc-ctucanfd).
 	  Guidepost CTU FEE CAN bus projects page http://canbus.pages.fel.cvut.cz/ .
+
+config CAN_CTUCANFD_PCI
+	tristate "CTU CAN-FD IP core PCI/PCIe driver"
+	depends on CAN_CTUCANFD
+	depends on PCI
+	help
+	  This driver adds PCI/PCIe support for CTU CAN-FD IP core.
+	  The project providing FPGA design for Intel EP4CGX15 based DB4CGX15
+	  PCIe board with PiKRON.com designed transceiver riser shield is available
+	  at https://gitlab.fel.cvut.cz/canbus/pcie-ctucanfd .
diff --git a/drivers/net/can/ctucanfd/Makefile b/drivers/net/can/ctucanfd/Makefile
index 1fd0610964f0..b679859c7c9b 100644
--- a/drivers/net/can/ctucanfd/Makefile
+++ b/drivers/net/can/ctucanfd/Makefile
@@ -5,3 +5,5 @@
 
 obj-$(CONFIG_CAN_CTUCANFD) := ctucanfd.o
 ctucanfd-y := ctucanfd_base.o ctucanfd_hw.o
+
+obj-$(CONFIG_CAN_CTUCANFD_PCI) += ctucanfd_pci.o
diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ctucanfd/ctucanfd_pci.c
new file mode 100644
index 000000000000..2222298b5137
--- /dev/null
+++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*******************************************************************************
+ *
+ * CTU CAN FD IP Core
+ *
+ * Copyright (C) 2015-2018 Ondrej Ille <ondrej.ille@gmail.com> FEE CTU
+ * Copyright (C) 2018-2020 Ondrej Ille <ondrej.ille@gmail.com> self-funded
+ * Copyright (C) 2018-2019 Martin Jerabek <martin.jerabek01@gmail.com> FEE CTU
+ * Copyright (C) 2018-2020 Pavel Pisa <pisa@cmp.felk.cvut.cz> FEE CTU/self-funded
+ *
+ * Project advisors:
+ *     Jiri Novak <jnovak@fel.cvut.cz>
+ *     Pavel Pisa <pisa@cmp.felk.cvut.cz>
+ *
+ * Department of Measurement         (http://meas.fel.cvut.cz/)
+ * Faculty of Electrical Engineering (http://www.fel.cvut.cz)
+ * Czech Technical University        (http://www.cvut.cz/)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ ******************************************************************************/
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "ctucanfd.h"
+
+#define DRV_NAME	"ctucanfd_pci"
+
+#ifndef PCI_DEVICE_DATA
+#define PCI_DEVICE_DATA(vend, dev, data) \
+.vendor = PCI_VENDOR_ID_##vend, \
+.device = PCI_DEVICE_ID_##vend##_##dev, \
+.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, 0, 0, \
+.driver_data = (kernel_ulong_t)(data)
+#endif
+
+#ifndef PCI_VENDOR_ID_TEDIA
+#define PCI_VENDOR_ID_TEDIA 0x1760
+#endif
+
+#ifndef PCI_DEVICE_ID_TEDIA_CTUCAN_VER21
+#define PCI_DEVICE_ID_TEDIA_CTUCAN_VER21 0xff00
+#endif
+
+#define CTUCAN_BAR0_CTUCAN_ID 0x0000
+#define CTUCAN_BAR0_CRA_BASE  0x4000
+#define CYCLONE_IV_CRA_A2P_IE (0x0050)
+
+#define CTUCAN_WITHOUT_CTUCAN_ID  0
+#define CTUCAN_WITH_CTUCAN_ID     1
+
+static bool use_msi = true;
+module_param(use_msi, bool, 0444);
+MODULE_PARM_DESC(use_msi, "PCIe implementation use MSI interrupts. Default: 1 (yes)");
+
+static bool pci_use_second = true;
+module_param(pci_use_second, bool, 0444);
+MODULE_PARM_DESC(pci_use_second, "Use the second CAN core on PCIe card. Default: 1 (yes)");
+
+struct ctucan_pci_board_data {
+	void __iomem *bar0_base;
+	void __iomem *cra_base;
+	void __iomem *bar1_base;
+	struct list_head ndev_list_head;
+	int use_msi;
+};
+
+static struct ctucan_pci_board_data *ctucan_pci_get_bdata(struct pci_dev *pdev)
+{
+	return (struct ctucan_pci_board_data *)pci_get_drvdata(pdev);
+}
+
+static void ctucan_pci_set_drvdata(struct device *dev,
+				   struct net_device *ndev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct ctucan_priv *priv = netdev_priv(ndev);
+	struct ctucan_pci_board_data *bdata = ctucan_pci_get_bdata(pdev);
+
+	list_add(&priv->peers_on_pdev, &bdata->ndev_list_head);
+	priv->irq_flags = IRQF_SHARED;
+}
+
+/**
+ * ctucan_pci_probe - PCI registration call
+ * @pdev:	Handle to the pci device structure
+ * @ent:	Pointer to the entry from ctucan_pci_tbl
+ *
+ * This function does all the memory allocation and registration for the CAN
+ * device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int ctucan_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	struct device	*dev = &pdev->dev;
+	unsigned long driver_data = ent->driver_data;
+	struct ctucan_pci_board_data *bdata;
+	void __iomem *addr;
+	void __iomem *cra_addr;
+	void __iomem *bar0_base;
+	u32 cra_a2p_ie;
+	u32 ctucan_id = 0;
+	int ret;
+	unsigned int ntxbufs;
+	unsigned int num_cores = 1;
+	unsigned int core_i = 0;
+	int irq;
+	int msi_ok = 0;
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "pci_enable_device FAILED\n");
+		goto err;
+	}
+
+	ret = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (ret) {
+		dev_err(dev, "pci_request_regions FAILED\n");
+		goto err_disable_device;
+	}
+
+	if (use_msi) {
+		ret = pci_enable_msi(pdev);
+		if (!ret) {
+			dev_info(dev, "MSI enabled\n");
+			pci_set_master(pdev);
+			msi_ok = 1;
+		}
+	}
+
+	dev_info(dev, "ctucan BAR0 0x%08llx 0x%08llx\n",
+		 (long long)pci_resource_start(pdev, 0),
+		 (long long)pci_resource_len(pdev, 0));
+
+	dev_info(dev, "ctucan BAR1 0x%08llx 0x%08llx\n",
+		 (long long)pci_resource_start(pdev, 1),
+		 (long long)pci_resource_len(pdev, 1));
+
+	addr = pci_iomap(pdev, 1, pci_resource_len(pdev, 1));
+	if (!addr) {
+		dev_err(dev, "PCI BAR 1 cannot be mapped\n");
+		ret = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	/* Cyclone IV PCI Express Control Registers Area */
+	bar0_base = pci_iomap(pdev, 0, pci_resource_len(pdev, 0));
+	if (!bar0_base) {
+		dev_err(dev, "PCI BAR 0 cannot be mapped\n");
+		ret = -EIO;
+		goto err_pci_iounmap_bar1;
+	}
+
+	if (driver_data == CTUCAN_WITHOUT_CTUCAN_ID) {
+		cra_addr = bar0_base;
+		num_cores = 2;
+	} else {
+		cra_addr = bar0_base + CTUCAN_BAR0_CRA_BASE;
+		ctucan_id = ioread32(bar0_base + CTUCAN_BAR0_CTUCAN_ID);
+		dev_info(dev, "ctucan_id 0x%08lx\n", (unsigned long)ctucan_id);
+		num_cores = ctucan_id & 0xf;
+	}
+
+	irq = pdev->irq;
+
+	ntxbufs = 4;
+
+	bdata = kzalloc(sizeof(*bdata), GFP_KERNEL);
+	if (!bdata) {
+		ret = -ENOMEM;
+		goto err_pci_iounmap_bar0;
+	}
+
+	INIT_LIST_HEAD(&bdata->ndev_list_head);
+	bdata->bar0_base = bar0_base;
+	bdata->cra_base = cra_addr;
+	bdata->bar1_base = addr;
+	bdata->use_msi = msi_ok;
+
+	pci_set_drvdata(pdev, bdata);
+
+	ret = ctucan_probe_common(dev, addr, irq, ntxbufs, 100000000,
+				  0, ctucan_pci_set_drvdata);
+	if (ret < 0)
+		goto err_free_board;
+
+	core_i++;
+
+	while (pci_use_second && (core_i < num_cores)) {
+		addr += 0x4000;
+		ret = ctucan_probe_common(dev, addr, irq, ntxbufs, 100000000,
+					  0, ctucan_pci_set_drvdata);
+		if (ret < 0) {
+			dev_info(dev, "CTU CAN FD core %d initialization failed\n",
+				 core_i);
+			break;
+		}
+		core_i++;
+	}
+
+	/* enable interrupt in
+	 * Avalon-MM to PCI Express Interrupt Enable Register
+	 */
+	cra_a2p_ie = ioread32(cra_addr + CYCLONE_IV_CRA_A2P_IE);
+	dev_info(dev, "cra_a2p_ie 0x%08x\n", cra_a2p_ie);
+	cra_a2p_ie |= 1;
+	iowrite32(cra_a2p_ie, cra_addr + CYCLONE_IV_CRA_A2P_IE);
+	cra_a2p_ie = ioread32(cra_addr + CYCLONE_IV_CRA_A2P_IE);
+	dev_info(dev, "cra_a2p_ie 0x%08x\n", cra_a2p_ie);
+
+	return 0;
+
+err_free_board:
+	pci_set_drvdata(pdev, NULL);
+	kfree(bdata);
+err_pci_iounmap_bar0:
+	pci_iounmap(pdev, cra_addr);
+err_pci_iounmap_bar1:
+	pci_iounmap(pdev, addr);
+err_release_regions:
+	if (msi_ok) {
+		pci_disable_msi(pdev);
+		pci_clear_master(pdev);
+	}
+	pci_release_regions(pdev);
+err_disable_device:
+	pci_disable_device(pdev);
+err:
+	return ret;
+}
+
+/**
+ * ctucan_pci_remove - Unregister the device after releasing the resources
+ * @pdev:	Handle to the pci device structure
+ *
+ * This function frees all the resources allocated to the device.
+ * Return: 0 always
+ */
+static void ctucan_pci_remove(struct pci_dev *pdev)
+{
+	struct net_device *ndev;
+	struct ctucan_priv *priv = NULL;
+	struct ctucan_pci_board_data *bdata = ctucan_pci_get_bdata(pdev);
+
+	dev_dbg(&pdev->dev, "ctucan_remove");
+
+	if (!bdata) {
+		dev_err(&pdev->dev, "%s: no list of devices\n", __func__);
+		return;
+	}
+
+	/* disable interrupt in
+	 * Avalon-MM to PCI Express Interrupt Enable Register
+	 */
+	if (bdata->cra_base)
+		iowrite32(0, bdata->cra_base + CYCLONE_IV_CRA_A2P_IE);
+
+	while ((priv = list_first_entry_or_null(&bdata->ndev_list_head, struct ctucan_priv,
+						peers_on_pdev)) != NULL) {
+		ndev = priv->can.dev;
+
+		unregister_candev(ndev);
+
+		netif_napi_del(&priv->napi);
+
+		list_del_init(&priv->peers_on_pdev);
+		free_candev(ndev);
+	}
+
+	pci_iounmap(pdev, bdata->bar1_base);
+
+	if (bdata->use_msi) {
+		pci_disable_msi(pdev);
+		pci_clear_master(pdev);
+	}
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+
+	pci_iounmap(pdev, bdata->bar0_base);
+
+	pci_set_drvdata(pdev, NULL);
+	kfree(bdata);
+}
+
+static SIMPLE_DEV_PM_OPS(ctucan_pci_pm_ops, ctucan_suspend, ctucan_resume);
+
+static const struct pci_device_id ctucan_pci_tbl[] = {
+	{PCI_DEVICE_DATA(TEDIA, CTUCAN_VER21,
+		CTUCAN_WITH_CTUCAN_ID)},
+	{},
+};
+
+static struct pci_driver ctucan_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = ctucan_pci_tbl,
+	.probe = ctucan_pci_probe,
+	.remove = ctucan_pci_remove,
+	.driver.pm = &ctucan_pci_pm_ops,
+};
+
+module_pci_driver(ctucan_pci_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pavel Pisa");
+MODULE_DESCRIPTION("CTU CAN FD for PCI bus");
-- 
2.20.1

