Return-Path: <linux-can+bounces-4851-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D9B94753
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA624424E6
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEA031A55B;
	Tue, 23 Sep 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQK8DD4w"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AD31A54B;
	Tue, 23 Sep 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606073; cv=none; b=nAT+PiBsry/2+7vLIH+bqcCt+qhmfLQinG7a0ms8iE1R2O//I6mr7imIpjlH7eSU9P28MwAN+Kve9hb54YB1AkyaHbGPSkF+380BkbX2wY9pFlzy7oop8Q+GgQ1m0YM8lQGQoPj3DjAyZqNQIlQ0+gk/g31OwIfijMlixGBNJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606073; c=relaxed/simple;
	bh=D/fnxllUMFFljUQVKz57aRLrEjBeJpnOQZizLzQrtrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FklxAxTFy8DLeteXHA2FSFuudqczV2zQLXhRSFHaZUHqnNRUZTdR5H7l4bOS0jbfj17Or4g8deC3phvS1WUgYtNGupW/r1axs66PoK/rr47d96DNc1K8/A5plXNfAsuxtxzOVPbFY+VcKmSmaBMU5p9ZYJrTEkFojXnH+l2mHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQK8DD4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C943C113CF;
	Tue, 23 Sep 2025 05:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606073;
	bh=D/fnxllUMFFljUQVKz57aRLrEjBeJpnOQZizLzQrtrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TQK8DD4wldUeYMP7+ylCaL8CEH9vQUjrymLv0i2FcHbGHIGD++3xsQgyDBuMVhG8H
	 l3QfPT4HaYNpDvhH14/xeqxpMaNSnamkHKJ0rf3Icbj2/Gb5OcSNGHLWxkWTXqjNWP
	 fQJomULy/+XCnOIuQ/cgDOqdZiKVFHdb7COmTIeUj7+eewpP0OPawbg5qV1viTBq8m
	 z2cSEQ1/5Pi77yp2EUrX2oGoLjo/jUJEgV7kAsdoFUIICTrNFgpVl5/6O5XGbVuuGH
	 5Kz3XrAxoE0uV+Is6ePA5HPz+EcvHhUZrJx4bO02sE1pP2ZyYKrWlqWq2gG2Esnk6T
	 8r2QvPUS9A8tA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:52 +0900
Subject: [PATCH v3 17/20] can: netlink: make can_tdc_fill_info() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-17-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=D/fnxllUMFFljUQVKz57aRLrEjBeJpnOQZizLzQrtrU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjC79y/if8mlLffGD9ytCmMJCyhaZVCySEtnMHfs6Q
 SyUZ3lzRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIlE8jEyPHscJZc2W7JY/4Tq
 MZ3z8wR8Pxx6Irj4tEfPBQvN4jNHbjP8dxCw92ZSql//9DKHxPTjb/2UN8tPLHx/szDw4q/nnur
 5vAA=
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
index 9794f283ed588e37fbc9a189cb54c6965960d436..99038e0fb25f4e05cd181b188d5aeea25de8f77e 100644
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


