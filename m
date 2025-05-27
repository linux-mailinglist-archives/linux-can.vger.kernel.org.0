Return-Path: <linux-can+bounces-3710-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C73AC5B2D
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 22:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310798A65E8
	for <lists+linux-can@lfdr.de>; Tue, 27 May 2025 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEF1F463F;
	Tue, 27 May 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nc0IgBs3";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nR46XOYv"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED51DE3CA
	for <linux-can@vger.kernel.org>; Tue, 27 May 2025 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376166; cv=pass; b=qt4aMbGrhv0e4rWpG2WPD1S/czZ/k1QK6LVutxBb2TVKOEPXW61K39jE6bChpLe/co6KqByfMEeDhmChAq07CAnrC4E3YP7/VKjy8T2KgZsrHbHERisEiHFDS4VPkoSuKLnLu28w+Ty+2avo1ZsgnNXyGE4FGYWvDjdIoboJvZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376166; c=relaxed/simple;
	bh=/1HeOgoa4uQyN6OISZapgle+0R6Lm9FHq9g+QSjGoUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVLEdC41SORvqw0kVGkRp4r+qNsqXIjc5OjDdFZp5FThiNHgZhwV9NszOX8wCUlrWkTmGnp2V8Y8/pXTgK82uJHtI83TZAkPkh5dCikpKFc4ScbFfICSovg/1TyMRef6dzGr7ueiqudZ+LEl36/YP0aX5Gm8rXa0M9dZqOlMhbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nc0IgBs3; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nR46XOYv; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1748375803; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Iyg72j+a6CLCPT2tsuUL02ylKW4HzjVPhlPs0AWZeIE8/ZsYd/REYFIWE3l3ocPYIa
    D/r5b3Tj8cSfPdRX3eUmEr82PEI5NZ4QwtzFYp4O28gdvFAknFqTkJoOpzrovBl8gBtn
    Vh3tQh6Gtrsn/MKq5nBWLtDEX6IWg+6c0tOF4kD76xdx/vGRrUBQ6BAmAxWYhdKWH9AZ
    AZA4sO640MLFoHiWpCNADOuheTmp8LTX0EeI3GHzds9qvhqNIR3hol/mrKzOzCa81Zkc
    A/vRLo3IoOV+zB4oxGtjhDUzl6BMEGuWZXSJlE3/ycUL4BfwRjLq16VuRTA87QgXrVDm
    z2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375803;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=n1txgVgDa4HZp6VcYDv9jZ8L/v7P4+IQr1u8rX7q52Q=;
    b=CN4+T3fM27eM5v144ue2w4rSVzcs5yslefqPeqQe0Y4N+Nm8MpimM+Ltlfs6JJx35x
    rhI8V7sPmutdq2E+y7UQMefYEE/b0gYy++/7O7+0u8DvD4b5u23GyYj9XIfv/6rw4mM0
    nvicICFYSZVF0vd+loyBcTPE4BLgvXRFNdnOaRNmWReSTe2ZZZQTPwHKkkgHPQqfpCTM
    tQRqsBd5h5M79KwPkui80IWwDqAuI9OnHmxtscGW/dia6kLYdguzb9BB6PUJaK0aipsM
    8p2BMNsVHe+ZAAOlN9+pekb2r1M+NsT2kHWVFQec6zoxsgR9LU1WOYNoKIjxR+NAmxWE
    g8Yw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1748375803;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=n1txgVgDa4HZp6VcYDv9jZ8L/v7P4+IQr1u8rX7q52Q=;
    b=nc0IgBs3LVT4bCytKESMHrRH/kKCIrnugxEg880Jkw7h0hrxVYWGPEaJE1vTbu7eQx
    LV849QU1iUKpxGrDfFbWk6oQTXDsVezFxVWh1aoPKpHAM2tRZ4KQbNw26GvxkDNPZ8uH
    o6DMIlv4D4B7CuYEThePPdxhS5Kb13Fou0nJvYHvvYX3wBmmaBqhoK1z+x9skzigHxxG
    kC3lxqn+fjdbg9bnbTDSUAWSUdfEvQn0IpbkLc4eN/srRau/BXWraIyIO2ZcSk/MWT+V
    JR6+MukMdU7Bdo5FGZg+fWZQJ40esGWwdQDPm1f+eKDY0o5ozfF+EumUjzyh5BGS0wB6
    PO+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1748375803;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=n1txgVgDa4HZp6VcYDv9jZ8L/v7P4+IQr1u8rX7q52Q=;
    b=nR46XOYv/NfR1M6UgtLht0hanLQA/MMAxo6Kzqw2RDoqFPX8w6T2Yaxmbe0NQSMruF
    op8zXme/YXjKQRJr/gAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e514RJugiWD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 May 2025 21:56:42 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 11/11] can: add CAN XL dummy driver DO NOT MERGE
Date: Tue, 27 May 2025 21:56:25 +0200
Message-ID: <20250527195625.65252-11-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527195625.65252-1-socketcan@hartkopp.net>
References: <20250527195625.65252-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

A dummy module just to check the CAN XL netlink interface.

Oliver: added control mode/supported output

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/Kconfig   |   8 ++
 drivers/net/can/Makefile  |   1 +
 drivers/net/can/dummyxl.c | 226 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+)
 create mode 100644 drivers/net/can/dummyxl.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cf989bea9aa3..a8bc5f4e752f 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -122,10 +122,18 @@ config CAN_CAN327
 	  Please refer to the documentation for information on how to use it:
 	  Documentation/networking/device_drivers/can/can327.rst
 
 	  If this driver is built as a module, it will be called can327.
 
+config CAN_DUMMY_XL
+	tristate "Dummy CAN XL"
+	help
+	  A dummy module just to check the CAN XL netlink interface. Do not
+	  merge this.
+
+	  If this driver is built as a module, it will be called dummyxl.
+
 config CAN_FLEXCAN
 	tristate "Support for Freescale FLEXCAN based chips"
 	depends on OF || COLDFIRE || COMPILE_TEST
 	depends on HAS_IOMEM
 	select CAN_RX_OFFLOAD
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index a71db2cfe990..ff8e00fa26e3 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -19,10 +19,11 @@ obj-$(CONFIG_CAN_AT91)		+= at91_can.o
 obj-$(CONFIG_CAN_BXCAN)		+= bxcan.o
 obj-$(CONFIG_CAN_CAN327)	+= can327.o
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_CTUCANFD)	+= ctucanfd/
+obj-$(CONFIG_CAN_DUMMY_XL)	+= dummyxl.o
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
 obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
 obj-$(CONFIG_CAN_KVASER_PCIEFD)	+= kvaser_pciefd.o
diff --git a/drivers/net/can/dummyxl.c b/drivers/net/can/dummyxl.c
new file mode 100644
index 000000000000..ac1b579b4c1f
--- /dev/null
+++ b/drivers/net/can/dummyxl.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2024 Vincent Mailhol <mailhol.vincent@wanadoo.fr> */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/units.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/skb.h>
+
+struct dummyxl {
+	struct can_priv can;
+	struct net_device *dev;
+};
+
+static struct dummyxl *dummyxl;
+
+static const struct can_bittiming_const dummyxl_bittiming_const = {
+	.name = "dummyxl nominal",
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1
+};
+
+static const struct can_bittiming_const dummyxl_fd_databittiming_const = {
+	.name = "dummyxl FD",
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1
+};
+
+static const struct can_tdc_const dummyxl_fd_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 0, /* Manual mode not supported. */
+	.tdco_min = 0,
+	.tdco_max = 127,
+	.tdcf_min = 0,
+	.tdcf_max = 127
+};
+
+static const struct can_bittiming_const dummyxl_xl_databittiming_const = {
+	.name = "dummyxl XL",
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 512,
+	.brp_inc = 1
+};
+
+static const struct can_tdc_const dummyxl_xl_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 0, /* Manual mode not supported. */
+	.tdco_min = 0,
+	.tdco_max = 127,
+	.tdcf_min = 0,
+	.tdcf_max = 127
+};
+
+static void dummyxl_print_bittiming(struct net_device *dev, struct can_bittiming *bt)
+{
+	netdev_info(dev, "\tbitrate: %u\n", bt->bitrate);
+	netdev_info(dev, "\tsample_point: %u\n", bt->sample_point);
+	netdev_info(dev, "\ttq: %u\n", bt->tq);
+	netdev_info(dev, "\tprop_seg: %u\n", bt->prop_seg);
+	netdev_info(dev, "\tphase_seg1: %u\n", bt->phase_seg1);
+	netdev_info(dev, "\tphase_seg2: %u\n", bt->phase_seg2);
+	netdev_info(dev, "\tsjw: %u\n", bt->sjw);
+	netdev_info(dev, "\tbrp: %u\n", bt->brp);
+}
+
+static void dummyxl_print_tdc(struct net_device *dev, struct can_tdc *tdc)
+{
+	netdev_info(dev, "\t\ttdcv: %u\n", tdc->tdcv);
+	netdev_info(dev, "\t\ttdco: %u\n", tdc->tdco);
+	netdev_info(dev, "\t\ttdcf: %u\n", tdc->tdcf);
+}
+
+static int dummyxl_netdev_open(struct net_device *dev)
+{
+	struct dummyxl *priv = netdev_priv(dev);
+	struct can_priv *can_priv = &priv->can;
+	int ret;
+
+	netdev_info(dev, "CAN control mode/supported : %08X/%08X\n",
+		    can_priv->ctrlmode, can_priv->ctrlmode_supported);
+	netdev_info(dev, "CAN CC nominal bittiming:\n");
+	dummyxl_print_bittiming(dev, &can_priv->bittiming);
+	netdev_info(dev, "\n");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_FD) {
+		netdev_info(dev, "CAN FD databittiming:\n");
+		dummyxl_print_bittiming(dev, &can_priv->fd.data_bittiming);
+		if (can_fd_tdc_is_enabled(can_priv)) {
+			netdev_info(dev, "\tCAN FD TDC:\n");
+			dummyxl_print_tdc(dev, &can_priv->fd.tdc);
+		} else {
+			netdev_info(dev, "\tCAN FD TDC is off\n");
+		}
+	} else {
+		netdev_info(dev, "CAN FD is off\n");
+	}
+	netdev_info(dev, "\n");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_XL) {
+		netdev_info(dev, "CAN XL databittiming:\n");
+		dummyxl_print_bittiming(dev, &can_priv->xl.data_bittiming);
+		if (can_xl_tdc_is_enabled(can_priv)) {
+			netdev_info(dev, "\tCAN XL TDC:\n");
+			dummyxl_print_tdc(dev, &can_priv->xl.tdc);
+		} else {
+			netdev_info(dev, "\tCAN XL TDC is off\n");
+		}
+	} else {
+		netdev_info(dev, "CAN XL is off\n");
+	}
+	netdev_info(dev, "\n");
+
+	ret = open_candev(dev);
+	if (ret)
+		return ret;
+	netif_start_queue(dev);
+	netdev_info(dev, "dummyxl is up\n");
+
+	return 0;
+}
+
+static int dummyxl_netdev_close(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+	close_candev(dev);
+	netdev_info(dev, "dummyxl is down\n");
+
+	return 0;
+}
+
+static netdev_tx_t dummyxl_start_xmit(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	if (can_is_canxl_skb(skb))
+		netdev_info(dev, "Received CAN XL skb\n");
+	else if (can_is_canfd_skb(skb))
+		netdev_info(dev, "Received CAN FD skb\n");
+	else if (can_is_can_skb(skb))
+		netdev_info(dev, "Received Classical CAN skb\n");
+	else
+		netdev_info(dev, "Received an odd skb?!\n");
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops dummyxl_netdev_ops = {
+	.ndo_open = dummyxl_netdev_open,
+	.ndo_stop = dummyxl_netdev_close,
+	.ndo_start_xmit = dummyxl_start_xmit,
+};
+
+static int __init dummyxl_init(void)
+{
+	struct net_device *dev;
+	struct dummyxl *priv;
+	int ret;
+
+	dev = alloc_candev(sizeof(struct dummyxl), 0);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->netdev_ops = &dummyxl_netdev_ops;
+	priv = netdev_priv(dev);
+	priv->can.bittiming_const = &dummyxl_bittiming_const;
+	priv->can.bitrate_max = 8 * MEGA /* BPS */;
+	priv->can.clock.freq = 80 * MEGA /* Hz */;
+	priv->can.fd.data_bittiming_const = &dummyxl_fd_databittiming_const;
+	priv->can.fd.tdc_const = &dummyxl_fd_tdc_const;
+	priv->can.xl.data_bittiming_const = &dummyxl_xl_databittiming_const;
+	priv->can.xl.tdc_const = &dummyxl_xl_tdc_const;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_FD | CAN_CTRLMODE_TDC_AUTO |
+		CAN_CTRLMODE_XL | CAN_CTRLMODE_XL_TDC_AUTO;
+	priv->dev = dev;
+
+	ret = register_candev(priv->dev);
+	if (ret) {
+		free_candev(priv->dev);
+		return ret;
+	}
+
+	dummyxl = priv;
+	netdev_info(dev, "dummyxl OK\n");
+
+	return 0;
+}
+
+static void __exit dummyxl_exit(void)
+{
+	struct net_device *dev = dummyxl->dev;
+
+	netdev_info(dev, "dummyxl bye bye\n");
+	unregister_candev(dev);
+	free_candev(dev);
+}
+
+module_init(dummyxl_init);
+module_exit(dummyxl_exit);
+
+MODULE_DESCRIPTION("A dummy module just to check the CAN XL netlink interface");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Vincent Mailhol <mailhol.vincent@wanadoo.fr>");
-- 
2.47.2


