Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5025823FA
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiG0KRT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiG0KRQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:16 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF5E41D3C
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:14 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso1722282pjr.2
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfZGVJCTvqb0foyMh/RhTEUuJyt2AHLb4M24qgrAUXc=;
        b=mM7JiUW3wfSTFTVY6IX8bKK2xQ0A3Du5wqR5tyJnzfsmb89jN3+sbQUrn0mOeEo6ud
         vGzeo8qJFkpwHWJ6+DmlRttW5bYxLip5gy537F0G2jFJ5DVWMqeZ4eBSf6PTnlIVOWB4
         2Ax8H56xPPFS9KTj0yFHoO6mS554YEAeQhfJ77QOHaSNLqGFtAPAfzwJC3mK5PA3IwiG
         TX5CWzk3BqWSkALSMQPKtFwrrGwJVdRtXEhsy96I41EE3VZezNcbNl5y9dboV3dAyva8
         8v8w98Ams6UOpOH/J6OJW49CCOJ0PhjwWlNhJyeyUSXimcdR9r51axt3if6NciWz5Ncf
         Qzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YfZGVJCTvqb0foyMh/RhTEUuJyt2AHLb4M24qgrAUXc=;
        b=5FcOvwMTluxRZgek6uuNWaZd0iS2PzpG+KLdGDpSllAoWfa41VH6Zs5IIOlz2MQIPh
         SeTNteTwLnQRu7QJ39w7yZ3tbiG3OmebU+TJgnzgapNufpfyi7xgqqpAy/fWsVlNe1/s
         mzFQNbU07YucUt94eYcByRulBMbLLJvy4mCtP9Hx63yoLcRQDpU+4g6tmN4dpYy/0NFl
         xscVR1qfuFACgeyx4AVrnYr/nytyA79AybzlH7Z7I5aTvfc91CnyvcU/1GZkaEHIImJS
         pzeyxSXQslicYR0O5FwxZ69hgsVma+mTgCTz1G1yOttfawVjLFtD0gA6rFlU+D1zbRer
         44Pw==
X-Gm-Message-State: AJIora+A0s2kvqbXfwii+M8D3BoWZAepTYJtGlbZLrKZeZcu5kEffv9D
        I8hLXdXkRE+9qeOFPhVenJ3MRuI5WfKFWA==
X-Google-Smtp-Source: AGRyM1uwFZTCzAkPu2S+0ZzLRl4DGwfO7KCVhG1jQiHgNIJG7d9sS6mbsG3ct91KLqdbngvQunfkZg==
X-Received: by 2002:a17:903:2344:b0:16d:2dbe:fb4e with SMTP id c4-20020a170903234400b0016d2dbefb4emr20612355plh.89.1658917033485;
        Wed, 27 Jul 2022 03:17:13 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:12 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 05/14] can: tree-wide: advertise software timestamping capabilities
Date:   Wed, 27 Jul 2022 19:16:32 +0900
Message-Id: <20220727101641.198847-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220727101641.198847-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Currently, some CAN drivers support hardware timestamping, some do
not. But userland has no method to query which features are supported
(aside maybe of getting RX messages and observe whether or not
hardware timestamps stay at zero).

The canonical way for a network driver to advertised what kind of
timestamping it supports is to implement ethtool_ops::get_ts_info().

This patch only targets the CAN drivers which *do not* support
hardware timestamping.  For each of those CAN drivers, implement the
get_ts_info() using the generic ethtool_op_get_ts_info().

This way, userland can do:

| $ ethtool --show-time-stamping canX

to confirm the device timestamping capacities.

N.B. the drivers which support hardware timestamping will be migrated
in separate patches.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/at91_can.c                | 6 ++++++
 drivers/net/can/c_can/c_can_ethtool.c     | 1 +
 drivers/net/can/can327.c                  | 5 +++++
 drivers/net/can/cc770/cc770.c             | 6 ++++++
 drivers/net/can/ctucanfd/ctucanfd_base.c  | 6 ++++++
 drivers/net/can/flexcan/flexcan-ethtool.c | 1 +
 drivers/net/can/grcan.c                   | 6 ++++++
 drivers/net/can/ifi_canfd/ifi_canfd.c     | 6 ++++++
 drivers/net/can/janz-ican3.c              | 6 ++++++
 drivers/net/can/m_can/m_can.c             | 6 ++++++
 drivers/net/can/mscan/mscan.c             | 1 +
 drivers/net/can/pch_can.c                 | 6 ++++++
 drivers/net/can/rcar/rcar_can.c           | 6 ++++++
 drivers/net/can/rcar/rcar_canfd.c         | 6 ++++++
 drivers/net/can/sja1000/sja1000.c         | 6 ++++++
 drivers/net/can/slcan/slcan-ethtool.c     | 1 +
 drivers/net/can/softing/softing_main.c    | 6 ++++++
 drivers/net/can/spi/hi311x.c              | 6 ++++++
 drivers/net/can/spi/mcp251x.c             | 6 ++++++
 drivers/net/can/sun4i_can.c               | 6 ++++++
 drivers/net/can/ti_hecc.c                 | 6 ++++++
 drivers/net/can/usb/ems_usb.c             | 6 ++++++
 drivers/net/can/usb/esd_usb.c             | 6 ++++++
 drivers/net/can/usb/gs_usb.c              | 2 ++
 drivers/net/can/usb/mcba_usb.c            | 6 ++++++
 drivers/net/can/usb/ucan.c                | 6 ++++++
 drivers/net/can/usb/usb_8dev.c            | 6 ++++++
 drivers/net/can/vcan.c                    | 6 ++++++
 drivers/net/can/vxcan.c                   | 6 ++++++
 drivers/net/can/xilinx_can.c              | 6 ++++++
 30 files changed, 155 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 29ed0d3cd171..3a2d109a3792 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/if_arp.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -1152,6 +1153,10 @@ static const struct net_device_ops at91_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops at91_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static ssize_t mb0_id_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -1293,6 +1298,7 @@ static int at91_can_probe(struct platform_device *pdev)
 	}
 
 	dev->netdev_ops	= &at91_netdev_ops;
+	dev->ethtool_ops = &at91_ethtool_ops;
 	dev->irq = irq;
 	dev->flags |= IFF_ECHO;
 
diff --git a/drivers/net/can/c_can/c_can_ethtool.c b/drivers/net/can/c_can/c_can_ethtool.c
index 8a826a6813bd..4994afc0826e 100644
--- a/drivers/net/can/c_can/c_can_ethtool.c
+++ b/drivers/net/can/c_can/c_can_ethtool.c
@@ -26,6 +26,7 @@ static void c_can_get_ringparam(struct net_device *netdev,
 
 static const struct ethtool_ops c_can_ethtool_ops = {
 	.get_ringparam = c_can_get_ringparam,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 void c_can_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 88718d0cc569..bfa33f5e7fbe 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -850,6 +850,10 @@ static const struct net_device_ops can327_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops can327_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static bool can327_is_valid_rx_char(u8 c)
 {
 	static const bool lut_char_is_valid['z'] = {
@@ -1034,6 +1038,7 @@ static int can327_ldisc_open(struct tty_struct *tty)
 	/* Configure netdev interface */
 	elm->dev = dev;
 	dev->netdev_ops = &can327_netdev_ops;
+	dev->ethtool_ops = &can327_ethtool_ops;
 
 	/* Mark ldisc channel as alive */
 	elm->tty = tty;
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 797a954bb1a0..0b9dfc76e769 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -17,6 +17,7 @@
 #include <linux/ptrace.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
@@ -836,6 +837,10 @@ static const struct net_device_ops cc770_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops cc770_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 int register_cc770dev(struct net_device *dev)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
@@ -846,6 +851,7 @@ int register_cc770dev(struct net_device *dev)
 		return err;
 
 	dev->netdev_ops = &cc770_netdev_ops;
+	dev->ethtool_ops = &cc770_ethtool_ops;
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 6b281f6eb9b4..3c18d028bd8c 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -19,6 +19,7 @@
 
 #include <linux/clk.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/init.h>
 #include <linux/bitfield.h>
 #include <linux/interrupt.h>
@@ -1301,6 +1302,10 @@ static const struct net_device_ops ctucan_netdev_ops = {
 	.ndo_change_mtu	= can_change_mtu,
 };
 
+static const struct ethtool_ops ctucan_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 int ctucan_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
@@ -1377,6 +1382,7 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 		set_drvdata_fnc(dev, ndev);
 	SET_NETDEV_DEV(ndev, dev);
 	ndev->netdev_ops = &ctucan_netdev_ops;
+	ndev->ethtool_ops = &ctucan_ethtool_ops;
 
 	/* Getting the can_clk info */
 	if (!can_clk_rate) {
diff --git a/drivers/net/can/flexcan/flexcan-ethtool.c b/drivers/net/can/flexcan/flexcan-ethtool.c
index 3ae535577700..8d9c45323da8 100644
--- a/drivers/net/can/flexcan/flexcan-ethtool.c
+++ b/drivers/net/can/flexcan/flexcan-ethtool.c
@@ -106,6 +106,7 @@ static const struct ethtool_ops flexcan_ethtool_ops = {
 	.get_priv_flags = flexcan_get_priv_flags,
 	.set_priv_flags = flexcan_set_priv_flags,
 	.get_sset_count = flexcan_get_sset_count,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 void flexcan_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 24035a6187c9..6c37aab93eb3 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/delay.h>
+#include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/can/dev.h>
 #include <linux/spinlock.h>
@@ -1561,6 +1562,10 @@ static const struct net_device_ops grcan_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops grcan_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static int grcan_setup_netdev(struct platform_device *ofdev,
 			      void __iomem *base,
 			      int irq, u32 ambafreq, bool txbug)
@@ -1577,6 +1582,7 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 	dev->irq = irq;
 	dev->flags |= IFF_ECHO;
 	dev->netdev_ops = &grcan_netdev_ops;
+	dev->ethtool_ops = &grcan_ethtool_ops;
 	dev->sysfs_groups[0] = &sysfs_grcan_group;
 
 	priv = netdev_priv(dev);
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 64e3be8b73af..ad7a89b95da7 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/ethtool.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -925,6 +926,10 @@ static const struct net_device_ops ifi_canfd_netdev_ops = {
 	.ndo_change_mtu	= can_change_mtu,
 };
 
+static const struct ethtool_ops ifi_canfd_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static int ifi_canfd_plat_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -962,6 +967,7 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 	ndev->irq = irq;
 	ndev->flags |= IFF_ECHO;	/* we support local echo */
 	ndev->netdev_ops = &ifi_canfd_netdev_ops;
+	ndev->ethtool_ops = &ifi_canfd_ethtool_ops;
 
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 78d9190a4220..71a2caae0757 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/ethtool.h>
 #include <linux/platform_device.h>
 
 #include <linux/netdevice.h>
@@ -1754,6 +1755,10 @@ static const struct net_device_ops ican3_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops ican3_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 /*
  * Low-level CAN Device
  */
@@ -1925,6 +1930,7 @@ static int ican3_probe(struct platform_device *pdev)
 	mod->free_page = DPM_FREE_START;
 
 	ndev->netdev_ops = &ican3_netdev_ops;
+	ndev->ethtool_ops = &ican3_ethtool_ops;
 	ndev->flags |= IFF_ECHO;
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 713a4b0edf86..4709c012b1dc 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/ethtool.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -1829,10 +1830,15 @@ static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops m_can_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static int register_m_can_dev(struct net_device *dev)
 {
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
+	dev->ethtool_ops = &m_can_ethtool_ops;
 
 	return register_candev(dev);
 }
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 78a21ab63601..b1677588a4c8 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -676,6 +676,7 @@ struct net_device *alloc_mscandev(void)
 	priv = netdev_priv(dev);
 
 	dev->netdev_ops = &mscan_netdev_ops;
+	dev->ethtool_ops = &mscan_ethtool_ops;
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 32804fed116c..0558ff67ec6a 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -6,6 +6,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -938,6 +939,10 @@ static const struct net_device_ops pch_can_netdev_ops = {
 	.ndo_change_mtu		= can_change_mtu,
 };
 
+static const struct ethtool_ops pch_can_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static void pch_can_remove(struct pci_dev *pdev)
 {
 	struct net_device *ndev = pci_get_drvdata(pdev);
@@ -1188,6 +1193,7 @@ static int pch_can_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->netdev_ops = &pch_can_netdev_ops;
+	ndev->ethtool_ops = &pch_can_ethtool_ops;
 	priv->can.clock.freq = PCH_CAN_CLK; /* Hz */
 
 	netif_napi_add_weight(ndev, &priv->napi, pch_can_poll, PCH_RX_OBJ_END);
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index d11db2112a4a..6ee968c59ac9 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <linux/can/dev.h>
@@ -630,6 +631,10 @@ static const struct net_device_ops rcar_can_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops rcar_can_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static void rcar_can_rx_pkt(struct rcar_can_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -785,6 +790,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 	}
 
 	ndev->netdev_ops = &rcar_can_netdev_ops;
+	ndev->ethtool_ops = &rcar_can_ethtool_ops;
 	ndev->irq = irq;
 	ndev->flags |= IFF_ECHO;
 	priv->ndev = ndev;
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index d3e569a02b4d..27085b796e75 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/platform_device.h>
 #include <linux/can/dev.h>
@@ -1695,6 +1696,10 @@ static const struct net_device_ops rcar_canfd_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops rcar_canfd_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 				    u32 fcan_freq)
 {
@@ -1711,6 +1716,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv = netdev_priv(ndev);
 
 	ndev->netdev_ops = &rcar_canfd_netdev_ops;
+	ndev->ethtool_ops = &rcar_canfd_ethtool_ops;
 	ndev->flags |= IFF_ECHO;
 	priv->ndev = ndev;
 	priv->base = gpriv->base;
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 75a2f9bf8c16..98dfd5f295a7 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -52,6 +52,7 @@
 #include <linux/ptrace.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
@@ -654,6 +655,10 @@ static const struct net_device_ops sja1000_netdev_ops = {
 	.ndo_change_mtu	= can_change_mtu,
 };
 
+static const struct ethtool_ops sja1000_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 int register_sja1000dev(struct net_device *dev)
 {
 	int ret;
@@ -663,6 +668,7 @@ int register_sja1000dev(struct net_device *dev)
 
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &sja1000_netdev_ops;
+	dev->ethtool_ops = &sja1000_ethtool_ops;
 
 	set_reset_mode(dev);
 	chipset_init(dev);
diff --git a/drivers/net/can/slcan/slcan-ethtool.c b/drivers/net/can/slcan/slcan-ethtool.c
index bf0afdc4e49d..e11d64de78a6 100644
--- a/drivers/net/can/slcan/slcan-ethtool.c
+++ b/drivers/net/can/slcan/slcan-ethtool.c
@@ -57,6 +57,7 @@ static const struct ethtool_ops slcan_ethtool_ops = {
 	.get_priv_flags = slcan_get_priv_flags,
 	.set_priv_flags = slcan_set_priv_flags,
 	.get_sset_count = slcan_get_sset_count,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 void slcan_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 8d27ac66ca7f..27579f99ef74 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -5,6 +5,7 @@
  * - Kurt Van Dijck, EIA Electronics
  */
 
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
@@ -611,6 +612,10 @@ static const struct net_device_ops softing_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops softing_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct can_bittiming_const softing_btr_const = {
 	.name = "softing",
 	.tseg1_min = 1,
@@ -649,6 +654,7 @@ static struct net_device *softing_netdev_create(struct softing *card,
 
 	netdev->flags |= IFF_ECHO;
 	netdev->netdev_ops = &softing_netdev_ops;
+	netdev->ethtool_ops = &softing_ethtool_ops;
 	priv->can.do_set_mode = softing_candev_set_mode;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
 
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 167114aae6dd..b87dc420428d 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -20,6 +20,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/freezer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -802,6 +803,10 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_start_xmit = hi3110_hard_start_xmit,
 };
 
+static const struct ethtool_ops hi3110_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct of_device_id hi3110_of_match[] = {
 	{
 		.compatible	= "holt,hi3110",
@@ -856,6 +861,7 @@ static int hi3110_can_probe(struct spi_device *spi)
 		goto out_free;
 
 	net->netdev_ops = &hi3110_netdev_ops;
+	net->ethtool_ops = &hi3110_ethtool_ops;
 	net->flags |= IFF_ECHO;
 
 	priv = netdev_priv(net);
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 666a4505a55a..e750d13c8841 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/freezer.h>
 #include <linux/gpio.h>
 #include <linux/gpio/driver.h>
@@ -1248,6 +1249,10 @@ static const struct net_device_ops mcp251x_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops mcp251x_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct of_device_id mcp251x_of_match[] = {
 	{
 		.compatible	= "microchip,mcp2510",
@@ -1313,6 +1318,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 		goto out_free;
 
 	net->netdev_ops = &mcp251x_netdev_ops;
+	net->ethtool_ops = &mcp251x_ethtool_ops;
 	net->flags |= IFF_ECHO;
 
 	priv = netdev_priv(net);
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index b90dfb429ccd..525309da1320 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -53,6 +53,7 @@
 #include <linux/can/error.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/ethtool.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -761,6 +762,10 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_start_xmit = sun4ican_start_xmit,
 };
 
+static const struct ethtool_ops sun4ican_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
 	.has_reset = false,
 };
@@ -851,6 +856,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 	}
 
 	dev->netdev_ops = &sun4ican_netdev_ops;
+	dev->ethtool_ops = &sun4ican_ethtool_ops;
 	dev->irq = irq;
 	dev->flags |= IFF_ECHO;
 
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index afa38771520e..ec0ffeeb2015 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/platform_device.h>
@@ -841,6 +842,10 @@ static const struct net_device_ops ti_hecc_netdev_ops = {
 	.ndo_change_mtu		= can_change_mtu,
 };
 
+static const struct ethtool_ops ti_hecc_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct of_device_id ti_hecc_dt_ids[] = {
 	{
 		.compatible = "ti,am3517-hecc",
@@ -918,6 +923,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->netdev_ops = &ti_hecc_netdev_ops;
+	ndev->ethtool_ops = &ti_hecc_ethtool_ops;
 
 	priv->clk = clk_get(&pdev->dev, "hecc_ck");
 	if (IS_ERR(priv->clk)) {
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index bbec3311d893..429fc53761d1 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2004-2009 EMS Dr. Thomas Wuensche
  */
+#include <linux/ethtool.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -879,6 +880,10 @@ static const struct net_device_ops ems_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops ems_usb_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct can_bittiming_const ems_usb_bittiming_const = {
 	.name = "ems_usb",
 	.tseg1_min = 1,
@@ -990,6 +995,7 @@ static int ems_usb_probe(struct usb_interface *intf,
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
 
 	netdev->netdev_ops = &ems_usb_netdev_ops;
+	netdev->ethtool_ops = &ems_usb_ethtool_ops;
 
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 177ed33e08d9..646cb85b3108 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2010-2012 esd electronic system design gmbh, Matthias Fuchs <socketcan@esd.eu>
  * Copyright (C) 2022 esd electronics gmbh, Frank Jungclaus <frank.jungclaus@esd.eu>
  */
+#include <linux/ethtool.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -882,6 +883,10 @@ static const struct net_device_ops esd_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops esd_usb_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct can_bittiming_const esd_usb2_bittiming_const = {
 	.name = "esd_usb2",
 	.tseg1_min = ESD_USB2_TSEG1_MIN,
@@ -1015,6 +1020,7 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
 	netdev->netdev_ops = &esd_usb_netdev_ops;
+	netdev->ethtool_ops = &esd_usb_ethtool_ops;
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
 	netdev->dev_id = index;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d3a658b444b5..0b2172bc57f1 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -946,6 +946,7 @@ static int gs_usb_set_phys_id(struct net_device *dev,
 
 static const struct ethtool_ops gs_usb_ethtool_ops = {
 	.set_phys_id = gs_usb_set_phys_id,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static struct gs_can *gs_make_candev(unsigned int channel,
@@ -989,6 +990,7 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	dev = netdev_priv(netdev);
 
 	netdev->netdev_ops = &gs_usb_netdev_ops;
+	netdev->ethtool_ops = &gs_usb_ethtool_ops;
 
 	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 792ab9da317d..69346c63021f 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -10,6 +10,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/signal.h>
@@ -758,6 +759,10 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_start_xmit = mcba_usb_start_xmit,
 };
 
+static const struct ethtool_ops mcba_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 /* Microchip CANBUS has hardcoded bittiming values by default.
  * This function sends request via USB to change the speed and align bittiming
  * values for presentation purposes only
@@ -836,6 +841,7 @@ static int mcba_usb_probe(struct usb_interface *intf,
 	priv->can.do_set_bittiming = mcba_net_set_bittiming;
 
 	netdev->netdev_ops = &mcba_netdev_ops;
+	netdev->ethtool_ops = &mcba_ethtool_ops;
 
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 5ae0d7c017cc..7c35f50fda4e 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -28,6 +28,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/signal.h>
@@ -1233,6 +1234,10 @@ static const struct net_device_ops ucan_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops ucan_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 /* Request to set bittiming
  *
  * This function generates an USB set bittiming message and transmits
@@ -1512,6 +1517,7 @@ static int ucan_probe(struct usb_interface *intf,
 	spin_lock_init(&up->context_lock);
 	spin_lock_init(&up->echo_skb_lock);
 	netdev->netdev_ops = &ucan_netdev_ops;
+	netdev->ethtool_ops = &ucan_ethtool_ops;
 
 	usb_set_intfdata(intf, up);
 	SET_NETDEV_DEV(netdev, &intf->dev);
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 8b7cd69e20b0..9453956303c0 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -12,6 +12,7 @@
  * who were very cooperative and answered my questions.
  */
 
+#include <linux/ethtool.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -870,6 +871,10 @@ static const struct net_device_ops usb_8dev_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops usb_8dev_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static const struct can_bittiming_const usb_8dev_bittiming_const = {
 	.name = "usb_8dev",
 	.tseg1_min = 1,
@@ -927,6 +932,7 @@ static int usb_8dev_probe(struct usb_interface *intf,
 				      CAN_CTRLMODE_CC_LEN8_DLC;
 
 	netdev->netdev_ops = &usb_8dev_netdev_ops;
+	netdev->ethtool_ops = &usb_8dev_ethtool_ops;
 
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index 4a363cfcf97c..36b6310a2e5b 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -40,6 +40,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
@@ -148,6 +149,10 @@ static const struct net_device_ops vcan_netdev_ops = {
 	.ndo_change_mtu = vcan_change_mtu,
 };
 
+static const struct ethtool_ops vcan_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static void vcan_setup(struct net_device *dev)
 {
 	dev->type		= ARPHRD_CAN;
@@ -163,6 +168,7 @@ static void vcan_setup(struct net_device *dev)
 		dev->flags |= IFF_ECHO;
 
 	dev->netdev_ops		= &vcan_netdev_ops;
+	dev->ethtool_ops	= &vcan_ethtool_ops;
 	dev->needs_free_netdev	= true;
 }
 
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 61b6eca383f8..cffd107d8b28 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -9,6 +9,7 @@
  * Copyright (c) 2017 Oliver Hartkopp <socketcan@hartkopp.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
@@ -146,6 +147,10 @@ static const struct net_device_ops vxcan_netdev_ops = {
 	.ndo_change_mtu = vxcan_change_mtu,
 };
 
+static const struct ethtool_ops vxcan_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 static void vxcan_setup(struct net_device *dev)
 {
 	struct can_ml_priv *can_ml;
@@ -157,6 +162,7 @@ static void vxcan_setup(struct net_device *dev)
 	dev->tx_queue_len	= 0;
 	dev->flags		= IFF_NOARP;
 	dev->netdev_ops		= &vxcan_netdev_ops;
+	dev->ethtool_ops	= &vxcan_ethtool_ops;
 	dev->needs_free_netdev	= true;
 
 	can_ml = netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index caa6b4cee63f..5d3172795ad0 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -12,6 +12,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/errno.h>
+#include <linux/ethtool.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1540,6 +1541,10 @@ static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_change_mtu	= can_change_mtu,
 };
 
+static const struct ethtool_ops xcan_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
 /**
  * xcan_suspend - Suspend method for the driver
  * @dev:	Address of the device structure
@@ -1821,6 +1826,7 @@ static int xcan_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->netdev_ops = &xcan_netdev_ops;
+	ndev->ethtool_ops = &xcan_ethtool_ops;
 
 	/* Getting the CAN can_clk info */
 	priv->can_clk = devm_clk_get(&pdev->dev, "can_clk");
-- 
2.35.1

