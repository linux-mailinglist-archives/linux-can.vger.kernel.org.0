Return-Path: <linux-can+bounces-2291-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035EB9DF55E
	for <lists+linux-can@lfdr.de>; Sun,  1 Dec 2024 12:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB17162370
	for <lists+linux-can@lfdr.de>; Sun,  1 Dec 2024 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AE378685;
	Sun,  1 Dec 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="io7WChja";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F9jM7zwb"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41464087C
	for <linux-can@vger.kernel.org>; Sun,  1 Dec 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733052207; cv=pass; b=awJdIkzdOIwex+PN+sF5sXjLty1+GDqz7eYkbBnCNvtBF48UtrrhLhTvfQVfxA92pOZFo6bUva35zmJm1lMjpn3Fr9sV7kzN+euAVxnIU1ueNxzVtDtprXQO8P1qOsLRLD95aNeseyrq4EKjVBayD3KvxWrK2xF/KRMr8OizSUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733052207; c=relaxed/simple;
	bh=VDOknzT5ZQ0Bs7u9kAJE08pI0LwVLqJVwh/obhaZ1hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5VgWhN/15loUe8v+TN2XF5XOwx06CQ6gbZObrMFCAxlVT7wLbzSDB+MT35s8pEJi9t/hXia/qL05VejOqDocIoinAq7Wq+W1aFrCv3UnuJ7vuH6A48V7pFTVCZXS63URLfrhYN/RxvGqz/BjcqhoaxHUnsfCvSzYwwybOaKZp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=io7WChja; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F9jM7zwb; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733052197; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SohQC8zKiwWpyKwi9u8Aq1OAHNFqif+x9glKodEMyoAwntTSIr+IzR0Nl7LlVMxNxU
    Alt54Enc+OpTWioEt1GJuMzevBb7+X9KRl6cniw6kVr+QGB0LaIsyRqjFjBjXLWWZxmx
    br7iyHF4+K2U5su4jSxDer5RWdJCm/hyUCpGf2vfZ0xkoNNrHm0DQt3GJhX5ndiz3X15
    l9hzrM3sg2J85CUW2+bc9fbufwX3Rz9uCG/SYURuyEjuHEQbrLBYpidBG7bD0wkDGaZo
    /Ms5Gd5JV91yBscKwtsUSg0P94TmxFwvF5YDqf4TKXeLzy8t6+Vdrm/W7teqHuF3kGn+
    TZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733052197;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rCMqS2hCw/j5XK+LaG3f7ULfifh8CndzoAMQKW3gxYk=;
    b=YHvzlwG/t3UYO/bgX2qH7Kbu3V9+72XlfJT3DzQzK4yTvQbhmfW4F6iT20mzTywBdA
    lvZi3vWBoYJ97Mewc5tB7AcHhrqh2H+TcBTgsAQSVDOU9OxDAjSscZHLV2F3NCNBoYt+
    nseAqn/3Kq/38XRWa2qjWa6A+iQ8vvUKv1sth08UddSDHdmVrUhq7iCqFmb7aiQ4uQx0
    C57frZiaUw7WxUH8TGjkx3wx0SIcX5jTLcy3XPp5SmJy7P1+XeD/mIXYgiobxn/beEe/
    nAFkxafkV53VaMUvs9tq3cfXnBQa469NT+bG5DbJQ4KL+BBB0DnmcJ536GswiWdVmPd9
    5LbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733052197;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rCMqS2hCw/j5XK+LaG3f7ULfifh8CndzoAMQKW3gxYk=;
    b=io7WChja5eP5IhBg7rNixDhufFDbhV6636Sdbj1ZDnVbi3YitW6UiIyOkVR4fru6VI
    Equuvjr3Cn+i2uTpVZzB8D85kePxrfxYPFSOsV2c6QvFEYtfLYcDdpJh6r7nrzI0mXXM
    lu9Co6Do6eXNl9lqaQG+WU59YbaUrbhpFMeK14JAbXM1FQvAb4Pv2H0p7ZETh68GUxL9
    TAOBCWXkw8tU4vZFoJMA6RVGvh7Dvn9/dwsAPERxFPgpLJWQR7HT+Zx3058wDtNIlU6q
    qcR/xJ/XS6ZQrgtr1juGDW6ly/uOb9UWHIj1QJcXYK7Bn8VGZ0v+tWbb83/l5UR810vd
    EsjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733052197;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=rCMqS2hCw/j5XK+LaG3f7ULfifh8CndzoAMQKW3gxYk=;
    b=F9jM7zwbtANgHMywMvwUFt3hVfkEz6SHX+BwHXzHy5bqw1RPI8lXfYiZmmLdCkM3qd
    TNw/i60oBgqZ5gc15aDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B1BNHgXE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 1 Dec 2024 12:23:17 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH 2/2] can xl dummy driver from Vincent
Date: Sun,  1 Dec 2024 12:22:30 +0100
Message-ID: <20241201112230.6917-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201112230.6917-1-socketcan@hartkopp.net>
References: <20241201112230.6917-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

added control mode/supported output

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
2.45.2


