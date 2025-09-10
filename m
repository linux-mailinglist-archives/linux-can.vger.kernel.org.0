Return-Path: <linux-can+bounces-4614-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47708B50DC3
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120AA1C25D86
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8C730C601;
	Wed, 10 Sep 2025 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWXnwgdM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532630C378;
	Wed, 10 Sep 2025 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484310; cv=none; b=otBUVvp4KUH6RYYlnFsfE1wSR0WbxfxoFZL6RPQde5XXU6i1yp88cKEkfciWTTLgd7ohYPR5SIqXLSC4lW0TLOjGArlaWeYJmLuan1Z/hcqst6a/+X2yfBUv+LULUXzEZxQFQ7UxjL4lGMcc4SLXhRI+Otfm0mMzV6IIfgMcsT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484310; c=relaxed/simple;
	bh=929EtOm6sQD4/p82XQBc5sAI4DNI3zMGcd+VcIf3Fp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHnsdR0Tpz8uRMZP9pn+rMcPj7IfvcEiflaLKR+/E8hYk8BTmOUpQgsuvOZAU/PxSL7bnt/cxRVb2Dz8OF3JC0w3PIlTcxTTlwWaVph/vqRuMvzFU6m92AnGJ6lMEk61xaS47PPWKtnEAdvBl4FqefReBuHLR+UsMyX516m5LkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWXnwgdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719F8C4CEFA;
	Wed, 10 Sep 2025 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484309;
	bh=929EtOm6sQD4/p82XQBc5sAI4DNI3zMGcd+VcIf3Fp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QWXnwgdMyeFG9HT9PoBcDVzfR+rP6ISiu0CM9E5cY5bCK/fTZ1mGDXpZDBXKYK0e2
	 sapzHcgscSTlLi8cAOzlrksM/6GniM9HP5LIiImeY/s3EGG/83MOau6TqDGuyO9bbR
	 yQ3lnDd8pA6i3PdoGu9SDKNjfH/FfukcZtr09a0gzkJBUWyewTuYa5Egg1otZcFlcn
	 bWIJnV8D36+L8/jw0a6k91IolcnaemKtyoiG86y+Hz3Dtt6iKkc+fxiEwvqUU/Vm1q
	 HBU1U6i0ICX1neX2zvNjXZDVPna4NPAuDlx2zxR0F3Du2iRn2duHEbm/Zd7wkDdqWU
	 m7DQ0rrxzejSA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:40 +0900
Subject: [PATCH v2 15/20] can: netlink: add can_bittiming_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-15-f128d4083721@kernel.org>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
In-Reply-To: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=929EtOm6sQD4/p82XQBc5sAI4DNI3zMGcd+VcIf3Fp4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRd52qGdf9xc26mUP/9K4Uu3Yx64iSen2L7WbqjSqd
 zlp2+zvKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMBGRPkaGv/0+R7xmX/Vi2V2x
 g2Gtu+Fj3UaW7NDb5zrm+32bLOd/iZFhtuR3pgge127VskOnl6dLll8riWGP2FK67wwjx1KzvdL
 sAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add function can_bittiming_fill_info() to factorise the logic when
filling the bittiming constant information for Classical CAN and CAN
FD. This function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index e2f26898b83be8df8d2c4d0cd64b505f3c4a9b7d..39b7b0a0f5f48ce1765c201e7c3e56a85fd58740 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -567,6 +567,15 @@ static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
 		nla_put(skb, ifla_can_bittiming, sizeof(*bittiming), bittiming);
 }
 
+static int can_bittiming_const_fill_info(struct sk_buff *skb,
+					 int ifla_can_bittiming_const,
+					 const struct can_bittiming_const *bittiming_const)
+{
+	return bittiming_const &&
+		nla_put(skb, ifla_can_bittiming_const,
+			sizeof(*bittiming_const), bittiming_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -652,9 +661,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (can_bittiming_fill_info(skb, IFLA_CAN_BITTIMING,
 				    &priv->bittiming) ||
 
-	    (priv->bittiming_const &&
-	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
-		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_BITTIMING_CONST,
+					  priv->bittiming_const) ||
 
 	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
 	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
@@ -668,10 +676,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    can_bittiming_fill_info(skb, IFLA_CAN_DATA_BITTIMING,
 				    &priv->fd.data_bittiming) ||
 
-	    (priv->fd.data_bittiming_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
-		     sizeof(*priv->fd.data_bittiming_const),
-		     priv->fd.data_bittiming_const)) ||
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_DATA_BITTIMING_CONST,
+					  priv->fd.data_bittiming_const) ||
 
 	    (priv->termination_const &&
 	     (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||

-- 
2.49.1


