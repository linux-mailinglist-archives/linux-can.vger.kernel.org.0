Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 367A812302F
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfLQPXd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 10:23:33 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:43557 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbfLQPXc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 10:23:32 -0500
X-ASG-Debug-ID: 1576596209-0a7b8d6cde4fc060001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.adsl.dyn.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id 3c9qLANTh8v8mjTu; Tue, 17 Dec 2019 16:23:29 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 0B3D8BCDEB9;
        Tue, 17 Dec 2019 16:23:29 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>,
        Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 10/11] can: c_can: support 64 message objects for D_CAN
Date:   Tue, 17 Dec 2019 16:23:25 +0100
X-ASG-Orig-Subj: [PATCH 10/11] can: c_can: support 64 message objects for D_CAN
Message-Id: <1576596206-27260-3-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576596206-27260-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.adsl.dyn.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576596209
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 4580
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7246 1.0000 1.5611
X-Barracuda-Spam-Score: 2.06
X-Barracuda-Spam-Status: No, SCORE=2.06 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78718
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>

D_CAN supports up to 128 message objects, comparing to 32 on C_CAN.
However, some CPUs with D_CAN controller have their own limits:
TI AM335x Sitara CPU, for example, supports max of 64 message objects.

This patch extends max D_CAN message objects up to 64.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/Kconfig |  1 +
 drivers/net/can/c_can/c_can.c | 37 +++++++++++++++----------------------
 drivers/net/can/c_can/c_can.h |  4 ++++
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
index b0f206d3..9cd8523 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -21,4 +21,5 @@ config CAN_C_CAN_PCI
 	---help---
 	  This driver adds support for the C_CAN/D_CAN chips connected
 	  to the PCI bus.
+
 endif
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 4ff9e49..189a8d7 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -211,7 +211,7 @@ enum c_can_bus_error_types {
 
 static const int c_can_obj_counts[] = {
 	[BOSCH_C_CAN] = 32,
-	[BOSCH_D_CAN] = 32, /* the IP supports 128, we support only 32 */
+	[BOSCH_D_CAN] = 64, /* the IP supports 128, we support only 64 */
 };
 
 static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
@@ -358,16 +358,6 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 	}
 }
 
-static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
-						       int iface)
-{
-	struct c_can_priv *priv = netdev_priv(dev);
-	int i;
-
-	for (i = priv->obj.recv_frst; i <= priv->obj.recv_last; i++)
-		c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
-}
-
 static int c_can_handle_lost_msg_obj(struct net_device *dev,
 				     int iface, int objno, u32 ctrl)
 {
@@ -740,7 +730,12 @@ static void c_can_do_tx(struct net_device *dev)
 	struct sk_buff *skb;
 	u8 len;
 
-	clr = pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
+	if (priv->type == BOSCH_D_CAN) {
+		pend = priv->read_reg32(priv, C_CAN_INTPND3_REG);
+	} else {
+		pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
+	}
+	clr = pend;
 
 	while ((idx = ffs(pend))) {
 		idx--;
@@ -850,7 +845,13 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 
 static inline u32 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+	u32 pend;
+
+	if (priv->type == BOSCH_D_CAN) {
+		pend = priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+	} else {
+		pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+	}
 
 	return pend;
 }
@@ -861,8 +862,7 @@ static inline u32 c_can_get_pending(struct c_can_priv *priv)
  * c_can core saves a received CAN message into the first free message
  * object it finds free (starting with the lowest). Bits NEWDAT and
  * INTPND are set for this message object indicating that a new message
- * has arrived. To work-around this issue, we keep two groups of message
- * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
+ * has arrived.
  *
  * We clear the newdat bit right away.
  *
@@ -873,13 +873,6 @@ static int c_can_do_rx_poll(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 	u32 pkts = 0, pend = 0, toread, n;
 
-	/*
-	 * It is faster to read only one 16bit register. This is only possible
-	 * for a maximum number of 16 objects.
-	 */
-	WARN_ONCE(priv->obj.recv_last > 16,
-			"Implementation does not support more message objects than 16");
-
 	for (;;) {
 		if (!pend) {
 			pend = c_can_get_pending(priv);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 70e3dc5..0a426d9 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -61,6 +61,8 @@ enum reg {
 	C_CAN_NEWDAT2_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
+	C_CAN_INTPND3_REG,
+	C_CAN_INTPND4_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
 	C_CAN_FUNCTION_REG,
@@ -122,6 +124,8 @@ enum reg {
 	[C_CAN_NEWDAT2_REG]	= 0x9E,
 	[C_CAN_INTPND1_REG]	= 0xB0,
 	[C_CAN_INTPND2_REG]	= 0xB2,
+	[C_CAN_INTPND3_REG]	= 0xB4,
+	[C_CAN_INTPND4_REG]	= 0xB6,
 	[C_CAN_MSGVAL1_REG]	= 0xC4,
 	[C_CAN_MSGVAL2_REG]	= 0xC6,
 	[C_CAN_IF1_COMREQ_REG]	= 0x100,
-- 
1.8.5.rc3

