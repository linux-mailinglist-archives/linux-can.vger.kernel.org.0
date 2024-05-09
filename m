Return-Path: <linux-can+bounces-619-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC428C13E5
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA53F282DE1
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE553381;
	Thu,  9 May 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="V8aIBvvJ"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411212E73;
	Thu,  9 May 2024 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275183; cv=none; b=O/o2V/tWCKbShkKxE0sz+ogirK1OcriaA2foBr9nQRFchDLZRfWYpodnuUjld5c17zvIjUz6J/6Vp1yZ8DJXtOzeXpu/WuXqZ+YPVSlyHJ9oZuQ3FuH5gOqndKv5Girt1Y8pJOPM38VRBE50d35AZ8eZL7jQLKScNSTdy14eDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275183; c=relaxed/simple;
	bh=cB+eXqs3cCRhfpzponI0o9uxGe7xxx8u+LTCb5KcMvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ECr3Sx51QaLyDWt2mA9kHBoIy1Vxuwp0BWfT3VRE97sA5fUUxNMKcU9RXeF9CdjbLGR/yNSIW2vCOOTCkO6650F96F+4U5m6OEBObhG92w2rAiS/xtl+zhrU4aKHDdCzEDAHX9RX+7IypElM+5V0u3GwVWjWuJ9awjPe0eyTi9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=V8aIBvvJ; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vqvON8O6pplr394AiIYA7rEkTZqNs8ERN+/Req4FvOk=; b=V8aIBvvJCwChAiP1cor81iIRmo
	9Sf1Y1ElVAmOUiMYgdLoRXhPy5kmVXiZvmDKJtdS6s6QtQTipZVfaS4kaWEsrzhQkGGwu7EJMhh8K
	D43kMZJgyFc30yVsAOj2oGot8NnmKYKu9eVnWmC1UenNdvKDNXvH9VDJWxj0S1l22p5I=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57QP-001jf8-0C;
	Thu, 09 May 2024 19:19:21 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
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
Subject: [PATCH v4 08/11] can: bcm: Add LIN answer offloading for responder mode
Date: Thu,  9 May 2024 19:17:33 +0200
Message-Id: <20240509171736.2048414-9-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
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
 net/can/bcm.c                | 72 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can/bcm.h b/include/uapi/linux/can/bcm.h
index f1e45f533a72c..d27bc79f924c1 100644
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
+#define LIN_EVENT_FRAME     BIT(12)
 
 #endif /* !_UAPI_CAN_BCM_H */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 27d5fcf0eac9d..6dc8b9877db4c 100644
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
+	dev = netdev_get_by_index(sock_net(sk), ifindex, &tracker, gfp_any());
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
@@ -1435,6 +1489,24 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
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


