Return-Path: <linux-can+bounces-4845-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1C3B9472F
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D11816DCDA
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90932311C22;
	Tue, 23 Sep 2025 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh6a1RSy"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7530E836;
	Tue, 23 Sep 2025 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606064; cv=none; b=QJ6fWJ2sDMZP003NomHsWMQa9ymE/sqUSle0uETleUYl+7LYGfLLF1ifQxKGRPyllVWwqGF7k3DoXNQyXFT1pL3yciOuB0qkurER6zMCBJ3mNUxiakv/YHUBRRl0ZRIeTC1Je+7LmKv3nNj/dBltAbgql6apWkEi+q6R4DhECj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606064; c=relaxed/simple;
	bh=p+xubPDbmlHlPuLjAhtq7k8gryVUlVt/9NutQMUf7Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CK8jOXNRMxWkC2x5XTJzdG8jmbIzq5pPFth0p+sjJnhrvqDFsl+uESLYAKfBajARKg66xMl9S4ibk74XzT4Mez5Bp0UUHm4fPViHDR3+KKCyOzPWCe5LPUZNMiDrCgiXQek4T8njfQC/gjRZ7FdA6IlinQPVRX0yZcl5Fb7OBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh6a1RSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C082C116B1;
	Tue, 23 Sep 2025 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606064;
	bh=p+xubPDbmlHlPuLjAhtq7k8gryVUlVt/9NutQMUf7Jg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sh6a1RSyeCfIIqDLDGarJkzNUb4b+TT5LVheplt5d1+Vl77ZQF/9x3cpi6I46Tqf+
	 s3U4m1rsbFwM0wOkYQgnwowKuObMjqjehcFjQLcrs2YnQqa+qUQsW079ZhgjIXCMcI
	 JmY6IRrLeqgnXuttxP2ydltxezl8N/rQAavnqcJlk5Jd8ovlyDMD95fqLh4Ftco7wt
	 y1A47fmd4x6QSIrXYaJUGExcdmX7ZY8B1hli7bB9UI4FrGEmKlc95VtaDXxZ5oHW+3
	 IRwzJ0JHGVnBpIH6b55yEf/X0qaoRU4D2+RM5yfI2zsIfHvY27IRkobSFU8YMEBkwr
	 TJg6gJlXzJRyw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:46 +0900
Subject: [PATCH v3 11/20] can: netlink: add can_ctrlmode_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-11-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4269; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=p+xubPDbmlHlPuLjAhtq7k8gryVUlVt/9NutQMUf7Jg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjA5rSt2+2HXryXTuJp0zpxcuXaPTkbAkYqK/B6veq
 SlsV5QkOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEykq57hf6LTt6tBvzUC77wq
 zztq/K9sre6FXNcwjlUqQRb1T4/edmD4p3pj119FqZR34df73pnlM2/cWBEx8WFgyJ07iQlLmF6
 9YAIA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Split the control mode change link logic into a new function:
can_ctrlmode_changelink(). The purpose is to increase code readability
by preventing can_changelink() from becoming too big.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 96 ++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 5f2962aab5763a0dc8f86a6fa7fa3afbef125d26..e1a1767c0a6cfeeb06b7d53f9ec4c48d76387b62 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -172,6 +172,59 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
+static int can_ctrlmode_changelink(struct net_device *dev,
+				   struct nlattr *data[],
+				   struct netlink_ext_ack *extack)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_ctrlmode *cm;
+	u32 maskedflags;
+	u32 ctrlstatic;
+
+	if (!data[IFLA_CAN_CTRLMODE])
+		return 0;
+
+	/* Do not allow changing controller mode while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	cm = nla_data(data[IFLA_CAN_CTRLMODE]);
+	maskedflags = cm->flags & cm->mask;
+	ctrlstatic = can_get_static_ctrlmode(priv);
+
+	/* check whether provided bits are allowed to be passed */
+	if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
+		return -EOPNOTSUPP;
+
+	/* do not check for static fd-non-iso if 'fd' is disabled */
+	if (!(maskedflags & CAN_CTRLMODE_FD))
+		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+
+	/* make sure static options are provided by configuration */
+	if ((maskedflags & ctrlstatic) != ctrlstatic)
+		return -EOPNOTSUPP;
+
+	/* If a top dependency flag is provided, reset all its dependencies */
+	if (cm->mask & CAN_CTRLMODE_FD)
+		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+
+	/* clear bits to be modified and copy the flag values */
+	priv->ctrlmode &= ~cm->mask;
+	priv->ctrlmode |= maskedflags;
+
+	/* Wipe potential leftovers from previous CAN FD config */
+	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
+		memset(&priv->fd.data_bittiming, 0,
+		       sizeof(priv->fd.data_bittiming));
+		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
+	}
+
+	can_set_default_mtu(dev);
+
+	return 0;
+}
+
 static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 			      const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
@@ -315,48 +368,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	/* We need synchronization with dev->stop() */
 	ASSERT_RTNL();
 
-	if (data[IFLA_CAN_CTRLMODE]) {
-		struct can_ctrlmode *cm;
-		u32 ctrlstatic;
-		u32 maskedflags;
-
-		/* Do not allow changing controller mode while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		ctrlstatic = can_get_static_ctrlmode(priv);
-		maskedflags = cm->flags & cm->mask;
-
-		/* check whether provided bits are allowed to be passed */
-		if (maskedflags & ~(priv->ctrlmode_supported | ctrlstatic))
-			return -EOPNOTSUPP;
-
-		/* do not check for static fd-non-iso if 'fd' is disabled */
-		if (!(maskedflags & CAN_CTRLMODE_FD))
-			ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
-
-		/* make sure static options are provided by configuration */
-		if ((maskedflags & ctrlstatic) != ctrlstatic)
-			return -EOPNOTSUPP;
-
-		/* If a top dependency flag is provided, reset all its dependencies */
-		if (cm->mask & CAN_CTRLMODE_FD)
-			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-
-		/* clear bits to be modified and copy the flag values */
-		priv->ctrlmode &= ~cm->mask;
-		priv->ctrlmode |= maskedflags;
-
-		/* Wipe potential leftovers from previous CAN FD config */
-		if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {
-			memset(&priv->fd.data_bittiming, 0,
-			       sizeof(priv->fd.data_bittiming));
-			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
-		}
-
-		can_set_default_mtu(dev);
-	}
+	can_ctrlmode_changelink(dev, data, extack);
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;

-- 
2.49.1


