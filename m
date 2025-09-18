Return-Path: <linux-can+bounces-4746-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A2B84B79
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 14:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74013B177D
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B5305967;
	Thu, 18 Sep 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+94Vn6S"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721A305962;
	Thu, 18 Sep 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200374; cv=none; b=Dl6NufRsNjJmo21EnRDs/S0u//3XpcVQJ32usns/vJpkRFU3LT8AG/CREV0SmI6iBULF9qzJSXsjAKPXsLfDMW8D1I47MozFPGHbLqvmqzrDiEYwHulXb0oBcnyOGCCBzsPN9oGDZDvTcmHKJHsdkd+k7QVJjX1HgGqHJXtDpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200374; c=relaxed/simple;
	bh=RCpnWNbRbTPOTIe59LVKPYVENEKNj5n7+1eM2LCxXJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2OYGbX5Mu0f8552n0dhfysz5vrjPpmir8++RLvSdCz/obl9fPln1IxLpptxUqK9iR1hcRx2HTjtpn/rPBkojsnPID+EoU1PI8ZEQik2m1Ma+y8j6ewqhRbIcLsrutYZc08lGKufc1dDfDmLiIWcgRntdFfjoD6WSMyjrGO8SJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+94Vn6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CC2C4CEEB;
	Thu, 18 Sep 2025 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758200374;
	bh=RCpnWNbRbTPOTIe59LVKPYVENEKNj5n7+1eM2LCxXJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f+94Vn6Shi4rKKWXzKs3VW3ZJ+WVea90kZmI1rYrKsEF/Ou0J8fZbYBrEsQhlLciv
	 cJjXmqRUwaC5z6JA1S8GqhvTQY/1m4+YW/wJnF2Hp6pszmZ8hQ9CyAyEFG1g+ys36v
	 uxFnSO48N4VuGzmTfNm46MWkFnl1KytZf/WSr8Jw804ILL0Fn+v6hFcRwDjrZwhGWN
	 NKIrTi6JrY6oe1Z4HF9l+VgY/mT6HXcETNqZehJOWH14M4EZCjO+1chsngKS6a9Q2L
	 RgZLvXHRPfyuxR5VxLQtNQYoWfQEwJYiEotlSyT7BMkqmsoAzy2DU9vjptvxzoojgh
	 dXCVGdAVWrJhg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 21:59:11 +0900
Subject: [PATCH RFC 1/5] can: annotate mtu accesses with READ_ONCE()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-1-471edb942295@kernel.org>
References: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
In-Reply-To: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=RCpnWNbRbTPOTIe59LVKPYVENEKNj5n7+1eM2LCxXJM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlnmDT9pvH7OgQ/e5214q6z6PKljyUkHDvOPepVP2B96
 ewjvssBHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACbyRoCR4cEBoSKZJpnvDD8P
 xc/6/OXbnxsztrx5utvuttqC2w92Hq9mZNgbwiKk4pQUUpOpUTSvcPOdY0mqK326Oe5zBTb33kz
 PZwAA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

As hinted in commit 501a90c94510 ("inet: protect against too small mtu
values."), net_device->mtu is vulnerable to race conditions if it is
written and read without holding the RTNL.

At the moment, all the writes are done while the interface is down, so
there are no such issues yet. But upcoming changes will allow to
modify the MTU while the CAN XL devices are up.

In preparation to the introduction of CAN XL, annotate all the
net_device->mtu accesses which are not yet guarded by the RTNL with a
READ_ONCE().

Note that all the write accesses are already either guarded by the
RTNL or are already annotated and thus need no changes.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 net/can/af_can.c | 2 +-
 net/can/isotp.c  | 2 +-
 net/can/raw.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index b2387a46794a576973f3d865a5ca8e2ba696d167..770173d8db42813d5c085248d1bcf5fbe717955b 100644
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
index dee1412b3c9c1ffcfc43a109b448701459fcf8b9..74ee1e52249b232813a06c5d2c6e404a38dce990 100644
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
index 76b867d21def209f5c6d236604c0e434a1c55a4d..6cb959e3dcd3e54972628ee59572a749009d1323 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -950,7 +950,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	err = -EINVAL;
 
 	/* check for valid CAN (CC/FD/XL) frame content */
-	txmtu = raw_check_txframe(ro, skb, dev->mtu);
+	txmtu = raw_check_txframe(ro, skb, READ_ONCE(dev->mtu));
 	if (!txmtu)
 		goto free_skb;
 

-- 
2.49.1


