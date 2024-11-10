Return-Path: <linux-can+bounces-1935-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E99C33B2
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C3F1C20A2C
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783777111;
	Sun, 10 Nov 2024 15:59:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA84CDEC
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254397; cv=none; b=WCjCTIG+ap3vEho4t5Ewy3mGtRrJxnKv/2lqngj3JOoGKSclMZE+XZa/V4tWH8uKueTKITsYrUGYuy9HJ8u0WJF+v2yeZBYUJ2w2N35Up4Leh9pvmwVHBgjDFvWNX8Y3FXaoJ0wXieT3NAxPW4VXNRCb357mrRUMIhsFvT7tdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254397; c=relaxed/simple;
	bh=79k9CFVshMMOmJX5yiVz7tWIh6yPCU72tgk6E50G/q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMOavPGUZnDu2VVy+cjfXhS328Vc7xNFF+A/wxEEsBT6K3FzEhLQAfmexGIDoN8r6/LxAn2C77URO9nGbAtD0IHA7Heq7/PG2b188G/Bwas/HhKTN7zU8OVIIntzvtkhDleJ0G+ns3OZjeTnbuF3EzpN9gWTdWHEi9r+ZlP9Vwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7206304f93aso3463455b3a.0
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254395; x=1731859195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5Q07iWaQ0LVNr+9grh6ZA4c8fYFab5R9sngOXhrhNk=;
        b=Q+WmcKiWmo3/bWVV7fPr3RBe4PXjUeVjyZOZqAt0N1LV6XeSIjMKzUWnys5Cg9f2t4
         6g73kH1r2qvn8JIY3FmE3kcH3KSJvT0kxmT2Rq9/oCXWWWQrjGg7uchrGREfaGEwpaiD
         E+7HmHFyGIZuXv88n2JjvryZJt1rTRgvKH1QxebiYUBbZITp9PGjVH2ne78UgXAhVZvm
         962z86hcuuDZFSPXDXYjoO7q5v1sYacbziXV0dHyNTyvN/L9LvkXZ9EF1hOd86AjslNY
         q5mLGrZ9twh2fU647yi5VfSqYz7lX2o4lh0905L2VPsHCr0PwQMP6DqoQxfH9oMCvZCA
         wr7Q==
X-Gm-Message-State: AOJu0YyZoBZvjSIAqkB1aOBRrmzqRG18wn/2Np/iA3zEQeTlhPINkPGx
	LmTfZ48rgXwcRbOYV3/qTC4ZjLp6qSR2L2ed/eJ8GJWfjw7L9MMPOr6HnQ==
X-Google-Smtp-Source: AGHT+IGoV+Ofm/2zP9g7Vz6x1oT1dgwW9+Hj5pslouHpKQVssxY7AIaDrl3E0+Ft5sfORyc6HOLzGA==
X-Received: by 2002:a05:6a20:7fa8:b0:1db:ec07:3436 with SMTP id adf61e73a8af0-1dc228930fcmr13875949637.9.1731254394957;
        Sun, 10 Nov 2024 07:59:54 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:54 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 14/14] !!! DO NOT MERGE !!! can: add dummyxl driver
Date: Mon, 11 Nov 2024 00:56:03 +0900
Message-ID: <20241110155902.72807-30-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9997; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=79k9CFVshMMOmJX5yiVz7tWIh6yPCU72tgk6E50G/q4=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN4LT9me+LPSUMWVYyMyW+HOpZgWbbqGQzwvmcz8Fj r88Pj2/o5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwET2v2b4pzvH5tXZDFGGNZeP 3tMWLxIyWSu4s1qqV0D0Rk7eLjf5+YwMF5I3P9JiSIlVkWHsuDyFZ/mRGqfQ32dzvqw10G6ICeP kBwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

A dummy driver to test the CAN XL netlink.

I wrote this in less than one hour. I will drop this from the series
once this is not an RFC anymore.

To test:

  1. Apply this series, compile it and load the driver. Example:

       modprobe dummyxl

     From now on, I will assume that the can device name is
     can0. Adjust below commands accordingly to your setup.

  2. Apply the other series to the iproute2-next [1].

  3. Using the compiled ip tool, send the CAN bittiming and set the
     interface up. Example:

       ./ip/ip link set can0 up type can bitrate 500000 fd on dbitrate 2000000 xl on xl-dbitrate 8000000

  4. The kernel message log should show the bittiming parameters of
     the dummyxl driver. Like that:

       can0: CAN CC nominal bittiming:
       can0: 	bitrate: 500000
       can0: 	sample_point: 875
       can0: 	tq: 12
       can0: 	prop_seg: 69
       can0: 	phase_seg1: 70
       can0: 	phase_seg2: 20
       can0: 	sjw: 10
       can0: 	brp: 1
       can0:
       can0: CAN FD databittiming:
       can0: 	bitrate: 2000000
       can0: 	sample_point: 750
       can0: 	tq: 12
       can0: 	prop_seg: 14
       can0: 	phase_seg1: 15
       can0: 	phase_seg2: 10
       can0: 	sjw: 5
       can0: 	brp: 1
       can0: 	CAN FD TDC:
       can0: 		tdcv: 0
       can0: 		tdco: 30
       can0: 		tdcf: 0
       can0:
       can0: CAN XL databittiming:
       can0: 	bitrate: 8000000
       can0: 	sample_point: 700
       can0: 	tq: 12
       can0: 	prop_seg: 3
       can0: 	phase_seg1: 3
       can0: 	phase_seg2: 3
       can0: 	sjw: 1
       can0: 	brp: 1
       can0: 	CAN XL TDC:
       can0: 		tdcv: 0
       can0: 		tdco: 7
       can0: 		tdcf: 0
       can0:
       can0: dummyxl is up

  5. Use a recent version of can-utils [2] to generate some CAN
     traffic. For example:

       cangen -m can0

     should generate a mix of Classical CAN, CAN FD and CAN XL
     frames. The dummyxl drivers should then print in the kernel log
     that those frames were well received.

Voila, with this, you are now able to send CAN XL frames to a CAN XL
driver.

[1] https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
[2] https://github.com/linux-can/can-utils

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/Kconfig   |   8 ++
 drivers/net/can/Makefile  |   1 +
 drivers/net/can/dummyxl.c | 224 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 drivers/net/can/dummyxl.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cf989bea9aa3..a8bc5f4e752f 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -124,6 +124,14 @@ config CAN_CAN327
 
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
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index a71db2cfe990..ff8e00fa26e3 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CAN_CAN327)	+= can327.o
 obj-$(CONFIG_CAN_CC770)		+= cc770/
 obj-$(CONFIG_CAN_C_CAN)		+= c_can/
 obj-$(CONFIG_CAN_CTUCANFD)	+= ctucanfd/
+obj-$(CONFIG_CAN_DUMMY_XL)	+= dummyxl.o
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan/
 obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
diff --git a/drivers/net/can/dummyxl.c b/drivers/net/can/dummyxl.c
new file mode 100644
index 000000000000..9f6a2991b0ec
--- /dev/null
+++ b/drivers/net/can/dummyxl.c
@@ -0,0 +1,224 @@
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
2.45.2


