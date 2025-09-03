Return-Path: <linux-can+bounces-4437-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCF0B4193B
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC241A88623
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7B2F3C21;
	Wed,  3 Sep 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd6uQBTw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD02F3C14;
	Wed,  3 Sep 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889538; cv=none; b=fvGTt11mQb5UbC1NkWqLlsnt/IHCV3IMoI7DEoe7rzv+XV1NXk2tavYKGWgItc0wIhuy6wLOX7MODQA07gEJzdO15P3V/owamm9F6KJFjzJr6ByIhpF1kYbz4FCpERC3947nH4qhgUq5U79fdJZaJQFQ0l1FboS8+XyRwVRYTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889538; c=relaxed/simple;
	bh=fbg4LcWIev6X2gJK2JMdJuUZi1OWGOZTlAtYM2zbcUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4ud/ErVgKdB2b6MT8mAbwFIaPvWzTqI1Yxepo+zZAmcJbYMfYLVfwVg3NiWvCkrvKOv+BSRiJN+BT6GsQPyZqIri1CLwWqxjLn1Fz0U+zTREXAu17IR5tHb2g0EIQql3Q8ZT0IL6R8QtF46ZuQh4VJdt2LmnP3EKmgRlzcLBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd6uQBTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E15FC4CEF0;
	Wed,  3 Sep 2025 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889538;
	bh=fbg4LcWIev6X2gJK2JMdJuUZi1OWGOZTlAtYM2zbcUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pd6uQBTwpePXctWI4W+PKhUHxpVa9yNRT9zF/LbqPcajXSGQ9TFdxUaWv9tIk3mgW
	 6rbczuCr24Zbs/+p6+B4VkcEZtpLDFlhz83C4XnGDqH7ic7HOUujr641aNbOzB6IVr
	 flcZylt5RaLx8iqwP9paq1fw2l/UbE2mH/ZLq5+0O6IjNZmkWsLYrMxZVRHOnzbQoj
	 0xn0w3znRz3qL+XzC2LceLLEtj8zWtqcXU4sDrnbHR/k12tYel9Di0yJXpzZ7Q1jUv
	 rqtElfscv0TiOPXlpzXlZVX9RgqVrTgWLPbZeMEIUquyOEs9kb+gHUllrtseFMU38I
	 CeLlptGNKZiog==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:11 +0900
Subject: [PATCH 12/21] can: netlink: add can_ctrlmode_changelink()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-12-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4331; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=fbg4LcWIev6X2gJK2JMdJuUZi1OWGOZTlAtYM2zbcUY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GCcve5V+IHlNzMEfueUs3ivmz5PecnKFaPnpd/UuD
 iv2hfjN6ihlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjARt8eMDNvmP/z597LHLP30
 Ha+EulgzGn5PKlzw4mJkb9pxPsVTXCcY/vstLHJaujRTa+NRnh4luxW/Qjpm/LCosH4sssG++Hn
 UZB4A
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
index 47c0b88ab2b3b1f6a2b006760124fe0ba4767e42..2f6192fc439bc3a7528aea2ad17efd18fce91c2c 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -164,6 +164,60 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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
@@ -307,49 +361,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
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


