Return-Path: <linux-can+bounces-4872-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54711B94A79
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337A77B3333
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103F31353A;
	Tue, 23 Sep 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcEk4tgN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C883128CA;
	Tue, 23 Sep 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610803; cv=none; b=uJgJ0Vyov1Do3SWop/VTAf3MtkbyjqGAM/tRKwEyWd3ht2cKHpKYHIaDUOejxydbaaJX5UcY/MTuTsotsA6rdSbs9fN+voYQvOdNDfywBfNDe87g2tdtlJXUUVmAJHjjp3dad4ahKTuyiWnzCPfD1YGJtkVB9uEhqFJzvA1uPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610803; c=relaxed/simple;
	bh=p+xubPDbmlHlPuLjAhtq7k8gryVUlVt/9NutQMUf7Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxC5vKdiU9NutXXTVEqtPN1zQi+WZUCxEE7Z2BjAEw8OPO2cbkrg83mPBbwifRONqHgZBbG+o1CqvXQYxwc3VThacLectx78fVG3sh0S/xPjdBH1cp60Sr+u6F/uZYWRRWygIWd6en8vZUxjkqM1aLVz+gOtcfJz94EM6KknMfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcEk4tgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CA3C116D0;
	Tue, 23 Sep 2025 07:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610803;
	bh=p+xubPDbmlHlPuLjAhtq7k8gryVUlVt/9NutQMUf7Jg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rcEk4tgNkQLW5DSOhmxlKcNqvp8Y3vdOIUr0mWSD8ePJzEpgfEf4o/P6i9Gi53WYr
	 mLGUVQMcww/74okWZlpilMBA/HzDKUrDkJAD+AELmYzIycDGvyHqrkUSuZC4AXN9Em
	 8zkTuarDr+LKxkjKysV15d7zIFqomaIPt69EGrxjlOU4XOlfuHUemhQ3WBrGnsJykj
	 YWpb7AjM6ogvf0oM52kopXIqF51Hmr7qU7wM8wUXr29WFnXmN2kZtY00A4kHks1vaA
	 QDSimW7kNnrmQ9tqGufdCmFoEDt/Ol8up6tNwPlmzLPWZtVD9sg2mrh9lMjk7TnBwh
	 mGStVSDH0tp8w==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:36 +0900
Subject: [PATCH v4 11/20] can: netlink: add can_ctrlmode_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-11-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4269; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=p+xubPDbmlHlPuLjAhtq7k8gryVUlVt/9NutQMUf7Jg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXB1ThA+HzZpZzhn45nAl/4Y5pe8Xyh3uO+o9mfWHt
 uRKF/etHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZiFMDIcE0o+uEf9+i8JPd4
 O/8ZzrvMRUI3uq0+kl0rnSYvfKjmHCPDwoY9i6frPJZqMmc/kd5aErG7ePYOjlvR8RfS183wMFj
 HDwA=
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


