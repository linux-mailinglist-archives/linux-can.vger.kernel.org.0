Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073F6582405
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiG0KRe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiG0KRd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EA342ADA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so1713825pjl.0
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Rc2jzSToE2WVmBBseF0efCy3p2ZF+4b2IH/8Qzzf5s=;
        b=XykStxtamg3FuXPFNdXihMLAKwUJJagTYjJ/vIJSSVnAHtbCczlxAi3Gmvv3NzsowU
         R1xxM6l+h3awHQDODvGQfT3jzpMz3O3Q2NsfCwBr08xEsFilWqtpjEZpTKmxTVkRzXFF
         eG1jlVH2kF+epOQ0ahSSIWby7xZYcAl6mi8gxbXjUsjlghMVvDryM4UFHZC/X54rbENO
         aN2Mqr8oDCPGhyd46uMu7tbiWGNlIXZxDYSVjFGfZbiRFaXR9OUPQHC2JJDQXPe2xieu
         3u/+xT2t68NKJEDG85ejP8wOoHWRSaQWtay6EtImgdD0cDMD/yV9DqAz85zqAbGXJYTf
         LVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+Rc2jzSToE2WVmBBseF0efCy3p2ZF+4b2IH/8Qzzf5s=;
        b=O85Sa0PxwUjENNbspzkkijqpDom8F7zc+lHRkfi+Py5m+R5GUsTBW+tXBrSjz3KfNB
         lThU7AYCFdneLytlvzQ7Mm5gE0xi9cPJh06jYDWwECjJIgDZR3XjCkmkvrcgBI6E2PFS
         V0WpXS/JcBPXgEYOcaYPmcJs2DKks583MDL1dNZuwwTekGQgcNq/g0HkOdLC4UYy87Pd
         7ZpxTwuwrayF6Qif328iQ4FVR/EYlG3VhnqPMALzaLyJRu2WN/cFK7MAa9p5JiuJnv3l
         R4MhTi2P/oRgqV4nNtSGq/X1WAKnZROpFwVKYf1r6wcsSXoGv343FqcnCIyCDd3T4Cm3
         5+Uw==
X-Gm-Message-State: AJIora9FjV+1NLXNIaXzDPZ/M24GJ9aeicKwhWciZT7gz4Rx1mKY1JYM
        3cJdLw8d3BvmkXrosjLnvxxCBIS5xhTsQw==
X-Google-Smtp-Source: AGRyM1u7yB4U/n+zIDi/k30LVD0OmorRWRY+jXmMEF88QgNwcslbSFpfvxkqsI/gvotwTjoG3u+yvw==
X-Received: by 2002:a17:902:6901:b0:168:9bb4:7adb with SMTP id j1-20020a170902690100b001689bb47adbmr20861762plk.147.1658917051900;
        Wed, 27 Jul 2022 03:17:31 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:31 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 13/14] can: peak_canfd: advertise timestamping capabilities and add ioctl support
Date:   Wed, 27 Jul 2022 19:16:40 +0900
Message-Id: <20220727101641.198847-14-mailhol.vincent@wanadoo.fr>
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
are supported by the peak_canfd driver (aside maybe of getting RX
messages and observe whether or not hardware timestamps stay at zero).

The canonical way to add hardware timestamp support is to implement
ethtool_ops::get_ts_info() in order to advertise the timestamping
capabilities and to implement net_device_ops::ndo_eth_ioctl() as
requested in [1]. Currently, the driver only supports hardware RX
timestamps [2] but not hardware TX. For this reason, the generic
function can_ethtool_op_get_ts_info_hwts() and can_eth_ioctl_hwts()
can not be reused and instead this patch adds peak_get_ts_info() and
peak_eth_ioctl().

[1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
Implementation: Device Drivers"
Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers

[2] https://lore.kernel.org/linux-can/20220727084257.brcbbf7lksoeekbr@pengutronix.de/

CC: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index afb9adb3d5c2..f8420cc1d907 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -7,6 +7,7 @@
 
 #include <linux/can.h>
 #include <linux/can/dev.h>
+#include <linux/ethtool.h>
 
 #include "peak_canfd_user.h"
 
@@ -742,13 +743,59 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int peak_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct hwtstamp_config hwts_cfg = { 0 };
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP: /* set */
+		if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
+			return -EFAULT;
+		if (hwts_cfg.tx_type == HWTSTAMP_TX_OFF &&
+		    hwts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
+			return 0;
+		return -ERANGE;
+
+	case SIOCGHWTSTAMP: /* get */
+		hwts_cfg.tx_type = HWTSTAMP_TX_OFF;
+		hwts_cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		if (copy_to_user(ifr->ifr_data, &hwts_cfg, sizeof(hwts_cfg)))
+			return -EFAULT;
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops peak_canfd_netdev_ops = {
 	.ndo_open = peak_canfd_open,
 	.ndo_stop = peak_canfd_close,
+	.ndo_eth_ioctl = peak_eth_ioctl,
 	.ndo_start_xmit = peak_canfd_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static int peak_get_ts_info(struct net_device *dev,
+			    struct ethtool_ts_info *info)
+{
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE |
+		SOF_TIMESTAMPING_RX_HARDWARE |
+		SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->phc_index = -1;
+	info->tx_types = BIT(HWTSTAMP_TX_OFF);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
+static const struct ethtool_ops peak_canfd_ethtool_ops = {
+	.get_ts_info = peak_get_ts_info,
+};
+
 struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
 					int echo_skb_max)
 {
@@ -789,6 +836,7 @@ struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
 
 	ndev->flags |= IFF_ECHO;
 	ndev->netdev_ops = &peak_canfd_netdev_ops;
+	ndev->ethtool_ops = &peak_canfd_ethtool_ops;
 	ndev->dev_id = index;
 
 	return ndev;
-- 
2.35.1

