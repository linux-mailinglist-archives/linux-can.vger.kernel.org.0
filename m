Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CC582403
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiG0KRb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiG0KR3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90542AF0
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so1683657pjf.2
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGs0q5Kj6OoKxYMqtEkZJ/PwzxQLKV1jDrgFlDwzeXo=;
        b=bgXqk7WLBDt0M3u8vuogegGSYWwdzkVvA2xDnDdDwdDMC2sa1RMszhn7q0nEuyoTiF
         FUR8EE0kzeTjOJ4TkiUdrcrnTbu7P8Wlsu1DWJcJTBCOlMQDsuNxe+mCXfQ9OUNyy3Y5
         KgLKVAr5PwpOEGz0mrAVpiqb1Da36y84cU1dcDedgadNd2wkI3vu1jhADda5zWD6UxP/
         GP18LVxD9O/gvKhMWvxA9fgllxH+SMInLk+tqg3ucydsAJ34Hp9JawW3tkXMMO6vesRQ
         ZARaWwxcf8WC4mZ+Od+yGH3BlfGjRu9yjTfhLJV6f3BL0DaGTLwZImtCaUZVN6hsbc9o
         Ea5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tGs0q5Kj6OoKxYMqtEkZJ/PwzxQLKV1jDrgFlDwzeXo=;
        b=cAhY2ydQShifhxk/ql7r4fLPIaQcOhyjlofg1a43xYo/vt8HT/7x0wXM+SEGlJ83aT
         4KpoNEhNfWL4kqNGbDT659XIajS1cCnD+j1W2nOz9EHBfXLaIYP4mR9zvjgMv5r+CQZ3
         K7lZXSyGWsFyM/aHDf/4VuEPZXqkEelBzOBgONZ8g1LuLtCPegKmV2XFKkCqa7ZaZgSg
         uD20tAoAQhZGZr/rdl0othN9soyXErVBkFOMIP5YBdjDysI5esEOyMLNbFvz/p++pw6V
         IVxw3sGxawv9ZEkZt4cPS3btBQnniH5i/acMX9FNi8+EleULmyilfuYP5OWc7WF7rU+Y
         0+tw==
X-Gm-Message-State: AJIora+Xs4lSsUqtDU5IYxYx8+jzHI62l5WTepLLpfMM3bp5lWyNHcy8
        0JMPLfyB3yzSjPXvvhRGtSBxaz5ei1IOJQ==
X-Google-Smtp-Source: AGRyM1vURnPtNfnv4UbxA57i3EWd2ByJaj8LzmVfKAkYXU9gRiPBHZyXpKYXYwdmkfl3/uAyN621zA==
X-Received: by 2002:a17:902:a710:b0:16c:5305:2244 with SMTP id w16-20020a170902a71000b0016c53052244mr21262125plq.125.1658917047381;
        Wed, 27 Jul 2022 03:17:27 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:27 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 11/14] can: kvaser_pciefd: advertise timestamping capabilities and add ioctl support
Date:   Wed, 27 Jul 2022 19:16:38 +0900
Message-Id: <20220727101641.198847-12-mailhol.vincent@wanadoo.fr>
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

Currently, userland has no method to query which timestamping features
are supported by the kvaser_pciefd driver (aside maybe of getting RX
messages and observe whether or not hardware timestamps stay at zero).

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

