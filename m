Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE23580248
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiGYPy3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 25 Jul 2022 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiGYPy2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 11:54:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ADAE003
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 23so10706519pgc.8
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5Txqu8QqXk1j94Vu9ZhuEySdqC2ZrZ0pryhl2/h6u4=;
        b=HrdnAZY5n8IbUeF5SVkLejIF/pnSuD4Q9IvtfRiGHc8c18yYF6nbOJAFUwARjzKlI6
         JVuhimFlgCCbIBCU7vZxHOl3TcHW4i1oXGa7YTv0G3a8k/VNxaUt8IGsk/NAz55+AD3c
         h6fL+9UNBV4JsjPeUhCoZriKnaUAxf9lWLQNtW2Wa7WjrKSIf2lg2HpeT1P3sBKdpZ+6
         wH3SLx8TP/mx37nuGodEjvZnJwh0Qx9BGtJRby68JbQ5j62pAtpyDTD3208NAOlpUKf5
         dsTXqUD2irFuEH30/s+FpeT9Y/Vo9lfHCEZ94mJ9K8dVWnyR9/lpXQKux4KYIMmqm8Ii
         sgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=r5Txqu8QqXk1j94Vu9ZhuEySdqC2ZrZ0pryhl2/h6u4=;
        b=efzqRV1CQ+aoIx+1nXT0hpDZcPl9lamb1Fov9cNV4LX04I3SX4iyOFD2az+dWcShK5
         a7LLGzV5Zhg3VuSv/VyvWEovX6gfu4Wqoh0PeUeXiodxk3Z44cucVA7PboabWnpSO6u5
         yts3O9zZ9TpHKCE5rpC35P7NM2gqFFFayTsYo8XNwoOb0ZKWcFOk86POfTUkmNKEgw5y
         A28K9Ovbs9ThVuO+qLw5xjFeTpqDKEbhgdz6SkQvy2zhW6KewIa9fvbThyboNZt1DiRK
         1WR8BPt+jQXkj9ajmfYXWq6iK2uhAJTPaeucUunYcF39QeuleE48hAdM/iYTjJGMW2lo
         H79Q==
X-Gm-Message-State: AJIora9vYPmBlMjngz/8B74jzvqzzWtHKhz7HEyB4VBj61GypmNRsSAM
        e8bC+eEL4tFPGxJTDo/3O6WXPlgB8FLJGg==
X-Google-Smtp-Source: AGRyM1ubzdFB8mWRzD0mu2mW1ieiiSpNae/KdO8dJp93XrHshR9C28Dm541R14CHqMBDPG6Ck4Kjog==
X-Received: by 2002:a05:6a00:24c6:b0:52b:ee89:eca9 with SMTP id d6-20020a056a0024c600b0052bee89eca9mr9189956pfv.78.1658764466810;
        Mon, 25 Jul 2022 08:54:26 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0016d692ff95esm3511296plr.133.2022.07.25.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:54:25 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 08/14] can: dev: add generic function can_eth_ioctl_hwts()
Date:   Tue, 26 Jul 2022 00:53:48 +0900
Message-Id: <20220725155354.482986-9-mailhol.vincent@wanadoo.fr>
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

