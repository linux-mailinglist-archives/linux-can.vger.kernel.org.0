Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565085823FC
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiG0KRW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiG0KRT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00847220DA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:18 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r186so15558705pgr.2
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGGyEEdPfjlH1QaPzOP46sjt0adhPkjHvUuvLk8R2os=;
        b=Z0CvHag+4ntEXagQpKWg7NSmlz9+4gOf5zdV+4KXhQcjwa+3TdVp7zz1J1+X7uPHZz
         JcgQkbhwD+8ege9Xfe5zRkQaBd1rNwvdcOCqRQFKhT4qAsh37AEUcDT5DA2Cs0LdMt2g
         lZQYnWFcvhONBo8wWgEmNcXsAlysQGCDbjNXWVou4/7mtgHVbQ+eYX0uPJo1cqrJHlnb
         +mmGcxHbS1xojT6EREPJarcv5s7lm4qZI+l6yGQLEufgMt7i0A4yPJexKBpndi1aaMtP
         mIdAoM7Vb39JeGm2tJXxxLoweVHpig+AscTD6jaUYztmd+DqVSyo4HmBpEDp5TvQWsOV
         qtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bGGyEEdPfjlH1QaPzOP46sjt0adhPkjHvUuvLk8R2os=;
        b=fb/MWdsbnu0GUYBCBA6bxTeSbwmMdNKIwgMbLWYPlJED8tVffIIF/t5I8gP6VP/8qF
         xIR357P50YFpx8NxCNVIg2tdSoqGE69xm0RO/XqIukROMSpGoOle3yS/uVaa5g53MMYx
         Wsqo/9+0YqKa9VPOVbFW3z/f0Hq+PXA22dbjXCOwKQX+64RwgJdk7LeDgAk64k4K9xpm
         f6dt0YwaGjJ00xWx0epfNO0gs+SsekJ7oq3tyDYwT5kwUgBMOcA+RAnymod2w4+SqtmK
         KlmjNEn8Z34tifiaE/Lcy5Tg/AMZqeKjrF6bSaLK+j57GloTqzdcFz3v08sZmgzzPS2c
         gg0Q==
X-Gm-Message-State: AJIora/M55JMhxOEnhS3YDZXyDNBNRbNzTU2SD26KjlguFcqKmw6mBL0
        LWLDkRVPK+mtfrT8U0oRg19gu974DXdzxA==
X-Google-Smtp-Source: AGRyM1taPwBvNmj3PK965v9y/3gqzND9siQWAVp0yHVLmwXMfuTj2PeY49olsAMgfSXZydowxS9ZUw==
X-Received: by 2002:a05:6a00:a8e:b0:527:9d23:c613 with SMTP id b14-20020a056a000a8e00b005279d23c613mr21522015pfl.53.1658917038194;
        Wed, 27 Jul 2022 03:17:18 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:17 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 07/14] can: dev: add generic function can_ethtool_op_get_ts_info_hwts()
Date:   Wed, 27 Jul 2022 19:16:34 +0900
Message-Id: <20220727101641.198847-8-mailhol.vincent@wanadoo.fr>
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

