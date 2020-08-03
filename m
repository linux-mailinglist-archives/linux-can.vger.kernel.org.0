Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32B23ACFD
	for <lists+linux-can@lfdr.de>; Mon,  3 Aug 2020 21:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgHCT2U (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 Aug 2020 15:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgHCT2U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Aug 2020 15:28:20 -0400
Received: from relay.felk.cvut.cz (relay.felk.cvut.cz [IPv6:2001:718:2:1611:0:1:0:70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C07ECC06174A;
        Mon,  3 Aug 2020 12:28:19 -0700 (PDT)
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
        by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 073JQH9f035403;
        Mon, 3 Aug 2020 21:26:17 +0200 (CEST)
        (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
        by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id 073JQG3l008549;
        Mon, 3 Aug 2020 21:26:16 +0200
Received: (from pisa@localhost)
        by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 073JQGCh008548;
        Mon, 3 Aug 2020 21:26:16 +0200
From:   pisa@cmp.felk.cvut.cz
To:     linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        mkl@pengutronix.de, socketcan@hartkopp.net
Cc:     wg@grandegger.com, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, c.emde@osadl.org, armbru@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.jerabek01@gmail.com, ondrej.ille@gmail.com,
        jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com,
        Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v4 5/6] can: ctucanfd: CTU CAN FD open-source IP core - platform/SoC support.
Date:   Mon,  3 Aug 2020 20:34:53 +0200
Message-Id: <58ba0e9298e6c5fb20fd78f291899c955817bf13.1596408856.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
References: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 073JQH9f035403
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-0.098, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
        SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1597087578.67277@RnPGAhg2NTNyB1npdVSMQQ
X-Spam-Status: No
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Platform bus adaptation for CTU CAN FD open-source IP core.

The core has been tested together with OpenCores SJA1000
modified to be CAN FD frames tolerant on MicroZed Zynq based
MZ_APO education kits designed by Petr Porazil from PiKRON.com
company. FPGA design

  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top.

The kit description at the Computer Architectures course pages

  https://cw.fel.cvut.cz/b182/courses/b35apo/documentation/mz_apo/start .

Kit carrier board and mechanics design source files

  https://gitlab.com/pikron/projects/mz_apo/microzed_apo

The work is documented in Martin Jeřábek's diploma theses
Open-source and Open-hardware CAN FD Protocol Support

  https://dspace.cvut.cz/handle/10467/80366
.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Martin Jerabek <martin.jerabek01@gmail.com>
Signed-off-by: Ondrej Ille <ondrej.ille@gmail.com>
---
 drivers/net/can/ctucanfd/Kconfig               |  11 ++
 drivers/net/can/ctucanfd/Makefile              |   3 +
 drivers/net/can/ctucanfd/ctu_can_fd_platform.c | 145 +++++++++++++++++++++++++
 3 files changed, 159 insertions(+)
 create mode 100644 drivers/net/can/ctucanfd/ctu_can_fd_platform.c

diff --git a/drivers/net/can/ctucanfd/Kconfig b/drivers/net/can/ctucanfd/Kconfig
index 8a5f5d05fa72..c0155d659373 100644
--- a/drivers/net/can/ctucanfd/Kconfig
+++ b/drivers/net/can/ctucanfd/Kconfig
@@ -24,4 +24,15 @@ config CAN_CTUCANFD_PCI
 	  PCIe board with PiKRON.com designed transceiver riser shield is available
 	  at https://gitlab.fel.cvut.cz/canbus/pcie-ctu_can_fd .
 
+config CAN_CTUCANFD_PLATFORM
+	tristate "CTU CAN-FD IP core platform (FPGA, SoC) driver"
+	depends on OF
+	help
+	  The core has been tested together with OpenCores SJA1000
+	  modified to be CAN FD frames tolerant on MicroZed Zynq based
+	  MZ_APO education kits designed by Petr Porazil from PiKRON.com
+	  company. FPGA design https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top.
+	  The kit description at the Computer Architectures course pages
+	  https://cw.fel.cvut.cz/b182/courses/b35apo/documentation/mz_apo/start .
+
 endif
diff --git a/drivers/net/can/ctucanfd/Makefile b/drivers/net/can/ctucanfd/Makefile
index eb945260952d..a77ca72d534e 100644
--- a/drivers/net/can/ctucanfd/Makefile
+++ b/drivers/net/can/ctucanfd/Makefile
@@ -8,3 +8,6 @@ ctucanfd-y := ctu_can_fd.o ctu_can_fd_hw.o
 
 obj-$(CONFIG_CAN_CTUCANFD_PCI) += ctucanfd_pci.o
 ctucanfd_pci-y := ctu_can_fd_pci.o
+
+obj-$(CONFIG_CAN_CTUCANFD_PLATFORM) += ctucanfd_platform.o
+ctucanfd_platform-y += ctu_can_fd_platform.o
diff --git a/drivers/net/can/ctucanfd/ctu_can_fd_platform.c b/drivers/net/can/ctucanfd/ctu_can_fd_platform.c
new file mode 100644
index 000000000000..435913573403
--- /dev/null
+++ b/drivers/net/can/ctucanfd/ctu_can_fd_platform.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*******************************************************************************
+ *
+ * CTU CAN FD IP Core
+ * Copyright (C) 2015-2018
+ *
+ * Authors:
+ *     Ondrej Ille <ondrej.ille@gmail.com>
+ *     Martin Jerabek <martin.jerabek01@gmail.com>
+ *     Jaroslav Beran <jara.beran@gmail.com>
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
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "ctu_can_fd.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Martin Jerabek");
+MODULE_DESCRIPTION("CTU CAN FD for platform");
+
+#define DRV_NAME	"ctucanfd"
+
+static void ctucan_platform_set_drvdata(struct device *dev,
+					struct net_device *ndev)
+{
+	struct platform_device *pdev = container_of(dev, struct platform_device,
+						    dev);
+
+	platform_set_drvdata(pdev, ndev);
+}
+
+/**
+ * ctucan_platform_probe - Platform registration call
+ * @pdev:	Handle to the platform device structure
+ *
+ * This function does all the memory allocation and registration for the CAN
+ * device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int ctucan_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res; /* IO mem resources */
+	struct device	*dev = &pdev->dev;
+	void __iomem *addr;
+	int ret;
+	unsigned int ntxbufs;
+	int irq;
+
+	/* Get the virtual base address for the device */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	addr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(addr)) {
+		dev_err(dev, "Cannot remap address.\n");
+		ret = PTR_ERR(addr);
+		goto err;
+	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Cannot find interrupt.\n");
+		ret = irq;
+		goto err;
+	}
+
+	/* Number of tx bufs might be change in HW for future. If so,
+	 * it will be passed as property via device tree
+	 */
+	ntxbufs = 4;
+	ret = ctucan_probe_common(dev, addr, irq, ntxbufs, 0,
+				  1, ctucan_platform_set_drvdata);
+
+	if (ret < 0)
+		platform_set_drvdata(pdev, NULL);
+
+err:
+	return ret;
+}
+
+/**
+ * ctucan_platform_remove - Unregister the device after releasing the resources
+ * @pdev:	Handle to the platform device structure
+ *
+ * This function frees all the resources allocated to the device.
+ * Return: 0 always
+ */
+static int ctucan_platform_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct ctucan_priv *priv = netdev_priv(ndev);
+
+	netdev_dbg(ndev, "ctucan_remove");
+
+	unregister_candev(ndev);
+	pm_runtime_disable(&pdev->dev);
+	netif_napi_del(&priv->napi);
+	free_candev(ndev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ctucan_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ctucan_suspend, ctucan_resume)
+};
+
+/* Match table for OF platform binding */
+static const struct of_device_id ctucan_of_match[] = {
+	{ .compatible = "ctu,canfd-2", },
+	{ .compatible = "ctu,ctucanfd", },
+	{ /* end of list */ },
+};
+MODULE_DEVICE_TABLE(of, ctucan_of_match);
+
+static struct platform_driver ctucanfd_driver = {
+	.probe	= ctucan_platform_probe,
+	.remove	= ctucan_platform_remove,
+	.driver	= {
+		.name = DRV_NAME,
+		.pm = &ctucan_dev_pm_ops,
+		.of_match_table	= ctucan_of_match,
+	},
+};
+
+module_platform_driver(ctucanfd_driver);
-- 
2.11.0

