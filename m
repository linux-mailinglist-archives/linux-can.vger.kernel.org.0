Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE64616043
	for <lists+linux-can@lfdr.de>; Wed,  2 Nov 2022 10:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKBJyw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Nov 2022 05:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBJyv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2022 05:54:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B313B2228A
        for <linux-can@vger.kernel.org>; Wed,  2 Nov 2022 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667382884;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=61zDzh73iSrUhz+0g4HylioHc9zxG90fZuJ28t6T+Ig=;
    b=tb054eZZC9OPPjsAsWN+OeyvclW0A9gmtgy38QkHAGWEp/4VJImz7AnrvRXpOPp6ja
    4UppXq1yr//aMOlTzJnrRRouH7q+99qRgTbyUpKfmLYza2qd4ONhMKuPTwsakYvoZaUJ
    riVpfrJTNsNWYJTc8e2Xku5SR70wa4Fq2cZLzrval+4oQxW31cVOLqG1Tg9x3/5njj9H
    P+wTrGSnM0gK8P77hYtxVwd6wwtU2q93mLcWBHA6GupHLNevyyS4/A99A1CfUKmt+1LG
    ku9hGDd3BibWo39Qyf5FIqXJpWJ7VymgcaL35lYhZAciSxCOR8XP3Qrme1vnvJz7MGg5
    UNvw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9JiLceSWJaYxMWqfZ"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yA29siIkh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Nov 2022 10:54:44 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Max Staudt <max@enpas.org>
Subject: [PATCH] can: dev: fix skb drop check
Date:   Wed,  2 Nov 2022 10:54:31 +0100
Message-Id: <20221102095431.36831-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In commit a6d190f8c767 ("can: skb: drop tx skb if in listen only mode") the
priv->ctrlmode element is read even on virtual CAN interfaces that do not
create the struct can_priv at startup. This out-of-bounds read may lead to
CAN frame drops for virtual CAN interfaces like vcan and vxcan.

This patch mainly reverts the original commit and adds a new helper for CAN
interface drivers that provide the required information in struct can_priv.

Fixes: a6d190f8c767 ("can: skb: drop tx skb if in listen only mode")
Reported-by: Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Max Staudt <max@enpas.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/at91_can.c                       |  2 +-
 drivers/net/can/c_can/c_can_main.c               |  2 +-
 drivers/net/can/can327.c                         |  2 +-
 drivers/net/can/cc770/cc770.c                    |  2 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c         |  2 +-
 drivers/net/can/dev/skb.c                        | 10 +---------
 drivers/net/can/flexcan/flexcan-core.c           |  2 +-
 drivers/net/can/grcan.c                          |  2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c            |  2 +-
 drivers/net/can/janz-ican3.c                     |  2 +-
 drivers/net/can/kvaser_pciefd.c                  |  2 +-
 drivers/net/can/m_can/m_can.c                    |  2 +-
 drivers/net/can/mscan/mscan.c                    |  2 +-
 drivers/net/can/peak_canfd/peak_canfd.c          |  2 +-
 drivers/net/can/rcar/rcar_can.c                  |  2 +-
 drivers/net/can/rcar/rcar_canfd.c                |  2 +-
 drivers/net/can/sja1000/sja1000.c                |  2 +-
 drivers/net/can/slcan/slcan-core.c               |  2 +-
 drivers/net/can/softing/softing_main.c           |  2 +-
 drivers/net/can/spi/hi311x.c                     |  2 +-
 drivers/net/can/spi/mcp251x.c                    |  2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c     |  2 +-
 drivers/net/can/sun4i_can.c                      |  2 +-
 drivers/net/can/ti_hecc.c                        |  2 +-
 drivers/net/can/usb/ems_usb.c                    |  2 +-
 drivers/net/can/usb/esd_usb.c                    |  2 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c      |  2 +-
 drivers/net/can/usb/gs_usb.c                     |  2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |  2 +-
 drivers/net/can/usb/mcba_usb.c                   |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c     |  2 +-
 drivers/net/can/usb/ucan.c                       |  2 +-
 drivers/net/can/usb/usb_8dev.c                   |  2 +-
 drivers/net/can/xilinx_can.c                     |  2 +-
 include/linux/can/dev.h                          | 16 ++++++++++++++++
 35 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 3a2d109a3792..199cb200f2bd 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -450,11 +450,11 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct at91_priv *priv = netdev_priv(dev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	unsigned int mb, prio;
 	u32 reg_mid, reg_mcr;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	mb = get_tx_next_mb(priv);
 	prio = get_tx_next_prio(priv);
 
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index d6605dbb7737..c63f7fc1e691 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -455,11 +455,11 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	struct can_frame *frame = (struct can_frame *)skb->data;
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct c_can_tx_ring *tx_ring = &priv->tx;
 	u32 idx, obj, cmd = IF_COMM_TX;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	if (c_can_tx_busy(priv, tx_ring))
 		return NETDEV_TX_BUSY;
 
diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 0aa1af31d0fe..094197780776 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -811,11 +811,11 @@ static netdev_tx_t can327_netdev_start_xmit(struct sk_buff *skb,
 					    struct net_device *dev)
 {
 	struct can327 *elm = netdev_priv(dev);
 	struct can_frame *frame = (struct can_frame *)skb->data;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	/* We shouldn't get here after a hardware fault:
 	 * can_bus_off() calls netif_carrier_off()
 	 */
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 0b9dfc76e769..30909f3aab57 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -427,11 +427,11 @@ static void cc770_tx(struct net_device *dev, int mo)
 static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
 	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
 
 	if ((cc770_read_reg(priv,
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index b8da15ea6ad9..64c349fd4600 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -598,11 +598,11 @@ static netdev_tx_t ctucan_start_xmit(struct sk_buff *skb, struct net_device *nde
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u32 txtb_id;
 	bool ok;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (unlikely(!CTU_CAN_FD_TXTNF(priv))) {
 		netif_stop_queue(ndev);
 		netdev_err(ndev, "BUG!, no TXB free when queue awake!\n");
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 791a51e2f5d6..241ec636e91f 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -3,11 +3,10 @@
  * Copyright (C) 2006 Andrey Volkov, Varma Electronics
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
 #include <linux/can/dev.h>
-#include <linux/can/netlink.h>
 #include <linux/module.h>
 
 #define MOD_DESC "CAN device driver interface"
 
 MODULE_DESCRIPTION(MOD_DESC);
@@ -335,12 +334,10 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 }
 
 /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 {
-	struct can_priv *priv = netdev_priv(dev);
-
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_CAN:
 		if (!can_is_can_skb(skb))
 			goto inval_skb;
 		break;
@@ -357,17 +354,12 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 
 	default:
 		goto inval_skb;
 	}
 
-	if (!can_skb_headroom_valid(dev, skb)) {
+	if (!can_skb_headroom_valid(dev, skb))
 		goto inval_skb;
-	} else if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
-		netdev_info_once(dev,
-				 "interface in listen only mode, dropping skb\n");
-		goto inval_skb;
-	}
 
 	return false;
 
 inval_skb:
 	kfree_skb(skb);
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 5ee38e586fd8..9bdadd716f4e 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -740,11 +740,11 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *de
 	u32 can_id;
 	u32 data;
 	u32 ctrl = FLEXCAN_MB_CODE_TX_DATA | ((can_fd_len2dlc(cfd->len)) << 16);
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
 
 	if (cfd->can_id & CAN_EFF_FLAG) {
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 6c37aab93eb3..4bedcc3eea0d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1343,11 +1343,11 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	u32 i, rtr, eff, dlc, tmp, err;
 	int j, shift;
 	unsigned long flags;
 	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	/* Trying to transmit in silent mode will generate error interrupts, but
 	 * this should never happen - the queue should not have been started.
 	 */
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 8d42b7e6661f..07eaf724a572 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -858,11 +858,11 @@ static netdev_tx_t ifi_canfd_start_xmit(struct sk_buff *skb,
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u32 txst, txid, txdlc;
 	int i;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	/* Check if the TX buffer is full */
 	txst = readl(priv->base + IFI_CANFD_TXSTCMD);
 	if (txst & IFI_CANFD_TXSTCMD_FULL) {
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 71a2caae0757..0732a5092141 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1691,11 +1691,11 @@ static netdev_tx_t ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	struct ican3_fast_desc desc;
 	void __iomem *desc_addr;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	spin_lock_irqsave(&mod->lock, flags);
 
 	/* check that we can actually transmit */
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 4e9680c8eb34..bcad11709bc9 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -770,11 +770,11 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	unsigned long irq_flags;
 	struct kvaser_pciefd_tx_packet packet;
 	int nwords;
 	u8 count;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	nwords = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
 
 	spin_lock_irqsave(&can->echo_lock, irq_flags);
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 59deb185fd6b..944529590ffe 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1729,11 +1729,11 @@ static void m_can_tx_work_queue(struct work_struct *ws)
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	if (cdev->is_peripheral) {
 		if (cdev->tx_skb) {
 			netdev_err(dev, "hard_xmit called while tx busy\n");
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 2119fbb287ef..a6829cdc0e81 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -189,11 +189,11 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 	int i, rtr, buf_id;
 	u32 can_id;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	out_8(&regs->cantier, 0);
 
 	i = ~priv->tx_active & MSCAN_TXE;
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index f8420cc1d907..31c9c127e24b 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -649,11 +649,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 	unsigned long flags;
 	bool should_stop_tx_queue;
 	int room_left;
 	u8 len;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	msg_size = ALIGN(sizeof(*msg) + cf->len, 4);
 	msg = priv->alloc_tx_msg(priv, msg_size, &room_left);
 
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 6ee968c59ac9..cc43c9c5e38c 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -588,11 +588,11 @@ static netdev_tx_t rcar_can_start_xmit(struct sk_buff *skb,
 {
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 data, i;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (cf->can_id & CAN_EFF_FLAG)	/* Extended frame format */
 		data = (cf->can_id & CAN_EFF_MASK) | RCAR_CAN_IDE;
 	else				/* Standard frame format */
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a0dd6044830b..a83d48eba205 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1479,11 +1479,11 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u32 sts = 0, id, dlc;
 	unsigned long flags;
 	u32 ch = priv->channel;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (cf->can_id & CAN_EFF_FLAG) {
 		id = cf->can_id & CAN_EFF_MASK;
 		id |= RCANFD_CFID_CFIDE;
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 1bb1129b0450..aac5956e4a53 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -289,11 +289,11 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	canid_t id;
 	uint8_t dreg;
 	u8 cmd_reg_val = 0x00;
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
 
 	fi = can_get_cc_dlc(cf, priv->can.ctrlmode);
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 8d13fdf8c28a..fbb34139daa1 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -592,11 +592,11 @@ static void slcan_write_wakeup(struct tty_struct *tty)
 static netdev_tx_t slcan_netdev_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
 {
 	struct slcan *sl = netdev_priv(dev);
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	spin_lock(&sl->lock);
 	if (!netif_running(dev))  {
 		spin_unlock(&sl->lock);
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index a5ef57f415f7..c72f505d29fe 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -58,11 +58,11 @@ static netdev_tx_t softing_netdev_start_xmit(struct sk_buff *skb,
 	uint8_t *ptr;
 	uint8_t fifo_wr, fifo_rd;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	uint8_t buf[DPRAM_TX_SIZE];
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	spin_lock(&card->spin);
 
 	ret = NETDEV_TX_BUSY;
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index b87dc420428d..e1b8533a602e 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -371,11 +371,11 @@ static netdev_tx_t hi3110_hard_start_xmit(struct sk_buff *skb,
 	if (priv->tx_skb || priv->tx_busy) {
 		dev_err(&spi->dev, "hard_xmit called while tx busy\n");
 		return NETDEV_TX_BUSY;
 	}
 
-	if (can_dropped_invalid_skb(net, skb))
+	if (can_dev_dropped_skb(net, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(net);
 	priv->tx_skb = skb;
 	queue_work(priv->wq, &priv->tx_work);
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 24883a65ca66..79c4bab5f724 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -787,11 +787,11 @@ static netdev_tx_t mcp251x_hard_start_xmit(struct sk_buff *skb,
 	if (priv->tx_skb || priv->tx_busy) {
 		dev_warn(&spi->dev, "hard_xmit called while tx busy\n");
 		return NETDEV_TX_BUSY;
 	}
 
-	if (can_dropped_invalid_skb(net, skb))
+	if (can_dev_dropped_skb(net, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(net);
 	priv->tx_skb = skb;
 	queue_work(priv->wq, &priv->tx_work);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
index ffb6c36b7d9b..160528d3cc26 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c
@@ -170,11 +170,11 @@ netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	struct mcp251xfd_tx_obj *tx_obj;
 	unsigned int frame_len;
 	u8 tx_head;
 	int err;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (mcp251xfd_tx_busy(priv, tx_ring))
 		return NETDEV_TX_BUSY;
 
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 525309da1320..2b78f9197681 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -427,11 +427,11 @@ static netdev_tx_t sun4ican_start_xmit(struct sk_buff *skb, struct net_device *d
 	u8 dlc;
 	u32 dreg, msg_flag_n;
 	canid_t id;
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
+	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
 	netif_stop_queue(dev);
 
 	id = cf->can_id;
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index b218fb3c6b76..27700f72eac2 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -468,11 +468,11 @@ static netdev_tx_t ti_hecc_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct ti_hecc_priv *priv = netdev_priv(ndev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 mbxno, mbx_mask, data;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	mbxno = get_tx_head_mb(priv);
 	mbx_mask = BIT(mbxno);
 	spin_lock_irqsave(&priv->mbx_lock, flags);
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index d31191686a54..050c0b49938a 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -745,11 +745,11 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	u8 *buf;
 	int i, err;
 	size_t size = CPC_HEADER_SIZE + CPC_MSG_HEADER_LEN
 			+ sizeof(struct cpc_can_msg);
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* create a URB, and a buffer for it, and copy the data to the URB */
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 1bcfad11b1e4..81b88e9e5bdc 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -723,11 +723,11 @@ static netdev_tx_t esd_usb_start_xmit(struct sk_buff *skb,
 	u8 *buf;
 	int i, err;
 	int ret = NETDEV_TX_OK;
 	size_t size = sizeof(struct esd_usb_msg);
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* create a URB, and a buffer for it, and copy the data to the URB */
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb) {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 51294b717040..25f863b4f5f0 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1911,11 +1911,11 @@ static netdev_tx_t es58x_start_xmit(struct sk_buff *skb,
 	struct es58x_priv *priv = es58x_priv(netdev);
 	struct es58x_device *es58x_dev = priv->es58x_dev;
 	unsigned int frame_len;
 	int ret;
 
-	if (can_dropped_invalid_skb(netdev, skb)) {
+	if (can_dev_dropped_skb(netdev, skb)) {
 		if (priv->tx_urb)
 			goto xmit_commit;
 		return NETDEV_TX_OK;
 	}
 
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ccb1a29835a2..838744d2ce34 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -726,11 +726,11 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	struct canfd_frame *cfd;
 	int rc;
 	unsigned int idx;
 	struct gs_tx_context *txc;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* find an empty context to keep track of transmission */
 	txc = gs_alloc_tx_context(dev);
 	if (!txc)
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 989e75351062..3a2bfaad1406 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -651,11 +651,11 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 	int cmd_len = 0;
 	int err, ret = NETDEV_TX_OK;
 	unsigned int i;
 	unsigned long flags;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb) {
 		stats->tx_dropped++;
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 69346c63021f..218b098b261d 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -309,11 +309,11 @@ static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
 	int err;
 	struct mcba_usb_msg_can usb_msg = {
 		.cmd_id = MBCA_CMD_TRANSMIT_MESSAGE_EV
 	};
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	ctx = mcba_usb_get_free_ctx(priv, cf);
 	if (!ctx)
 		return NETDEV_TX_BUSY;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 225697d70a9a..1d996d3320fe 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -349,11 +349,11 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 	struct urb *urb;
 	u8 *obuf;
 	int i, err;
 	size_t size = dev->adapter->tx_buffer_size;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	for (i = 0; i < PCAN_USB_MAX_TX_URBS; i++)
 		if (dev->tx_contexts[i].echo_index == PCAN_USB_MAX_TX_URBS) {
 			context = dev->tx_contexts + i;
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index a1734f1c0148..ffa38f533c35 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1119,11 +1119,11 @@ static netdev_tx_t ucan_start_xmit(struct sk_buff *skb,
 	struct ucan_urb_context *context;
 	struct ucan_priv *up = netdev_priv(netdev);
 	struct can_frame *cf = (struct can_frame *)skb->data;
 
 	/* check skb */
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* allocate a context and slow down tx path, if fifo state is low */
 	context = ucan_alloc_context(up);
 	echo_index = context - up->context_array;
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 64c00abe91cf..8a5596ce4e46 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -600,11 +600,11 @@ static netdev_tx_t usb_8dev_start_xmit(struct sk_buff *skb,
 	struct usb_8dev_tx_urb_context *context = NULL;
 	u8 *buf;
 	int i, err;
 	size_t size = sizeof(struct usb_8dev_tx_msg);
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* create a URB, and a buffer for it, and copy the data to the URB */
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 	if (!urb)
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 5d3172795ad0..43c812ea1de0 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -741,11 +741,11 @@ static int xcan_start_xmit_mailbox(struct sk_buff *skb, struct net_device *ndev)
 static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
 	int ret;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES)
 		ret = xcan_start_xmit_mailbox(skb, ndev);
 	else
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 58f5431a5559..982ba245eb41 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -150,10 +150,26 @@ static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 static inline bool can_is_canxl_dev_mtu(unsigned int mtu)
 {
 	return (mtu >= CANXL_MIN_MTU && mtu <= CANXL_MAX_MTU);
 }
 
+/* drop skb if it does not contain a valid CAN frame for sending */
+static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *skb)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+		netdev_info_once(dev,
+				 "interface in listen only mode, dropping skb\n");
+		kfree_skb(skb);
+		dev->stats.tx_dropped++;
+		return true;
+	}
+
+	return can_dropped_invalid_skb(dev, skb);
+}
+
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
-- 
2.30.2

