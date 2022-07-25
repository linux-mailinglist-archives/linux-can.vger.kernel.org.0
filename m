Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93C757FFF6
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiGYNdM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiGYNdI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2977DE96
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id g17so10421552plh.2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxLdM3bhTihB/y+XUyyQ1K10iEJgo+YQuj88f0CMsLI=;
        b=kGffn8AKXzuZlyJUIo9cv7Uw5rQGUYstBDYd+LxaKsLtfQzAb0PxwHbWxcRatP8IjL
         d6/T6OzF9PIzRpdQ6zHevfWvhz6+hay0VecNau/oZkp6LGY+1EseR3r8iFfFvvZD96ig
         2kGx+M2as2UBh6NQ1Er5XceaA6CAi2wVPTz2wPlq4zOK+FSTO/5zkYEngtkKrQs2gmz3
         Mu/qRNtcUcSQnomN4KgFcA0tyYnBPUmESQWRzOQThiIZVkCAyJsTjaB96brhYBkI5Nbl
         yyh5Z289PCR1RuKB+guIJ5gwmkpSANkqXOAdKhaN0sSRqelZ8I9+Iz9U0aNt5Gs1xiEK
         UbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rxLdM3bhTihB/y+XUyyQ1K10iEJgo+YQuj88f0CMsLI=;
        b=gGx+O1Gd5Mz2iNsytUTEwf9LMz18cx1A7NVkA6rnCiqYajtcoUd6SnFVDwyGT2uT8r
         Vm3XJcXxPCgatvd2dbU91xrS8DzMeuSjofU8reFss6oz2ABLfQ++kbsr2sYLq8027Rp1
         sq6T2SiRKTwI1127iEjaCb4HhWB+N8pg7Roh8uubp3xLg3GGWhwZrJ65matmkcp2jQzF
         tVGa8IXxo/eEBtDhRos3v5r5Kw7JZsCkL949Y1yoEv6DMTvZSZoFp1VCTKqmONdaF60f
         7hS288b9fYODxhViF9iPqOhzFa+BA840eiexXza9PePvzZ5pzegcBDpCra2XIpNpSUcd
         FZ1Q==
X-Gm-Message-State: AJIora9+USnvJdIoQ7gXg7RCvPv80nU0oxfA34zYwPsAAXv1+OpQt3AI
        YdLvp77IRhhTNhC6qyZqPDHqq2LqyUpbmA==
X-Google-Smtp-Source: AGRyM1tn0M49Pal72bBNixkghRsBupCatNmVhsJkuY+9RSlGXXmJkRk3HMKQDfh2pQplrEjAQPPL8g==
X-Received: by 2002:a17:90a:b007:b0:1f1:d31e:4914 with SMTP id x7-20020a17090ab00700b001f1d31e4914mr32713381pjq.36.1658755982065;
        Mon, 25 Jul 2022 06:33:02 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:01 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 15/24] can: tree-wide: advertise software timestamping capabilities
Date:   Mon, 25 Jul 2022 22:31:59 +0900
Message-Id: <20220725133208.432176-16-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
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

N.B. the drivers which support hardware timespamping will be migrated
in separate patches.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/at91_can.c               | 1 +
 drivers/net/can/c_can/c_can_main.c       | 1 +
 drivers/net/can/can327.c                 | 1 +
 drivers/net/can/cc770/cc770.c            | 1 +
 drivers/net/can/ctucanfd/ctucanfd_base.c | 1 +
 drivers/net/can/flexcan/flexcan-core.c   | 1 +
 drivers/net/can/grcan.c                  | 1 +
 drivers/net/can/ifi_canfd/ifi_canfd.c    | 1 +
 drivers/net/can/janz-ican3.c             | 1 +
 drivers/net/can/m_can/m_can.c            | 1 +
 drivers/net/can/pch_can.c                | 1 +
 drivers/net/can/rcar/rcar_can.c          | 1 +
 drivers/net/can/rcar/rcar_canfd.c        | 1 +
 drivers/net/can/sja1000/sja1000.c        | 1 +
 drivers/net/can/slcan/slcan-core.c       | 1 +
 drivers/net/can/softing/softing_main.c   | 1 +
 drivers/net/can/spi/hi311x.c             | 1 +
 drivers/net/can/spi/mcp251x.c            | 1 +
 drivers/net/can/sun4i_can.c              | 1 +
 drivers/net/can/ti_hecc.c                | 1 +
 drivers/net/can/usb/ems_usb.c            | 1 +
 drivers/net/can/usb/esd_usb.c            | 1 +
 drivers/net/can/usb/gs_usb.c             | 1 +
 drivers/net/can/usb/mcba_usb.c           | 1 +
 drivers/net/can/usb/ucan.c               | 1 +
 drivers/net/can/usb/usb_8dev.c           | 1 +
 drivers/net/can/vcan.c                   | 1 +
 drivers/net/can/vxcan.c                  | 1 +
 drivers/net/can/xilinx_can.c             | 1 +
 29 files changed, 29 insertions(+)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 637d2ca34d08..7fbf22401579 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1161,6 +1161,7 @@ static void at91_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops at91_ethtool_ops = {
 	.get_drvinfo = at91_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static ssize_t mb0_id_show(struct device *dev,
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index fa541a7cb9c1..c828324d018f 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1362,6 +1362,7 @@ static void c_can_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops c_can_ethtool_ops = {
 	.get_drvinfo = c_can_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 int register_c_can_dev(struct net_device *dev)
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 497a298c3de7..fbf61437b1e0 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -858,6 +858,7 @@ static void can327_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops can327_ethtool_ops = {
 	.get_drvinfo = can327_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static bool can327_is_valid_rx_char(u8 c)
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 1bb30e69cb24..e57d1f3f4268 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -845,6 +845,7 @@ static void cc770_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops cc770_ethtool_ops = {
 	.get_drvinfo = cc770_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 int register_cc770dev(struct net_device *dev)
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index fd5fd17c16f2..6b579e0da967 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1310,6 +1310,7 @@ static void ctucan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops ctucan_ethtool_ops = {
 	.get_drvinfo = ctucan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 int ctucan_suspend(struct device *dev)
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 61e3483802c6..bec3166c0293 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1822,6 +1822,7 @@ static void flexcan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops flexcan_ethtool_ops = {
 	.get_drvinfo = flexcan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static int register_flexcandev(struct net_device *dev)
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ce64f2cbe9c6..f755e15860b7 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1570,6 +1570,7 @@ static void grcan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops grcan_ethtool_ops = {
 	.get_drvinfo = grcan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static int grcan_setup_netdev(struct platform_device *ofdev,
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index c682401eea3d..0a4d4a52c296 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -934,6 +934,7 @@ static void ifi_canfd_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops ifi_canfd_ethtool_ops = {
 	.get_drvinfo = ifi_canfd_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static int ifi_canfd_plat_probe(struct platform_device *pdev)
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 923df896512f..f2056d366369 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1763,6 +1763,7 @@ static void ican3_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops ican3_ethtool_ops = {
 	.get_drvinfo = ican3_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /*
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index dc55bfd260c9..1cf14d646493 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1838,6 +1838,7 @@ static void m_can_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_drvinfo = m_can_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static int register_m_can_dev(struct net_device *dev)
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index c51354b4cf0c..59cf1f077520 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -947,6 +947,7 @@ static void pch_can_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops pch_can_ethtool_ops = {
 	.get_drvinfo = pch_can_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static void pch_can_remove(struct pci_dev *pdev)
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index aa644bb79da6..41d053e13f8a 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -639,6 +639,7 @@ static void rcar_can_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops rcar_can_ethtool_ops = {
 	.get_drvinfo = rcar_can_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static void rcar_can_rx_pkt(struct rcar_can_priv *priv)
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 89cc28985b81..9c4312b098ae 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1704,6 +1704,7 @@ static void rcar_canfd_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops rcar_canfd_ethtool_ops = {
 	.get_drvinfo = rcar_canfd_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 43967790f4c1..bf9dbf27ed2a 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -663,6 +663,7 @@ static void sja1000_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops sja1000_ethtool_ops = {
 	.get_drvinfo = sja1000_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 int register_sja1000dev(struct net_device *dev)
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 65f466582fa2..b7a8e35a5922 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -801,6 +801,7 @@ static void slcan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops slcan_ethtool_ops = {
 	.get_drvinfo = slcan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /******************************************
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index d2ce61562ccc..23862891a40f 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -621,6 +621,7 @@ static void softing_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops softing_ethtool_ops = {
 	.get_drvinfo = softing_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct can_bittiming_const softing_btr_const = {
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 5e0c0d21aee2..8fd8ff2c80bb 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -811,6 +811,7 @@ static void hi3110_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops hi3110_ethtool_ops = {
 	.get_drvinfo = hi3110_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct of_device_id hi3110_of_match[] = {
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 2e4c03c61b15..972da0918d88 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1257,6 +1257,7 @@ static void mcp251x_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops mcp251x_ethtool_ops = {
 	.get_drvinfo = mcp251x_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct of_device_id mcp251x_of_match[] = {
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 27ea4e68b516..8902c80442f4 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -770,6 +770,7 @@ static void sun4ican_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops sun4ican_ethtool_ops = {
 	.get_drvinfo = sun4ican_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 965376453050..1cb66d092f3c 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -850,6 +850,7 @@ static void ti_hecc_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops ti_hecc_ethtool_ops = {
 	.get_drvinfo = ti_hecc_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct of_device_id ti_hecc_dt_ids[] = {
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index ac155f73bedd..bbb6129243e0 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -888,6 +888,7 @@ static void ems_usb_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops ems_usb_ethtool_ops = {
 	.get_drvinfo = ems_usb_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct can_bittiming_const ems_usb_bittiming_const = {
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 2367edd49eb7..a2a8473e7d8d 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -891,6 +891,7 @@ static void esd_usb_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops esd_usb_ethtool_ops = {
 	.get_drvinfo = esd_usb_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct can_bittiming_const esd_usb2_bittiming_const = {
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 75f5e9c5059a..85174a99a52b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -953,6 +953,7 @@ static int gs_usb_set_phys_id(struct net_device *dev,
 static const struct ethtool_ops gs_usb_ethtool_ops = {
 	.get_drvinfo = gs_usb_get_drvinfo,
 	.set_phys_id = gs_usb_set_phys_id,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static struct gs_can *gs_make_candev(unsigned int channel,
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 485ec697fc08..2a28203294a8 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -767,6 +767,7 @@ static void mcba_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops mcba_ethtool_ops = {
 	.get_drvinfo = mcba_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /* Microchip CANBUS has hardcoded bittiming values by default.
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 52263fa286f3..b8352a17bc34 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1242,6 +1242,7 @@ static void ucan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops ucan_ethtool_ops = {
 	.get_drvinfo = ucan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /* Request to set bittiming
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 2a56d7c2fdb6..209ec6e593a5 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -879,6 +879,7 @@ static void usb_8dev_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops usb_8dev_ethtool_ops = {
 	.get_drvinfo = usb_8dev_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static const struct can_bittiming_const usb_8dev_bittiming_const = {
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index e820b2621e53..bb98206c04d1 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -157,6 +157,7 @@ static void vcan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops vcan_ethtool_ops = {
 	.get_drvinfo = vcan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static void vcan_setup(struct net_device *dev)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index aedeb9766996..68d3043e2ced 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -155,6 +155,7 @@ static void vxcan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops vxcan_ethtool_ops = {
 	.get_drvinfo = vxcan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static void vxcan_setup(struct net_device *dev)
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index b802ddec1965..1b79474018c9 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1549,6 +1549,7 @@ static void xcan_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops xcan_ethtool_ops = {
 	.get_drvinfo = xcan_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /**
-- 
2.35.1

