Return-Path: <linux-can+bounces-4616-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C620B50DCB
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617EB16E627
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BB730DD00;
	Wed, 10 Sep 2025 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To6jQbc2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4104E30597C;
	Wed, 10 Sep 2025 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484314; cv=none; b=OcwMb3zTq7SBo0HlJaRvE5OIh61W7jpJaDZuPKvkmLtz4Gl5wv4yN/n/zMmXJl/4IBTxtY3BnAsGg9GIaZG/PJzEGfSx8yF9UszbdovoeYZrc7d8+1GSCFbV9wJf887WXRr2DK9wsHgMkICfmOdljbBfOA+pkIKT+T5UUsB1NFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484314; c=relaxed/simple;
	bh=juwFCjhZpA2PEpp2usDTBZQoUm5o6gL48EyfCnh03/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G81K82b/fYYzzbodAMjMMr9aY/oBBRWmrhWU/XgxRvGfSzs0cSTrRYHVy9ximGaQl1UICNZY/cyYnLfoACugBhTn3QSPwJo2U/bl89HBI7YYZ+znJOUodiLjLbFJy/9DyjBE3nT/jIyFKzX9SB8GFpj3t9/PCxVfeApYFnXGZ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To6jQbc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B49CC4CEF5;
	Wed, 10 Sep 2025 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484312;
	bh=juwFCjhZpA2PEpp2usDTBZQoUm5o6gL48EyfCnh03/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=To6jQbc2uZy+v9DF5w1G48ogq3RhhQ0Gm3W3KNGfVw58+EDqPFAplHeb7QbcgkjBT
	 WpkXHVGKQzo4ZcLy33jXvoIhlSpaw7HDTd4O1YLPvVivekAdaMG3xpxO/mWJ1swwXT
	 bm4B3BsFPeMJettoeNEBMe90uZg9ft31A09gpWk67nk7KJbPz7aSwhtrp/SDG5uPcY
	 WC10pw5H3sHMeu03uMkCoRPke5UOG5xNr9RQwRCEFGCJYbaaGLa1SkhXYJZbc81Cv1
	 TPNSoLn8l5OECAqCb7oxjedv/WnIFrpR8wjnyW1MgxcpchJlRwdyglnMMQ0D+Wy4XK
	 Vvra2aUley+dQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:42 +0900
Subject: [PATCH v2 17/20] can: netlink: make can_tdc_fill_info() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-17-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=juwFCjhZpA2PEpp2usDTBZQoUm5o6gL48EyfCnh03/o=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRT59tt+yJ6e5d8mDs8UhsRt8Hr7WL3Jem358r7jk9
 5vNHoKTO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEykS4rhn9KiEhH15d0KN48t
 enJPaNk9zkM5Hi3OnLXN10/smatT/IiRoWF+TouBtpCmypUjZqWlL9X2Kec0vPO7eP6r/iXWLPc
 2PgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_tdc_fill_info() depends on some variables which are specific to CAN
FD. Move these to the function parameters list so that, later on, this
function can be reused for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v1 -> v2:

  - Change WARN_ON(1) into return -EOPNOTSUPP to suppress a gcc
    warning.
    Link: https://lore.kernel.org/linux-can/202509050541.1FKRbqOi-lkp@intel.com/

RFC -> v1:

 - Just pass the IFLA index instead of passing each argument
   individually. Instead, derive these as local variables depending on
   whethe the IFLA index is IFLA_CAN_TDC or IFLA_CAN_XL_TDC.
---
 drivers/net/can/dev/netlink.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d79a1559ca76dbff8dd1043bfd964fbbe82b1b9c..8c0830fb2d1e729a65aeb8a2eaa0db83959a71a1 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -585,21 +585,34 @@ static int can_bitrate_const_fill_info(struct sk_buff *skb,
 			sizeof(*bitrate_const) * cnt, bitrate_const);
 }
 
-static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
+static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
+			     int ifla_can_tdc)
 {
-	struct nlattr *nest;
 	struct can_priv *priv = netdev_priv(dev);
-	struct can_tdc *tdc = &priv->fd.tdc;
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	struct data_bittiming_params *dbt_params;
+	const struct can_tdc_const *tdc_const;
+	struct can_tdc *tdc;
+	struct nlattr *nest;
+	bool tdc_is_enabled, tdc_manual;
+
+	if (ifla_can_tdc == IFLA_CAN_TDC) {
+		dbt_params = &priv->fd;
+		tdc_is_enabled = can_fd_tdc_is_enabled(priv);
+		tdc_manual = priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL;
+	} else {
+		return -EOPNOTSUPP; /* Place holder for CAN XL */
+	}
+	tdc_const = dbt_params->tdc_const;
+	tdc = &dbt_params->tdc;
 
 	if (!tdc_const)
 		return 0;
 
-	nest = nla_nest_start(skb, IFLA_CAN_TDC);
+	nest = nla_nest_start(skb, ifla_can_tdc);
 	if (!nest)
 		return -EMSGSIZE;
 
-	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL &&
+	if (tdc_manual &&
 	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MIN, tdc_const->tdcv_min) ||
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MAX, tdc_const->tdcv_max)))
 		goto err_cancel;
@@ -611,15 +624,15 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
 		goto err_cancel;
 
-	if (can_fd_tdc_is_enabled(priv)) {
+	if (tdc_is_enabled) {
 		u32 tdcv;
 		int err = -EINVAL;
 
-		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		if (tdc_manual) {
 			tdcv = tdc->tdcv;
 			err = 0;
-		} else if (priv->fd.do_get_auto_tdcv) {
-			err = priv->fd.do_get_auto_tdcv(dev, &tdcv);
+		} else if (dbt_params->do_get_auto_tdcv) {
+			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
 		}
 		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
 			goto err_cancel;
@@ -707,7 +720,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		     sizeof(priv->bitrate_max),
 		     &priv->bitrate_max)) ||
 
-	    can_tdc_fill_info(skb, dev) ||
+	    can_tdc_fill_info(skb, dev, IFLA_CAN_TDC) ||
 
 	    can_ctrlmode_ext_fill_info(skb, priv)
 	    )

-- 
2.49.1


