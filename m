Return-Path: <linux-can+bounces-4608-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B42B50DB9
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32D8188FE33
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11DF309EF2;
	Wed, 10 Sep 2025 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VneqGBpN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F74309EEB;
	Wed, 10 Sep 2025 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484301; cv=none; b=aqbNFCIs40BKULkyVxqu2hQZZeaJBrXDCcmrBjlAMUUTtGt+zliHLlrYg84KrPQVKA+UFmzxPlqrzkxNL83alamBl2eojOtRo3SCoBt+JW3PREV2rNEKNJvR+yVb/HIodq4o3LXlErnTH9K4CNkY/qlkeqq934zVoBpLfIpSIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484301; c=relaxed/simple;
	bh=ZPwaMXLQpELfhY6LNtDeM9ItGR8zdqayo+s0dJRI6ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYp2TfgS4pf4a+9KVNhBzTPkeMCG4uQpWZ3BvBvmL8E3GVQq5bNxNeGU5j51fBEYr01bsStlOKX6ZdrGLdjvgYQmO1YKkYa7gq4MA2zLcR8lPzzdTKqUxDGSK56zcvc7p4tgXN1h5R1+9kh8WavyBqc+tnAPl8e6AjBlwBIFXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VneqGBpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20411C4CEF9;
	Wed, 10 Sep 2025 06:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484300;
	bh=ZPwaMXLQpELfhY6LNtDeM9ItGR8zdqayo+s0dJRI6ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VneqGBpN7FlBWpEhvUd5AbpBtrTcYJalnYmULrq4aXsQTmBsvJ0sYspSrkp6Qi1OZ
	 /sljBx849RMarQ121+L7Y6oXMY0pMujVM6CpSEA0GdV9HxuGuIKfS29/1USgona3Fd
	 /hzD8PjFCZZ1nNjg2IMPjRhw9yduQN2f20Chp+yZwtq2XZNbhNum8zKY54dUfKIz8L
	 1DesJkjiH2QySc7jPpO2e5doBio6vitY/e5gIoQ1JgGemGAEfDwl/GI3k23sksh6NA
	 ViTtP+uXcSX23VQhNp8ThB3KhizU7bA5XLUKcDf7Se4eS8Pxr2+EBKJurjGpz11h6y
	 +MbqaiIyAhrWw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:34 +0900
Subject: [PATCH v2 09/20] can: netlink: make can_tdc_changelink() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-9-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=ZPwaMXLQpELfhY6LNtDeM9ItGR8zdqayo+s0dJRI6ng=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRe79Ek2fN1dBcDaPk+NRyWdTXLLUpx3jNMpiSfy0y
 qf8/ZrGjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABMx+s3IcGRizaPbk76wVTM/
 5WvNU/BZedx/0VvJrF1G7AGhh6W4XRn+l9+c4XfmTE0Gw8dd6/1m3j30/c73x//+Vk1uX53oLrd
 zDTcA
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
index 33a6621bd7a916583802fa12e0bd971c89560924..fde6565fa04af0c5615c09ebb094cbf8bcef3172 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -171,12 +171,13 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
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
@@ -214,7 +215,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
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


