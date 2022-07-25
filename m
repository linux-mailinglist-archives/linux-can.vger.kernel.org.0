Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB058024F
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiGYPyl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiGYPyk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37212D19
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o12so10795262pfp.5
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFN6QmtGVHCxLF5Lled8grHNKzbHwXYEZA4KcLz3/Uc=;
        b=WAGPW0T0dyGhxhtlg/SPGP+GQglhZDVu+fBVy5g2VZqaE34b4LfsIsLfa/WXzckAnX
         jLDIUGy/VpRUlRboZo1AKmSEEYn1K+oi/WzmLrbInq7kDDBsNjE1N1mJisfNVxyRtSge
         sHlk+sHZC9TWSPocjTPI1vtjoC7WR4y8S5PGww8qaCgG4iUZb+9KqIk7AF5I7jLxvmxI
         XJL/9otBHqvOnNdVaao0OF0+h+fqPHX9jUhHJscrk/ee/bsJ+GeJnjd8QfqXnXQX0REr
         c+JOm0YvitUODfstfnCTPND2RMLiDrOh7ZgLJ+cUNH+BvTAoggwI8QCV1xjA8lLEnJkl
         xOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EFN6QmtGVHCxLF5Lled8grHNKzbHwXYEZA4KcLz3/Uc=;
        b=vx/gVlbmgY+NF+BEuUcubz2PpEYQhYZs38TVBEEzi+/jreYj5dmsTMO0kk/4vfI7uG
         2ISCqYLWu5OLk4PsLXRiCUPFORQ1SdWbftuesAE9Zv4F9X09XAi9Bjhk7Fg5Y2hrQ+8A
         fxvDqyzWGtFO2N36dXT6pVqbhLzYsRNmRYNOqgTi1cNn4xHJyZhM6/tCMRCrU5et07G5
         jJt9Nuam7WDUHN87U3lBoz7eZ2EJono+5O8GzprU6qAKchGd6S/Yh4l+pvSsQ4oDodir
         UqMMoc/uFDtqJ2Jo7lbizJl+cdV7/Xv9etzklcLqLmLBD8RhTjAoPwThvzA2Wn2sTU7L
         nRUw==
X-Gm-Message-State: AJIora+uKcgWoCt7ur4bJ0e8l8z60WdM3vfOCSBXL+MyBQLR8LmIht24
        PR2psasE0mUGqK4Wxx7oDf1AWhsp7g2W4A==
X-Google-Smtp-Source: AGRyM1tsDJb6HcVSgIYvc/K9R6rlFbNzIOcUoAzvMoFnSQzp/0ecpzOiWI3HucxpSJc55liGUScPsg==
X-Received: by 2002:a63:1923:0:b0:419:b27c:7acf with SMTP id z35-20020a631923000000b00419b27c7acfmr11244079pgl.449.1658764475934;
        Mon, 25 Jul 2022 08:54:35 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:35 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 12/14] can: kvaser_usb: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 00:53:52 +0900
Message-Id: <20220725155354.482986-13-mailhol.vincent@wanadoo.fr>
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
are supported by the kvaser_usb driver (aside maybe of getting RX
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

Hi Jimmy, as far as I understand, only the hydra has the hardware
timestamping. If not the case, let me know.

This is not tested. If you find any issue or if you want to modify,
feel free to pick up that patch and resend it.
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb.h   |  1 +
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 27 +++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
index eefcbe3aadce..841da29cef93 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb.h
@@ -39,6 +39,7 @@
 #define KVASER_USB_QUIRK_HAS_SILENT_MODE	BIT(0)
 #define KVASER_USB_QUIRK_HAS_TXRX_ERRORS	BIT(1)
 #define KVASER_USB_QUIRK_IGNORE_CLK_FREQ	BIT(2)
+#define KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP	BIT(3)
 
 /* Device capabilities */
 #define KVASER_USB_CAP_BERR_CAP			0x01
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index f211bfcb1d97..5e357f5d3116 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -13,6 +13,7 @@
 
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/gfp.h>
 #include <linux/if.h>
 #include <linux/kernel.h>
@@ -89,7 +90,7 @@
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	278
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
-	.quirks = 0,
+	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.ops = &kvaser_usb_hydra_dev_ops,
 };
 
@@ -665,6 +666,22 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
 	.ndo_change_mtu = can_change_mtu,
 };
 
+static const struct net_device_ops kvaser_usb_netdev_ops_hwts = {
+	.ndo_open = kvaser_usb_open,
+	.ndo_stop = kvaser_usb_close,
+	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_start_xmit = kvaser_usb_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+static const struct ethtool_ops kvaser_usb_ethtool_ops = {
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
+static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+};
+
 static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
 {
 	int i;
@@ -742,7 +759,13 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	netdev->flags |= IFF_ECHO;
 
 	netdev->netdev_ops = &kvaser_usb_netdev_ops;
-
+	if (driver_info->quirks & KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP) {
+		netdev->netdev_ops = &kvaser_usb_netdev_ops_hwts;
+		netdev->ethtool_ops = &kvaser_usb_ethtool_ops_hwts;
+	} else {
+		netdev->netdev_ops = &kvaser_usb_netdev_ops;
+		netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
+	}
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
 
-- 
2.35.1

