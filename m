Return-Path: <linux-can+bounces-4603-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE9B50DAF
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D21C25A5F
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C9F306B10;
	Wed, 10 Sep 2025 06:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPPWq8jC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2D3064AA;
	Wed, 10 Sep 2025 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484293; cv=none; b=a425D6wCFBboUL+oqJj0iyEtsH+Hd/znxpyN672bGUkrGC1+bUlH+QyDtoUejTV4s7A8P+3dgfJmD0kj6XUNapxLtzr283ft5i/svRVyIMz4ouzVFO+Y5AxqT1egfMq0ni8GiNujtIQeU3pl1yD1PSbvzg5taILAMQ89nxFSkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484293; c=relaxed/simple;
	bh=tdXomOJI//XghU69xAqi9CGEG7kEl4VTCc4F7HwUNcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keZM5VGo78drJzoQ+TMqmW1dWINwsgSfsoDO3X3MsJkLGCd0LpxXiYonc4Dkr60yezYBss8opjGL7QooRpJkEigYe1YyvTOjeZ82CUUnCqaJGAGPmhAcR0J+Fn0NlJz+uUAX1NsNtIBZVcvc5mkgeFK0loUQVnuMmUXlYmeAJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPPWq8jC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581AFC4CEF5;
	Wed, 10 Sep 2025 06:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484292;
	bh=tdXomOJI//XghU69xAqi9CGEG7kEl4VTCc4F7HwUNcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nPPWq8jCLwJX8c1U2FdxzYjwbnYkRHWYZH6pcnDNwqF1YXKHSPcMi+SWzdL6arxPd
	 A79/LW11IwYJ3qb4QLfJyY3lH7nV4eB32HY3a6SVqKG7WIEv7xYZS1X9l8yqT8dRzj
	 VV3o5zFV6WIDiacDyhveqv7T1GR9hdMBx1gXNGdTfzPcwjHcnqdEJzkOr3NTpldomY
	 8Ht/JONPK9aVdmFWHfj2+3wdWWz2jxuW+Y+R1v8kvgWid/G5XS0/RfcuVoxy+cIA/4
	 otmBbm4ygCBf1Z8e5BWp7F97R0J+464NqPV8Tun3+iECkgWtrTtqHfILqLmBWGbWzM
	 uYw0ND//GzUHQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:29 +0900
Subject: [PATCH v2 04/20] can: netlink: refactor can_validate_bittiming()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-4-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=tdXomOJI//XghU69xAqi9CGEG7kEl4VTCc4F7HwUNcY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRS5suhJ3SOXBsrebLDSfmYrrvi/9sTXPviFXMJZ9c
 d9zvzXvO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExELJjhr2iW+wp1kzLfvndp
 db0H9zao1k2pKQmOn3K/N7Ckx6hJgJHhp9RBt+Npqa+7Lsh2T2PS8zmY2+6zNneRvsSSyVVBcY3
 8AA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Whenever can_validate_bittiming() is called, it is always preceded by
some boilerplate code which was copy pasted all over the place. Move
that repeated code directly inside can_validate_bittiming().

Finally, the mempcy() is not needed. Just use the pointer returned by
nla_data() as-is.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d9f6ab3efb9767409c318b714f19df8a30e51137..bc91df8d75ac41381fefea895d7e490a965d3f7b 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -36,13 +36,20 @@ static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
 	[IFLA_CAN_TDC_TDCF] = { .type = NLA_U32 },
 };
 
-static int can_validate_bittiming(const struct can_bittiming *bt,
-				  struct netlink_ext_ack *extack)
+static int can_validate_bittiming(struct nlattr *data[],
+				  struct netlink_ext_ack *extack,
+				  int ifla_can_bittiming)
 {
+	struct can_bittiming *bt;
+
+	if (!data[ifla_can_bittiming])
+		return 0;
+
+	bt = nla_data(data[ifla_can_bittiming]);
+
 	/* sample point is in one-tenth of a percent */
 	if (bt->sample_point >= 1000) {
 		NL_SET_ERR_MSG(extack, "sample point must be between 0 and 100%");
-
 		return -EINVAL;
 	}
 
@@ -105,14 +112,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
+	err = can_validate_bittiming(data, extack, IFLA_CAN_BITTIMING);
+	if (err)
+		return err;
 
 	if (is_can_fd) {
 		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
@@ -124,14 +126,9 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			return -EOPNOTSUPP;
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming bt;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]), sizeof(bt));
-		err = can_validate_bittiming(&bt, extack);
-		if (err)
-			return err;
-	}
+	err = can_validate_bittiming(data, extack, IFLA_CAN_DATA_BITTIMING);
+	if (err)
+		return err;
 
 	return 0;
 }

-- 
2.49.1


