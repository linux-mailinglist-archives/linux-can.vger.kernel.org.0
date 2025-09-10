Return-Path: <linux-can+bounces-4610-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C9DB50DBB
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BD21707E5
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F1C30ACF3;
	Wed, 10 Sep 2025 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLY/SlU1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5730ACEA;
	Wed, 10 Sep 2025 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484303; cv=none; b=g+6maDSXrePXGR9k8xIOj+FSKHfrZkpvC1JQGO4qFPLnp6ZJxu39D1USFUr7LZT1Q+Mc1dwJb9Ma0xYZue2F8kVamqsTuapPNnMPIOjpB/WXTnAxZ2Odf05tsteLrkVFs8NQWeVSB3S/4IAC/NTKBbg1ymoIDwKWmpbk+lbs2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484303; c=relaxed/simple;
	bh=Ogh7Ss/aTKbsx92iG49zUPC2IyGgZeHE21Avay2ymEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMuRoE/g4f2a7XxvMNUZCUTgwLe2vPiG5SAVVaa9YOZQzW/X2Zs6jvy2ojb5yaAXF/xz7DkslrLSpgUZWYJFy46l4JpuwbBcJ50PfJ/sFgEHdh9pXkcDbrYRy+eRlc7oQZ2r82sapMg+OjkFfSLFzYbiAbpbWdhSJEN8p8YSzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLY/SlU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACE1C4CEF5;
	Wed, 10 Sep 2025 06:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484303;
	bh=Ogh7Ss/aTKbsx92iG49zUPC2IyGgZeHE21Avay2ymEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XLY/SlU10UwAV495myOqyBDGrHybhc3HPRUlpgD/yW44Jg+aGswl1OyCTiScIXoPm
	 UJOV6ZGW9sEVi/HWF80pDcM2TGEmejYFW62cRnlrH4i0MJShRSQ7CjESMgXhwj1Bm2
	 Qbve+TjZyanlgE9mZ4TfWm9HiTxU96mOY6skw2KIoZ17T6cRQcI45jPRkamWXw696o
	 6Edadj5zW78nuRg09vWIybn7skkD42ST3T7fcGlOLbR4xrZVBASQkdQKTvj6HR+3tS
	 /qOk862b1frkHeeH1+l1iAS8QxxbROONiHXFLhnKNyeF6bq8xpPR3yCcohSZMJdj4U
	 WBzTE+YbcSfeQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:36 +0900
Subject: [PATCH v2 11/20] can: netlink: add can_ctrlmode_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-11-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4331; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Ogh7Ss/aTKbsx92iG49zUPC2IyGgZeHE21Avay2ymEg=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRR4zuye9l14iteLblORdn1gOfdQSSV8lx6Q5WX315
 lXCtWr9HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACaSYMDwh1c5/mqb7PTnM4/7
 xaVFlRk3G2odWnVrCdPl7Mil7SZ53Qz/bFuFFyqenvkpOEY/YF3As5Z9qjEGVt0/I+/333DSd+x
 nBQA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Split the control mode change link logic into a new function:
can_ctrlmode_changelink(). The purpose is to increase code readability
by preventing can_changelink() from becoming too big.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 98 ++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 5812114ca8842baedebd698d3000843dbce3ec7d..ab2c9e75347704132b4dfe3b3d29b2c3f1c98908 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -171,6 +171,60 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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
+		priv->ctrlmode &= !CAN_CTRLMODE_FD_TDC_MASK;
+
+	/* clear bits to be modified and copy the flag values */
+	priv->ctrlmode &= ~cm->mask;
+	priv->ctrlmode |= maskedflags;
+
+	/* CAN_CTRLMODE_FD can only be set when driver supports FD */
+	if (priv->ctrlmode & CAN_CTRLMODE_FD) {
+		dev->mtu = CANFD_MTU;
+	} else {
+		dev->mtu = CAN_MTU;
+		memset(&priv->fd.data_bittiming, 0,
+		       sizeof(priv->fd.data_bittiming));
+		priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
+	}
+
+	return 0;
+}
+
 static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 			      const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
@@ -314,49 +368,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
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
-			priv->ctrlmode &= !CAN_CTRLMODE_FD_TDC_MASK;
-
-		/* clear bits to be modified and copy the flag values */
-		priv->ctrlmode &= ~cm->mask;
-		priv->ctrlmode |= maskedflags;
-
-		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
-		if (priv->ctrlmode & CAN_CTRLMODE_FD) {
-			dev->mtu = CANFD_MTU;
-		} else {
-			dev->mtu = CAN_MTU;
-			memset(&priv->fd.data_bittiming, 0,
-			       sizeof(priv->fd.data_bittiming));
-			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
-		}
-	}
+	can_ctrlmode_changelink(dev, data, extack);
 
 	if (data[IFLA_CAN_BITTIMING]) {
 		struct can_bittiming bt;

-- 
2.49.1


