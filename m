Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50B15823FD
	for <lists+linux-can@lfdr.de>; Wed, 27 Jul 2022 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiG0KRX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 27 Jul 2022 06:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiG0KRW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 27 Jul 2022 06:17:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CBF220DA
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f11so15540025pgj.7
        for <linux-can@vger.kernel.org>; Wed, 27 Jul 2022 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5Txqu8QqXk1j94Vu9ZhuEySdqC2ZrZ0pryhl2/h6u4=;
        b=YTKN/NzE8WHdYkUBqILSCxfG0khjzXHh1pnOMCSO/vs2NDR1iRj89UJjP4nSR9dmE8
         Ds+AXp/hu4zY9Baj2GxCQp5wJXXKc4RcdsywfnrlOT07Fi2I4nAwfOfYXsjkqDbprTlJ
         Mjv00u56lDG1qnulsSUa7BESXaRh7wQwzTEWmTplt7rA3Ley43OJ4ZlrvuwxbJ0IDY36
         hc69V9+tltkHNR1fQuBTbDzHV/0c56f99en87H6AJ2HeQvGwKpH4973qGCstHdb4UPkw
         7U0/rP2W6IDx0IYGIJZ8wKaYwHkTxTqcGXg9Gg17OgEVd2PPLQpaUXcMGAWoYKCdL1t7
         tRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r5Txqu8QqXk1j94Vu9ZhuEySdqC2ZrZ0pryhl2/h6u4=;
        b=ezRoA9c3oqheRGlkOR6nYFfAuPzkL6UmvvRqfMwGuLItXAJ0jZaQJKzCc8CZC1HR4i
         a2Utm76et4Myd+of7FJJpIX8Z0OdUyUGT4nXzVshokCW9bMw9LEDdAnyfiESN20GnRsz
         J/EacdD7CIfboqrKmSnu03cjvdKnErTod9ZKu9zNFFZLZsmN5GS6NqFM/F2K3FGprLc8
         XkEet6Dpqw46E80fnKl8LrsquXK2UPIU8NaS8O+Ri+f/MilSXATmZ+uwfhxXQY+vjKTa
         jNT9tPeoiswDBbo94PArroDJJ519LGLYX6dNmr8xp1pxYXKw+canugdmzu1KVVVsS/yl
         o/gA==
X-Gm-Message-State: AJIora9CVRNk4mxQwb6+djvSUr53KnQ6tqeCy5K6FcvrOl99Kb82gwr1
        LzF42JPOF4+D6f/YEyGW3q+s4IkX9b9NOA==
X-Google-Smtp-Source: AGRyM1u8r6lSizV14EcxK3oU0Dw/bOF6tR7Gfk5coEDfKKSSzvrJDmdVH9o36ah3pDYdVgbWtrPBfw==
X-Received: by 2002:a05:6a00:4211:b0:52a:c86e:aba3 with SMTP id cd17-20020a056a00421100b0052ac86eaba3mr21840527pfb.41.1658917040590;
        Wed, 27 Jul 2022 03:17:20 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w22-20020aa79556000000b005284e98304csm13260666pfq.205.2022.07.27.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:17:20 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 08/14] can: dev: add generic function can_eth_ioctl_hwts()
Date:   Wed, 27 Jul 2022 19:16:35 +0900
Message-Id: <20220727101641.198847-9-mailhol.vincent@wanadoo.fr>
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

Tools based on libpcap (such as tcpdump) expect the SIOCSHWTSTAMP
ioctl call to be supported. This is also specified in the kernel doc
[1]. The purpose of this ioctl is to toggle the hardware timestamps.

Currently, CAN devices which support hardware timestamping have those
always activated. can_eth_ioctl_hwts() is a dumb function that will
always succeed when requested to set tx_type to HWTSTAMP_TX_ON or
rx_filter to HWTSTAMP_FILTER_ALL.

[1] Kernel doc: Timestamping, section 3.1 "Hardware Timestamping
Implementation: Device Drivers"
Link: https://docs.kernel.org/networking/timestamping.html#hardware-timestamping-implementation-device-drivers

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/dev.c | 29 +++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  1 +
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index f307034ff4fd..c1956b1e9faf 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -322,6 +322,35 @@ int can_change_mtu(struct net_device *dev, int new_mtu)
 }
 EXPORT_SYMBOL_GPL(can_change_mtu);
 
+/* generic implementation of netdev_ops::ndo_eth_ioctl for CAN devices
+ * supporting hardware timestamps
+ */
+int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct hwtstamp_config hwts_cfg = { 0 };
+
+	switch (cmd) {
+	case SIOCSHWTSTAMP: /* set */
+		if (copy_from_user(&hwts_cfg, ifr->ifr_data, sizeof(hwts_cfg)))
+			return -EFAULT;
+		if (hwts_cfg.tx_type == HWTSTAMP_TX_ON &&
+		    hwts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
+			return 0;
+		return -ERANGE;
+
+	case SIOCGHWTSTAMP: /* get */
+		hwts_cfg.tx_type = HWTSTAMP_TX_ON;
+		hwts_cfg.rx_filter = HWTSTAMP_FILTER_ALL;
+		if (copy_to_user(ifr->ifr_data, &hwts_cfg, sizeof(hwts_cfg)))
+			return -EFAULT;
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL(can_eth_ioctl_hwts);
+
 /* generic implementation of ethtool_ops::get_ts_info for CAN devices
  * supporting hardware timestamps
  */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 752bd45d8ebf..c3e50e537e39 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -163,6 +163,7 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
 int open_candev(struct net_device *dev);
 void close_candev(struct net_device *dev);
 int can_change_mtu(struct net_device *dev, int new_mtu);
+int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
 int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
 				    struct ethtool_ts_info *info);
 
-- 
2.35.1

