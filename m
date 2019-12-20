Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D17C127898
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 10:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLTJ4g (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Dec 2019 04:56:36 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:59997 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfLTJ4f (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 04:56:35 -0500
X-ASG-Debug-ID: 1576835790-0a7b8d6ce17621c0003-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id SGAojuLELvSe4tzy for <linux-can@vger.kernel.org>; Fri, 20 Dec 2019 10:56:33 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id C247CBD9C04;
        Fri, 20 Dec 2019 10:56:32 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 05/11] can: c_can: use rx-offload for echo skb
Date:   Fri, 20 Dec 2019 10:55:21 +0100
X-ASG-Orig-Subj: [PATCH 05/11] can: c_can: use rx-offload for echo skb
Message-Id: <1576835727-2956-6-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.wls.msr91gen3.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576835792
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1800
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5405 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78781
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
index 0357ee8..ee528d6 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -481,7 +481,6 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	 * transmit as we might race against do_tx().
 	 */
 	c_can_setup_tx_object(dev, IF_TX, frame, idx);
-	priv->dlc[idx] = frame->can_dlc;
 	can_put_echo_skb(skb, dev, idx);
 
 	/* Update the active bits */
@@ -731,6 +730,8 @@ static void c_can_do_tx(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	u32 idx, obj, pkts = 0, bytes = 0, pend, clr;
+	struct sk_buff *skb;
+	u8 len;
 
 	clr = pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
 
@@ -739,8 +740,9 @@ static void c_can_do_tx(struct net_device *dev)
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

