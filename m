Return-Path: <linux-can+bounces-4875-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85AB94A76
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE8E176EC5
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E18B314A63;
	Tue, 23 Sep 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjvj78sd"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412A314A61;
	Tue, 23 Sep 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610808; cv=none; b=mLD9GO7ItbR1pqLp3z/vpahNA871BDw5rdRF+Td8Ni2ter7f794vOL+FRG7b7QEfHVPn03SGSRSddvH4X8uweyI+Oe/xmB3DNiRPl8p0JofgnmX4FQf+Aopj9tAt1oM1GDa9w8h4o6kfAlSWFK8XmgtHLZzFDgf4nlzFjKp5s1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610808; c=relaxed/simple;
	bh=vvz9ul3gCi9NrWnP1mxXcrN0iSXDjogBTe50AwWngEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDxXp1nd2bGyHkLcyzCHH/Bx01Ed2W5LiXjWqXbffuJO/7ougCQlY+4uEpvfjrn4DtJuV9fKNeVYjEEwENdLCHawlreBjXhVJBx5xA7wNnxC87GLVT1Jh9/58nD+unujuLoTQzG3Y9zies9RKQNIr+e/auiZBvmpcS+CqiuYc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjvj78sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4BFC4CEF7;
	Tue, 23 Sep 2025 07:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610807;
	bh=vvz9ul3gCi9NrWnP1mxXcrN0iSXDjogBTe50AwWngEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bjvj78sdxJtMQiOyF+hIrqfDtVPrRLxWeTrQN19d/HdNKqwtraRu3Y+CNfUm8sGMv
	 4X3ErLnA1pnQ3orTCkf4bGxB0R0vx/FaNTlO3mXjDWW7dCvPCeDAjkMddHcyGa31qv
	 jRT6ddhxslG8YxJC+89tAOcsTO4Qs7+ikr0sZ4Do0U7066QgQEATakIUdR6xwXbSvr
	 rUBxPxwukj87b8a8YZP7a/DTEYAT8fTr4IRRT/Zyc/L7lTJ9XMY2bZgq1RUrueB86r
	 mWK+dkvMkn9GY9nWMIJ3nLr/2eIOHMXLslKjtAGhqVVFlnthnftbFysWdyN37mQq/0
	 mGa6OXRkkrQMw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:39 +0900
Subject: [PATCH v4 14/20] can: netlink: add can_bittiming_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-14-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=vvz9ul3gCi9NrWnP1mxXcrN0iSXDjogBTe50AwWngEg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXH1/Bp1PcpnU7MgT7djIf0Vvk+1Hndnanhwhe1K6v
 JpjHLM7SlkYxLgYZMUUWZaVc3IrdBR6hx36awkzh5UJZAgDF6cATIRrHyPD6Y9btR5HF0lubVrG
 de2J8v8Fe468vJwSeOolQ63GgoCVcxj+2VpNSFvaJNPpt0mBy4inuf/UN8/tLhMqd11Yp/fJLPs
 VDwA=
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


