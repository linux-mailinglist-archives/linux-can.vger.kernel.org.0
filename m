Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CAD2F0260
	for <lists+linux-can@lfdr.de>; Sat,  9 Jan 2021 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbhAIRlo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 9 Jan 2021 12:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIRlo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 9 Jan 2021 12:41:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1FC0617A5
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 09:40:24 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyIDv-0004mb-0l
        for linux-can@vger.kernel.org; Sat, 09 Jan 2021 18:40:23 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E14BC5BE8C0
        for <linux-can@vger.kernel.org>; Sat,  9 Jan 2021 17:40:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 865F85BE89A;
        Sat,  9 Jan 2021 17:40:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ecb4f8b7;
        Sat, 9 Jan 2021 17:40:14 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 04/13] can: dev: move length related code into seperate file
Date:   Sat,  9 Jan 2021 18:40:04 +0100
Message-Id: <20210109174013.534145-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109174013.534145-1-mkl@pengutronix.de>
References: <20210109174013.534145-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch moves all CAN frame length related code of the CAN device
infrastructure into a separate file.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS                  |  1 +
 drivers/net/can/dev/Makefile |  1 +
 drivers/net/can/dev/dev.c    | 33 -----------------------
 drivers/net/can/dev/length.c | 40 ++++++++++++++++++++++++++++
 include/linux/can/dev.h      | 41 +----------------------------
 include/linux/can/length.h   | 51 ++++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 73 deletions(-)
 create mode 100644 drivers/net/can/dev/length.c
 create mode 100644 include/linux/can/length.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d17662df1cd7..21780c4e2e71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3946,6 +3946,7 @@ F:	drivers/net/can/
 F:	include/linux/can/bittiming.h
 F:	include/linux/can/dev.h
 F:	include/linux/can/led.h
+F:	include/linux/can/length.h
 F:	include/linux/can/platform/
 F:	include/linux/can/rx-offload.h
 F:	include/uapi/linux/can/error.h
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
index b5c6bb848d9d..5c647951e06d 100644
--- a/drivers/net/can/dev/Makefile
+++ b/drivers/net/can/dev/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_CAN_DEV)		+= can-dev.o
 can-dev-y			+= bittiming.o
 can-dev-y			+= dev.o
+can-dev-y			+= length.o
 can-dev-y			+= rx-offload.o
 
 can-dev-$(CONFIG_CAN_LEDS)	+= led.o
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 1b3ab95b3fd1..3372e99d5db7 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -25,39 +25,6 @@ MODULE_DESCRIPTION(MOD_DESC);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 
-/* CAN DLC to real data length conversion helpers */
-
-static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
-			     8, 12, 16, 20, 24, 32, 48, 64};
-
-/* get data length from raw data length code (DLC) */
-u8 can_fd_dlc2len(u8 dlc)
-{
-	return dlc2len[dlc & 0x0F];
-}
-EXPORT_SYMBOL_GPL(can_fd_dlc2len);
-
-static const u8 len2dlc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
-			     9, 9, 9, 9,			/* 9 - 12 */
-			     10, 10, 10, 10,			/* 13 - 16 */
-			     11, 11, 11, 11,			/* 17 - 20 */
-			     12, 12, 12, 12,			/* 21 - 24 */
-			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
-			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
-			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
-			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
-			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
-
-/* map the sanitized data length to an appropriate data length code */
-u8 can_fd_len2dlc(u8 len)
-{
-	if (unlikely(len > 64))
-		return 0xF;
-
-	return len2dlc[len];
-}
-EXPORT_SYMBOL_GPL(can_fd_len2dlc);
-
 static void can_update_state_error_stats(struct net_device *dev,
 					 enum can_state new_state)
 {
diff --git a/drivers/net/can/dev/length.c b/drivers/net/can/dev/length.c
new file mode 100644
index 000000000000..540d40dc0bc2
--- /dev/null
+++ b/drivers/net/can/dev/length.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
+ * Copyright (C) 2006 Andrey Volkov, Varma Electronics
+ * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
+ */
+
+#include <linux/can/dev.h>
+
+/* CAN DLC to real data length conversion helpers */
+
+static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
+			     8, 12, 16, 20, 24, 32, 48, 64};
+
+/* get data length from raw data length code (DLC) */
+u8 can_fd_dlc2len(u8 dlc)
+{
+	return dlc2len[dlc & 0x0F];
+}
+EXPORT_SYMBOL_GPL(can_fd_dlc2len);
+
+static const u8 len2dlc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
+			     9, 9, 9, 9,			/* 9 - 12 */
+			     10, 10, 10, 10,			/* 13 - 16 */
+			     11, 11, 11, 11,			/* 17 - 20 */
+			     12, 12, 12, 12,			/* 21 - 24 */
+			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
+			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
+			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
+			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
+			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
+
+/* map the sanitized data length to an appropriate data length code */
+u8 can_fd_len2dlc(u8 len)
+{
+	if (unlikely(len > 64))
+		return 0xF;
+
+	return len2dlc[len];
+}
+EXPORT_SYMBOL_GPL(can_fd_len2dlc);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 054c3bed190b..d75fba1d030a 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -18,6 +18,7 @@
 #include <linux/can/bittiming.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/can/length.h>
 #include <linux/can/netlink.h>
 #include <linux/can/skb.h>
 #include <linux/netdevice.h>
@@ -83,15 +84,6 @@ struct can_priv {
 #endif
 };
 
-/*
- * can_cc_dlc2len(value) - convert a given data length code (dlc) of a
- * Classical CAN frame into a valid data length of max. 8 bytes.
- *
- * To be used in the CAN netdriver receive path to ensure conformance with
- * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
- */
-#define can_cc_dlc2len(dlc)	(min_t(u8, (dlc), CAN_MAX_DLEN))
-
 /* Check for outgoing skbs that have not been created by the CAN subsystem */
 static inline bool can_skb_headroom_valid(struct net_device *dev,
 					  struct sk_buff *skb)
@@ -156,31 +148,6 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 	return skb->len == CANFD_MTU;
 }
 
-/* helper to get the data length code (DLC) for Classical CAN raw DLC access */
-static inline u8 can_get_cc_dlc(const struct can_frame *cf, const u32 ctrlmode)
-{
-	/* return len8_dlc as dlc value only if all conditions apply */
-	if ((ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC) &&
-	    (cf->len == CAN_MAX_DLEN) &&
-	    (cf->len8_dlc > CAN_MAX_DLEN && cf->len8_dlc <= CAN_MAX_RAW_DLC))
-		return cf->len8_dlc;
-
-	/* return the payload length as dlc value */
-	return cf->len;
-}
-
-/* helper to set len and len8_dlc value for Classical CAN raw DLC access */
-static inline void can_frame_set_cc_len(struct can_frame *cf, const u8 dlc,
-					const u32 ctrlmode)
-{
-	/* the caller already ensured that dlc is a value from 0 .. 15 */
-	if (ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC && dlc > CAN_MAX_DLEN)
-		cf->len8_dlc = dlc;
-
-	/* limit the payload length 'len' to CAN_MAX_DLEN */
-	cf->len = can_cc_dlc2len(dlc);
-}
-
 /* helper to define static CAN controller features at device creation time */
 static inline void can_set_static_ctrlmode(struct net_device *dev,
 					   u32 static_mode)
@@ -196,12 +163,6 @@ static inline void can_set_static_ctrlmode(struct net_device *dev,
 		dev->mtu = CANFD_MTU;
 }
 
-/* get data length from raw data length code (DLC) */
-u8 can_fd_dlc2len(u8 dlc);
-
-/* map the sanitized data length to an appropriate data length code */
-u8 can_fd_len2dlc(u8 len);
-
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
 				    unsigned int txqs, unsigned int rxqs);
 #define alloc_candev(sizeof_priv, echo_skb_max) \
diff --git a/include/linux/can/length.h b/include/linux/can/length.h
new file mode 100644
index 000000000000..fabd93bcde3e
--- /dev/null
+++ b/include/linux/can/length.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2006 Andrey Volkov <avolkov@varma-el.com>
+ *               Varma Electronics Oy
+ * Copyright (C) 2008 Wolfgang Grandegger <wg@grandegger.com>
+ */
+
+#ifndef _CAN_LENGTH_H
+#define _CAN_LENGTH_H
+
+/*
+ * can_cc_dlc2len(value) - convert a given data length code (dlc) of a
+ * Classical CAN frame into a valid data length of max. 8 bytes.
+ *
+ * To be used in the CAN netdriver receive path to ensure conformance with
+ * ISO 11898-1 Chapter 8.4.2.3 (DLC field)
+ */
+#define can_cc_dlc2len(dlc)	(min_t(u8, (dlc), CAN_MAX_DLEN))
+
+/* helper to get the data length code (DLC) for Classical CAN raw DLC access */
+static inline u8 can_get_cc_dlc(const struct can_frame *cf, const u32 ctrlmode)
+{
+	/* return len8_dlc as dlc value only if all conditions apply */
+	if ((ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC) &&
+	    (cf->len == CAN_MAX_DLEN) &&
+	    (cf->len8_dlc > CAN_MAX_DLEN && cf->len8_dlc <= CAN_MAX_RAW_DLC))
+		return cf->len8_dlc;
+
+	/* return the payload length as dlc value */
+	return cf->len;
+}
+
+/* helper to set len and len8_dlc value for Classical CAN raw DLC access */
+static inline void can_frame_set_cc_len(struct can_frame *cf, const u8 dlc,
+					const u32 ctrlmode)
+{
+	/* the caller already ensured that dlc is a value from 0 .. 15 */
+	if (ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC && dlc > CAN_MAX_DLEN)
+		cf->len8_dlc = dlc;
+
+	/* limit the payload length 'len' to CAN_MAX_DLEN */
+	cf->len = can_cc_dlc2len(dlc);
+}
+
+/* get data length from raw data length code (DLC) */
+u8 can_fd_dlc2len(u8 dlc);
+
+/* map the sanitized data length to an appropriate data length code */
+u8 can_fd_len2dlc(u8 len);
+
+#endif /* !_CAN_LENGTH_H */
-- 
2.29.2


