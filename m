Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2DC58111D
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiGZKZv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbiGZKZu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11EE20F77
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y9so12809967pff.12
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtRmkmr+SilLup9rXNkFXNPmfO8iwIS53qmaBY1SSeA=;
        b=ezf1pP1nwkFBt5QeuiSzhoL1sbxaE+yQMjTAY/2iuZEVc10N5ZaIFwC7gw/WeSJJke
         gtyAN0vhSeoyWUQ5BFzkyh54xQ68iNWRZaA4shiph6AhOf+Ndhoqgmz8OLYR7bkUtbDy
         aQ/8lmB8ekkGN4ibJOW1mVvWZthVNJv5Iq84XNAToMlSRWyUWLeCky4pewOxWp0yXPKq
         HqfQ/RqdJLZA6o2RnSK/Shqdo30OqAMZ9ywGFLuCyjs5HXjNSv0m29tHlIzjmfEGcMB6
         y69y7d86KCiaisR5Mqa87O4tDvi5ctThB4KO2pIkWzN9XOQmj8TbEwXNkwK5IwtTlGqN
         7cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mtRmkmr+SilLup9rXNkFXNPmfO8iwIS53qmaBY1SSeA=;
        b=CqoVhO3HuWgPci5VwOdGSuuTtWeb4FIIu/dgHqdqtwrcJS/yrMaIKhg8ZzdCxsf2rs
         /NjETGvpHnO05Nk1CuiW9D3hxNW7159uqUR1w8qab2AXmSgDdxds0AwmkIDs3FuFIe7X
         ZUIxrqixRelp3hPpGshotizgHtmWijzZwqxMciYJGavG+O/mT6uBjqKbfoe0nB823V55
         dbqjYtGF/uuciyxMkd4CxhWZUJVwGBVdSlTtivkSxrey0zhgRZu84eWqrYU+thfuLMja
         eJA1NKNXigBVBNE86wAzTke9REEkYOEhuD3mJ29/VyWAuyBmoA4bqqrNw8kq6EtoVdpC
         fFbg==
X-Gm-Message-State: AJIora+6lX/uuqhVgfRSmrHJ8gRKBIGbBC5rkI/Za5yld++DyiOj9lXL
        GIKJsMJTYyFN+L3S3we4H1ZFnAEnOumbOA==
X-Google-Smtp-Source: AGRyM1uFPd8cmzscBBGS9IFT8N9nQD+CtETxDjlXlaYDzNIvaSeUhnPgbX2Bhz2HQ61TZ318qTrxvQ==
X-Received: by 2002:a05:6a00:a93:b0:528:77d6:f660 with SMTP id b19-20020a056a000a9300b0052877d6f660mr16923000pfl.50.1658831148012;
        Tue, 26 Jul 2022 03:25:48 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:47 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 11/14] can: kvaser_pciefd: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 19:24:51 +0900
Message-Id: <20220726102454.95096-12-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
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

