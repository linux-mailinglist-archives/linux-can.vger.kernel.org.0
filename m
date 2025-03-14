Return-Path: <linux-can+bounces-3081-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9357DA61283
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96653BD722
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6E200B8C;
	Fri, 14 Mar 2025 13:23:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB461FF7D7
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958616; cv=none; b=q5Km43mgtiQUbH4YUKpaRXuqdAEX4swBSf8hcDSYzh/Hc0Qv3/6HT6o4pTSe+ZXo3aNJG2UvAhUJNvy6kb4dYNoXBr/Pv5Hg9Ous7WbyHWPD8CtZ//TX3cVtnFuJ6S/STu0365mtmFZE8pajMCGuKTE67JmYb5N2uafH5R2B6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958616; c=relaxed/simple;
	bh=03Gds4CjtMJZXTuFkC7Wld7aK+UOPjF1pKnqV6XYav0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBg1YBNJtTHFf0xqXAjIu4d79vwxlV7AfD3Vhv0ODDTrxQDwOq4G+dJ/+s9xDa4rOsvyRTaNyIeMArh2Av2+RkZtHNosMZdBFnn+/WsEGd1mGM0RhSUq30o3EsyOf+QZwXKl6z8KPynsQVpDRZWfNpxoHYr8wXuZhNYzR7u84Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50d-0001in-LN
	for linux-can@vger.kernel.org; Fri, 14 Mar 2025 14:23:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50d-005i5d-14
	for linux-can@vger.kernel.org;
	Fri, 14 Mar 2025 14:23:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 07C8D3DBC08
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:23:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 70FE23DBBEC;
	Fri, 14 Mar 2025 13:23:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bec4f144;
	Fri, 14 Mar 2025 13:23:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Davide Caratti <dcaratti@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 4/4] can: add protocol counter for AF_CAN sockets
Date: Fri, 14 Mar 2025 14:19:18 +0100
Message-ID: <20250314132327.2905693-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314132327.2905693-1-mkl@pengutronix.de>
References: <20250314132327.2905693-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

The third column in the output of the following command:

| # grep CAN /proc/net/protocols

is systematically '0': use sock_prot_inuse_add() to account for the number
of sockets for each protocol on top of AF_CAN family.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Link: https://patch.msgid.link/9db5d0e6c11b232ad895885616f1258882a32f61.1741952160.git.dcaratti@redhat.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.47.2



