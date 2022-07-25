Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA312580001
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiGYNd1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiGYNdX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097513D7E
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so14385962pjg.3
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHZllP+LkQASzlYCEgbC2URVtDXJ0m/2moXp2NDhlEk=;
        b=Iw8WDe688zw28kTyJ5mi3UZeV3w3LNRXYjKX81Loody9wmpIkEgocdhO32SUmm8ykM
         nRmOfUxCiiXsQ5DFm0yoTE2te6u5KdjztrL5/l7AY3LLrydyoO42rrshYhoa47u2jaXr
         yFHAKVYObu+x2BXRF6hFYsPUacCId8G5p8+Nnanugf+26v6OdW8UmfNz5xtGPfS0+9F8
         8sVix8lBqXqPndn9l3dwOGe+DmbtDiJsqhCCNSaSg88dJKX575fM6gaYbqFjTVeBKPPx
         tGAPyAScZPxne2B3zgQ0nuGscX+snkLOfd0JVIthKVqr1pUz3bYzdcrlBbVHKEXatoBU
         oUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DHZllP+LkQASzlYCEgbC2URVtDXJ0m/2moXp2NDhlEk=;
        b=zdWFo3mWv3BmUdxrABJcJJ0iLQJLuwo4S0PgL3UgOU5TBah3NQsmkPYxDTn6XVa26L
         xoMHl95Iv014IZYTRXAW0Fqf0QGlFIWnvv26Ciu0JwWj1I4CH0fzIqNUNsrRlUFqx16a
         1XAe+RtjVf1JDd0OZ5Ns/001omuu3oU9afY5EZKynerx7DFyRAC9vgv6ZzRmVDB8LAM0
         G2banJuGDI2Y5E4bjZNUWdkb720MSBDXBz+mlw3V626kJ9JkJSBsE+geW+yNxk4KVzlh
         egyGe0rRXw4+2GdefQPPDXghj722em3whpL5vFiIy1WaOB+z3gdiK9jgVk4cMtSEPMhv
         yYyA==
X-Gm-Message-State: AJIora8q2tmZladUOr05xsHh/yOAOP31GQXzox66zInX9TmfTw1IKcB5
        A0gyo11PHg76T/+/Dfta/FQ5IutArezJyw==
X-Google-Smtp-Source: AGRyM1swEPnn2xaf7yISqpfVVeu9+RLLEPVAEhesSgJM6wsjb7jUDPkH7EN8xhzGvucOvrwszIuvHg==
X-Received: by 2002:a17:902:d504:b0:16d:69f9:e607 with SMTP id b4-20020a170902d50400b0016d69f9e607mr6992478plg.131.1658755997168;
        Mon, 25 Jul 2022 06:33:17 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:16 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 22/24] can: kvaser_usb: advertise timestamping capabilities and add ioctl support
Date:   Mon, 25 Jul 2022 22:32:06 +0900
Message-Id: <20220725133208.432176-23-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
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
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  | 25 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

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
index 964c0026383e..36e896dbd94b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -92,7 +92,7 @@
 #define USB_HYBRID_PRO_CANLIN_PRODUCT_ID	278
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_hydra = {
-	.quirks = 0,
+	.quirks = KVASER_USB_QUIRK_HAS_HARDWARE_TIMESTAMP,
 	.ops = &kvaser_usb_hydra_dev_ops,
 };
 
@@ -668,6 +668,14 @@ static const struct net_device_ops kvaser_usb_netdev_ops = {
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
 static void kvaser_usb_get_drvinfo(struct net_device *netdev,
 				   struct ethtool_drvinfo *drvinfo)
 {
@@ -676,6 +684,12 @@ static void kvaser_usb_get_drvinfo(struct net_device *netdev,
 
 static const struct ethtool_ops kvaser_usb_ethtool_ops = {
 	.get_drvinfo = kvaser_usb_get_drvinfo,
+	.get_ts_info = ethtool_op_get_ts_info,
+};
+
+static const struct ethtool_ops kvaser_usb_ethtool_ops_hwts = {
+	.get_drvinfo = kvaser_usb_get_drvinfo,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
 };
 
 static void kvaser_usb_remove_interfaces(struct kvaser_usb *dev)
@@ -755,8 +769,13 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 	netdev->flags |= IFF_ECHO;
 
 	netdev->netdev_ops = &kvaser_usb_netdev_ops;
-	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
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

