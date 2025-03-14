Return-Path: <linux-can+bounces-3065-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9EA61031
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 12:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B42187AA615
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 11:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA41FDA82;
	Fri, 14 Mar 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEZsDXYN"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46801FDA99
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952447; cv=none; b=MrBJ5IMe/nIzYoxES8OcB2+bZKRE2jzZJJ9xoTqyYbRvVFSUwcn3pqgIXt6RbCaqjlt9+4fdgUiUaVw8Oa23Xcm1P1Oz1QHxj4he5fW0F5AgamqtBP5zlz+bOMT7o2UBDhAHod7heQHNpX0i3lBwJf1V3yaORfhUrMSJVaKXOoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952447; c=relaxed/simple;
	bh=ry6BbwXF+XWNbEVntrAZGVaa2gSXCltXgt/sjPOtf9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mvk6XIX2UusC3cPRBmVu/tTh1tNL1lm/xAPuKk4AwFGxfIs3z+45kZi3riKxpRzMTPtfkTZDxGGJ1aVCWLx5cREuYw+NEWtqotCmQUR/jjtQmzBVrT4j68DPDQ8G/SNh6wOzT0OFCLd1NY5zNMzqRCQ6WH6iJe3bji+FcTmOAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEZsDXYN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741952444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eweFpCzoGSbrrn71Dm9f5378WnOKQr6rI6TBfQc3jsY=;
	b=TEZsDXYNNV1SKdJiFP+19tfMcnCikzTiK8UvPNEKxVT0TrvgZWYmQW9IjsuMwR3F5oyyGE
	pSIpNqI3ckxPTSa0j5Xb3e0AM7en6j6Ph4Ep9GuCSHLFDvLZ5cLWS8njL5tjxh/rYkdrEt
	RHEqmGenultwPQXpRfSSeNZ62FLucBU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-8T3lJaDTOneOzq5vwB-xcA-1; Fri,
 14 Mar 2025 07:40:40 -0400
X-MC-Unique: 8T3lJaDTOneOzq5vwB-xcA-1
X-Mimecast-MFC-AGG-ID: 8T3lJaDTOneOzq5vwB-xcA_1741952439
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8BCD19560BB;
	Fri, 14 Mar 2025 11:40:38 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.32.181.94])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81909180175A;
	Fri, 14 Mar 2025 11:40:37 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Subject: [PATCH] can: add protocol counter for AF_CAN sockets
Date: Fri, 14 Mar 2025 12:39:49 +0100
Message-ID: <9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The third column in the output of the following command:

 # grep CAN /proc/net/protocols

is systematically '0': use sock_prot_inuse_add() to account for the number
of sockets for each protocol on top of AF_CAN family.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/can/af_can.c | 2 ++
 net/can/bcm.c    | 1 +
 net/can/isotp.c  | 1 +
 net/can/raw.c    | 5 ++++-
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 01f3fbb3b67d..7b191dbe3693 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -172,6 +172,8 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		sock_orphan(sk);
 		sock_put(sk);
 		sock->sk = NULL;
+	} else {
+		sock_prot_inuse_add(net, sk->sk_prot, 1);
 	}
 
  errout:
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 217049fa496e..6dc041e054ba 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1625,6 +1625,7 @@ static int bcm_release(struct socket *sock)
 	sock->sk = NULL;
 
 	release_sock(sk);
+	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 16046931542a..789583c62f98 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1239,6 +1239,7 @@ static int isotp_release(struct socket *sock)
 	sock->sk = NULL;
 
 	release_sock(sk);
+	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
diff --git a/net/can/raw.c b/net/can/raw.c
index 9b1d5f036f57..020f21430b1d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -397,11 +397,13 @@ static int raw_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro;
+	struct net *net;
 
 	if (!sk)
 		return 0;
 
 	ro = raw_sk(sk);
+	net = sock_net(sk);
 
 	spin_lock(&raw_notifier_lock);
 	while (raw_busy_notifier == ro) {
@@ -421,7 +423,7 @@ static int raw_release(struct socket *sock)
 			raw_disable_allfilters(dev_net(ro->dev), ro->dev, sk);
 			netdev_put(ro->dev, &ro->dev_tracker);
 		} else {
-			raw_disable_allfilters(sock_net(sk), NULL, sk);
+			raw_disable_allfilters(net, NULL, sk);
 		}
 	}
 
@@ -440,6 +442,7 @@ static int raw_release(struct socket *sock)
 	release_sock(sk);
 	rtnl_unlock();
 
+	sock_prot_inuse_add(net, sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
-- 
2.47.0


