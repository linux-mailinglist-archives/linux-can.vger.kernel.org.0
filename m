Return-Path: <linux-can+bounces-4829-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF4B94428
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845C118A2EF3
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 04:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91AF30DD08;
	Tue, 23 Sep 2025 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgGtwf7U"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08930DD00;
	Tue, 23 Sep 2025 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758603211; cv=none; b=F1XHRjXlp00zzanPQ3GU9GW8MZID+89203sn5u+1OWiYQzgnCRPeUBcFJYD75hkO3S5cllACtanmqRpPJXhgIDFWuPqxwAZIkVg2Jt3t5bw5Vgb4ZSNi4m2PWdto8goZfKIbilVgpPLFmgYxfBXZRvLaB8od8CsHqzr8zUAVb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758603211; c=relaxed/simple;
	bh=drdc6vhp0itUxR+RtAgDkGEMcboFw0v8IhKD5qU7Q48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPJ91EyMyPUmnB2vMv0Pv2jv1iXU0xUYzKA7cVxPBCsVCRPWsXYgF/mGIBZU880VYv4xOtZDoqBffUxghrm0wvX5zdTGqetbc+nP3cm0yibc0cTpypPFjZYrZS8rH8tUfMqMFdIOGoTZgi8nUfHwvVuGpRPgGdCGLFQU3UlZlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgGtwf7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7BFC113CF;
	Tue, 23 Sep 2025 04:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758603211;
	bh=drdc6vhp0itUxR+RtAgDkGEMcboFw0v8IhKD5qU7Q48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VgGtwf7UDYJjsDitxTOtFDIcHl2EowhGFPsh8U06u/6XLJgrCh8et7OrTxE9deTsA
	 idx6HIJJrXWYM4t1ZLRMyCmJKurYHPuhPqFj336B4aNTfkzzzxtnyB2p4725B8B7TR
	 i2+OhhEh8t+FhVD2Uxr80D7pXpk26DmvIyaHEcR6ATRgapsNJ4ROQ3Z74GAj0oijJ8
	 9OFwAt7iW9kEAKwejnH4ttwnxaoKHO2Nf6sNF3HmtSkeuAlGib9ml9IIocdmfBjJLG
	 fJtSpLwHbDgqt9TEBmzK0xbHLMeAYe6fetYa6AldaKgxXn4Ccd+0XhIkby0+bMHN27
	 sGdluinbQRNrg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 13:52:41 +0900
Subject: [PATCH v2 1/4] can: annotate mtu accesses with READ_ONCE()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-can-fix-mtu-v2-1-984f9868db69@kernel.org>
References: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
In-Reply-To: <20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2365; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=drdc6vhp0itUxR+RtAgDkGEMcboFw0v8IhKD5qU7Q48=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmX1PcfdH4jqCeitvJXQnTW/bvf6qbzOVaIfolPeO+Su
 Ppjg+G9jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABMJvcbwT6WF+zxrx9rZcg9F
 NS9aLb/44LzpKundp8rbmQr2T1A81sXwPzHEx+RZa94EjaoqjcItG9V/Xao9Y+dw6Ylm3fXT55b
 kMwAA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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


