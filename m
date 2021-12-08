Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9F46D2D6
	for <lists+linux-can@lfdr.de>; Wed,  8 Dec 2021 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhLHL77 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Dec 2021 06:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhLHL77 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Dec 2021 06:59:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E04EC061746
        for <linux-can@vger.kernel.org>; Wed,  8 Dec 2021 03:56:27 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b40so5087094lfv.10
        for <linux-can@vger.kernel.org>; Wed, 08 Dec 2021 03:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWwg/2Nq/2ARp5S64Gsv4+P2D8IsMc7vE3JZbRGAmeg=;
        b=mClwcMZ+sxSo1idXjECH/NFl1K2cLKmom+TkZGndGU11R4osXsBB0zHp4qXvTtyu+i
         +Jz7wDXsMu9CRpq2iZWLpWsmx6zyppwtssaDbvbL6tz/2tMSapgjVHnNZ9CJ+YJHGxng
         FIf3Kl0fqo6jOfNF37hHMUypIfisUzK156XpdvT9AixZuwouOAOF3Jd17+AMRwcDKG8Q
         mmzN+sxnUm/ToU1n5DUgxtah7s4rTlpAqqF8F8yvhheN63hLA7BEG7TGRGYEMVbVQ+fQ
         oF079xTQ17byidu9gB8p7fg3ZjNfm++2OfokKRtpLnnv7RJzV+d5s15l4WlmcpZxUPT/
         /JkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWwg/2Nq/2ARp5S64Gsv4+P2D8IsMc7vE3JZbRGAmeg=;
        b=cSv3s2HwQnwyIjE5dWf/Nr82PQwTqd/XNkWQ4vhUALkk6sM3VPIHkxmo05GzY7VQ0j
         9IcOBJOVLgiOmtyC/hphJfAdvElxn6pUO+eB7yeFXdt7gAsw6Qj1A/PPjO8/bmcMl0M7
         WmCyoYP6EEjSqp1rmCNqXK7t9OVRbY8FwSWuU+u471MhB43Mt6uSxfIAYnm0QW0VDO2C
         +PyLUvxk0UoHVWWpIqOX1aIBLky4r6gfjPgQdOG+z7fTEx/JkIBEklrI4daeC8E66IAS
         37jbrwIWijAZaOjcfGgQhaHytWU7Q5JurwaQ/lHpuTEcAHkHsCrHbm2LJsKCHBXwFVfp
         Ez9A==
X-Gm-Message-State: AOAM531vqrfj6THEtxk3z2Df+LHfVwmg5l0JvlGve/s/dBOrV1n1yUTD
        p4CHEO3+mMsP3eK+pwInjJZ1SJ7CZAqrZONu
X-Google-Smtp-Source: ABdhPJww+VcP2Tz/XpYyE4hdVDlmG9AfmP4on+5oNv55V6VK1msf7Ck4E6Fu9DtjqsfEAMSxMf0AUw==
X-Received: by 2002:ac2:5cd7:: with SMTP id f23mr48232269lfq.153.1638964585467;
        Wed, 08 Dec 2021 03:56:25 -0800 (PST)
Received: from freke.kvaser.se (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id c25sm256977lja.38.2021.12.08.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 03:56:25 -0800 (PST)
From:   Jimmy Assarsson <extja@kvaser.com>
To:     linux-can@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 3/4] can: kvaser_usb: Rearrange kvaser_usb_leaf_dev_cfg to avoid forward declaration
Date:   Wed,  8 Dec 2021 12:56:06 +0100
Message-Id: <20211208115607.202859-4-extja@kvaser.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211208115607.202859-1-extja@kvaser.com>
References: <20211208115607.202859-1-extja@kvaser.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Rearrange kvaser_usb_leaf_dev_cfg and kvaser_usb_leaf_bittiming_const.
And remove forward declaration of kvaser_usb_leaf_dev_cfg.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 43 +++++++++----------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 533e25cb4337..bd5d469a9c3c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -29,9 +29,6 @@
 
 #include "kvaser_usb.h"
 
-/* Forward declaration */
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg;
-
 #define CAN_USB_CLOCK			(8 * CAN_MHZ)
 #define MAX_USBCAN_NET_DEVICES		2
 
@@ -341,6 +338,26 @@ struct kvaser_usb_err_summary {
 	};
 };
 
+static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
+	.name = "kvaser_usb",
+	.tseg1_min = KVASER_USB_TSEG1_MIN,
+	.tseg1_max = KVASER_USB_TSEG1_MAX,
+	.tseg2_min = KVASER_USB_TSEG2_MIN,
+	.tseg2_max = KVASER_USB_TSEG2_MAX,
+	.sjw_max = KVASER_USB_SJW_MAX,
+	.brp_min = KVASER_USB_BRP_MIN,
+	.brp_max = KVASER_USB_BRP_MAX,
+	.brp_inc = KVASER_USB_BRP_INC,
+};
+
+static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg = {
+	.clock = {
+		.freq = CAN_USB_CLOCK,
+	},
+	.timestamp_freq = 1,
+	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
+};
+
 static void *
 kvaser_usb_leaf_frame_to_cmd(const struct kvaser_usb_net_priv *priv,
 			     const struct sk_buff *skb, int *cmd_len,
@@ -1226,18 +1243,6 @@ static int kvaser_usb_leaf_init_card(struct kvaser_usb *dev)
 	return 0;
 }
 
-static const struct can_bittiming_const kvaser_usb_leaf_bittiming_const = {
-	.name = "kvaser_usb",
-	.tseg1_min = KVASER_USB_TSEG1_MIN,
-	.tseg1_max = KVASER_USB_TSEG1_MAX,
-	.tseg2_min = KVASER_USB_TSEG2_MIN,
-	.tseg2_max = KVASER_USB_TSEG2_MAX,
-	.sjw_max = KVASER_USB_SJW_MAX,
-	.brp_min = KVASER_USB_BRP_MIN,
-	.brp_max = KVASER_USB_BRP_MAX,
-	.brp_inc = KVASER_USB_BRP_INC,
-};
-
 static int kvaser_usb_leaf_set_bittiming(struct net_device *netdev)
 {
 	struct kvaser_usb_net_priv *priv = netdev_priv(netdev);
@@ -1343,11 +1348,3 @@ const struct kvaser_usb_dev_ops kvaser_usb_leaf_dev_ops = {
 	.dev_read_bulk_callback = kvaser_usb_leaf_read_bulk_callback,
 	.dev_frame_to_cmd = kvaser_usb_leaf_frame_to_cmd,
 };
-
-static const struct kvaser_usb_dev_cfg kvaser_usb_leaf_dev_cfg = {
-	.clock = {
-		.freq = CAN_USB_CLOCK,
-	},
-	.timestamp_freq = 1,
-	.bittiming_const = &kvaser_usb_leaf_bittiming_const,
-};
-- 
2.34.1

