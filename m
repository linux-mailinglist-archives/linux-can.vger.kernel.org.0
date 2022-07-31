Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4A5860FA
	for <lists+linux-can@lfdr.de>; Sun, 31 Jul 2022 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbiGaTWg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 31 Jul 2022 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiGaTV0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 31 Jul 2022 15:21:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C871180B
        for <linux-can@vger.kernel.org>; Sun, 31 Jul 2022 12:21:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oIEUk-0008Cz-9E
        for linux-can@vger.kernel.org; Sun, 31 Jul 2022 21:20:58 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 20B94BED18
        for <linux-can@vger.kernel.org>; Sun, 31 Jul 2022 19:20:41 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 89171BED04;
        Sun, 31 Jul 2022 19:20:40 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0823160a;
        Sun, 31 Jul 2022 19:20:31 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 33/36] can: peak_canfd: advertise timestamping capabilities and add ioctl support
Date:   Sun, 31 Jul 2022 21:20:26 +0200
Message-Id: <20220731192029.746751-34-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220731192029.746751-1-mkl@pengutronix.de>
References: <20220731192029.746751-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

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
Link: https://lore.kernel.org/all/20220727101641.198847-14-mailhol.vincent@wanadoo.fr
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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


