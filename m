Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68620D0BBD
	for <lists+linux-can@lfdr.de>; Wed,  9 Oct 2019 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfJIJsx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Oct 2019 05:48:53 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:34631 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIJsx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Oct 2019 05:48:53 -0400
X-ASG-Debug-ID: 1570614526-0a7b8d13bf1a17d0003-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.105.74.adsl.dyn.edpnet.net [77.109.105.74]) by relay-b02.edpnet.be with ESMTP id tWXNmbbLdEJXeS1w for <linux-can@vger.kernel.org>; Wed, 09 Oct 2019 11:48:49 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Apparent-Source-IP: 77.109.105.74
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [192.168.0.36])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 8A6D4A4C928;
        Wed,  9 Oct 2019 11:48:49 +0200 (CEST)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 3/3] can: c_can: use rx-offload for echo skb too
Date:   Wed,  9 Oct 2019 11:48:35 +0200
X-ASG-Orig-Subj: [PATCH 3/3] can: c_can: use rx-offload for echo skb too
Message-Id: <1570614515-14765-4-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <20191009074338.GA23530@x1.vandijck-laurijssen.be>
 <1570614515-14765-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.105.74.adsl.dyn.edpnet.net[77.109.105.74]
X-Barracuda-Start-Time: 1570614529
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1800
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9846 1.0000 4.1651
X-Barracuda-Spam-Score: 4.17
X-Barracuda-Spam-Status: No, SCORE=4.17 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.77241
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 8 +++++---
 drivers/net/can/c_can/c_can.h | 1 -
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 8f68d51..0455de1 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -480,7 +480,6 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	 * transmit as we might race against do_tx().
 	 */
 	c_can_setup_tx_object(dev, IF_TX, frame, idx);
-	priv->dlc[idx] = frame->can_dlc;
 	can_put_echo_skb(skb, dev, idx);
 
 	/* Update the active bits */
@@ -705,6 +704,8 @@ static void c_can_do_tx(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	u32 idx, obj, pkts = 0, bytes = 0, pend, clr;
+	struct sk_buff *skb;
+	u8 len;
 
 	clr = pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
 
@@ -713,8 +714,9 @@ static void c_can_do_tx(struct net_device *dev)
 		pend &= ~(1 << idx);
 		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
 		c_can_inval_tx_object(dev, IF_RX, obj);
-		can_get_echo_skb(dev, idx);
-		bytes += priv->dlc[idx];
+		skb = __can_get_echo_skb(dev, idx, &len);
+		can_rx_offload_irq_receive_skb(&priv->offload, skb);
+		bytes += len;
 		pkts++;
 	}
 
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 770e944..ebe0676 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -214,7 +214,6 @@ struct c_can_priv {
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
 	u32 comm_rcv_high;
 	u32 rxmasked;
-	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
 };
 
 struct net_device *alloc_c_can_dev(void);
-- 
1.8.5.rc3

