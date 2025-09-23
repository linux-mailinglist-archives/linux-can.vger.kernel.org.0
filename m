Return-Path: <linux-can+bounces-4848-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C128CB94741
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C13254E137B
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B03128D3;
	Tue, 23 Sep 2025 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htcWT9LL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596993128D1;
	Tue, 23 Sep 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606069; cv=none; b=V5Bsm0Of/AMIXlCLbj0XdiryenfwuyeXTubutv2AxNv3c764AY50G/eMFXrKrinY9FaAhBE/3H860HkKg5E5ARB5zIhEmvhuY01x7tMidyyBszWdLu0F70MVendwwNRJVXaX/5Eg4Tx4n1erxaeBHzJ8z7AHiMmyPZJI+pIcTq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606069; c=relaxed/simple;
	bh=vvz9ul3gCi9NrWnP1mxXcrN0iSXDjogBTe50AwWngEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRD6q2hEsAEvgQf9OqjMQtInU9fFWStwVbwgE9iTAk1cbWCSSP21RbbmXb83/8paZfphwieZZ9oqqznSQa/2F4tkyKNK2muRNVQM1JQTttAZViepAIjT26Nxba0fNq/DAebsrisq+ggbA5F0ZLYAENq5MuXYW2Dt+tvFW3TRupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htcWT9LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC18C113CF;
	Tue, 23 Sep 2025 05:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606068;
	bh=vvz9ul3gCi9NrWnP1mxXcrN0iSXDjogBTe50AwWngEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=htcWT9LLgKEcMRJL43JA9Fp8C5lQ1fPP4o4y41qSHUthntxh70gR4PjN/2zmjMEbO
	 HYLXLlBv4SR+fDMXxj/DuurWMly1G3+nBMgFuniqomc6SBY4msKSbLphXTK31rhH/8
	 n4wPO35qrdcgW+t19LVv+pcg3zNa0M4enxr7u7Si/ICvR4Z5lUyHj3fdHwzAYrmHV3
	 c0LdzbCQRJfkL4gps9hnOzjzYi7A62geRulonCsCJCRfec/cdtGfLCgq/i4lvFfG48
	 L9flLpgqkM0MFdQUbbKdUPRuxKKMNu6V6/8iluMfOYx/y8nQOUITLkaHEjc/90j+/F
	 11qpexMQMeLiw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:49 +0900
Subject: [PATCH v3 14/20] can: netlink: add can_bittiming_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-14-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=vvz9ul3gCi9NrWnP1mxXcrN0iSXDjogBTe50AwWngEg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjE6JdBrvsu/izpqSmn9E+11iB4eQoUPSiZBTV8vmq
 vq+PXOko5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwERmzmBkeHD2nvK3RaHLXn31
 WuOU6rvkfeKh8LP3CvvO3xE6oZ+0L5HhrzTX/Ty5pfv27o7XmsukI7+ouVjqlvSlTfNbv6U+ig+
 /wwoA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add can_bittiming_fill_info() to factorise the logic when filling the
bittiming information for Classical CAN and CAN FD. This function will
be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 5d2b524daea90442e56a1b24e7c32190a84ed934..bedd2611d35852e3e1e8b63aa418726a5675897d 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -559,6 +559,14 @@ static size_t can_get_size(const struct net_device *dev)
 	return size;
 }
 
+static int can_bittiming_fill_info(struct sk_buff *skb, int ifla_can_bittiming,
+				   struct can_bittiming *bittiming)
+{
+	return bittiming->bitrate != CAN_BITRATE_UNSET &&
+		bittiming->bitrate != CAN_BITRATE_UNKNOWN &&
+		nla_put(skb, ifla_can_bittiming, sizeof(*bittiming), bittiming);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -641,10 +649,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
 
-	if ((priv->bittiming.bitrate != CAN_BITRATE_UNSET &&
-	     priv->bittiming.bitrate != CAN_BITRATE_UNKNOWN &&
-	     nla_put(skb, IFLA_CAN_BITTIMING,
-		     sizeof(priv->bittiming), &priv->bittiming)) ||
+	if (can_bittiming_fill_info(skb, IFLA_CAN_BITTIMING,
+				    &priv->bittiming) ||
 
 	    (priv->bittiming_const &&
 	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
@@ -659,9 +665,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
-	    (priv->fd.data_bittiming.bitrate &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
-		     sizeof(priv->fd.data_bittiming), &priv->fd.data_bittiming)) ||
+	    can_bittiming_fill_info(skb, IFLA_CAN_DATA_BITTIMING,
+				    &priv->fd.data_bittiming) ||
 
 	    (priv->fd.data_bittiming_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,

-- 
2.49.1


