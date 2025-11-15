Return-Path: <linux-can+bounces-5437-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B95C608B0
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6FBF6242F7
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B47A2FFDFE;
	Sat, 15 Nov 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="qLmoRqrh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="pzt7aaLQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C22FF140
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224689; cv=pass; b=QFK9NX29/I3kd/20dZm0yiIdbDG0J02YHYbPuiMbmG5dNikYKiFV78b9xa4K5r6KRqMG3ZT64jKY9uc2U8G5mDlDJbAnspoEb484w+tTP4l7qLyIa+cDyolpFRXWzdSz9a+gSFalsOivtjO4YLz8TbR0i2B+3c2Cgc5+Y9N5FWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224689; c=relaxed/simple;
	bh=MuX286oxUZ8YOyZtXuymWdY3UhYrGP2K8lVLc5PFs0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewGjb8r7bQoRFNlIuqMroMBV0fiHVFoUFoRWH5wECITCj3u12oZyq+qJg8QP2gGIo+XZLuPHP273uxeX6WIg2lPCH17DUnHjHQ5KKtwZqfXxWGuXVYXZ0yAa3IlZGzUxMhZlWuTyxMEwFnascp6wqnnTe1Gy6CLbyqIht40pgoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=qLmoRqrh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=pzt7aaLQ; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763224673; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CdfZSVtbSW8f2953uGYI/ab1VKjvadmdmuJ3kAiR4lBOz/tT5FoHtKPUDex7f65/Ss
    jjyYFtofKGeJqZIgOeeoAbNtVtTNz+awKcQ9NgtC1BkRAVzom10+CpqT1JsKlyutklJF
    x0JLMnXt+VJqss9CJbBNCb03tYxN9yo0iXCWDth/lMs4/xMW3/IxzJRyvce2CDBCeMTU
    o+wN8xqRF5h0j7hrU0CZeLTzebbcGpd3GlNcT6eNcFfgwqjLqzCslQjGVcZcY+S9MQxQ
    uK1AER/kMBAL6c3bm0b1qribW7r68w26K2ly6BJ+Akjb5KJZPTn3y5duHbEW7gh3zh1k
    qc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7CnAUXl77iU3byj1HoDDkLhwM1RRaebYwKbVhgkWJQo=;
    b=Hgj3FgHPh8+t6UwSARyfjf6misclHWaZGof3QpvPLNLckGWtWCwy2QAlKWJLX+RWr+
    qAgCuOCd8Pt3l0yyzhQ5oz++E6gpt8RL9sVuIJHFDOhsRWW8yuhyFNYT5rnBjWQRnjbW
    McrZniF+MJ+/wjoS/Rs7sLg7nqTjTWdrjShZTad0r/0bMd6R8b37AlT5Rv49emhvlFom
    1ZCdPoumdvgqkgXx6uyluaSAxQxqqjN6nPVdXn5L8qpK4e9wuxcgO4QlFcwQVrGOu7Zj
    yZThR+TDKmdTAcom7EhZ4z+E1N9ikvEtXYUEx7WKPbSkkBdvtq/D18BdIpCix0wud9ik
    mXPg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7CnAUXl77iU3byj1HoDDkLhwM1RRaebYwKbVhgkWJQo=;
    b=qLmoRqrhCVcCWErZoMtLX8ZWa7ehDxV1UZLUBBfUInvPcH6FKAg0l+yyj8sWz/7wp3
    Xg5Xii6wo0raHmaI/fWAjUXD/Cbf7SEzAb5bGIePONxlO/Z2s3cx5AnS1ATg6E47F4jB
    l+y4v0rsSMn97wrk63Gwzv+VJE4Y/HF56SO8zc+p2LynLO1jJmxE0xue+nfK0aqgwKxP
    D9CICwNYvsUo9XKRSKwruc5VBkfdzYm/0wbvEUi9pYZgAewSSNLlj3Tw0RaLg+lV3H+E
    Ao5La/fhV/AChpHrIkF9BYXTzNzlOR4e0wnPMRF7gu7iabrjM9QVmNbSuF433Y/hgVar
    Y09A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763224673;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=7CnAUXl77iU3byj1HoDDkLhwM1RRaebYwKbVhgkWJQo=;
    b=pzt7aaLQnIOnZxVUROSoXIusu3EbNRuLzUqLM4HN/K8WbwuCS/r16Q5vjgV1+5rsUh
    ltjs9sPyeG4Oal7ejuAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFGbreQl
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 17:37:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol@kernel.org>
Subject: [canxl v2 02/15] can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
Date: Sat, 15 Nov 2025 17:37:27 +0100
Message-ID: <20251115163740.7875-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115163740.7875-1-socketcan@hartkopp.net>
References: <20251115163740.7875-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Vincent Mailhol <mailhol@kernel.org>

Currently, the CAN FD skb validation logic is based on the MTU: the
interface is deemed FD capable if and only if its MTU is greater or
equal to CANFD_MTU.

This logic is showing its limit with the introduction of CAN XL. For
example, consider the two scenarios below:

  1. An interface configured with CAN FD on and CAN XL on

  2. An interface configured with CAN FD off and CAN XL on

In those two scenarios, the interfaces would have the same MTU:

  CANXL_MTU

making it impossible to differentiate which one has CAN FD turned on
and which one has it off.

Because of the limitation, the only non-UAPI-breaking workaround is to
do the check at the device level using the can_priv->ctrlmode flags.
Unfortunately, the virtual interfaces (vcan, vxcan), which do not have
a can_priv, are left behind.

Add a check on the CAN_CTRLMODE_FD flag in can_dev_dropped_skb() and
drop FD frames whenever the feature is turned off.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 include/linux/can/dev.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index bd7410b5d8a6..a7a39a6101d9 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -101,16 +101,24 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 	struct can_priv *priv = netdev_priv(dev);
 
 	if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		netdev_info_once(dev,
 				 "interface in listen only mode, dropping skb\n");
-		kfree_skb(skb);
-		dev->stats.tx_dropped++;
-		return true;
+		goto invalid_skb;
+	}
+
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD) && can_is_canfd_skb(skb)) {
+		netdev_info_once(dev, "CAN FD is disabled, dropping skb\n");
+		goto invalid_skb;
 	}
 
 	return can_dropped_invalid_skb(dev, skb);
+
+invalid_skb:
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+	return true;
 }
 
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-- 
2.47.3


