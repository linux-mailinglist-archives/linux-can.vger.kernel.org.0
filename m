Return-Path: <linux-can+bounces-4441-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8E6B41947
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AA7682CA0
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414F2F8BC8;
	Wed,  3 Sep 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8KxcZOW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD52F83D6;
	Wed,  3 Sep 2025 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889545; cv=none; b=cEjBEKcQjmYy25YdagqDKAGGxx4odw8xdsvEyAOUziGOfRaHAhi84/Afx51VpMhjBUOKDUAPAGLbaYHUOPlIRxZ9AK/q5Nqlwr0b4UtD8U2XJVZk2hX+4h4wZeeo6l/RK2PtxWSBRchhP1gvNdU8b9pY8AQ4hcQaTd972YQ38Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889545; c=relaxed/simple;
	bh=fQLITV2DEwk+llmou/UkvpSu3rAnj7qUbF9deEat87I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmqDbXmTwONQC9EyQINRhzufgHQLTOWh1kBRTzhyajbw8sFroOxpXYLZ1KPCMuLLUi0eYSgyz4z6bRVohw3N7CL/FQSAtAsYtWwDoEmR82JNzL/3tbHxDgHvMGfqKBx+DgfaSYQifOiPlGjjIR3fqTwjf9tlRe2mJGqpOi4w53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8KxcZOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8278BC4CEF0;
	Wed,  3 Sep 2025 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889544;
	bh=fQLITV2DEwk+llmou/UkvpSu3rAnj7qUbF9deEat87I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y8KxcZOWATFMgjMmZehIue5FFptUJNLbm7QNiMZVvEMThWnej2CR7hUWzIuESVLkV
	 gPZJmn5JjSO2RQQx5vN02/fLVfA9LOSrklM6W5hdYaJDM4cn56dwIb3AzjIc2pJ3g9
	 mUmYl3gjdv/sCWPQQ0+m5l/2+Q/GCHdAl64Zu3BbCWwjgSP4ycnKzKCmVSX91OPMp2
	 Zg+rcsUWYrWHmm4mWOGRP/ECQJa0u6YG8FyxrZTqd42RyC7+mRdGmP5ekI83ILE7Ge
	 v645TIRDaxM67SWxpEej+145PLYqPwePW9thh5f+g/rNUxtqBoKLqk4kSJY+e4aZsz
	 jNKwEIrRGKrQQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:15 +0900
Subject: [PATCH 16/21] can: netlink: add can_bittiming_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-16-904bd6037cd9@kernel.org>
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=fQLITV2DEwk+llmou/UkvpSu3rAnj7qUbF9deEat87I=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GOcZ5LQXcBz/KXfzvYvjW+7gAq74PI/lu2atmvur4
 8zXUqWVHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACay9hTDbxYvs8cltooiC1v/
 Tb/W8P7x20rviKUODaw3WrjZFu/8/ILhr0xNnkeMi/TuRkX3vp1tuSvuM857lxo2X6xz0vV/z7x
 U+QE=
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
index c3004c92e55cef72b9d03f7742e05fb1404cb1a3..cf9bf8eb1ae8e5c6b7910d8c9935cad73b78ef40 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -560,6 +560,15 @@ static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
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
@@ -645,9 +654,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (can_bittiming_fill_info(skb, IFLA_CAN_BITTIMING,
 				    &priv->bittiming) ||
 
-	    (priv->bittiming_const &&
-	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
-		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
+	    can_bittiming_const_fill_info(skb, IFLA_CAN_BITTIMING_CONST,
+					  priv->bittiming_const) ||
 
 	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
 	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
@@ -661,10 +669,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
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


