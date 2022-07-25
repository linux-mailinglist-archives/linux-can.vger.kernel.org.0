Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3357FFF8
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbiGYNdR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiGYNdM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:33:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043113F2A
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w185so10463026pfb.4
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dz/+LWSLoWBhNIvbF6vY3nIjRctJJjTp9jFTSKhncA8=;
        b=aI10NXD5+km2YkKBCwkaT2v9aMzGCYHlIR8AaRShSXcPw6A2IsyyDjSumSGaAa0FS0
         jBhDyZFDxA47lSuKkxE/uikIWhVRCKRgumVMQ0UzbpLAexeuSZK63kb6Szj6vOt2k7b1
         ceEkG3q2E9SSpRaCPbALS8wZxRLvQgTRKiu0Hb62jhSu8yOkwcyB9hSKbUyzoTyTekMH
         3grF09y6Ro0hIltMIcahIAec9lVQF2puGiEzA+kkamQFPga1TuCiOT1jqfgN0IhiIMV3
         7+ArzNw+53JFFsK5GDJhdvCboadZ8FDeRhhI7+PaWZCAAoH5F+K1mtPPdEms2mL20JX6
         ZHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dz/+LWSLoWBhNIvbF6vY3nIjRctJJjTp9jFTSKhncA8=;
        b=mwP2lmFKk/Nd8jLmUM3qR+4mq0mWlzzBU1HqWu8Vd/prvRQfHvAMAKqdaWrIjLZRSf
         +K5PX3uk2+gDLnRiNbIanvMABCvKTPLc3d/4034JRuIb+cM2t7OGHnjd4on5n8J7UgIn
         oeqTRqdpa/kC7Ty6aELDVGPz5Zvf395KVOgbqAbHtDG7jMEgO2WDrAum8mhxfdMJIHcT
         nQEAHJtoiYDXfRemv+98vG1ryvw9xXqfIwLyHHqXRrHw1yusa+QrEkedWbc36l3Om1wi
         Yyoa6ekdzzQlYg52ij3pQwLxI5T5bmsb78Fh78HYUpAqh7OU7EbdwMRgbrwCmhFqa6z0
         vOTA==
X-Gm-Message-State: AJIora+jAoghcX5ZfD5lxTChHfjXQQiypPHNOub7h7WYNfbDKWxSf9hI
        ykEjd0nIEKir+i6oI4Tc9g7H5Z2SEl9cBw==
X-Google-Smtp-Source: AGRyM1ugJYrY1RXjgFcTKcZzk5caXTvslSRaS3nFvxSLCBBdhp0zcA5nQ+RtRlU5L5/qwbo9PVWUlQ==
X-Received: by 2002:a63:fc1c:0:b0:415:f5f1:f7a7 with SMTP id j28-20020a63fc1c000000b00415f5f1f7a7mr11094501pgi.332.1658755986368;
        Mon, 25 Jul 2022 06:33:06 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b0016c16648213sm9406133pla.20.2022.07.25.06.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:33:06 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 17/24] can: dev: add generic function can_ethtool_op_get_ts_info_hwts()
Date:   Mon, 25 Jul 2022 22:32:01 +0900
Message-Id: <20220725133208.432176-18-mailhol.vincent@wanadoo.fr>
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
index 523eaacfe29e..7ad56d31cec9 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -322,6 +322,27 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 }
 EXPORT_SYMBOL_GPL(can_change_mtu);
 
+/* generic implementation of ethtool_ops::get_ts_info for CAN devices
+ * supporting hardware RX timestamps
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

