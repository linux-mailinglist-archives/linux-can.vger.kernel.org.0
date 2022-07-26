Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE2581121
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiGZK0C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238584AbiGZKZ6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D46532452
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w205so9505363pfc.8
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvDgRz/MplAwmDfkyK8xElrgmqecEwbpdB/PkWK41EQ=;
        b=Ys5XlrPR9W5VwTmtLftyvO2is422Rsy+Zx06UF6lzkbSnrfr+08xrCb0jv2krFM+xm
         pcPpwBKxHmRbDAJHvwsuR6P3k3bsvPK/tZlpkPMiaXMc4eF533oqctaIZISbCvz1ywqT
         rLTu3EP3D5lHU3zbRE+wlZaSsm9GfovaaEo2Fm2nU0jwsO/pf2aG0ClW68ovUHJ1Ap/Q
         1r77/SwlgGfLeq9IHZgNR748Jj2YSeYvY/vJ/xABBZOzkxb6qX6iiuZOR+q+YCJ30trJ
         4YE5Jyy+RYpKzD3WkXpi2QXyLBFqyBgM+uus/D1DQwrXYLzzo1nZWf/mJYT4sQ+eRhkG
         MnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EvDgRz/MplAwmDfkyK8xElrgmqecEwbpdB/PkWK41EQ=;
        b=MG2Zy+aJneu5VfsGsrkMepDm11lhT2ZC0SgoAPA0qco/FSd/rGLwmm9UEWnFdLAf/r
         PJfnXH0dKg6MCnRTpkFAicxMbjj7x7hVLMqMVN9k3XCsArUhHFGMWMJr1u7NfLC8oUVG
         Re9fIMXACRA6jyIg43/20QKn9iVeZKEJDsLg1QD7sP+53SK851sOj25BufpmJs1rHm3w
         b91WeDgdZxpC4VSQu9cdj9dqmFz42b79AAqyhA6XvQfgLfCBR/UKW7/DCASj/656dKKD
         stFFBmkMdT/jhKfvBp6t4vaoD3JajU5NKiSyN+UXF6HBoPRPXaNObqoaWkUMgqGryAtl
         WiOA==
X-Gm-Message-State: AJIora/RUp+CsJy9+eCOPmHDRnf2CcvEvRsLCB3wdN+lGy3z0cKB/sTw
        vuRWpiMNFK05e2OCuEuBkXj3Jcvf0nsx3g==
X-Google-Smtp-Source: AGRyM1uHZikEjACJRDrs/VBzBXtP4KO0RE/5cyYoolTMQl2D30oQb1RQezv23fnrs4gmHBZYF8enPw==
X-Received: by 2002:aa7:8d03:0:b0:52b:5792:e304 with SMTP id j3-20020aa78d03000000b0052b5792e304mr16990981pfe.36.1658831155100;
        Tue, 26 Jul 2022 03:25:55 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:54 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 14/14] can: peak_usb: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 19:24:54 +0900
Message-Id: <20220726102454.95096-15-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
 <20220726102454.95096-1-mailhol.vincent@wanadoo.fr>
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
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  2 ++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 12 ++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  4 ++++
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  2 ++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |  2 ++
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index d07b7ee79e3e..23966d5d7825 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -965,6 +965,7 @@ static int pcan_usb_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_ethtool_ops = {
 	.set_phys_id = pcan_usb_set_phys_id,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 /*
@@ -996,6 +997,7 @@ const struct peak_usb_adapter pcan_usb = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb),
 
+	.netdev_ops = &pcan_usb_netdev_ops,
 	.ethtool_ops = &pcan_usb_ethtool_ops,
 
 	/* timestamps usage */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 27b0a72fd885..88d0505d3f8d 100644
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
 /*
  * create one device which is attached to CAN controller #ctrl_idx of the
  * usb adapter.
@@ -833,7 +841,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.do_get_berr_counter = peak_usb_adapter->do_get_berr_counter;
 	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
 
-	netdev->netdev_ops = &peak_usb_netdev_ops;
+	netdev->netdev_ops = peak_usb_adapter->netdev_ops;
 
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 9c90487b9c92..a7412235d36f 100644
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
index 3d7e0e370505..8560f82b0ab2 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -1080,6 +1080,7 @@ static int pcan_usb_fd_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_fd_ethtool_ops = {
 	.set_phys_id = pcan_usb_fd_set_phys_id,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /* describes the PCAN-USB FD adapter */
@@ -1123,6 +1124,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_fd_device),
 
+	.netdev_ops = &pcan_usb_netdev_ops_hwts,
 	.ethtool_ops = &pcan_usb_fd_ethtool_ops,
 
 	/* timestamps usage */
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 457887113e75..13b2d82047c7 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -1022,6 +1022,7 @@ static int pcan_usb_pro_set_phys_id(struct net_device *netdev,
 
 static const struct ethtool_ops pcan_usb_pro_ethtool_ops = {
 	.set_phys_id = pcan_usb_pro_set_phys_id,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 /*
@@ -1053,6 +1054,7 @@ const struct peak_usb_adapter pcan_usb_pro = {
 	/* size of device private data */
 	.sizeof_dev_private = sizeof(struct pcan_usb_pro_device),
 
+	.netdev_ops = &pcan_usb_netdev_ops_hwts,
 	.ethtool_ops = &pcan_usb_pro_ethtool_ops,
 
 	/* timestamps usage */
-- 
2.35.1

