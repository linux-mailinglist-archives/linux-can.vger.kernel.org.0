Return-Path: <linux-can+bounces-6380-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDE2FDaRemmz7wEAu9opvQ
	(envelope-from <linux-can+bounces-6380-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1904A9B6F
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E02B30166FB
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501A344DA4;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRoakwyE"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FA342528;
	Wed, 28 Jan 2026 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640239; cv=none; b=CQVek8+yGsqeCUFGaXoT1lswlQzNfHaz07suA++fSq0dPLptKjeRX5hvTKpIUctP61si+OdzkTcyzsYFMd4AQ1uoXRmHf32SkU46EFQXy9z2zesyelgJx3H2wiW6i4HjA+cCwYc01EjL2jCaP17xL1PH23rCiZaHd2ebRLqJbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640239; c=relaxed/simple;
	bh=epcqwU6jADNwATDkl3Ga1c/l7t0/48mgMqav7bPzipM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ep7UNu8LTTONbfjnYAt4nX8LYdYXl97EsqEgkvZGBsv4UHFyA+j4ytjAugYSV5eH6I5+9I6LnfWnDcRXqI7qv3aN7H9fLIMot/9cv9jwxnSvbHhlLNvecy833pxqatm5h7W4nC1PNrXj8qg1BYye6yXZA75Vqk9A+Kk3/hYQXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRoakwyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1F5FC4CEF7;
	Wed, 28 Jan 2026 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640238;
	bh=epcqwU6jADNwATDkl3Ga1c/l7t0/48mgMqav7bPzipM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GRoakwyEUqs2xVYoBuhk3S7oGz7G6s1JCv4XZavZsVv7f1I8idpUtLCmIM8CjIoL0
	 k3yOHgT9JzKPDpYld8sKBnDUxzkU/+7/uCZ8ZXnx//glvg2LSHYqCCxhSHSXL5AmdL
	 kgGaKI9t6TSxueHQVydZ9Av0vIHMS7VGHcHcmz27nAqdCg0rZfmtLCIUAbkeRLj6co
	 iCK6GrCuIUWlzI1DGxs4S48LwmOU0tjGkB3MAjFbqWXmANPMnEw8UIIfb16Ua4XliN
	 2WefjKXzf9iiUzoARIBuTa0ZIXZWgvkbZv+/vh6Gnl9JjmY8mqFOlAIwvYqyiHhKMK
	 dRy+C6PXq9HAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB727D46C10;
	Wed, 28 Jan 2026 22:43:58 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Wed, 28 Jan 2026 23:43:41 +0100
Subject: [PATCH net-next V4 2/6] can: add CAN skb extension infrastructure
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-can_skb_ext-v1-2-330f60fd5d7e@hartkopp.net>
References: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
In-Reply-To: <20260128-can_skb_ext-v1-0-330f60fd5d7e@hartkopp.net>
To: netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769640237; l=24574;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=fPrOH/hPYx2Xlx/fedjs9ehyT8i0WeTrMzFpZjM3arY=;
 b=NB+QUMmt7hI+1J8gUDB7vPxDyFlQlgdNhxIUboqdfpaqlN7IDq2hUZ4bMTDD4AGzHcL8b+gNV
 7Hnu/vg5I3dB4/ZGTnhk400+a4VFlcigVrdIYarCIjAB7jXCPg33s4D
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-6380-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net]
X-Rspamd-Queue-Id: B1904A9B6F
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

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 MAINTAINERS               |  1 +
 drivers/net/can/dev/skb.c | 56 +++++++++++++++++++++++++++++++++++++----------
 include/linux/can/skb.h   | 17 ++++++++++++++
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
 14 files changed, 188 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3df85fd5acdecfad95498918f3ee175ef7994ec..97f276375219eea66c92e086d078e45d28b40d6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5632,10 +5632,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 F:	Documentation/networking/can.rst
 F:	Documentation/networking/iso15765-2.rst
 F:	include/linux/can/can-ml.h
 F:	include/linux/can/core.h
 F:	include/linux/can/skb.h
+F:	include/net/can.h
 F:	include/net/netns/can.h
 F:	include/uapi/linux/can.h
 F:	include/uapi/linux/can/bcm.h
 F:	include/uapi/linux/can/gw.h
 F:	include/uapi/linux/can/isotp.h
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 0da615afa04de7c3df16c189ef8c7c1664d1a681..c572745565f6d0ff25729039220614ecb117e2b3 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -4,10 +4,11 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
 #include <linux/can/dev.h>
 #include <linux/module.h>
+#include <net/can.h>
 
 #define MOD_DESC "CAN device driver interface"
 
 MODULE_DESCRIPTION(MOD_DESC);
 MODULE_LICENSE("GPL v2");
@@ -205,40 +206,53 @@ static void init_can_skb_reserve(struct sk_buff *skb)
 }
 
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
 	init_can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
 	*cf = skb_put_zero(skb, sizeof(struct can_frame));
 
 	return skb;
+
+out_error_cc:
+	*cf = NULL;
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(alloc_can_skb);
 
 struct sk_buff *alloc_canfd_skb(struct net_device *dev,
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
 	init_can_skb_reserve(skb);
 	can_skb_prv(skb)->ifindex = dev->ifindex;
@@ -247,26 +261,38 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	/* set CAN FD flag by default */
 	(*cfd)->flags = CANFD_FDF;
 
 	return skb;
+
+out_error_fd:
+	*cfd = NULL;
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(alloc_canfd_skb);
 
 struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 				struct canxl_frame **cxl,
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
 	can_skb_prv(skb)->ifindex = dev->ifindex;
 
@@ -276,11 +302,11 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 	(*cxl)->flags = CANXL_XLF;
 	(*cxl)->len = data_len;
 
 	return skb;
 
-out_error:
+out_error_xl:
 	*cxl = NULL;
 
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(alloc_canxl_skb);
@@ -301,17 +327,25 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 
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
 
 		/* perform proper loopback on capable devices */
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 869ea574a40a194b27081ae5eeed701f91ec69c4..68c0f24e69149707e38d657e821d6cbe129f7d1d 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -12,10 +12,11 @@
 #define _CAN_SKB_H
 
 #include <linux/types.h>
 #include <linux/skbuff.h>
 #include <linux/can.h>
+#include <net/can.h>
 #include <net/sock.h>
 
 void can_flush_echo_skb(struct net_device *dev);
 int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		     unsigned int idx, unsigned int frame_len);
@@ -66,10 +67,26 @@ static inline struct can_skb_priv *can_skb_prv(struct sk_buff *skb)
 static inline void can_skb_reserve(struct sk_buff *skb)
 {
 	skb_reserve(skb, sizeof(struct can_skb_priv));
 }
 
+static inline struct can_skb_ext *can_skb_ext_add(struct sk_buff *skb)
+{
+	struct can_skb_ext *csx = skb_ext_add(skb, SKB_EXT_CAN);
+
+	/* skb_ext_add() returns uninitialized space */
+	if (csx)
+		csx->can_gw_hops = 0;
+
+	return csx;
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
 	 * refcount may already be 0 (and the socket will be freed
 	 * after the last TX skb has been freed). So only increase
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e6bfe5d0c5252b2e7540e1fef9317aab83feced2..b5beb28e5730133a2f4f95557fa308e7cc30ef6d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4986,10 +4986,13 @@ enum skb_ext_id {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
 #endif
 #if IS_ENABLED(CONFIG_INET_PSP)
 	SKB_EXT_PSP,
+#endif
+#if IS_ENABLED(CONFIG_CAN)
+	SKB_EXT_CAN,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
 
 /**
diff --git a/include/net/can.h b/include/net/can.h
new file mode 100644
index 0000000000000000000000000000000000000000..6db9e826f0e05fda2f361e11c58dd6b7378d767c
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
index af64a6f764588cc63862ce285ee47f3245d72d5e..abbb4be7ad2152c66abd2e28dbbd5282ec45d065 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -3,10 +3,11 @@
 # Controller Area Network (CAN) network layer core configuration
 #
 
 menuconfig CAN
 	tristate "CAN bus subsystem support"
+	select SKB_EXTENSIONS
 	help
 	  Controller Area Network (CAN) is a slow (up to 1Mbit/s) serial
 	  communications protocol. Development of the CAN bus started in
 	  1983 at Robert Bosch GmbH, and the protocol was officially
 	  released in 1986. The CAN bus was originally mainly for automotive,
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 70659987ef4d27fc25aaecf01302306d3f7494d0..22c65a014861600c96078f605309419a96b8c6bd 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -685,11 +685,12 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 }
 
 static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		   struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_can_skb(skb))) {
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_skb_ext_find(skb) || !can_is_can_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CAN_RX_INVALID_FRAME);
 		return NET_RX_DROP;
@@ -700,11 +701,12 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 }
 
 static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canfd_skb(skb))) {
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_skb_ext_find(skb) || !can_is_canfd_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANFD_RX_INVALID_FRAME);
 		return NET_RX_DROP;
@@ -715,11 +717,12 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 }
 
 static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *pt, struct net_device *orig_dev)
 {
-	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) || !can_is_canxl_skb(skb))) {
+	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
+		     !can_skb_ext_find(skb) || !can_is_canxl_skb(skb))) {
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
 		kfree_skb_reason(skb, SKB_DROP_REASON_CANXL_RX_INVALID_FRAME);
 		return NET_RX_DROP;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 8ed60f18c2eaff7053cb2c76e5e4cf1124dd3ac5..38452069dea883a35b86ba2d085d5c37a11a909d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -57,10 +57,11 @@
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
 /*
  * To send multiple CAN frame content within TX_SETUP or to filter
@@ -289,10 +290,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
  *              of the given bcm tx op
  */
 static void bcm_can_tx(struct bcm_op *op)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int err;
 
 	/* no target device? => exit */
@@ -312,10 +314,16 @@ static void bcm_can_tx(struct bcm_op *op)
 
 	skb = alloc_skb(op->cfsiz + sizeof(struct can_skb_priv), gfp_any());
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
 
 	skb_put_data(skb, cf, op->cfsiz);
 
@@ -1315,10 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
  */
 static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 		       int cfsiz)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	int err;
 
 	/* we need a real device to send frames */
 	if (!ifindex)
@@ -1326,10 +1335,16 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 
 	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), GFP_KERNEL);
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
 	if (err < 0) {
 		kfree_skb(skb);
diff --git a/net/can/gw.c b/net/can/gw.c
index 55eccb1c7620c094e04a7525b5d6c2becb96b72c..8894ab5d2087c759135ec21644dcbe31a9e5162f 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -53,10 +53,11 @@
 #include <linux/skbuff.h>
 #include <linux/can.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/gw.h>
+#include <net/can.h>
 #include <net/rtnetlink.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
 #define CAN_GW_NAME "can-gw"
@@ -457,10 +458,11 @@ static void cgw_csum_crc8_neg(struct canfd_frame *cf,
 static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 {
 	struct cgw_job *gwj = (struct cgw_job *)data;
 	struct canfd_frame *cf;
 	struct sk_buff *nskb;
+	struct can_skb_ext *csx, *ncsx;
 	struct cf_mod *mod;
 	int modidx = 0;
 
 	/* process strictly Classic CAN or CAN FD frames */
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
@@ -469,10 +471,14 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	} else {
 		if (!can_is_can_skb(skb))
 			return;
 	}
 
+	csx = can_skb_ext_find(skb);
+	if (!csx)
+		return;
+
 	/* Do not handle CAN frames routed more than 'max_hops' times.
 	 * In general we should never catch this delimiter which is intended
 	 * to cover a misconfiguration protection (e.g. circular CAN routes).
 	 *
 	 * The Controller Area Network controllers only accept CAN frames with
@@ -516,10 +522,17 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	if (!nskb) {
 		gwj->dropped_frames++;
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
 
 	/* first processing of this CAN frame -> adjust to private hop limit */
 	if (gwj->limit_hops && cgw_hops(nskb) == 1)
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 4bb60b8f9b96188a328e77be2fdefcb879da1089..c4fb8afde165d28a4b4783f1d1f7fb1b063cd41a 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -67,10 +67,11 @@
 #include <linux/can.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/isotp.h>
 #include <linux/slab.h>
+#include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
 MODULE_DESCRIPTION("PF_CAN ISO 15765-2 transport protocol");
 MODULE_LICENSE("Dual BSD/GPL");
@@ -212,18 +213,25 @@ static enum hrtimer_restart isotp_rx_timer_handler(struct hrtimer *hrtimer)
 
 static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 {
 	struct net_device *dev;
 	struct sk_buff *nskb;
+	struct can_skb_ext *csx;
 	struct canfd_frame *ncf;
 	struct isotp_sock *so = isotp_sk(sk);
 	int can_send_ret;
 
 	nskb = alloc_skb(so->ll.mtu + sizeof(struct can_skb_priv), gfp_any());
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
 		return 1;
 	}
@@ -760,10 +768,11 @@ static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 
 static void isotp_send_cframe(struct isotp_sock *so)
 {
 	struct sock *sk = &so->sk;
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int can_send_ret;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 
@@ -775,10 +784,17 @@ static void isotp_send_cframe(struct isotp_sock *so)
 	if (!skb) {
 		dev_put(dev);
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
 
 	cf = (struct canfd_frame *)skb->data;
 	skb_put_zero(skb, so->ll.mtu);
@@ -936,10 +952,11 @@ static enum hrtimer_restart isotp_txfr_timer_handler(struct hrtimer *hrtimer)
 static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
@@ -1003,10 +1020,17 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!skb) {
 		dev_put(dev);
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
 
 	so->tx.len = size;
 	so->tx.idx = 0;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 1589e8ca634ecc2b59eb0c2a1e48f546fafccbe0..fc28a7677369da821324e6c1e371a449f7a85336 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -15,10 +15,11 @@
 #include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/errqueue.h>
 #include <linux/if_arp.h>
+#include <net/can.h>
 
 #include "j1939-priv.h"
 
 #define J1939_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.j1939)
 
@@ -882,10 +883,11 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 					  int *errcode)
 {
 	struct j1939_sock *jsk = j1939_sk(sk);
 	struct j1939_sk_buff_cb *skcb;
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	int ret;
 
 	skb = sock_alloc_send_skb(sk,
 				  size +
 				  sizeof(struct can_frame) -
@@ -893,10 +895,16 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 				  sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &ret);
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
 
 	ret = memcpy_from_msg(skb_put(skb, size), msg, size);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index d5d3e5320f7ac5fb247756f6413ab448c75447f6..0514f3504e39927f7950cfad33a20d6536bca797 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -7,10 +7,11 @@
 //                         Marc Kleine-Budde <kernel@pengutronix.de>
 // Copyright (c) 2017-2019 Pengutronix,
 //                         Oleksij Rempel <kernel@pengutronix.de>
 
 #include <linux/can/skb.h>
+#include <net/can.h>
 
 #include "j1939-priv.h"
 
 #define J1939_XTP_TX_RETRY_LIMIT 100
 
@@ -589,17 +590,24 @@ sk_buff *j1939_tp_tx_dat_new(struct j1939_priv *priv,
 			     const struct j1939_sk_buff_cb *re_skcb,
 			     bool ctl,
 			     bool swap_src_dst)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 
 	skb = alloc_skb(sizeof(struct can_frame) + sizeof(struct can_skb_priv),
 			GFP_ATOMIC);
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
 	/* reserve CAN header */
 	skb_reserve(skb, offsetof(struct can_frame, data));
@@ -1523,17 +1531,24 @@ static struct
 j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 				       int size,
 				       const struct j1939_sk_buff_cb *rel_skcb)
 {
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct j1939_sk_buff_cb *skcb;
 	struct j1939_session *session;
 
 	skb = alloc_skb(size + sizeof(struct can_skb_priv), GFP_ATOMIC);
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
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(skcb, rel_skcb, sizeof(*skcb));
diff --git a/net/can/raw.c b/net/can/raw.c
index fb4f9c854df04d90ed6bd4601c616ac39bb85ad9..03438e9bc535eef3cee29188b0d57be9a907a383 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -51,10 +51,11 @@
 #include <linux/can.h>
 #include <linux/can/can-ml.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/can/raw.h>
+#include <net/can.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
 MODULE_DESCRIPTION("PF_CAN raw protocol");
 MODULE_LICENSE("Dual BSD/GPL");
@@ -916,10 +917,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
 	struct sockcm_cookie sockc;
 	struct sk_buff *skb;
+	struct can_skb_ext *csx;
 	struct net_device *dev;
 	unsigned int txmtu;
 	int ifindex;
 	int err = -EINVAL;
 
@@ -954,10 +956,16 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
 				  msg->msg_flags & MSG_DONTWAIT, &err);
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
 
 	/* fill the skb before testing for valid CAN frames */
 	err = memcpy_from_msg(skb_put(skb, size), msg, size);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4d3920e5b141a02117186c3095f15f4f7a35b1df..648c20e190387b8c66e2a6ff8e265795f81974c7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -76,10 +76,11 @@
 #include <net/ip6_checksum.h>
 #include <net/xfrm.h>
 #include <net/mpls.h>
 #include <net/mptcp.h>
 #include <net/mctp.h>
+#include <net/can.h>
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
 #include <net/dropreason.h>
 #include <net/xdp_sock.h>
 
@@ -5137,10 +5138,13 @@ static const u8 skb_ext_type_len[] = {
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
 #if IS_ENABLED(CONFIG_INET_PSP)
 	[SKB_EXT_PSP] = SKB_EXT_CHUNKSIZEOF(struct psp_skb_ext),
 #endif
+#if IS_ENABLED(CONFIG_CAN)
+	[SKB_EXT_CAN] = SKB_EXT_CHUNKSIZEOF(struct can_skb_ext),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
 {
 	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);

-- 
2.47.3



