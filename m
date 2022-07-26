Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A8581113
	for <lists+linux-can@lfdr.de>; Tue, 26 Jul 2022 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiGZKZl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 26 Jul 2022 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiGZKZk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 26 Jul 2022 06:25:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D20221
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:38 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so16865494pjg.3
        for <linux-can@vger.kernel.org>; Tue, 26 Jul 2022 03:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGGyEEdPfjlH1QaPzOP46sjt0adhPkjHvUuvLk8R2os=;
        b=SbPNM7AkFEf/tW/wZ3ddGpKmQ4cqmNzVupsm1oAP+A6IYJfAYoZqMC6t4fRXMpHFet
         /Mzcq5mvIuR5NJJ+Ks2139uYazfOjFMKyzAODrcUZGhZQx3D7LH8ogNKtS3uHx5XeA3D
         xWChng+LeElMahxZlsve5N+jmGUATFyN1NM/HSMSDuYHlq6PBVBPzVYFJFy6aLClt1LK
         4O7HjHOvhY39RLwgTHBd0axoYRpsVZJRpSdNBZ4A7v2dgseqkKzS2kq4RHzwKmlTyncr
         t/CymFznvmxIOYbaZZufK6I/QT71SeeR4ukIEfzW2s2U/hRvlMrwD+PXllG5S0Fsk+oc
         DPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bGGyEEdPfjlH1QaPzOP46sjt0adhPkjHvUuvLk8R2os=;
        b=NO7736ZTkZSZjGX5mO8VaI8ZvdbIFsdXZpe8gpq6ar9nRHX29K6mO9/EK6TxoMxJ5F
         7jH7nEajZk8HgMCN9ctWtbGkx875O6WlEiKRtcgURl5/WwukDGqd4IEWebt4Cywuy551
         5zWmBT3FFaQIAbGXQ8d0l0YJYycQQbr18lfm2CddhEmCm/xtrS9X04yy/y1CrUfNnuBE
         /e6uEFvhZgj7BXrdJ4pvVREHQbpJu7WXSA5sL5siQKIW1aNa6aG09zSi9ZRWSPLdwYi4
         duGJg6XZG1KgswBIx18R8NXKgxGdw42SA09SQU5/Lw1TTUK2iqctZ8OR10R1rT5oLyv+
         6SSA==
X-Gm-Message-State: AJIora+xJuRo1gdEsaqhICyMu5Z3C1iZP+4xFQgN+DcyrOAHxAMD3tz9
        v4w+F/lBKqy/m22zsESzfb78lCB1el3qtw==
X-Google-Smtp-Source: AGRyM1ulYMy0MFd/N2Hf81XycX6vsQmY9NL/1bFQ0OIjs4cQa7EOwOPWyWpFJ69U5qw+APoTz2Fmuw==
X-Received: by 2002:a17:90b:4c52:b0:1f2:c763:5303 with SMTP id np18-20020a17090b4c5200b001f2c7635303mr7282691pjb.21.1658831138181;
        Tue, 26 Jul 2022 03:25:38 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id y6-20020a655b46000000b00411bbcdfbf7sm9869894pgr.87.2022.07.26.03.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 03:25:37 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 07/14] can: dev: add generic function can_ethtool_op_get_ts_info_hwts()
Date:   Tue, 26 Jul 2022 19:24:47 +0900
Message-Id: <20220726102454.95096-8-mailhol.vincent@wanadoo.fr>
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

Add function can_ethtool_op_get_ts_info_hwts(). This function will be
used by CAN devices with hardware TX/RX timestamping support to
implement ethtool_ops::get_ts_info. This function does not offer
support to activate/deactivate hardware timestamps at device level nor
support the filter options (which is currently the case for all CAN
devices with hardware timestamping support).

The fact that hardware timestamp can not be deactivated at hardware
level does not impact the userland. As long as the user do not set
SO_TIMESTAMPING using a setsockopt() or ioctl(), the kernel will not
emit TX timestamps (RX timestamps will still be reproted as it is the
case currently).

Drivers which need more fine grained control remains free to implement
their own function, but we foresee that the generic function
introduced here will be sufficient for the majority.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/dev.c | 21 +++++++++++++++++++++
 include/linux/can/dev.h   |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 523eaacfe29e..f307034ff4fd 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -322,6 +322,27 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 }
 EXPORT_SYMBOL_GPL(can_change_mtu);
 
+/* generic implementation of ethtool_ops::get_ts_info for CAN devices
+ * supporting hardware timestamps
+ */
+int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
+				    struct ethtool_ts_info *info)
+{
+	info->so_timestamping =
+		SOF_TIMESTAMPING_TX_SOFTWARE |
+		SOF_TIMESTAMPING_RX_SOFTWARE |
+		SOF_TIMESTAMPING_SOFTWARE |
+		SOF_TIMESTAMPING_TX_HARDWARE |
+		SOF_TIMESTAMPING_RX_HARDWARE |
+		SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->phc_index = -1;
+	info->tx_types = BIT(HWTSTAMP_TX_ON);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+EXPORT_SYMBOL(can_ethtool_op_get_ts_info_hwts);
+
 /* Common open function when the device gets opened.
  *
  * This function should be called in the open function of the device
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index e22dc03c850e..752bd45d8ebf 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -20,6 +20,7 @@
 #include <linux/can/length.h>
 #include <linux/can/netlink.h>
 #include <linux/can/skb.h>
+#include <linux/ethtool.h>
 #include <linux/netdevice.h>
 
 /*
@@ -162,6 +163,8 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
+int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
+				    struct ethtool_ts_info *info);
 
 int register_candev(struct net_device *dev);
 void unregister_candev(struct net_device *dev);
-- 
2.35.1

