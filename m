Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FED9582406
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiG0KRi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiG0KRf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D142AE5
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bf13so15516158pgb.11
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3UfLAGFs/UUTMnnKLBN4WLp0pUigF8hnWvH8xPWBfU=;
        b=llRo/W/WCkdwGnukaFYxCNsT2e+UhcjFMf5HnkGtkbpuCMguZeo7UeYuw2/FsL8r/c
         wlZI/2hwjIxJP30zdtVG8U5x57fgjT+8hX3O27C1sC+lePh29ygUEzMkzaCWyQQj6vCq
         UI8cBAmeg+RHCmlNdI7qTvZxHi4vG6QZ9ypJEhN/2dVPRALPRrSmruiLp/KeTGrm//Z6
         JHSEznK3xC8ToJkWfG3yF0H+7lCzl4F+0qzaQV2X5yrY+ZvLw92onGiDwbTcQOb0LiCv
         Ml6uVB8+L/GDkfP7LKuY2kE1aVbuBonDJkOvx78o6/6AklOhELSgELHBiwJdq47M/31D
         hueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=o3UfLAGFs/UUTMnnKLBN4WLp0pUigF8hnWvH8xPWBfU=;
        b=n2eAlVxqXyBnPzFJ7ANV8UvgOcBmsw0w9IbR3S1X3XbKNB2pVnM8Rg1SleKu4HmW+K
         krSL5mpAXxJXk58GhaQJdZiD49dYdk/pTRH2pNwU/yj4YXiMzWGKkFENOeAO6jQe7kni
         7Xf0CSvpBIckdJ450P9WPSa1zr2L68zlDJNttBQYZR4vPXbMK4Z5UBLWKFXIK9chWcBT
         0e83c1FBVRYedt11WPt6vIld6Q7t4eY4nKbxTpwmN44lbotLR5VxS66nec6Bhwnr2/xJ
         mGOzSGf+Atf/J16I9ACYhQl1EDc7lbBYUaFKYvHPKIdVn7gRcJDXtOhu5CI8lMzUn6Fe
         YRZg==
X-Gm-Message-State: AJIora8C8bR9WmtSW6IdQJAk6L013LE5T5eX/6b2GnH3hyPh3fciHrZs
        7Z4L7CH8jlQ0dZcrQbG4srxJ1OF7wgUIng==
X-Google-Smtp-Source: AGRyM1tBlyYJPy16iGvH/rpN0LdXsA3m1EfgUROm1M3QvqEyAyKkVPs3ZNz3cOJrpeK6LCpRXbNu4A==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:6680 with SMTP id t2-20020a056a0021c200b0052bff446680mr11559333pfj.57.1658917054147;
        Wed, 27 Jul 2022 03:17:34 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:33 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 14/14] can: peak_usb: advertise timestamping capabilities and add ioctl support
Date:   Wed, 27 Jul 2022 19:16:41 +0900
Message-Id: <20220727101641.198847-15-mailhol.vincent@wanadoo.fr>
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
are supported by the peak_usb driver (aside maybe of getting RX
messages and observe whether or not hardware timestamps stay at zero).

The canonical way to add hardware timestamp support is to implement
ethtool_ops::get_ts_info() in order to advertise the timestamping
capabilities and to implement net_device_ops::ndo_eth_ioctl() as
requested in [1]. Currently, the driver only supports hardware RX
timestamps [2] but not hardware TX. For this reason, the generic
function can_ethtool_op_get_ts_info_hwts() and can_eth_ioctl_hwts()
can not be reused and instead this patch adds pcan_get_ts_info() and
peak_eth_ioctl().

[1] kernel doc Timestamping, section 3.1: "Hardware Timestamping
Implementation: Device Drivers"
Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers

[2] https://lore.kernel.org/linux-can/20220727080634.l6uttnbrmwbabh3o@pengutronix.de/

CC: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 41 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  1 +
 5 files changed, 45 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index d07b7ee79e3e..687dd542f7f6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -965,6 +965,7 @@ static int pcan_usb_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_ethtool_ops = {
 	.set_phys_id = pcan_usb_set_phys_id,
+	.get_ts_info = pcan_get_ts_info,
 };
 
 /*
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 27b0a72fd885..8c9d53f6e24c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -775,13 +775,54 @@ static int peak_usb_set_data_bittiming(struct net_device *netdev)
 	return 0;
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
 static const struct net_device_ops peak_usb_netdev_ops = {
 	.ndo_open = peak_usb_ndo_open,
 	.ndo_stop = peak_usb_ndo_stop,
+	.ndo_eth_ioctl = peak_eth_ioctl,
 	.ndo_start_xmit = peak_usb_ndo_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
 };
 
+int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
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
 /*
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 9c90487b9c92..f6bdd8b3f290 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -145,5 +145,6 @@ int peak_usb_netif_rx(struct sk_buff *skb,
 int peak_usb_netif_rx_64(struct sk_buff *skb, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
+int pcan_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
 
 #endif
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 3d7e0e370505..2ea1500df393 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1080,6 +1080,7 @@ static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
 	.set_phys_id = pcan_usb_fd_set_phys_id,
+	.get_ts_info = pcan_get_ts_info,
 };
 
 /* describes the PCAN-USB FD adapter */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 457887113e75..5d8f6a40bb2c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1022,6 +1022,7 @@ static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
 	.set_phys_id = pcan_usb_pro_set_phys_id,
+	.get_ts_info = pcan_get_ts_info,
 };
 
 /*
-- 
2.35.1

