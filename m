Return-Path: <linux-can+bounces-4876-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B913CB94A9A
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3237B51F1
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C19314A76;
	Tue, 23 Sep 2025 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYkSJ7SF"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF7314A7C;
	Tue, 23 Sep 2025 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610809; cv=none; b=BHRS6he0tBS5OSL5AdZKjFI4v4r4gO0F7FeqvW5Fk+ElvOsVhCfdW57Q2KykFgVuUJ6HtNy7+22IDF64VDstKZwEY/QBafGLdab03pImYVXxbdPGv3/jZqBJCPEsHRo4yAXmGzRa+Se88T+epyrM0WccjFyLCYAMnKUpBXrCGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610809; c=relaxed/simple;
	bh=g34JJI4MYiixUaRVCWnqaQWymZ4kL9no0rZXQlvaevQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOmgL4MgstK/tNvxBSEIY+lZG+nF5o6GaUJrlhgvDKDhxvoAzhz5KUjAddtlcAVKBytSwgMD4MPRxq6uoVW+w2aJ/toqdR4D2dUy+TxFKvXGH8+5ORrFSrJlQqLCvo5A6XOa28CxI9TVr6ESaDeA/slER9QWuNmMb+dzfe0eDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYkSJ7SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CF7C116B1;
	Tue, 23 Sep 2025 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610809;
	bh=g34JJI4MYiixUaRVCWnqaQWymZ4kL9no0rZXQlvaevQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nYkSJ7SFCHxSESmT67t6zIcXyANzKV4DzB+HzVVPpq+VdFGrxSTzcOuWqbGSjRImS
	 1kZvVCsD6RdFvXd07hqTAr4qNfWUaXDoVxx+P00JbOPwPFOjxn/dnHmdrZVrhVEPwm
	 cs0lBTpxzrBcHBs5Wxfuctylael9EPK7v2bd17a0zLIh/8Ph9aMkhkDd20oXec75qx
	 ai+fhGR8DyVmQtx1tZ/URb8qdF8yEUMByHUGd3/VEQnSbJbPuiDua6X/3s9M6gQTDl
	 O4d1FGFVXsM46qMUIig+xbwZW2aBtChi9aSxtywj1M2FiSJNjKKJHXsWm7EdX0I01/
	 Pc7YsSBItOkvg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:40 +0900
Subject: [PATCH v4 15/20] can: netlink: add can_bittiming_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-15-e720d28f66fe@kernel.org>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
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
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXANiSm/e1N1Sqj3/4+8pcRYvTyn7174oX9L1bOHGh
 tUr7HqqOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzEkofhr0Ddt4eHPn1NPDP9
 zKklP5pYLl/YcTg7RZ/Z+dlH7tgrW0QY/nB0Li+/MWGS3M59bxjT59VFM7bUyiUVP/6q7XvbnMX
 KnRUA
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


