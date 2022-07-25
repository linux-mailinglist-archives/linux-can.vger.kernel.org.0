Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663EA58024E
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbiGYPyi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbiGYPyg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026FE003
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so10700256pjl.0
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtRmkmr+SilLup9rXNkFXNPmfO8iwIS53qmaBY1SSeA=;
        b=UftCCKbuQHJEQFV32qWuULis4pykBLTsLYYCyMWRDWRk4qEpuAjlwexfg2snHcztwW
         x1pVjjy46GNlVqgTTYtiBOo7R8IaxnHv/mERJNlldrA9clkezKJ7/caTglRneav8aq53
         OkFpWdkJzdn8bDmhzFUAUTbmL9LvPx+5Ce0hP9Gc+pBzAgZsF/j5fkiLjXDUfSel7dKB
         MMoQN/ZCnpub5peXMY64UOQN4F8BSq7wcSalD1MF9B7WdmyKqR6Nhne9vsmk3Lcp7qNd
         7pXF3c9qE5elIInc+0HJ6U3QJJZd4tb/k1GIMYZLj1s2if91djw6bagmmM5QfKKpiLtO
         rEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mtRmkmr+SilLup9rXNkFXNPmfO8iwIS53qmaBY1SSeA=;
        b=NJegFeonF/zikp2C1muW/+ZzPc3HmeL9XICm4GC/enqaC0EjxmLyoaT3nj/O6spiBK
         ugclJutrdV/zWZakQvGKj8YpOD+oFKj1/OOz86dlwr+NiMhFIyHwSoiJv9wsTMgVSQZ9
         t4ev/LYk2J9BPv31CIooaof5ZVD3ONZ14tlFd088Yke1bSLMSYAIQJv/XloAjpyo6nrf
         Iv8a95LdN49BRB0JQ2xdkd6kl/Dij/DbUiRcr2dK9F5n4o1SkeYWSKeWWW7Jg1OTxJW5
         AOEWZffucEFYDXNc3v7RJB+tGopMsdl8vh4zeeDcEh7GTcKiCjU3ueGIYpe7QjCCpV1L
         lf/g==
X-Gm-Message-State: AJIora9u2uvRJxY5Z5aLPadQMtsAukHSV0HLaQ4lkNh2Y/HWkMcgzpjw
        cB894ZXhZDNf2rhJM6ROTRopDHJRMRfqmQ==
X-Google-Smtp-Source: AGRyM1uPTH5CFnuYnKAJYpbEaVEnSAS/I/EK+FKQrsEUNTxEN9i1p4XI8D5p3SFdnuwhTaQiK39MSQ==
X-Received: by 2002:a17:90a:4e05:b0:1ec:8de4:1dd5 with SMTP id n5-20020a17090a4e0500b001ec8de41dd5mr14845064pjh.242.1658764473819;
        Mon, 25 Jul 2022 08:54:33 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:33 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 11/14] can: kvaser_pciefd: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 00:53:51 +0900
Message-Id: <20220725155354.482986-12-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220725155354.482986-1-mailhol.vincent@wanadoo.fr>
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

Currently, userland has no method to query which timestamping features
are supported by the kvaser_pciefd driver (aside maybe of getting RX
messages and obseverse whever or not hardware timestamps stay at
zero).

The canonical way for a network driver to advertise what kind of
timestamping it supports is to implement
ethtool_ops::get_ts_info(). Here, we use the CAN specific
can_ethtool_op_get_ts_info_hwts() function to achieve this.

In addition, the driver currently does not support the hardware
timestamps ioctls. According to [1], SIOCSHWTSTAMP is "must" and
SIOCGHWTSTAMP is "should". This patch fills up that gap by
implementing net_device_ops::ndo_eth_ioctl() using the CAN specific
function can_eth_ioctl_hwts().

[1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
Implementation: Device Drivers"
Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers

CC: Jimmy Assarsson <extja@kvaser.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/kvaser_pciefd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index dcd2c9d50d5e..ed54c0b3c7d4 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/pci.h>
 #include <linux/can/dev.h>
 #include <linux/timer.h>
@@ -919,10 +920,15 @@ static void kvaser_pciefd_bec_poll_timer(struct timer_list *data)
 static const struct net_device_ops kvaser_pciefd_netdev_ops = {
 	.ndo_open = kvaser_pciefd_open,
 	.ndo_stop = kvaser_pciefd_stop,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 	.ndo_start_xmit = kvaser_pciefd_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct ethtool_ops kvaser_pciefd_ethtool_ops = {
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+};
+
 static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 {
 	int i;
@@ -939,6 +945,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		can = netdev_priv(netdev);
 		netdev->netdev_ops = &kvaser_pciefd_netdev_ops;
+		netdev->ethtool_ops = &kvaser_pciefd_ethtool_ops;
 		can->reg_base = pcie->reg_base + KVASER_PCIEFD_KCAN0_BASE +
 				i * KVASER_PCIEFD_KCAN_BASE_OFFSET;
 
-- 
2.35.1

