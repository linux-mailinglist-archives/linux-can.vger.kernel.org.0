Return-Path: <linux-can+bounces-4440-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E483EB41941
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF131A88115
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2532F658E;
	Wed,  3 Sep 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjG093ae"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ABA2F656F;
	Wed,  3 Sep 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889543; cv=none; b=Bxct7eFnCD0nfIzXH4Cnmte03nJCd+rizl66AmwmC//V0Kajt3CXcG8zEH6ZyWuujtC+bFFCjH8KWUNR7nJpSBUoSnvdjcbJpTOzIdOmnHExqQ6f5/o3CI57vPtXny0f6FEluCafpuBD+NzNpvdcXwub5PFhSkPdx5tDu1ppGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889543; c=relaxed/simple;
	bh=VnK9XwWlQqTcAzjcLUdmaJ0eiYY8B6rEBCKETAxcsC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exUVvJn1bM4jaHV6DaI5M7296LUOyzsTTw9d23btRtAFq8HwSbGAn8JU9Htf0RAZ6Tf9oaIHavEZ9qUOf8N/F8vrArXy8DDWEcbZaVEpqxL0VTRwyjpAKlf1Wi6MqdBZpCdZRCL/tY/uW37e13d7cTyHhV0uI4pAIFA/P/EJ/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjG093ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7937C4CEF1;
	Wed,  3 Sep 2025 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889543;
	bh=VnK9XwWlQqTcAzjcLUdmaJ0eiYY8B6rEBCKETAxcsC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DjG093aeLbynDiiMla18PPGn5uF0i5Lh66G0NUHG/9bGeeblXMzNdXBHiGPOuCiha
	 dGpXArz/Fnbg4d0Tg40su2uOpIXQAnLSeEzv1jl43jJEy5k9V076m7kn0Ff5ZQ+WRR
	 GpQc/MN7L4aXDuCqmDFHvB83TaAOXYnmx9LZHpoY1LtODVjt5RPEycJ1MuhFKNOZRq
	 yeh5fthGX+K6lhkEytoKNerz8A3JPqgrtghmJK/1E0/fi1P+mKKajFgrg8LwFrevc9
	 8aMDZDc7nES6R3or/Y2bB/2t+wz7WeEweXijQUz7LK4loxO6rooCPY9X240fj3E/5z
	 0CUQ0lewTveRw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:14 +0900
Subject: [PATCH 15/21] can: netlink: add can_bittiming_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-15-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=VnK9XwWlQqTcAzjcLUdmaJ0eiYY8B6rEBCKETAxcsC8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GGf7LrC3ayo4UXLLWV+40v5sutb6e0x7H7FUlMsf0
 VrT8rm/o5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwES83jH8L54s+uHITM6pMRPl
 F6eoKszKcPQ9Ira39jxbwcMr2YKy5xn+8GYzxdZMFzPvOlAQ/PuLz6Jf/aVlnHO3rXGeoZZvvpi
 TAQA=
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
index e1ccb65bb555919a99cd9d71fe5f99399539fde2..c3004c92e55cef72b9d03f7742e05fb1404cb1a3 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -552,6 +552,14 @@ static size_t can_get_size(const struct net_device *dev)
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
@@ -634,10 +642,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
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
@@ -652,9 +658,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
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


