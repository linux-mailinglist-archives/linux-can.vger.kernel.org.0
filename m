Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F026127899
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 10:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLTJ4h (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 20 Dec 2019 04:56:37 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:52129 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfLTJ4g (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 04:56:36 -0500
X-ASG-Debug-ID: 1576835793-0a7ff5137b1f76600001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b01.edpnet.be with ESMTP id BDmf2ZMYu636agKk for <linux-can@vger.kernel.org>; Fri, 20 Dec 2019 10:56:33 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id E6E36BD9C08;
        Fri, 20 Dec 2019 10:56:32 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 07/11] can: c_can: remove quota during isr
Date:   Fri, 20 Dec 2019 10:55:23 +0100
X-ASG-Orig-Subj: [PATCH 07/11] can: c_can: remove quota during isr
Message-Id: <1576835727-2956-8-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576835727-2956-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576835793
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2634
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8557 1.0000 2.7648
X-Barracuda-Spam-Score: 2.76
X-Barracuda-Spam-Status: No, SCORE=2.76 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78781
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The quota are heritage of using NAPI. The rx-offload FIFO in front
of the NAPI handler obsoleted the quota.

Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/c_can.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index dc44d90..cf2d47e 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -809,11 +809,11 @@ static inline void c_can_rx_finalize(struct net_device *dev,
 }
 
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
-			      u32 pend, int quota)
+			      u32 pend)
 {
 	u32 pkts = 0, ctrl, obj;
 
-	while ((obj = ffs(pend)) && quota > 0) {
+	while ((obj = ffs(pend))) {
 		pend &= ~BIT(obj - 1);
 
 		c_can_rx_object_get(dev, priv, obj);
@@ -823,7 +823,6 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 			int n = c_can_handle_lost_msg_obj(dev, IF_RX, obj, ctrl);
 
 			pkts += n;
-			quota -= n;
 			continue;
 		}
 
@@ -841,7 +840,6 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 		c_can_rx_finalize(dev, priv, obj);
 
 		pkts++;
-		quota--;
 	}
 
 	return pkts;
@@ -867,7 +865,7 @@ static inline u32 c_can_get_pending(struct c_can_priv *priv)
  *
  * This can result in packet reordering when the readout is slow.
  */
-static int c_can_do_rx_poll(struct net_device *dev, int quota)
+static int c_can_do_rx_poll(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 	u32 pkts = 0, pend = 0, toread, n;
@@ -879,7 +877,7 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
 			"Implementation does not support more message objects than 16");
 
-	while (quota > 0) {
+	for (;;) {
 		if (!pend) {
 			pend = c_can_get_pending(priv);
 			if (!pend)
@@ -895,9 +893,8 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 		/* Remove the bits from pend */
 		pend &= ~toread;
 		/* Read the objects */
-		n = c_can_read_objects(dev, priv, toread, quota);
+		n = c_can_read_objects(dev, priv, toread);
 		pkts += n;
-		quota -= n;
 	}
 
 	if (pkts)
@@ -1126,7 +1123,7 @@ static irqreturn_t c_can_isr(int irq, void *dev_id)
 	work_done += c_can_handle_bus_err(dev, curr & LEC_MASK);
 
 	/* Handle Tx/Rx events. We do this unconditionally */
-	work_done += c_can_do_rx_poll(dev, C_CAN_MSG_OBJ_RX_NUM);
+	work_done += c_can_do_rx_poll(dev);
 	c_can_do_tx(dev);
 
 end:
-- 
1.8.5.rc3

