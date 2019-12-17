Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89300122D7A
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 14:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfLQNxU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 08:53:20 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:59169 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfLQNxT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 08:53:19 -0500
X-ASG-Debug-ID: 1576590794-0a7b8d6cde4ec0d0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.static.edpnet.net [77.109.77.154]) by relay-b02.edpnet.be with ESMTP id F0keOybnIllX56xj; Tue, 17 Dec 2019 14:53:14 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 84888BCDC08;
        Tue, 17 Dec 2019 14:53:14 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>,
        Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 09/11] can: c_can: support 64 message objects for D_CAN
Date:   Tue, 17 Dec 2019 14:53:04 +0100
X-ASG-Orig-Subj: [PATCH 09/11] can: c_can: support 64 message objects for D_CAN
Message-Id: <1576590786-22075-2-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576590786-22075-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <c0272077-c3c1-f106-ef51-fee546368ba6@pengutronix.de>
 <1576590786-22075-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576590794
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 5138
X-Barracuda-Bayes: SPAM GLOBAL 0.9115 1.0000 3.3493
X-Barracuda-Spam-Score: 3.85
X-Barracuda-Spam-Status: No, SCORE=3.85 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78717
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
 drivers/net/can/c_can/c_can.c | 34 ++++++++++++++--------------------
 drivers/net/can/c_can/c_can.h | 20 ++++++++++++++++----
 3 files changed, 31 insertions(+), 24 deletions(-)

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
index cf2d47e..848cc77 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -357,15 +357,6 @@ static void c_can_setup_tx_object(struct net_device *dev, int iface,
 	}
 }
 
-static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
-						       int iface)
-{
-	int i;
-
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_RX_LOW_LAST; i++)
-		c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
-}
-
 static int c_can_handle_lost_msg_obj(struct net_device *dev,
 				     int iface, int objno, u32 ctrl)
 {
@@ -737,7 +728,12 @@ static void c_can_do_tx(struct net_device *dev)
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
@@ -847,7 +843,13 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 
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
@@ -858,8 +860,7 @@ static inline u32 c_can_get_pending(struct c_can_priv *priv)
  * c_can core saves a received CAN message into the first free message
  * object it finds free (starting with the lowest). Bits NEWDAT and
  * INTPND are set for this message object indicating that a new message
- * has arrived. To work-around this issue, we keep two groups of message
- * objects whose partitioning is defined by C_CAN_MSG_OBJ_RX_SPLIT.
+ * has arrived.
  *
  * We clear the newdat bit right away.
  *
@@ -870,13 +871,6 @@ static int c_can_do_rx_poll(struct net_device *dev)
 	struct c_can_priv *priv = netdev_priv(dev);
 	u32 pkts = 0, pend = 0, toread, n;
 
-	/*
-	 * It is faster to read only one 16bit register. This is only possible
-	 * for a maximum number of 16 objects.
-	 */
-	BUILD_BUG_ON_MSG(C_CAN_MSG_OBJ_RX_LAST > 16,
-			"Implementation does not support more message objects than 16");
-
 	for (;;) {
 		if (!pend) {
 			pend = c_can_get_pending(priv);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 8387b3f..24128e7 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -25,9 +25,15 @@
 #include <linux/can/rx-offload.h>
 
 /* message object split */
+
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+#define C_CAN_NO_OF_OBJECTS	64
+#else
 #define C_CAN_NO_OF_OBJECTS	32
-#define C_CAN_MSG_OBJ_RX_NUM	16
-#define C_CAN_MSG_OBJ_TX_NUM	16
+#endif
+
+#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
+#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_NUM)
 
 #define C_CAN_MSG_OBJ_RX_FIRST	1
 #define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
@@ -37,9 +43,11 @@
 #define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
 				C_CAN_MSG_OBJ_TX_NUM - 1)
 
-#define C_CAN_MSG_OBJ_RX_SPLIT	9
-#define C_CAN_MSG_RX_LOW_LAST	(C_CAN_MSG_OBJ_RX_SPLIT - 1)
+#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+#define RECEIVE_OBJECT_BITS	0xffffffff
+#else
 #define RECEIVE_OBJECT_BITS	0x0000ffff
+#endif
 
 enum reg {
 	C_CAN_CTRL_REG = 0,
@@ -78,6 +86,8 @@ enum reg {
 	C_CAN_NEWDAT2_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
+	C_CAN_INTPND3_REG,
+	C_CAN_INTPND4_REG,
 	C_CAN_MSGVAL1_REG,
 	C_CAN_MSGVAL2_REG,
 	C_CAN_FUNCTION_REG,
@@ -139,6 +149,8 @@ enum reg {
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

