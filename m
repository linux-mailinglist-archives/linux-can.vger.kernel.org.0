Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF52581120
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbiGZKZ5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiGZKZx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:53 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690641EAFE
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:51 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g12so12862561pfb.3
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFN6QmtGVHCxLF5Lled8grHNKzbHwXYEZA4KcLz3/Uc=;
        b=g1CSO1Mlv60nNm6HC1fL8YflIb3Dw8UsGdc/Wl67VGSzlLCPHKxbhbijAi4v1hWedb
         mgZAhJTKtYc7uy85292cVONCcLXmDSf1jBmLmcj6XQPB7aEG/KQZq3ntU7yI+L+JG4fw
         5pXHcqAoVJfvi7jZSfP+21imZscm9HmP3dyfaP+zSBXQikJ0VLlbqe3u8rIIMsOhmkNc
         8h/Wx8BQsUxF5q2josyT9R1ljDrCYh1ByHAGqHS/9ww5bzPYs2prnIURjq3zekrxwaVC
         jWiuCBA0JG/486sqCDzRc+UueD4XLt3kbpRnnT1qpyQTO6j+Uh2bfivGLq116jaZhsjy
         GaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EFN6QmtGVHCxLF5Lled8grHNKzbHwXYEZA4KcLz3/Uc=;
        b=Do+IaCFbqh06K32IHyOozdF25/TiBw1+jRJJB3FrxiFZf7q3SBKmQhvtJzdDEOeTFm
         e5GAxcAosN1Ed/VzsKlaaE0UTdKJnkReBTs5BkvlrJEk+qD8lSRmI/wV1Dzx26tntB7k
         mnwPWKPkGgSDm7lnIzMZbxMVs17ExM9uGZL8hi4Ipa6KGOeKWH6Unf90xZBjEBI1yQTQ
         nZwryFGMwEyi6fgkt1o9FMlRVsnfDV0cNh8WpXQ5GzmUxxRr3FWEQFEbgDTZpJZblfCD
         /YukG/OyTZp76EChhH7OFVmBuKzorO2o/dmbUItbd1ITFzYClcPWB9neg0wKfYPbOMWn
         Nxkw==
X-Gm-Message-State: AJIora8J6Gw8ulQDThZEYFO9g7KtdKHsN8yztHcdL46qe15y4jRMuxwq
        2heiDO3qS3TXpUCCkTaZC+i/deUkHd6MpQ==
X-Google-Smtp-Source: AGRyM1utRzI6HUiO63DRt7wTknai4OrRgfYQd7OQw+h3ZTWYSZmNDzubm2s6cVbQ8EJ5hP1H8WH7qw==
X-Received: by 2002:a63:81c2:0:b0:415:da59:25dc with SMTP id t185-20020a6381c2000000b00415da5925dcmr14536269pgd.11.1658831150309;
        Tue, 26 Jul 2022 03:25:50 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:49 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 12/14] can: kvaser_usb: advertise timestamping capabilities and add ioctl support
Date:   Tue, 26 Jul 2022 19:24:52 +0900
Message-Id: <20220726102454.95096-13-mailhol.vincent@wanadoo.fr>
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

