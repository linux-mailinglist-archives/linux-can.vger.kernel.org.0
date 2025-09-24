Return-Path: <linux-can+bounces-4933-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A884B98CF7
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DF14C3B6A
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5F728314A;
	Wed, 24 Sep 2025 08:21:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61412285073
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702108; cv=none; b=d7sMQ4D3WiC4gqxW9yOoYGauZgYtox6jUYUbpZFBDx7ivpQ1Sh+Xo6FRXzIoSmYwJ8GRNwNmsnqfw85tQK8UxNJAjlZrFA5fiUAUMaj3raj9bajHPfGRMrvtCjbOsS7pOJKiZ4Hmj0WaMoD7BFjaAINMhmcqBFMLARxpcm7w4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702108; c=relaxed/simple;
	bh=bR2u+ioVeca1qbN5tdQpyAoUwN5vWtiGyLDka6Jmh6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFCVtXSX/xLVjedcfHTpvGWwSw/ey+4QmApjQKDNuzPlJGTF5szL3/Ltd1b9OFhridmxl4f1Qit9w8+FsOIIZBqsF1B5bDoftbiP2QHZU7zHXAvyRNPwEnyRoEum3GFvDsFdZtLt3WfBNh0gmed2GurGlJuzyYfH3iH/TF/WQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kke-0001Fd-Mu; Wed, 24 Sep 2025 10:21:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dvz-2s;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6EE06478896;
	Wed, 24 Sep 2025 08:21:09 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 25/48] can: annotate mtu accesses with READ_ONCE()
Date: Wed, 24 Sep 2025 10:06:42 +0200
Message-ID: <20250924082104.595459-26-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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

From: Vincent Mailhol <mailhol@kernel.org>

As hinted in commit 501a90c94510 ("inet: protect against too small mtu
values."), net_device->mtu is vulnerable to race conditions if it is
written and read without holding the RTNL.

At the moment, all the writes are done while the interface is down,
either in the devices' probe() function or in can_changelink(). So
there are no such issues yet. But upcoming changes will allow to
modify the MTU while the CAN XL devices are up.

In preparation to the introduction of CAN XL, annotate all the
net_device->mtu accesses which are not yet guarded by the RTNL with a
READ_ONCE().

Note that all the write accesses are already either guarded by the
RTNL or are already annotated and thus need no changes.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-can-fix-mtu-v3-1-581bde113f52@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 2 +-
 net/can/isotp.c  | 2 +-
 net/can/raw.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index b2387a46794a..770173d8db42 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -221,7 +221,7 @@ int can_send(struct sk_buff *skb, int loop)
 	}
 
 	/* Make sure the CAN frame can pass the selected CAN netdevice. */
-	if (unlikely(skb->len > skb->dev->mtu)) {
+	if (unlikely(skb->len > READ_ONCE(skb->dev->mtu))) {
 		err = -EMSGSIZE;
 		goto inval_skb;
 	}
diff --git a/net/can/isotp.c b/net/can/isotp.c
index dee1412b3c9c..74ee1e52249b 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1313,7 +1313,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 		err = -ENODEV;
 		goto out;
 	}
-	if (dev->mtu < so->ll.mtu) {
+	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
 		dev_put(dev);
 		err = -EINVAL;
 		goto out;
diff --git a/net/can/raw.c b/net/can/raw.c
index bf65d67b5df0..a53853f5e9af 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -961,7 +961,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, dev->mtu);
+	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
 	if (!txmtu)
 		goto free_skb;
 
-- 
2.51.0


