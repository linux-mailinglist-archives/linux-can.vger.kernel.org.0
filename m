Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E05A5A260E
	for <lists+linux-can@lfdr.de>; Fri, 26 Aug 2022 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343637AbiHZKqj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Aug 2022 06:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343858AbiHZKqg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Aug 2022 06:46:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B163A7EFD9
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 03:46:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oRWrA-0001sl-QF
        for linux-can@vger.kernel.org; Fri, 26 Aug 2022 12:46:32 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 047BDD2E5F
        for <linux-can@vger.kernel.org>; Fri, 26 Aug 2022 10:46:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BA1E0D2E5A;
        Fri, 26 Aug 2022 10:46:31 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 76bcff46;
        Fri, 26 Aug 2022 10:46:30 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: gs_usb: advertise timestamping capabilities and add ioctl support
Date:   Fri, 26 Aug 2022 12:46:29 +0200
Message-Id: <20220826104629.2837024-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826104629.2837024-1-mkl@pengutronix.de>
References: <20220826104629.2837024-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: John Whittington <git@jbrengineering.co.uk>

Following dc0d8e068f837 ("can: gs_usb: hardware timestamp support")
this correctly advertises the support for RX HW timestamps if the device
does support it. Similar to bedd94835a352 ("can: peak_usb: advertise
timestamping capabilities...") since PCAN devices also only support RX
and not TX HW timestamping.

Not-Signed-off-by: John Whittington <git@jbrengineering.co.uk>
Link: https://github.com/candle-usb/candleLight_fw/issues/100
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 51 ++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 0d6729f12946..da14bdc63281 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1016,12 +1016,37 @@ static int gs_can_close(struct net_device *netdev)
 	return 0;
 }
 
+static int gs_can_eth_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
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
 static const struct net_device_ops gs_usb_netdev_ops = {
 	.ndo_open = gs_can_open,
 	.ndo_stop = gs_can_close,
 	.ndo_start_xmit = gs_can_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
-	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_eth_ioctl = gs_can_eth_ioctl,
 };
 
 static int gs_usb_set_identify(struct net_device *netdev, bool do_identify)
@@ -1071,9 +1096,31 @@ static int gs_usb_set_phys_id(struct net_device *dev,
 	return rc;
 }
 
+int  gs_usb_get_ts_info_hwts(struct net_device *netdev,
+				    struct ethtool_ts_info *info)
+{
+	struct gs_can *dev = netdev_priv(netdev);
+
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE;
+	info->phc_index = -1;
+	info->tx_types = BIT(HWTSTAMP_TX_OFF);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
+
+	/* report if device supports HW timestamps but only RX */
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+		info->so_timestamping |=
+			SOF_TIMESTAMPING_RX_HARDWARE |
+			SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	return 0;
+}
+
 static const struct ethtool_ops gs_usb_ethtool_ops = {
 	.set_phys_id = gs_usb_set_phys_id,
-	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+	.get_ts_info = gs_usb_get_ts_info_hwts,
 };
 
 static struct gs_can *gs_make_candev(unsigned int channel,
-- 
2.35.1


