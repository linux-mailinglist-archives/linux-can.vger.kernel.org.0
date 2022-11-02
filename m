Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732A96160AF
	for <lists+linux-can@lfdr.de>; Wed,  2 Nov 2022 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKBKOe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Nov 2022 06:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBKOc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2022 06:14:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E42497C
        for <linux-can@vger.kernel.org>; Wed,  2 Nov 2022 03:14:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 130so15995398pfu.8
        for <linux-can@vger.kernel.org>; Wed, 02 Nov 2022 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OnyBCCiBXh+mGkppBbeDTh8mdZfhPPjgzMvzlgu5dc=;
        b=Vh78lxEHzFma7InV+MA2uDwZDbs71GID4X3/znU5N1YyXJagBNj1OopNAn5swYbcWH
         j3FN/dTwle0d6YD8ZPRjM817gtIFJe07RXHgHnKFlRzhg53n2JYVoORLatRwoDbl6uoB
         gzEX3WxpB4k3qqZc+0VBYTSh5ITPQp4Z8tCZX/J/NRRzu4NixE4tXea4/lsvbymY4nuT
         RLJk3gNTM/Id8urhfJVWnA3wB697upBnvscWixXKfqz195B3atAe/6dM/Rq7MPCht2NR
         ARS9ustuEgqwYCwhwZM+UiLa6LJxDJ0lUxA/aX6XGJxq0wGY42b449WIK28Dci9/yNo5
         V0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OnyBCCiBXh+mGkppBbeDTh8mdZfhPPjgzMvzlgu5dc=;
        b=uO3Yk8xzeTczGXUqSIDAEIMSW/E9iIrfMIjk0eUk9NwzlLyr11nvzuv2HMprwfjSRv
         4w8Wpltt2Vg1ojtvnncAsXHonFxXb7Vg2SmV4Vrr9P048c0ifjAb7d5vhaGPdeyBTnQJ
         VQ7jb4Z8BzryZrAfyuEqtGbaQUfluLF9nJn8WN38pgdtLHyrrobvZ8tYkk3U+bdw6yYX
         ZJSmLQ2MohfCEZ7i4PD1Ii58lnmNtwGMAjSb725CPSxcYLCMRFZgzGSiqEo9bv3ptian
         ArYCHgyohhfJsYWmWSUoD4lhMTTSNxtki1Z8mrakTMmMZ9+7DjNp/9dqfV4WDl1xi8zM
         YZBA==
X-Gm-Message-State: ACrzQf1JtINzAi1iRKiyhzxJCaEIPP+sjkzl9050CQdMXeVnmLxvsOZa
        hYQqt4aYotiYfEnp6s+Xko+iEJ3Dfso=
X-Google-Smtp-Source: AMsMyM61B8sg/gvsTjv9hn5YfuzmXnV34AL76IGjvrRliT/qzErCmYQBM1LyAyEr8I9S8F/omZX2FA==
X-Received: by 2002:a63:d54:0:b0:46f:9c0b:1e78 with SMTP id 20-20020a630d54000000b0046f9c0b1e78mr16310802pgn.178.1667384070593;
        Wed, 02 Nov 2022 03:14:30 -0700 (PDT)
Received: from XH22050090-L.ad.ts.tri-ad.global ([103.175.111.222])
        by smtp.gmail.com with ESMTPSA id m18-20020a62a212000000b0056bd737fdf3sm8099370pff.123.2022.11.02.03.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 03:14:30 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Max Staudt <max@enpas.org>,
        linux-can <linux-can@vger.kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: skb: can_dropped_invalid_skb: fix out of bound access
Date:   Wed,  2 Nov 2022 19:14:23 +0900
Message-Id: <20221102101424.351095-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <41ebf2d2-651c-2325-5005-20b24f5261d2@hartkopp.net>
References: <41ebf2d2-651c-2325-5005-20b24f5261d2@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Commit a6d190f8c767 introduced a check toward the
CAN_CTRLMODE_LISTENONLY flag in can_dropped_invalid_skb(). That flag
is stored in the priv member of the network device
(can_priv::ctrlmode).

However, some virtual CAN devices do not have a struct can_priv member
in their priv. This means that:

  	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY)

does an out of bound access. If the flag happens to bet set, the skb
is then erroneously dropped.

Revert the changes in drivers/net/can/dev/skb.c and introduce a new
can_dropped_invalid_tx_frame() functions.

For each "real" CAN drivers which have a struct can_priv member, call
can_dropped_invalid_tx_frame() in their net_device_ops::ndo_start_xmit()
function.

For each virtual device, keep using can_dropped_invalid_skb()

Fixes: commit a6d190f8c767 ("can: skb: drop tx skb if in listen only mode")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/at91_can.c                    |  2 +-
 drivers/net/can/c_can/c_can_main.c            |  2 +-
 drivers/net/can/can327.c                      |  2 +-
 drivers/net/can/cc770/cc770.c                 |  2 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c      |  2 +-
 drivers/net/can/dev/dev.c                     | 19 +++++++++++++++++++
 drivers/net/can/dev/skb.c                     |  7 -------
 drivers/net/can/flexcan/flexcan-core.c        |  2 +-
 drivers/net/can/grcan.c                       |  2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c         |  2 +-
 drivers/net/can/janz-ican3.c                  |  2 +-
 drivers/net/can/kvaser_pciefd.c               |  2 +-
 drivers/net/can/m_can/m_can.c                 |  2 +-
 drivers/net/can/mscan/mscan.c                 |  2 +-
 drivers/net/can/pch_can.c                     |  2 +-
 drivers/net/can/peak_canfd/peak_canfd.c       |  2 +-
 drivers/net/can/rcar/rcar_can.c               |  2 +-
 drivers/net/can/rcar/rcar_canfd.c             |  2 +-
 drivers/net/can/sja1000/sja1000.c             |  2 +-
 drivers/net/can/slcan/slcan-core.c            |  2 +-
 drivers/net/can/softing/softing_main.c        |  2 +-
 drivers/net/can/spi/hi311x.c                  |  2 +-
 drivers/net/can/spi/mcp251x.c                 |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c  |  2 +-
 drivers/net/can/sun4i_can.c                   |  2 +-
 drivers/net/can/ti_hecc.c                     |  2 +-
 drivers/net/can/usb/ems_usb.c                 |  2 +-
 drivers/net/can/usb/esd_usb.c                 |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c   |  2 +-
 drivers/net/can/usb/gs_usb.c                  |  2 +-
 .../net/can/usb/kvaser_usb/kvaser_usb_core.c  |  2 +-
 drivers/net/can/usb/mcba_usb.c                |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c  |  2 +-
 drivers/net/can/usb/ucan.c                    |  2 +-
 drivers/net/can/usb/usb_8dev.c                |  2 +-
 drivers/net/can/xilinx_can.c                  |  2 +-
 include/linux/can/dev.h                       |  2 ++
 37 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 3a2d109a3792..86d61efc0fff 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -452,7 +452,7 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int mb, prio;
 	u32 reg_mid, reg_mcr;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	mb = get_tx_next_mb(priv);
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index d6605dbb7737..e597208369fd 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -457,7 +457,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	struct c_can_tx_ring *tx_ring = &priv->tx;
 	u32 idx, obj, cmd = IF_COMM_TX;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	if (c_can_tx_busy(priv, tx_ring))
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 0aa1af31d0fe..6765b812b6b9 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -813,7 +813,7 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 	struct can327 *elm = netdev_priv(dev);
 	struct can_frame *frame = (struct can_frame *)skb->data;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	/* We shouldn't get here after a hardware fault:
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 0b9dfc76e769..8527e87c2139 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -429,7 +429,7 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct cc770_priv *priv = netdev_priv(dev);
 	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index b8da15ea6ad9..3e00defa69f1 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -600,7 +600,7 @@ static netdev_tx_t ctucan_start_xmit(struct sk_buff *skb, struct net_device *nde
 	bool ok;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (unlikely(!CTU_CAN_FD_TXTNF(priv))) {
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index c1956b1e9faf..c97f62e07d9c 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -568,4 +568,23 @@ static __exit void can_dev_exit(void)
 }
 module_exit(can_dev_exit);
 
+bool can_dropped_invalid_tx_frame(struct net_device *dev, struct sk_buff *skb)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return true;
+
+	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+		netdev_info_once(dev,
+				 "interface in listen only mode, dropping skb\n");
+		kfree_skb(skb);
+		dev->stats.tx_dropped++;
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(can_dropped_invalid_tx_frame);
+
 MODULE_ALIAS_RTNL_LINK("can");
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 791a51e2f5d6..ec8ecd6e418b 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/can/dev.h>
-#include <linux/can/netlink.h>
 #include <linux/module.h>
 
 #define MOD_DESC "CAN device driver interface"
@@ -337,8 +336,6 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 {
-	struct can_priv *priv = netdev_priv(dev);
-
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_CAN:
 		if (!can_is_can_skb(skb))
@@ -361,10 +358,6 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 
 	if (!can_skb_headroom_valid(dev, skb)) {
 		goto inval_skb;
-	} else if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
-		netdev_info_once(dev,
-				 "interface in listen only mode, dropping skb\n");
-		goto inval_skb;
 	}
 
 	return false;
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 5ee38e586fd8..15b4d9e4f92e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -742,7 +742,7 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *de
 	u32 ctrl = FLEXCAN_MB_CODE_TX_DATA | ((can_fd_len2dlc(cfd->len)) << 16);
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 6c37aab93eb3..b72f91cac4ff 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1345,7 +1345,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	unsigned long flags;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	/* Trying to transmit in silent mode will generate error interrupts, but
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 8d42b7e6661f..3468cab98b09 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -860,7 +860,7 @@ static netdev_tx_t ifi_canfd_start_xmit(struct sk_buff *skb,
 	u32 txst, txid, txdlc;
 	int i;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	/* Check if the TX buffer is full */
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 71a2caae0757..9295535924fe 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1693,7 +1693,7 @@ static netdev_tx_t ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	void __iomem *desc_addr;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	spin_lock_irqsave(&mod->lock, flags);
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4e9680c8eb34..bd34d208a2af 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -772,7 +772,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	int nwords;
 	u8 count;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	nwords = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index dcb582563d5e..8de2b4759ec1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1721,7 +1721,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	if (cdev->is_peripheral) {
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 2119fbb287ef..0d028ff30058 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -191,7 +191,7 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int i, rtr, buf_id;
 	u32 can_id;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	out_8(&regs->cantier, 0);
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 0558ff67ec6a..6cbead54426d 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -882,7 +882,7 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 	int i;
 	u32 id2;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	tx_obj_no = priv->tx_obj;
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index f8420cc1d907..2a15dfc82eba 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -651,7 +651,7 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 	int room_left;
 	u8 len;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	msg_size = ALIGN(sizeof(*msg) + cf->len, 4);
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 6ee968c59ac9..74684021b0e0 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -590,7 +590,7 @@ static netdev_tx_t rcar_can_start_xmit(struct sk_buff *skb,
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 data, i;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (cf->can_id & CAN_EFF_FLAG)	/* Extended frame format */
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 567620d215f8..7773c5296a0a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1483,7 +1483,7 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 	unsigned long flags;
 	u32 ch = priv->channel;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (cf->can_id & CAN_EFF_FLAG) {
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 1bb1129b0450..9a6a8fce3665 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -291,7 +291,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	u8 cmd_reg_val = 0x00;
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 8d13fdf8c28a..eb6eb4b60d18 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -594,7 +594,7 @@ static netdev_tx_t slcan_netdev_xmit(struct sk_buff *skb,
 {
 	struct slcan *sl = netdev_priv(dev);
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	spin_lock(&sl->lock);
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index a5ef57f415f7..d77c9b1dc5a1 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -60,7 +60,7 @@ static netdev_tx_t softing_netdev_start_xmit(struct sk_buff *skb,
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	uint8_t buf[DPRAM_TX_SIZE];
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	spin_lock(&card->spin);
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index b87dc420428d..1abf9decb8d9 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -373,7 +373,7 @@ static netdev_tx_t hi3110_hard_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
-	if (can_dropped_invalid_skb(net, skb))
+	if (can_dropped_invalid_tx_frame(net, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(net);
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index c320de474f40..18e6c5746571 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -789,7 +789,7 @@ static netdev_tx_t mcp251x_hard_start_xmit(struct sk_buff *skb,
 		return NETDEV_TX_BUSY;
 	}
 
-	if (can_dropped_invalid_skb(net, skb))
+	if (can_dropped_invalid_tx_frame(net, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(net);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index ffb6c36b7d9b..0b943e9e426c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -172,7 +172,7 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	u8 tx_head;
 	int err;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (mcp251xfd_tx_busy(priv, tx_ring))
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 525309da1320..6ba09308a0d7 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -429,7 +429,7 @@ static netdev_tx_t sun4ican_start_xmit(struct sk_buff *skb, struct net_device *d
 	canid_t id;
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dropped_invalid_tx_frame(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index b218fb3c6b76..020d0958a0bc 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -470,7 +470,7 @@ static netdev_tx_t ti_hecc_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u32 mbxno, mbx_mask, data;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	mbxno = get_tx_head_mb(priv);
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index d31191686a54..ea838a87af20 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -747,7 +747,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	size_t size = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN
 			+ sizeof(struct cpc_can_msg);
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* create a URB, and a buffer for it, and copy the data to the URB */
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 1bcfad11b1e4..ea02107a7aa2 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -725,7 +725,7 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	int ret = NETDEV_TX_OK;
 	size_t size = sizeof(struct esd_usb_msg);
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* create a URB, and a buffer for it, and copy the data to the URB */
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 51294b717040..16e4905e811f 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1913,7 +1913,7 @@ static netdev_tx_t es58x_start_xmit(struct sk_buff *skb,
 	unsigned int frame_len;
 	int ret;
 
-	if (can_dropped_invalid_skb(netdev, skb)) {
+	if (can_dropped_invalid_tx_frame(netdev, skb)) {
 		if (priv->tx_urb)
 			goto xmit_commit;
 		return NETDEV_TX_OK;
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index f0065d40eb24..2f42aa5d610c 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -723,7 +723,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	unsigned int idx;
 	struct gs_tx_context *txc;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* find an empty context to keep track of transmission */
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index e91648ed7386..9fbaff8e60a8 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -570,7 +570,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	unsigned int i;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 69346c63021f..79756578c359 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -311,7 +311,7 @@ static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
 		.cmd_id = MBCA_CMD_TRANSMIT_MESSAGE_EV
 	};
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	ctx = mcba_usb_get_free_ctx(priv, cf);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 225697d70a9a..231b3cee2611 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -351,7 +351,7 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 	int i, err;
 	size_t size = dev->adapter->tx_buffer_size;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	for (i = 0; i < PCAN_USB_MAX_TX_URBS; i++)
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 7c35f50fda4e..51516d6cf4cc 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1120,7 +1120,7 @@ static netdev_tx_t ucan_start_xmit(struct sk_buff *skb,
 	struct can_frame *cf = (struct can_frame *)skb->data;
 
 	/* check skb */
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* allocate a context and slow down tx path, if fifo state is low */
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 64c00abe91cf..c45ed17c3e25 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -602,7 +602,7 @@ static netdev_tx_t usb_8dev_start_xmit(struct sk_buff *skb,
 	int i, err;
 	size_t size = sizeof(struct usb_8dev_tx_msg);
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dropped_invalid_tx_frame(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* create a URB, and a buffer for it, and copy the data to the URB */
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 5d3172795ad0..5b6c010f910b 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -743,7 +743,7 @@ static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dropped_invalid_tx_frame(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES)
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 58f5431a5559..18a48e081743 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -192,4 +192,6 @@ extern struct rtnl_link_ops can_link_ops;
 int can_netlink_register(void);
 void can_netlink_unregister(void);
 
+bool can_dropped_invalid_tx_frame(struct net_device *dev, struct sk_buff *skb);
+
 #endif /* !_CAN_DEV_H */
-- 
2.25.1

