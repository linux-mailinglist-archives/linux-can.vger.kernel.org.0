Return-Path: <linux-can+bounces-6331-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ0NMh3XeWlI0AEAu9opvQ
	(envelope-from <linux-can+bounces-6331-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:30:05 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40E9ECEE
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 10:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A24E3023356
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AF9346799;
	Wed, 28 Jan 2026 09:29:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9CE33C188
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592573; cv=none; b=B9+Gt9gTczA7qphCyMCnYQgsiyDpN8qFOHH95LK87NHKWSw/UvRhr///VjSm58ZUKq6nx/S4eAz9gthycf/NF0DWgUsZS4rGpXC4QZNwRaJpWgBgonF8LWh0nVLeI25B+B4HvSGcIEcUqY7NAneNyGDzrhpOytrvq33XryUqLbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592573; c=relaxed/simple;
	bh=M6qYArSwg/zM32lWCEWmVbctmOKve6707XcOz91s0J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p19t+A/+oH2VAvk4TbZ6J2AobK8y95madkhBryiEgjkHlJ+DMHJT6NGpI/wGhqqCz5lDsRN1styVuk9Tv2XW+TIDbAWuJVcrIrYhy6G9Yo09y/pQLU9/+V7TQyor9OWznNy6Qk9HOMnM5Ucld3JAuvb3iTCO79lar6vg/f+qTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-0007xW-Mu; Wed, 28 Jan 2026 10:29:13 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1rN-002tQF-1K;
	Wed, 28 Jan 2026 10:29:12 +0100
Received: from hardanger.blackshift.org (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4A8B94DA02D;
	Wed, 28 Jan 2026 09:29:12 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 28 Jan 2026 10:28:54 +0100
Subject: [PATCH can-next v2 2/6] can: add CAN skb extension infrastructure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can-skb-ext-v2-2-fe64aa152c8a@pengutronix.de>
References: <20260128-can-skb-ext-v2-0-fe64aa152c8a@pengutronix.de>
In-Reply-To: <20260128-can-skb-ext-v2-0-fe64aa152c8a@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=18749; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=egTIrte9okHBnHo0mVWojeObZtqUgebbD4ASzpmqfxo=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpedbegAOp4s05jquVQK1on/jgQdhj684GhAf+3
 v1JnWDEW4WJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaXnW3gAKCRAMdGXf+ZCR
 nKk4B/4ooUICVGn7bJOUy2s1m1kWI7ePa8ZjveCEXae1/Gni5flmGu+76x/JeE7uBvkiN6A5FvN
 TMlhp+3auQxvQpbt8HixNT3wKAqi5Aaq73Bvt2gmRMCsEnggWKrIThd66FMQo9HEy6Jy9cwCRDH
 L8Ov9EAjDRECY/26IO8wFZSFCK53h6tlxYt5GFNPtLIGOpB7gJjzPoeNIqXK5r+b9lbGYExtw61
 3/ItBZNGVN6lnOEG856ZdJ/fdfCaQYvN5Uj0mIBomqQFuOSNv9sxAiK7w56VbGNzeTMeALdphRf
 HJtoLUsvFfGD7jsAitAccLN3FSCi9muPGRCRhAsxvOE4wax2
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-6331-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hartkopp.net:email,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: 4F40E9ECEE
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

To remove the private CAN bus skb headroom infrastructure 8 bytes need to
be stored in the skb. The skb extensions are a common pattern and an easy
and efficient way to hold private data travelling along with the skb. We
only need the skb_ext_add() and skb_ext_find() functions to allocate and
access CAN specific content as the skb helpers to copy/clone/free skbs
automatically take care of skb extensions and their final removal.

This patch introduces the complete CAN skb extensions infrastructure:
- add struct can_skb_ext in new file include/net/can.h
- add include/net/can.h in MAINTAINERS
- add SKB_EXT_CAN to skbuff.c and skbuff.h
- select SKB_EXTENSIONS in Kconfig when CONFIG_CAN is enabled
- check for existing CAN skb extensions in can_rcv() in af_can.c
- add CAN skb extensions allocation at every skb_alloc() location
- introduce can_skb_ext_add() and can_skb_ext_find() helpers

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS               |  1 +
 drivers/net/can/dev/skb.c | 56 +++++++++++++++++++++++++++++++++++++----------
 include/linux/can/skb.h   | 11 ++++++++++
 include/linux/skbuff.h    |  3 +++
 include/net/can.h         | 28 ++++++++++++++++++++++++
 net/can/Kconfig           |  1 +
 net/can/af_can.c          |  9 +++++---
 net/can/bcm.c             | 15 +++++++++++++
 net/can/gw.c              | 13 +++++++++++
 net/can/isotp.c           | 24 ++++++++++++++++++++
 net/can/j1939/socket.c    |  8 +++++++
 net/can/j1939/transport.c | 15 +++++++++++++
 net/can/raw.c             |  8 +++++++
 net/core/skbuff.c         |  4 ++++
 14 files changed, 182 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3df85fd5acd..97f276375219 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5634,6 +5634,7 @@ F:	Documentation/networking/iso15765-2.rst
 F:	include/linux/can/can-ml.h
 F:	include/linux/can/core.h
 F:	include/linux/can/skb.h
+F:	include/net/can.h
 F:	include/net/netns/can.h
 F:	include/uapi/linux/can.h
 F:	include/uapi/linux/can/bcm.h
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 0da615afa04d..c572745565f6 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -6,6 +6,7 @@
 
 #include <linux/can/dev.h>
 #include <linux/module.h>
+#include <net/can.h>
 
 #define MOD_DESC "CAN device driver interface"
 
@@ -207,13 +208,17 @@ static void init_can_skb_reserve(struct sk_buff *skb)
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 
 	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
 			       sizeof(struct can_frame));
-	if (unlikely(!skb)) {
-		*cf = NULL;
+	if (unlikely(!skb))
+		goto out_error_cc;
 
-		return NULL;
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		goto out_error_cc;
 	}
 
 	skb->protocol = htons(ETH_P_CAN);
@@ -223,6 +228,11 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
+
+out_error_cc:
+	*cf = NULL;
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(alloc_can_skb);
 
@@ -230,13 +240,17 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 
 	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
 			       sizeof(struct canfd_frame));
-	if (unlikely(!skb)) {
-		*cfd = NULL;
+	if (unlikely(!skb))
+		goto out_error_fd;
 
-		return NULL;
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		goto out_error_fd;
 	}
 
 	skb->protocol = htons(ETH_P_CANFD);
@@ -249,6 +263,11 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 	(*cfd)->flags = CANFD_FDF;
 
 	return skb;
+
+out_error_fd:
+	*cfd = NULL;
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(alloc_canfd_skb);
 
@@ -257,14 +276,21 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 				unsigned int data_len)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 
 	if (data_len < CANXL_MIN_DLEN || data_len > CANXL_MAX_DLEN)
-		goto out_error;
+		goto out_error_xl;
 
 	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
 			       CANXL_HDR_SIZE + data_len);
 	if (unlikely(!skb))
-		goto out_error;
+		goto out_error_xl;
+
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		goto out_error_xl;
+	}
 
 	skb->protocol = htons(ETH_P_CANXL);
 	init_can_skb_reserve(skb);
@@ -278,7 +304,7 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 
 	return skb;
 
-out_error:
+out_error_xl:
 	*cxl = NULL;
 
 	return NULL;
@@ -303,13 +329,21 @@ EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 /* Check for outgoing skbs that have not been created by the CAN subsystem */
 static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 {
+	struct can_skb_ext *csx = can_skb_ext_find(skb);
+
 	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
 	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
 		return false;
 
 	/* af_packet does not apply CAN skb specific settings */
-	if (skb->ip_summed == CHECKSUM_NONE) {
-		/* init headroom */
+	if (skb->ip_summed == CHECKSUM_NONE || !csx) {
+		/* init CAN skb content */
+		if (!csx) {
+			csx = can_skb_ext_add(skb);
+			if (!csx)
+				return false;
+		}
+
 		can_skb_prv(skb)->ifindex = dev->ifindex;
 
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 869ea574a40a..aeb08f47de48 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <net/can.h>
 #include <net/sock.h>
 
 void can_flush_echo_skb(struct net_device *dev);
@@ -68,6 +69,16 @@ static inline void can_skb_reserve(struct sk_buff *skb)
 	skb_reserve(skb, sizeof(struct can_skb_priv));
 }
 
+static inline struct can_skb_ext *can_skb_ext_add(struct sk_buff *skb)
+{
+	return skb_ext_add(skb, SKB_EXT_CAN);
+}
+
+static inline struct can_skb_ext *can_skb_ext_find(struct sk_buff *skb)
+{
+	return skb_ext_find(skb, SKB_EXT_CAN);
+}
+
 static inline void can_skb_set_owner(struct sk_buff *skb, struct sock *sk)
 {
 	/* If the socket has already been closed by user space, the
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e6bfe5d0c525..b5beb28e5730 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4988,6 +4988,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_INET_PSP)
 	SKB_EXT_PSP,
+#endif
+#if IS_ENABLED(CONFIG_CAN)
+	SKB_EXT_CAN,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/net/can.h b/include/net/can.h
new file mode 100644
index 000000000000..6db9e826f0e0
--- /dev/null
+++ b/include/net/can.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * net/can.h
+ *
+ * Definitions for the CAN network socket buffer extensions
+ *
+ * Copyright (C) 2026 Oliver Hartkopp <socketcan@hartkopp.net>
+ *
+ */
+
+#ifndef _NET_CAN_H
+#define _NET_CAN_H
+
+/**
+ * struct can_skb_ext - skb extensions for CAN specific content
+ * @can_iif: ifindex of the first interface the CAN frame appeared on
+ * @can_framelen: cached echo CAN frame length for bql
+ * @can_gw_hops: can-gw CAN frame time-to-live counter
+ * @can_ext_flags: CAN skb extensions flags
+ */
+struct can_skb_ext {
+	int	can_iif;
+	u16	can_framelen;
+	u8	can_gw_hops;
+	u8	can_ext_flags;
+};
+
+#endif /* _NET_CAN_H */
diff --git a/net/can/Kconfig b/net/can/Kconfig
index af64a6f76458..abbb4be7ad21 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig CAN
 	tristate "CAN bus subsystem support"
+	select SKB_EXTENSIONS
 	help
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
 	  communications protocol. Development of the CAN bus started in
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 70659987ef4d..22c65a014861 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -687,7 +687,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_skb_ext_find(skb) || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -702,7 +703,8 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_skb_ext_find(skb) || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
@@ -717,7 +719,8 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_skb_ext_find(skb) || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 8ed60f18c2ea..38452069dea8 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -59,6 +59,7 @@
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -291,6 +292,7 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 static void bcm_can_tx(struct bcm_op *op)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int err;
@@ -314,6 +316,12 @@ static void bcm_can_tx(struct bcm_op *op)
 	if (!skb)
 		goto out;
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		goto out;
+	}
+
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
@@ -1317,6 +1325,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 		       int cfsiz)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	int err;
 
@@ -1328,6 +1337,12 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	if (!skb)
 		return -ENOMEM;
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		return -ENOMEM;
+	}
+
 	can_skb_reserve(skb);
 
 	err = memcpy_from_msg(skb_put(skb, cfsiz), msg, cfsiz);
diff --git a/net/can/gw.c b/net/can/gw.c
index 55eccb1c7620..8894ab5d2087 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -55,6 +55,7 @@
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/gw.h>
+#include <net/can.h>
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
@@ -459,6 +460,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct cgw_job *gwj = (struct cgw_job *)data;
 	struct canfd_frame *cf;
 	struct sk_buff *nskb;
+	struct can_skb_ext *csx, *ncsx;
 	struct cf_mod *mod;
 	int modidx = 0;
 
@@ -471,6 +473,10 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 			return;
 	}
 
+	csx = can_skb_ext_find(skb);
+	if (!csx)
+		return;
+
 	/* Do not handle CAN frames routed more than 'max_hops' times.
 	 * In general we should never catch this delimiter which is intended
 	 * to cover a misconfiguration protection (e.g. circular CAN routes).
@@ -518,6 +524,13 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		return;
 	}
 
+	ncsx = can_skb_ext_find(nskb);
+	if (!ncsx) {
+		kfree_skb(nskb);
+		gwj->dropped_frames++;
+		return;
+	}
+
 	/* put the incremented hop counter in the cloned skb */
 	cgw_hops(nskb) = cgw_hops(skb) + 1;
 
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4bb60b8f9b96..c4fb8afde165 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -69,6 +69,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/isotp.h>
 #include <linux/slab.h>
+#include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -214,6 +215,7 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 {
 	struct net_device *dev;
 	struct sk_buff *nskb;
+	struct can_skb_ext *csx;
 	struct canfd_frame *ncf;
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
@@ -222,6 +224,12 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 	if (!nskb)
 		return 1;
 
+	csx = can_skb_ext_add(nskb);
+	if (!csx) {
+		kfree_skb(nskb);
+		return 1;
+	}
+
 	dev = dev_get_by_index(sock_net(sk), so->ifindex);
 	if (!dev) {
 		kfree_skb(nskb);
@@ -762,6 +770,7 @@ static void isotp_send_cframe(struct isotp_sock *so)
 {
 	struct sock *sk = &so->sk;
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int can_send_ret;
@@ -777,6 +786,13 @@ static void isotp_send_cframe(struct isotp_sock *so)
 		return;
 	}
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		dev_put(dev);
+		return;
+	}
+
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
@@ -938,6 +954,7 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
@@ -1005,6 +1022,13 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		goto err_out_drop;
 	}
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		dev_put(dev);
+		goto err_out_drop;
+	}
+
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 1589e8ca634e..fc28a7677369 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -17,6 +17,7 @@
 #include <linux/can/skb.h>
 #include <linux/errqueue.h>
 #include <linux/if_arp.h>
+#include <net/can.h>
 
 #include "j1939-priv.h"
 
@@ -884,6 +885,7 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	struct j1939_sock *jsk = j1939_sk(sk);
 	struct j1939_sk_buff_cb *skcb;
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	int ret;
 
 	skb = sock_alloc_send_skb(sk,
@@ -895,6 +897,12 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	if (!skb)
 		goto failure;
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		goto failure;
+	}
+
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = ndev->ifindex;
 	skb_reserve(skb, offsetof(struct can_frame, data));
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index d5d3e5320f7a..0514f3504e39 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -9,6 +9,7 @@
 //                         Oleksij Rempel <kernel@pengutronix.de>
 
 #include <linux/can/skb.h>
+#include <net/can.h>
 
 #include "j1939-priv.h"
 
@@ -591,6 +592,7 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 			     bool swap_src_dst)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 
 	skb = alloc_skb(sizeof(struct can_frame) + sizeof(struct can_skb_priv),
@@ -598,6 +600,12 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
@@ -1525,6 +1533,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 				       const struct j1939_sk_buff_cb *rel_skcb)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 	struct j1939_session *session;
 
@@ -1532,6 +1541,12 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	if (unlikely(!skb))
 		return NULL;
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
 	skb->dev = priv->ndev;
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = priv->ndev->ifindex;
diff --git a/net/can/raw.c b/net/can/raw.c
index fb4f9c854df0..03438e9bc535 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -53,6 +53,7 @@
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/raw.h>
+#include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -918,6 +919,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct raw_sock *ro = raw_sk(sk);
 	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	unsigned int txmtu;
 	int ifindex;
@@ -956,6 +958,12 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!skb)
 		goto put_dev;
 
+	csx = can_skb_ext_add(skb);
+	if (!csx) {
+		kfree_skb(skb);
+		goto put_dev;
+	}
+
 	can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4d3920e5b141..648c20e19038 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -78,6 +78,7 @@
 #include <net/mpls.h>
 #include <net/mptcp.h>
 #include <net/mctp.h>
+#include <net/can.h>
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
@@ -5139,6 +5140,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_INET_PSP)
 	[SKB_EXT_PSP] = SKB_EXT_CHUNKSIZEOF(struct psp_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_CAN)
+	[SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)

-- 
2.51.0


