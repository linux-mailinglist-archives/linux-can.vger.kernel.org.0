Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE300580003
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiGYNdm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiGYNd3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2C013F8A
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q22so5227051pgt.9
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJejdVrvSGANSTM4YPxy3vgBrgbUGCuUS7JogeMO/Co=;
        b=V4rAiRTFMoWORUEurz+x5DVJkoJiGY+8oUT0aXJb5Gu2BiNJinO13Nh4G9g1WA02jw
         rjg+CbarHDHxMgZl/YNq13H7V57+/HhjK+tdr2gzpzYhU3FWk86tvMzA8lv3ewwAvk+V
         mOIzEkFx/Au+WEgw+aq0vZkhnd/ThN9a9gKEKTfmrt8jNm38S1/yR0trDMW9tuXludNn
         K6txWda2o5RyDSnz7t6gZH8kKZCGI4A6GuO61ppvs3erTvp6vEhttbfJHsEnmWv/FAR8
         78tyyPjqnqfVfUT44GH+pVo0ZLZtfgfggaiYT99PXIpaZHyY7/uJqiudB9h2dmZqw7ah
         EemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yJejdVrvSGANSTM4YPxy3vgBrgbUGCuUS7JogeMO/Co=;
        b=CV6rEvwN/Nz6Iu3V7E9M+8iAu8J989t+rn/yMjmdn5AUyZlPWPrcwiTwjF8WFX6qNr
         rwTRAJBfZt+jDiplZ7+xSMX/kCtCHnSr6dM4l1vSYlidyH3Zz6cgUBKhOxkzs3naOlGO
         a8xrobOjYqZgB/s9bQDV+EZOPQGiozlugWojX34rgMSZtGuTDl5skX06UbylJXoJ+9+6
         XHBVUJIiaeaB9xJsiLxt2PKiB7s9iEZczDb6Hj77VKOMC0yOxuEPks1/zei067R82k4p
         sadd/nGyvHWaxC2FeF25jt/Jvu2vgzEcUoiOBMNJt76fLaelQdTwO67IY3EcxSeaNAN/
         adFw==
X-Gm-Message-State: AJIora/dQ2DaCL0tzMwS4qQOKvvkKsnyDRR4BIRrovnSGKyLAN7Tnt6J
        HSKbn05NeLYIc4MIeGCVQ7hzO2stP2nSSQ==
X-Google-Smtp-Source: AGRyM1vlwenlrbSzMmgb14XOWk86ByGCjIKY868/a51LbjC4J1KV2NRum25nIMAsGWfuT6sIhn4uSQ==
X-Received: by 2002:a63:60d:0:b0:41a:d6cb:33dd with SMTP id 13-20020a63060d000000b0041ad6cb33ddmr8092087pgg.496.1658756001655;
        Mon, 25 Jul 2022 06:33:21 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:21 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 24/24] can: peak_usb: advertise timestamping capabilities and add ioctl support
Date:   Mon, 25 Jul 2022 22:32:08 +0900
Message-Id: <20220725133208.432176-25-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

CC: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---

Hi Stéphane, as far as I understand, the pcan_usb and the pacn_usb_pro
support hardware timestamps but the pcan_usb_fd doesn't. If not the
case, let me know.

This is not tested. If you find any issue or if you want to modify,
feel free to pick up that patch and resend it.
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  3 +++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 12 ++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  4 ++++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  2 ++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  2 ++
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index d07b7ee79e3e..4cd7bd894276 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -964,7 +964,9 @@ static int pcan_usb_set_phys_id(struct net_device *netdev,
 }
 
 static const struct ethtool_ops pcan_usb_ethtool_ops = {
+	.get_drvinfo = peak_usb_get_drvinfo,
 	.set_phys_id = pcan_usb_set_phys_id,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 /*
@@ -996,6 +998,7 @@ const struct peak_usb_adapter pcan_usb = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb),
 
+	.netdev_ops = &pcan_usb_netdev_ops,
 	.ethtool_ops = &pcan_usb_ethtool_ops,
 
 	/* timestamps usage */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 959448bae3ca..2712e08ffaba 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -775,13 +775,21 @@ static int peak_usb_set_data_bittiming(struct net_device *netdev)
 	return 0;
 }
 
-static const struct net_device_ops peak_usb_netdev_ops = {
+const struct net_device_ops pcan_usb_netdev_ops = {
 	.ndo_open = peak_usb_ndo_open,
 	.ndo_stop = peak_usb_ndo_stop,
 	.ndo_start_xmit = peak_usb_ndo_start_xmit,
 	.ndo_change_mtu = can_change_mtu,
 };
 
+const struct net_device_ops pcan_usb_netdev_ops_hwts = {
+	.ndo_open = peak_usb_ndo_open,
+	.ndo_stop = peak_usb_ndo_stop,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_start_xmit = peak_usb_ndo_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
 void peak_usb_get_drvinfo(struct net_device *netdev,
 			  struct ethtool_drvinfo *drvinfo)
 {
@@ -839,7 +847,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.do_get_berr_counter = peak_usb_adapter->do_get_berr_counter;
 	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
 
-	netdev->netdev_ops = &peak_usb_netdev_ops;
+	netdev->netdev_ops = peak_usb_adapter->netdev_ops;
 
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index da1205575379..cfb25bebb54f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -46,6 +46,7 @@ struct peak_usb_adapter {
 	const struct can_bittiming_const * const data_bittiming_const;
 	unsigned int ctrl_count;
 
+	const struct net_device_ops *netdev_ops;
 	const struct ethtool_ops *ethtool_ops;
 
 	int (*intf_probe)(struct usb_interface *intf);
@@ -88,6 +89,9 @@ extern const struct peak_usb_adapter pcan_usb_chip;
 extern const struct peak_usb_adapter pcan_usb_pro_fd;
 extern const struct peak_usb_adapter pcan_usb_x6;
 
+extern const struct net_device_ops pcan_usb_netdev_ops;
+extern const struct net_device_ops pcan_usb_netdev_ops_hwts;
+
 struct peak_time_ref {
 	ktime_t tv_host_0, tv_host;
 	u32 ts_dev_1, ts_dev_2;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 63122f567380..3c0dc9391bec 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1081,6 +1081,7 @@ static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
 static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
 	.get_drvinfo = peak_usb_get_drvinfo,
 	.set_phys_id = pcan_usb_fd_set_phys_id,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /* describes the PCAN-USB FD adapter */
@@ -1124,6 +1125,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
 
+	.netdev_ops = &pcan_usb_netdev_ops_hwts,
 	.ethtool_ops = &pcan_usb_fd_ethtool_ops,
 
 	/* timestamps usage */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index ea2d4fbceaa4..7189fa70c08e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1023,6 +1023,7 @@ static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
 static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
 	.get_drvinfo = peak_usb_get_drvinfo,
 	.set_phys_id = pcan_usb_pro_set_phys_id,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 /*
@@ -1054,6 +1055,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_pro_device),
 
+	.netdev_ops = &pcan_usb_netdev_ops_hwts,
 	.ethtool_ops = &pcan_usb_pro_ethtool_ops,
 
 	/* timestamps usage */
-- 
2.35.1

