Return-Path: <linux-can+bounces-4870-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB52DB94A55
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9DD3B3B9F
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114B3128A4;
	Tue, 23 Sep 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzFO/IFa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32F3128AD;
	Tue, 23 Sep 2025 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610800; cv=none; b=PGC3jyaj5+TnOdS5KxWaT8sbNAbOEZkL7ZUUnb2wDuDOQshFMsN6oNA1FiBXaIld96iGkBhswWYybRrWfgTH2tsZ2joqCj9ZlpuxKd5h7ggnCMmfpKwf+BjFXlVkmqIUdUg5i6OL6uafbNk4YFuQpbaavIWfavxwHkDZn71o8Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610800; c=relaxed/simple;
	bh=o4MugYdXfmhUPXOXY4Q6rh0kdu4L448448o6JZzxGa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ow3lMwiMj96c5Q0l8ettG9eRZ5bGQOieb+h3lTrMs56dRnwWSBJpvxvl1CfoT/8hp7eQUe6XdSEmTPm+8+wXrkZdfSf0E9Z64nd164adqF+yE3Pug+rSmjQwUEvfxsU1LPSTp60aC6dvKHuc02OOAXSmNRfnmSbvuTcYTrO0FMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzFO/IFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC1AC4CEF7;
	Tue, 23 Sep 2025 06:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610799;
	bh=o4MugYdXfmhUPXOXY4Q6rh0kdu4L448448o6JZzxGa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PzFO/IFavyhqfzeQg5GQtXPQXi5PjvgJUu0BCCH76E/IXFdf/xU5pUnh1EtOLOv0U
	 z8k8rbsR3yefsW/SYv1+vnJndjn7EojGFLZrymGQmuw+mGlFCJq19ADjT7pd66BfIT
	 4xBbnwNIy2PDtVXMs7ppVmW+hmgZJR2uohE1wAghcALEmMam3iiAw9FUHK4yuF2K53
	 iJAPVSgZ4/uQcrZip1kYz8j5daxlpi95Rj0UoaXv25b3LDPrWWKlzLVIZe/PoewCSX
	 R+3Jks3LxggrhmEzzTfb6gFcE8ZLSe98S2nJaKcLXu4zvf622zkMgUUVO1e2dSIUzg
	 9mHqTqT6kb92g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:34 +0900
Subject: [PATCH v4 09/20] can: netlink: make can_tdc_changelink() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-9-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=o4MugYdXfmhUPXOXY4Q6rh0kdu4L448448o6JZzxGa4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXK2lvzCHf5rF4Z14+u6BQPPHNxKWxe3S881XTT7pW
 s0Tcpa3o5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwEQCJjL8D2uZGrjef2b+nOma
 bUrxobOffRD6mybUkLif0Ww6w2KG7YwMD5Kanr91n6nleVKp/PvUFCf1/Dv5NRqBc8Jbg+v4Ki0
 YAQ==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_tdc_changelink() needs to access can_priv->fd making it
specific to CAN FD. Change the function parameter from struct can_priv
to struct data_bittiming_params. This way, the function becomes CAN FD
agnostic and can be reused later on for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 17ed52d238e3a17e946116a94c7c5f503e184c3d..abff7b84fdce9641e1a5338ec6cef992774b0ec0 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -172,12 +172,13 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
+static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
+			      const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 	int err;
 
 	if (!tdc_const)
@@ -215,7 +216,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 		tdc.tdcf = tdcf;
 	}
 
-	priv->fd.tdc = tdc;
+	dbt_params->tdc = tdc;
 
 	return 0;
 }
@@ -382,8 +383,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		if (data[IFLA_CAN_TDC]) {
 			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
-						 extack);
+			err = can_tdc_changelink(&priv->fd,
+						 data[IFLA_CAN_TDC], extack);
 			if (err) {
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;

-- 
2.49.1


