Return-Path: <linux-can+bounces-524-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA2D8B95DE
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965EE282114
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19B4F60D;
	Thu,  2 May 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="AQ2YOd66"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCE46B9F;
	Thu,  2 May 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636612; cv=none; b=cIL4Djt94pxCLJFE4KI/OADS+2Ct83luqMOZGUyue3Vq9U/yr/+F4R4ahVOZEGJ355XyZONoxqIF6ApzXOn1vKdevbIvYCFy8IRQOwcNT1m5g/1cdz1m8SKi7ea34dxnhjSWCRn2OIo+hf5uFdfzqy1SziyFpy6wFFzKyRDkiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636612; c=relaxed/simple;
	bh=+LED3j9UryOnzM8qONYEGqaHQ70XD8TvZDjsh/8WL7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+y6rDbxdh9iZz7hTfpdebUThm27F+QSa4m5oOYsXWVrsWFZE9PyX3XePb/mTRr5WiF7NV2spGUM3jd+PvLTBq8LtThAJ2bSabHggcKlDg5f3l4E4Z/KLkAaRwseNnu1wp8qDaFQOle/8HhbN9gejRi5YLGF7tWplZafpeOSL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=AQ2YOd66; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4mGMEjjPGqNagIRfWqi116NhC2pHD+0tS99iQ53aUj4=; b=AQ2YOd66LtN/F5hjO+myYmy7yn
	sSWRRT5zKR2mCrjY0+IcSUofbR6L9AZDPrTb7IaqFs6I7nsX1dGqEJmhS0CerwL7BDKxXsdhihzQ7
	zcs37YT16MAyR4kcoc6g1Vmt1gw2a+TEmQIthN2Vy9NgxSt22xqdT51qGx2cwXPoOwKc=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2RJ4-001Yg7-1a;
	Thu, 02 May 2024 09:56:43 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 09/12] can: bcm: Add LIN answer offloading for responder mode
Date: Thu,  2 May 2024 09:55:31 +0200
Message-Id: <20240502075534.882628-10-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502075534.882628-1-christoph.fritz@hexdev.de>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance CAN broadcast manager with RX_LIN_SETUP and RX_LIN_DELETE
operations to setup automatic LIN frame responses in responder mode.

Additionally, the patch introduces the LIN_EVENT_FRAME flag to
setup event-triggered LIN frames.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 include/uapi/linux/can/bcm.h |  5 ++-
 net/can/bcm.c                | 74 +++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
index f1e45f533a72c..c46268a114078 100644
--- a/include/uapi/linux/can/bcm.h
+++ b/include/uapi/linux/can/bcm.h
@@ -86,7 +86,9 @@ enum {
 	TX_EXPIRED,	/* notification on performed transmissions (count=0) */
 	RX_STATUS,	/* reply to RX_READ request */
 	RX_TIMEOUT,	/* cyclic message is absent */
-	RX_CHANGED	/* updated CAN frame (detected content change) */
+	RX_CHANGED,	/* updated CAN frame (detected content change) */
+	RX_LIN_SETUP,	/* create auto-response for LIN frame */
+	RX_LIN_DELETE,  /* remove auto-response for LIN frame */
 };
 
 #define SETTIMER            0x0001
@@ -101,5 +103,6 @@ enum {
 #define TX_RESET_MULTI_IDX  0x0200
 #define RX_RTR_FRAME        0x0400
 #define CAN_FD_FRAME        0x0800
+#define LIN_EVENT_FRAME     0x1000
 
 #endif /* !_UAPI_CAN_BCM_H */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 27d5fcf0eac9d..a717e594234d1 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -59,6 +59,7 @@
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
 #include <net/sock.h>
+#include <net/lin.h>
 #include <net/net_namespace.h>
 
 /*
@@ -1330,6 +1331,59 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk,
 	return cfsiz + MHSIZ;
 }
 
+static int bcm_lin_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
+			 int ifindex, struct sock *sk, int cfsiz, int is_active)
+{
+	struct lin_responder_answer answ;
+	struct net_device *dev;
+	struct sk_buff *skb;
+	struct canfd_frame cf;
+	netdevice_tracker tracker;
+	size_t sz;
+	int ret;
+
+	if (msg_head->nframes > 1)
+		return -EINVAL;
+
+	if (!(msg_head->flags & CAN_FD_FRAME))
+		return -EINVAL;
+
+	ret = memcpy_from_msg(&cf, msg, cfsiz);
+	if (ret < 0)
+		return ret;
+
+	answ.lf.lin_id = cf.can_id & LIN_ID_MASK;
+	answ.is_active = is_active;
+	answ.is_event_frame = !!(msg_head->flags & LIN_EVENT_FRAME);
+	answ.event_associated_id = msg_head->can_id;
+	answ.lf.len = min(cf.len, LIN_MAX_DLEN);
+	memcpy(answ.lf.data, cf.data, answ.lf.len);
+	sz = min(sizeof(struct lin_responder_answer), sizeof(cf.data));
+	cf.can_id |= LIN_RXOFFLOAD_DATA_FLAG;
+	memcpy(cf.data, &answ, sz);
+
+	dev = netdev_get_by_index(sock_net(sk), ifindex, &tracker, GFP_KERNEL);
+	if (!dev)
+		return -ENODEV;
+
+	skb = alloc_skb(cfsiz + sizeof(struct can_skb_priv), gfp_any());
+	if (!skb)
+		goto lin_out;
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+	skb_put_data(skb, &cf, cfsiz);
+
+	skb->dev = dev;
+	can_skb_set_owner(skb, sk);
+	ret = can_send(skb, 1); /* send with loopback */
+
+lin_out:
+	netdev_put(dev, &tracker);
+	return ret;
+}
+
 /*
  * bcm_sendmsg - process BCM commands (opcodes) from the userspace
  */
@@ -1429,12 +1483,30 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	case TX_SEND:
 		/* we need exactly one CAN frame behind the msg head */
-		if ((msg_head.nframes != 1) || (size != cfsiz + MHSIZ))
+		if (msg_head.nframes != 1 || size != cfsiz + MHSIZ)
 			ret = -EINVAL;
 		else
 			ret = bcm_tx_send(msg, ifindex, sk, cfsiz);
 		break;
 
+	case RX_LIN_SETUP:
+		/* we need exactly one CAN frame behind the msg head */
+		if (msg_head.nframes != 1 || size != cfsiz + MHSIZ)
+			ret = -EINVAL;
+		else
+			ret = bcm_lin_setup(&msg_head, msg, ifindex, sk, cfsiz,
+					    1);
+		break;
+
+	case RX_LIN_DELETE:
+		/* we need exactly one CAN frame behind the msg head */
+		if (msg_head.nframes != 1 || size != cfsiz + MHSIZ)
+			ret = -EINVAL;
+		else
+			ret = bcm_lin_setup(&msg_head, msg, ifindex, sk, cfsiz,
+					    0);
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.39.2


