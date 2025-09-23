Return-Path: <linux-can+bounces-4849-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6CB94747
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D447AE9AE
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53DE314A6A;
	Tue, 23 Sep 2025 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTSu0mKa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9E3148AE;
	Tue, 23 Sep 2025 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606070; cv=none; b=bKk+J/W4gGAGEWUj40Tr7moeoRXMe472zT4f2Gh+aB61xo8PG0r5HLwJh+apZvBFmOSSAU1CU5FB2JCvyEY3hxMj0wneLvQQ068G4/uOIge8OhwGBPoiFWAK9J2Cww1aVCO+Jd4Lw0wBgbKlunLFg2t3lRYz38j+ugBUKFwwONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606070; c=relaxed/simple;
	bh=g34JJI4MYiixUaRVCWnqaQWymZ4kL9no0rZXQlvaevQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gv79yij11p5bECyKPtIWZ6TRlE2APR0JlKLGAttvux75+MoeuPmf0zGJfmLGtU2G1PjiiWJcqVQpf48pozPMo7aPywu9mmAl3+fb2Jy0+QljKQdT8sP4noGGexbFVq6KkvS0eN6SMh9gUizNHyOHI1pn/K0Euf2J+F06ilXPZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTSu0mKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA2EC116B1;
	Tue, 23 Sep 2025 05:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606070;
	bh=g34JJI4MYiixUaRVCWnqaQWymZ4kL9no0rZXQlvaevQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fTSu0mKaundYeTuwdMm6y+hB7l2JJQkGQdiSw8NWzR8+AuDc9Bk6x6uutgyp7Ro7M
	 eWKEBs6WAH8Ddifkjh/TOVCwNSFWTAWW/cPJw/r91Qwlw6WdNIZIen7Wf5K9zkJ1c8
	 uUkVEDdl19ipBeI6UBbjajpVJNUjf4sW0VDGPokI0EhrvB5VvmKaZIs/20x5a+lA3z
	 B+A8jdeQk/sjsJHXn1Bew4P/1BgXdaRoW9a+FCOrxB8VW/YG7TgMCSZIL6GWMegLz4
	 APoahFoqVdCrHn6qKQWV2iZ+DakpBOGWrlrxq16NMBhOJchEQoRY1Oz/qkwUaNsZli
	 2H+yvgJec/XfA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:50 +0900
Subject: [PATCH v3 15/20] can: netlink: add can_bittiming_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-15-87a7684333f3@kernel.org>
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=g34JJI4MYiixUaRVCWnqaQWymZ4kL9no0rZXQlvaevQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjM6+Wlz6OCFHdA3j7/V795XcTcg7+uvbm5iXTLN3G
 f1XYlBT6yhlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCR5FuMDOedJPb8eDG37OKl
 IO19Vqav/nyOmRHyWOqcCx+77Jej044wMvQp9F+SFgiUeNg1I/LkZ9tVnoUzKi0PNfS8lrj4reu
 6JBcA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add function can_bittiming_const_fill_info() to factorise the logic
when filling the bittiming constant information for Classical CAN and
CAN FD. This function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index bedd2611d35852e3e1e8b63aa418726a5675897d..fa922a61f75afd18c587f144b6bb2a17be7f26da 100644
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


