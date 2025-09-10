Return-Path: <linux-can+bounces-4615-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F338B50DC0
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90EA94E1F8F
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB42630C62F;
	Wed, 10 Sep 2025 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdlfD03h"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2730C62E;
	Wed, 10 Sep 2025 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484311; cv=none; b=EjhOzA86myAuNI7PbWQ3EGXxUyGn1v7JbRM5fj47yp+7Itoe3H8I+2whP8FTq6X7m40yxUGJbivnQNHcFM5SRQ4cckLL9+qVevyCRM04Q4G47BfiWiC3Xu2pHMRu/Z+1kHXGU6kxZf2S5kHdFfRzZQ5bZw//uO09ybksZpT9lPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484311; c=relaxed/simple;
	bh=TwzsJia/6Wex+hAdgCL3nGxx7qXiznIvPUUS1MM0RVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ty0J38i2UdVmBVcq2XZpuyyVBfjCCthtkPZ77oadQDw+y++KFocn1e8xfLlVATuvOSgBVdCjtQk5Z3iPBkILijS8e5K9oqnBsTrO//DdL8DczppAA2/vq8AGmlHLl3/P4QQrQesWTJjN1lgiRydNtS00aQqadwJvk6A+qKZVaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdlfD03h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046BFC4CEF0;
	Wed, 10 Sep 2025 06:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484311;
	bh=TwzsJia/6Wex+hAdgCL3nGxx7qXiznIvPUUS1MM0RVM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DdlfD03hEupONDiJMXVXoUI+XltpS0LUedR2TFkW4DkdcYYDlucBBGSQPY/IRAanu
	 oR6Elcuv9McCBj61BexcUmhCrLsP2WLAR4ociLO0JT7evPBmwa6JBLQKQm3MU9mJjY
	 3rKjLJs+B66Lpg00NqzFaFtu9tGz678tcvDYLmJ0sPdo2re36cUR3KgUNfCB3Eu4+I
	 GG8eJoSrGDHmm+4pEyTSgbIA1i25g4V3WHzgkLbkJECC1AhUspf1SxuCV0StY6bfRD
	 BKxz5QyOXPPeyUDfS/hcZcXfJxqMN1l+OmaRwifQmN9MdfuzX5HQG5pGoqT3f3Q/JI
	 MUamijbL2gdwQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:41 +0900
Subject: [PATCH v2 16/20] can: netlink: add can_bitrate_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-16-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=TwzsJia/6Wex+hAdgCL3nGxx7qXiznIvPUUS1MM0RVM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRd4ffJd+9oxZ8IrI5+I/1vEkMbWs6ixtyytqN/kRF
 CHi8PhERykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInI/GL4X/x3u/cdtRaHPVwn
 fj04VrOa3/h2vKDtt8953asZmqZ7zGRkmLasdkPGRu7Epyclduy6/WLr//yvF6S2BkWt/73kuun
 nlewA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add can_bitrate_const_fill_info() to factorise the logic when filling
the bitrate constant information for Classical CAN and CAN FD. This
function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 39b7b0a0f5f48ce1765c201e7c3e56a85fd58740..d79a1559ca76dbff8dd1043bfd964fbbe82b1b9c 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -576,6 +576,15 @@ static int can_bittiming_const_fill_info(struct sk_buff *skb,
 			sizeof(*bittiming_const), bittiming_const);
 }
 
+static int can_bitrate_const_fill_info(struct sk_buff *skb,
+				       int ifla_can_bitrate_const,
+				       const u32 *bitrate_const, unsigned int cnt)
+{
+	return bitrate_const &&
+		nla_put(skb, ifla_can_bitrate_const,
+			sizeof(*bitrate_const) * cnt, bitrate_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -686,17 +695,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		      priv->termination_const_cnt,
 		      priv->termination_const))) ||
 
-	    (priv->bitrate_const &&
-	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
-		     sizeof(*priv->bitrate_const) *
-		     priv->bitrate_const_cnt,
-		     priv->bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_BITRATE_CONST,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt) ||
 
-	    (priv->fd.data_bitrate_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
-		     sizeof(*priv->fd.data_bitrate_const) *
-		     priv->fd.data_bitrate_const_cnt,
-		     priv->fd.data_bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_DATA_BITRATE_CONST,
+					priv->fd.data_bitrate_const,
+					priv->fd.data_bitrate_const_cnt) ||
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),

-- 
2.49.1


