Return-Path: <linux-can+bounces-3775-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14481ACE1EC
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47A13A5130
	for <lists+linux-can@lfdr.de>; Wed,  4 Jun 2025 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE328DD0;
	Wed,  4 Jun 2025 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccLwDpa3"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79E4C7C
	for <linux-can@vger.kernel.org>; Wed,  4 Jun 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053228; cv=none; b=Y95EonXxwDTQQwF6Fhv5EhoZeuql3M2NCbw2ygqufeA061Cq1+aceMSSF60x7+OJPs8/K3uKuvzeTTTx8kNFs4XryvJ6jYvUDXwTZrTz8KgZlSR4POlLVRkzIPy/ZpPR5tSrU2GjntJXYOdE7w9K+VKPM8L+ii5LeCF0zVMr0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053228; c=relaxed/simple;
	bh=jnfZEaOPEmlAXDQ/7ZdZ2iNfB04pMe9SUcI3IcfjEYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yc/aoUxL8TB6Mxb/BrB/4UOlsakmsGo3dVkAh9ugavpG+F8q9uJJBpaTBdZCgUZsGFZ7w2APtU0JSMB0U2ZdH65Brfnv8q8WrWelfn1pBS4tneij8I1jG5Ah0FuOQJgcEwxdz0GCT4cz9f3aRs8Ih7LSvd03NhGWV6TjQEDAq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccLwDpa3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749053225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iJJNDShQ/Nob70wvVwDhvFkHWW+hRJBAZxgsH5paD14=;
	b=ccLwDpa3bpXc90n8ysA6RXiqnMYsI+6CzTFeceOpD7qeYLX/YBT8G4BKWVs7DCemzIwCeS
	42gJkAhlAsK/8nlvGv3pbIcM3gkYWs+jAF5dSPx6ShD9ywiDk71HhVJun4e+eFq12eC5cG
	EUkNOdYpKf8CD/IzvObMBopLEYLJFow=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-NOM7VQEbM5-81lgCvU3Hkw-1; Wed,
 04 Jun 2025 12:07:01 -0400
X-MC-Unique: NOM7VQEbM5-81lgCvU3Hkw-1
X-Mimecast-MFC-AGG-ID: NOM7VQEbM5-81lgCvU3Hkw_1749053220
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99B3D1800771;
	Wed,  4 Jun 2025 16:07:00 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB67830002D1;
	Wed,  4 Jun 2025 16:06:57 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: fstornio@redhat.com,
	fmaurer@redhat.com
Subject: [PATCH 1/2] can: add drop reasons in the receive path of AF_CAN
Date: Wed,  4 Jun 2025 18:06:04 +0200
Message-ID: <20250604160605.1005704-2-dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Besides the existing pr_warn_once(), use skb drop reasons in case AF_CAN
layer drops non-conformant CAN{,FD,XL} frames, or conformant frames
received by "wrong" devices, so that it's possible to debug (and count)
such events using existing tracepoints:

| # perf record -e skb:kfree_skb -aR -- ./drv/canfdtest -v -g -l 1 vcan0
| # perf script
| [...]
| canfdtest  1123 [000]  3893.271264: skb:kfree_skb: skbaddr=0xffff975703c9f700 rx_sk=(nil) protocol=12 location=can_rcv+0x4b  reason: CAN_RX_INVALID_FRAME

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/dropreason-core.h | 18 ++++++++++++++++++
 net/can/af_can.c              |  6 +++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index e4fdc6b54cef..a59aa4d6c3c0 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -119,6 +119,9 @@
 	FN(ARP_PVLAN_DISABLE)		\
 	FN(MAC_IEEE_MAC_CONTROL)	\
 	FN(BRIDGE_INGRESS_STP_STATE)	\
+	FN(CAN_RX_INVALID_FRAME)	\
+	FN(CANFD_RX_INVALID_FRAME)	\
+	FN(CANXL_RX_INVALID_FRAME)	\
 	FNe(MAX)
 
 /**
@@ -563,6 +566,21 @@ enum skb_drop_reason {
 	 * ingress bridge port does not allow frames to be forwarded.
 	 */
 	SKB_DROP_REASON_BRIDGE_INGRESS_STP_STATE,
+	/**
+	 * @SKB_DROP_REASON_CAN_RX_INVALID_FRAME: received
+	 * non conform CAN frame (or device is unable to receive CAN frames)
+	 */
+	SKB_DROP_REASON_CAN_RX_INVALID_FRAME,
+	/**
+	 * @SKB_DROP_REASON_CANFD_RX_INVALID_FRAME: received
+	 * non conform CAN-FD frame (or device is unable to receive CAN frames)
+	 */
+	SKB_DROP_REASON_CANFD_RX_INVALID_FRAME,
+	/**
+	 * @SKB_DROP_REASON_CANXL_RX_INVALID_FRAME: received
+	 * non conform CAN-XL frame (or device is unable to receive CAN frames)
+	 */
+	SKB_DROP_REASON_CANXL_RX_INVALID_FRAME,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 49629eb22dd9..bb2943d73730 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -684,7 +684,7 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_CAN_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
@@ -699,7 +699,7 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
 		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_CANFD_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
@@ -714,7 +714,7 @@ static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
 		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
 			     dev->type, skb->len);
 
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_CANXL_RX_INVALID_FRAME);
 		return NET_RX_DROP;
 	}
 
-- 
2.27.0


