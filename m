Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428A02B699A
	for <lists+linux-can@lfdr.de>; Tue, 17 Nov 2020 17:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgKQQMP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Nov 2020 11:12:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:52869 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgKQQMP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:15 -0500
IronPort-SDR: FC7fbc3uOIWky0TemG2aVPWPmt/V62hAlKPchpUto4+AR5X0HbZYZfFsxjJ9uqjPyJDe5Vk8Vy
 MK2yIyckInmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="167443154"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="167443154"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 08:08:33 -0800
IronPort-SDR: /R++iEFHTXONbaVvzx747Bajzo3QQmdTYXEI1B68N9wS6WPiVC7TT2sMvRLD5xkYEu0LJpmMzL
 z0L6Jdlij6mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="368137683"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.96])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2020 08:08:29 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dan Murphy <dmurphy@ti.com>,
        Sriram Dash <sriram.dash@samsung.com>,
        Patrik Flykt <patrik.flykt@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH] can: m_can: Add PCI glue driver for Intel Elkhart Lake
Date:   Tue, 17 Nov 2020 18:08:27 +0200
Message-Id: <20201117160827.3636264-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add support for M_CAN controller on Intel Elkhart Lake attached to the
PCI bus. It integrates the Bosch M_CAN controller with Message RAM and
the wrapper IP block with additional registers which all of them are
within the same MMIO range.

Currently only interrupt control register from wrapper IP is used and
the MRAM configuration is expected to come from the firmware via
"bosch,mram-cfg" device property and parsed by m_can.c core.

Initial implementation is done by Felipe Balbi while he was working at
Intel with later changes from Raymond Tan and me.

Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
This has soft dependency to patches sent earlier by Patrik Flykt and me:
https://www.spinics.net/lists/linux-can/msg04936.html
https://www.spinics.net/lists/linux-can/msg04182.html
Soft dependency since this can be applied without them but will see the
issues fixed by those patches.
---
 drivers/net/can/m_can/Kconfig     |   8 ++
 drivers/net/can/m_can/Makefile    |   1 +
 drivers/net/can/m_can/m_can_pci.c | 186 ++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/net/can/m_can/m_can_pci.c

diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
index 5f9f8192dd0b..aa6044c6bbac 100644
--- a/drivers/net/can/m_can/Kconfig
+++ b/drivers/net/can/m_can/Kconfig
@@ -14,6 +14,14 @@ config CAN_M_CAN_PLATFORM
 	  This support is for devices that have the Bosch M_CAN controller
 	  IP embedded into the device and the IP is IO Mapped to the processor.
 
+config CAN_M_CAN_PCI
+	tristate "Generic PCI Bus based M_CAN driver"
+	depends on PCI
+	depends on CAN_M_CAN
+	help
+	   Say Y here if you want to support Bosch M_CAN controller connected
+	   to the pci bus.
+
 config CAN_M_CAN_TCAN4X5X
 	depends on CAN_M_CAN
 	depends on SPI
diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
index 52a4a6fbe527..227e67390c4e 100644
--- a/drivers/net/can/m_can/Makefile
+++ b/drivers/net/can/m_can/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_CAN_M_CAN) += m_can.o
 obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
+obj-$(CONFIG_CAN_M_CAN_PCI) += m_can_pci.o
 obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) += tcan4x5x.o
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
new file mode 100644
index 000000000000..04010ee0407c
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Specific M_CAN Glue
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+
+#include "m_can.h"
+
+#define M_CAN_PCI_MMIO_BAR		0
+
+#define M_CAN_CLOCK_FREQ_EHL		100000000
+#define CTL_CSR_INT_CTL_OFFSET		0x508
+
+struct m_can_pci_priv {
+	void __iomem *base;
+};
+
+static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
+{
+	struct m_can_pci_priv *priv = cdev->device_data;
+
+	return readl(priv->base + reg);
+}
+
+static u32 iomap_read_fifo(struct m_can_classdev *cdev, int offset)
+{
+	struct m_can_pci_priv *priv = cdev->device_data;
+
+	return readl(priv->base + offset);
+}
+
+static int iomap_write_reg(struct m_can_classdev *cdev, int reg, int val)
+{
+	struct m_can_pci_priv *priv = cdev->device_data;
+
+	writel(val, priv->base + reg);
+
+	return 0;
+}
+
+static int iomap_write_fifo(struct m_can_classdev *cdev, int offset, int val)
+{
+	struct m_can_pci_priv *priv = cdev->device_data;
+
+	writel(val, priv->base + offset);
+
+	return 0;
+}
+
+static struct m_can_ops m_can_pci_ops = {
+	.read_reg = iomap_read_reg,
+	.write_reg = iomap_write_reg,
+	.write_fifo = iomap_write_fifo,
+	.read_fifo = iomap_read_fifo,
+};
+
+static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct device *dev = &pci->dev;
+	struct m_can_classdev *mcan_class;
+	struct m_can_pci_priv *priv;
+	void __iomem *base;
+	int ret;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	ret = pcim_iomap_regions(pci, BIT(M_CAN_PCI_MMIO_BAR), pci_name(pci));
+	if (ret)
+		return ret;
+
+	base = pcim_iomap_table(pci)[M_CAN_PCI_MMIO_BAR];
+
+	if (!base) {
+		dev_err(dev, "failed to map BARs\n");
+		return -ENOMEM;
+	}
+
+	priv = devm_kzalloc(&pci->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mcan_class = m_can_class_allocate_dev(&pci->dev);
+	if (!mcan_class)
+		return -ENOMEM;
+
+	priv->base = base;
+
+	ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
+	mcan_class->device_data = priv;
+	mcan_class->dev = &pci->dev;
+	mcan_class->net->irq = pci_irq_vector(pci, 0);
+	mcan_class->pm_clock_support = 1;
+	mcan_class->can.clock.freq = id->driver_data;
+	mcan_class->ops = &m_can_pci_ops;
+
+	pci_set_drvdata(pci, mcan_class->net);
+
+	ret = m_can_class_register(mcan_class);
+	if (ret)
+		goto err;
+
+	/* Enable interrupt control at CAN wrapper IP */
+	writel(0x1, base + CTL_CSR_INT_CTL_OFFSET);
+
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_allow(dev);
+
+	return 0;
+
+err:
+	pci_free_irq_vectors(pci);
+	return ret;
+}
+
+static void m_can_pci_remove(struct pci_dev *pci)
+{
+	struct net_device *dev = pci_get_drvdata(pci);
+	struct m_can_classdev *mcan_class = netdev_priv(dev);
+	struct m_can_pci_priv *priv = mcan_class->device_data;
+
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
+
+	/* Disable interrupt control at CAN wrapper IP */
+	writel(0x0, priv->base + CTL_CSR_INT_CTL_OFFSET);
+
+	m_can_class_unregister(mcan_class);
+	pci_free_irq_vectors(pci);
+}
+
+static __maybe_unused int m_can_pci_suspend(struct device *dev)
+{
+	return m_can_class_suspend(dev);
+}
+
+static __maybe_unused int m_can_pci_resume(struct device *dev)
+{
+	return m_can_class_resume(dev);
+}
+
+static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
+			 m_can_pci_suspend, m_can_pci_resume);
+
+static const struct pci_device_id m_can_pci_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
+	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
+	{  }	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci, m_can_pci_id_table);
+
+static struct pci_driver m_can_pci_driver = {
+	.name = "m_can_pci",
+	.probe = m_can_pci_probe,
+	.remove = m_can_pci_remove,
+	.id_table = m_can_pci_id_table,
+	.driver = {
+		.pm = &m_can_pci_pm_ops,
+	},
+};
+
+module_pci_driver(m_can_pci_driver);
+
+MODULE_AUTHOR("Felipe Balbi (Intel)");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller on PCI bus");
-- 
2.29.2

