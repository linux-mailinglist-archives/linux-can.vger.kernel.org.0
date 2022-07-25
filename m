Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3FD580246
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbiGYPy1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235752AbiGYPy0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA38DF66
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso7380977pjr.2
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGGyEEdPfjlH1QaPzOP46sjt0adhPkjHvUuvLk8R2os=;
        b=m4wKjH7NhMJFk9Fmn38XNHz1aQLG9yCUQhLdJDkxD5t2u0jzYUy/BPebLVQGVQsYEv
         OII7gbtz+4ZsMiLSeHgAy0HfrkxCBTg16z/akmm1R1kGMrqYZFDg5J0/8S8RUzwYRBQ9
         V3ADU0tGIfI4MzAkCF7sr1TJHT/x8m1FzL2AqUFxm8xPl/oM/pRYDHsPIhFGHADm1s7Y
         zpnuhSXvpy88eW3GZ2KpVOgUOARFUnh+7+3pCgEdPqZnyX/uwvPOmP1AIVSvnTX5oOJi
         qlNbDPh0ZfZ8eA0mZ4wsRk4mLDPyI/UCap/xyps/fU4rKkMhsHGBzhhYvsZhFO9yqYqB
         GRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bGGyEEdPfjlH1QaPzOP46sjt0adhPkjHvUuvLk8R2os=;
        b=iO3ldiDm4ylaIJSER4Y2ilBj8tArwuUcXKnJ8NcmYU201IenEG32DeczzeoW1sUgZ6
         3FE/n+FbFDZoW1T95rX3Zx3N5jA8kh11aCDHKZUkmJBo/87luyA/FiB1RG7A6rjUf1E3
         /6dP3GAXWlmBMtfEhlEBDfNL514CkhrHqO8kPZS4Gbc7G1RQAU0YZ0dRzeBVD+t0dvvP
         VNiBeKBXAkRU/mcvnN3jAInaOyosJRtQ/485/R0VOaXRLVs1/axD09ZShSUG7LvAQf02
         j79jP5lhbkmh4+mIMGpETs5/NV4vPLoSeTa5K1LEB3p0QULpxowM/e4alI70fg63Ya7H
         a1Mg==
X-Gm-Message-State: AJIora/WVvhbT/K+eWDgOqvl4E6QXeNyqVzhPZ77KZ5dwuKB8OT9DVx7
        QK+rrciQCZLTxKdsmouK+SOnqWq8+e3kHQ==
X-Google-Smtp-Source: AGRyM1u0ol+4nz6R0sGxqq85dbrofjP8sQ5BgXpDhAoev84qGbBzczDgvN7jaqAq8JzeikS702Na/A==
X-Received: by 2002:a17:90a:760b:b0:1f2:3d0d:9b64 with SMTP id s11-20020a17090a760b00b001f23d0d9b64mr15336507pjk.74.1658764464012;
        Mon, 25 Jul 2022 08:54:24 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:23 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 07/14] can: dev: add generic function can_ethtool_op_get_ts_info_hwts()
Date:   Tue, 26 Jul 2022 00:53:47 +0900
Message-Id: <20220725155354.482986-8-mailhol.vincent@wanadoo.fr>
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

