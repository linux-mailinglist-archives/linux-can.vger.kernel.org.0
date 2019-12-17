Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 617EF122B30
	for <lists+linux-can@lfdr.de>; Tue, 17 Dec 2019 13:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfLQMR3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Dec 2019 07:17:29 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:35104 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfLQMR3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2019 07:17:29 -0500
X-ASG-Debug-ID: 1576585041-0a7ff5137c1cdc3e0002-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.154.static.edpnet.net [77.109.77.154]) by relay-b01.edpnet.be with ESMTP id ALymP124dSwibGZL; Tue, 17 Dec 2019 13:17:21 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Apparent-Source-IP: 77.109.77.154
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B572DBCD905;
        Tue, 17 Dec 2019 13:17:21 +0100 (CET)
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Cc:     Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>,
        Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: [PATCH 10/10] can: c_can: configurable amount of D_CAN RX objects
Date:   Tue, 17 Dec 2019 13:16:34 +0100
X-ASG-Orig-Subj: [PATCH 10/10] can: c_can: configurable amount of D_CAN RX objects
Message-Id: <1576584994-15873-11-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Mailer: git-send-email 1.8.5.rc3
In-Reply-To: <1576584994-15873-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
References: <1576584994-15873-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
X-Barracuda-Connect: 77.109.77.154.static.edpnet.net[77.109.77.154]
X-Barracuda-Start-Time: 1576585041
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 6643
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3425
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.78715
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>

Make number of D_CAN RX message objects configurable. This will allow
having bigger (or smaller) RX buffer instead of 50/50 split for RX/TX.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@netmodule.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
---
 drivers/net/can/c_can/Kconfig |  8 ++++++
 drivers/net/can/c_can/c_can.c | 64 +++++++++++++++++++++++++++++--------------
 drivers/net/can/c_can/c_can.h | 16 +++++------
 3 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/c_can/Kconfig b/drivers/net/can/c_can/Kconfig
index 47b2587..9468ceb 100644
--- a/drivers/net/can/c_can/Kconfig
+++ b/drivers/net/can/c_can/Kconfig
@@ -33,4 +33,12 @@ config CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	  Enabling this option extends max D_CAN message objects up to
 	  64.
 
+config CAN_C_CAN_DCAN_RX_MSG_OBJECTS
+	int "Specify amount of D_CAN RX message objects"
+	depends on CAN_C_CAN_DCAN_64_MSG_OBJECTS
+	default 32
+	---help---
+	  Use specific number of message objects for RX, instead of
+	  50/50 split between RX/TX.
+
 endif
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index a935199..6cf23e9 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -213,6 +213,26 @@ enum c_can_bus_error_types {
 	.brp_inc = 1,
 };
 
+static inline u64 c_can_get_mask(int bits)
+{
+	return ((u64)1 << bits) - 1;
+}
+
+static inline int c_can_ffs64(u64 x)
+{
+	int b;
+
+	b = ffs(x);
+
+	if (!b) {
+		b = ffs(x >> 32);
+		if (b)
+			b += 32;
+	}
+
+	return b;
+}
+
 static inline void c_can_pm_runtime_enable(const struct c_can_priv *priv)
 {
 	if (priv->device)
@@ -724,26 +744,25 @@ static void c_can_do_tx(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
-	u32 idx, obj, pkts = 0, bytes = 0, pend, clr;
+	u32 idx, obj, pkts = 0, bytes = 0;
+	u64 pend, clr;
 	struct sk_buff *skb;
 	u8 len;
 
+	/* Mask interrupt pending bits */
+	pend = priv->read_reg32(priv, C_CAN_INTPND1_REG);
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	if (priv->type == BOSCH_D_CAN) {
-		pend = priv->read_reg32(priv, C_CAN_INTPND3_REG);
-	} else {
-#endif
-		pend = priv->read_reg(priv, C_CAN_INTPND2_REG);
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
+		pend |= (u64)priv->read_reg32(priv, C_CAN_INTPND3_REG) << 32;
 	}
 #endif
-	clr = pend;
+	pend &= ~c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM);
+	clr = pend >> C_CAN_MSG_OBJ_RX_NUM;
 
-	while ((idx = ffs(pend))) {
-		idx--;
-		pend &= ~(1 << idx);
-		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+	while ((obj = c_can_ffs64(pend))) {
+		pend &= ~((u64)1 << (obj - 1));
 		c_can_inval_tx_object(dev, IF_RX, obj);
+		idx = obj - C_CAN_MSG_OBJ_TX_FIRST;
 		skb = __can_get_echo_skb(dev, idx, &len);
 		can_rx_offload_irq_receive_skb(&priv->offload, skb);
 		bytes += len;
@@ -768,19 +787,19 @@ static void c_can_do_tx(struct net_device *dev)
  * raced with the hardware or failed to readout all upper
  * objects in the last run due to quota limit.
  */
-static u32 c_can_adjust_pending(u32 pend)
+static u64 c_can_adjust_pending(u64 pend)
 {
-	u32 weight, lasts;
+	u64 weight, lasts;
 
-	if (pend == RECEIVE_OBJECT_BITS)
+	if (pend == c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM))
 		return pend;
 
 	/*
 	 * If the last set bit is larger than the number of pending
 	 * bits we have a gap.
 	 */
-	weight = hweight32(pend);
-	lasts = fls(pend);
+	weight = hweight64(pend);
+	lasts = fls64(pend);
 
 	/* If the bits are linear, nothing to do */
 	if (lasts == weight)
@@ -809,11 +828,11 @@ static inline void c_can_rx_finalize(struct net_device *dev,
 }
 
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
-			      u32 pend)
+			      u64 pend)
 {
 	u32 pkts = 0, ctrl, obj;
 
-	while ((obj = ffs(pend))) {
+	while ((obj = c_can_ffs64(pend))) {
 		pend &= ~BIT(obj - 1);
 
 		c_can_rx_object_get(dev, priv, obj);
@@ -845,13 +864,15 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 	return pkts;
 }
 
-static inline u32 c_can_get_pending(struct c_can_priv *priv)
+static inline u64 c_can_get_pending(struct c_can_priv *priv)
 {
-	u32 pend;
+	u64 pend;
 
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 	if (priv->type == BOSCH_D_CAN) {
 		pend = priv->read_reg32(priv, C_CAN_NEWDAT1_REG);
+		pend |= (u64)priv->read_reg32(priv, C_CAN_NEWDAT3_REG) << 32;
+		pend &= c_can_get_mask(C_CAN_MSG_OBJ_RX_NUM);
 	} else {
 #endif
 		pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
@@ -877,7 +898,8 @@ static inline u32 c_can_get_pending(struct c_can_priv *priv)
 static int c_can_do_rx_poll(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
-	u32 pkts = 0, pend = 0, toread, n;
+	u32 pkts = 0, n;
+	u64 pend = 0, toread;
 
 	for (;;) {
 		if (!pend) {
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 24128e7..8308edd 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -28,12 +28,12 @@
 
 #ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
 #define C_CAN_NO_OF_OBJECTS	64
+#define C_CAN_MSG_OBJ_RX_NUM	CONFIG_CAN_C_CAN_DCAN_RX_MSG_OBJECTS
 #else
 #define C_CAN_NO_OF_OBJECTS	32
+#define C_CAN_MSG_OBJ_RX_NUM	16
 #endif
-
-#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS >> 1)
-#define C_CAN_MSG_OBJ_RX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_TX_NUM)
+#define C_CAN_MSG_OBJ_TX_NUM	(C_CAN_NO_OF_OBJECTS - C_CAN_MSG_OBJ_RX_NUM)
 
 #define C_CAN_MSG_OBJ_RX_FIRST	1
 #define C_CAN_MSG_OBJ_RX_LAST	(C_CAN_MSG_OBJ_RX_FIRST + \
@@ -43,12 +43,6 @@
 #define C_CAN_MSG_OBJ_TX_LAST	(C_CAN_MSG_OBJ_TX_FIRST + \
 				C_CAN_MSG_OBJ_TX_NUM - 1)
 
-#ifdef CONFIG_CAN_C_CAN_DCAN_64_MSG_OBJECTS
-#define RECEIVE_OBJECT_BITS	0xffffffff
-#else
-#define RECEIVE_OBJECT_BITS	0x0000ffff
-#endif
-
 enum reg {
 	C_CAN_CTRL_REG = 0,
 	C_CAN_CTRL_EX_REG,
@@ -84,6 +78,8 @@ enum reg {
 	C_CAN_TXRQST2_REG,
 	C_CAN_NEWDAT1_REG,
 	C_CAN_NEWDAT2_REG,
+	C_CAN_NEWDAT3_REG,
+	C_CAN_NEWDAT4_REG,
 	C_CAN_INTPND1_REG,
 	C_CAN_INTPND2_REG,
 	C_CAN_INTPND3_REG,
@@ -147,6 +143,8 @@ enum reg {
 	[C_CAN_TXRQST2_REG]	= 0x8A,
 	[C_CAN_NEWDAT1_REG]	= 0x9C,
 	[C_CAN_NEWDAT2_REG]	= 0x9E,
+	[C_CAN_NEWDAT3_REG]	= 0xA0,
+	[C_CAN_NEWDAT4_REG]	= 0xA2,
 	[C_CAN_INTPND1_REG]	= 0xB0,
 	[C_CAN_INTPND2_REG]	= 0xB2,
 	[C_CAN_INTPND3_REG]	= 0xB4,
-- 
1.8.5.rc3

