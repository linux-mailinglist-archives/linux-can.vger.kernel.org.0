Return-Path: <linux-can+bounces-2326-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE809E34D2
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 09:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9FE16682C
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 08:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35418FDCE;
	Wed,  4 Dec 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="e7GELVzA";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="o692TOxe"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229F18C900
	for <linux-can@vger.kernel.org>; Wed,  4 Dec 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299053; cv=pass; b=kWBW9LT4zwPdKB8PO9rniOunojgAiGDEodOneCi1uh+sf0J2lGPRdbn5w6AQMq41rZ/jxqqNUyM57vUOxbJ8owE+193M0lXvAvtqhooRhqAzVbVlfRKvcUFSKKmAqLgZmkPnkiIzN7A8xbRoqsy4jGdH90k4dPWXBuLrC1NSYUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299053; c=relaxed/simple;
	bh=VDOknzT5ZQ0Bs7u9kAJE08pI0LwVLqJVwh/obhaZ1hM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGCFpo8qNdVPHWMvCIzp6778F+HFibG9LxWdT6JV4U6otFQTZkSW+1q3C9TjQ0KMhs07J0zIE6WehxtrE653zPUdBU4ulazLVE4wrkP9vsrYQoVXRgiwdO9ptioEshj//y5/I/JyDUroOqbJwmLEh0doQgAJEJqsY/ja2u6cUAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=e7GELVzA; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=o692TOxe; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733299042; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Wqvx4WjvRMZwSUlB5RA5cvxM4C1iVmp1iQ56b2yJRIxe+rbCC5gbCGl2OQ6xHZ9K2B
    hzALrL71+Ba3UYUGbnw4Pe8lq5q/fzIW943bXfPnc7+YQNTxgxl25E4hY+TazOJfq6uQ
    dpjFOYV6JOFN7TcsvwjI8jfZtEY+qa667yuHIjzAqeuEPO6F9za6WXpalr0CGe+lDa1+
    UcyonWrujFhI/4k8m0nFd3OfLjemwYhk0GwkAKvQsHw9JijOtDNwCABeolT9TvEh0zcc
    HNJmmnh9K5qMg3fBXm8U/Fv6uetK5oIoBMaMHJpx0waI0HJuUGXJhYkBAnaoFwfgz6av
    Ck+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299042;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rCMqS2hCw/j5XK+LaG3f7ULfifh8CndzoAMQKW3gxYk=;
    b=bWmElWapR1LA71p+BumM9u+3f6a/wfucbm7qtPsz8ige5hyR26trWUtBH2FnJaoxvw
    RUGn37W5mDC2WpuEN1RpT89RNhB5QOXLJ1X6JvV0Oo8UCT7g9JGCvZlNPZ0UC3a33LFn
    aJWUud1m+wCsZX5CCQDYhSf/d3+5uZbBrhufC54m5zKkBh1yhN3OZlS3HmbyswgwbDUl
    Os73xYId8UUfpTjlZ7aKW/pfMYEpYTWtzjBOBF5LaK0xjL/ocKYe4MQnZdxv4kvsRhxc
    Hg56PJgu+E/ESWpUwDGZLwCkodfu8/iaC8OxKphG5v/cuzhqyNBoU/5YMPdOjvf8uS5m
    oXMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733299042;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rCMqS2hCw/j5XK+LaG3f7ULfifh8CndzoAMQKW3gxYk=;
    b=e7GELVzAxTcONtvU/+E0PpN74mPr/gJZ9xUCVCXhKFypVIaUynA6b+0DgbqM4/7KnR
    wAx1MBhUrRopaAX4Ib5/BNKblHiM+4kcBrPXc+9lS1bh7zGU19WX4v7Q2swJZpatZikE
    paPaKD1S8D6zuGWefkfZJ87TO0MXtm48LdlCOJoITsS/926XHLOHmqH9YIjliIAjq7u2
    J8o0ai6kfhEKJLZ2iJHdGJVWM2WLkCwVMmrU7sOCuclX5PpS3co3WWCp2pSwg8EIKZU+
    eiY3/PhZUwY1TjZyOqSXNVREfi6/9WWbLtxwo/KUCVhgNgvQQOgIwybSUpABapkaLz7C
    JdoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733299042;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=rCMqS2hCw/j5XK+LaG3f7ULfifh8CndzoAMQKW3gxYk=;
    b=o692TOxe412D/OE1YWeXu1uVaUqbbaOvcWjc0xzbPjpSQbi5p2fzEaqO2veUXnH9or
    D8MJCx7cZkvSUIi+SMAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B47vMsr2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:57:22 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [RFC PATCH v2 1/4] can xl dummy driver from Vincent
Date: Wed,  4 Dec 2024 08:57:00 +0100
Message-ID: <20241204075703.3699-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
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


