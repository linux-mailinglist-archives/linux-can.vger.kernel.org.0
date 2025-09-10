Return-Path: <linux-can+bounces-4612-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302FBB50DBF
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2CE189B083
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55D30BF4B;
	Wed, 10 Sep 2025 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT7hafGp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B630BBA4;
	Wed, 10 Sep 2025 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484307; cv=none; b=LCm5YXs1o/jkozS7mtNVZXkvO7hRT2by+8EzqYHT7DL0IVAxHpicE1cga05Q3DnIWIaCItw8xB6VECz+B7jAGmTw0udy3nP6BWdsIsRBIGQRB/u9w670FjFUcUHEGo+eI7WYzUM+4Oqq/8ZVPG7aLlG5vWys+hGKrjwrJBxHjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484307; c=relaxed/simple;
	bh=6zg+qPvfilA0yhLj5lrUlqzYlcQX6SDNB9BNFfpT4YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzXuzG9y3ZlhJpJ6OQW2HTnjPsTu0tz3O2TLXr78FMb4dSJKL6iLRMo0KyoCbGKxiwy4jkX25ATlen7WPBrzDrvBQO0brEXLHz9cII+lxLMOKvTFKPjQ/RfYsegGlMlm6mPSkXwS4dw0xqz/qyoZyS0/ldjEuEYgt4t0CJ7d198=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT7hafGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573ADC4CEF0;
	Wed, 10 Sep 2025 06:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484306;
	bh=6zg+qPvfilA0yhLj5lrUlqzYlcQX6SDNB9BNFfpT4YU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TT7hafGp4YOFuh7dwY1BZTzEUeaYDjWj17Ggl3m2krKMDpwrCyKgWaK6neSmmAQJJ
	 F6wkl46Na77hxS1jUqvRraYtSDNdlf7ATUr/EWjGslH3T6nIZhBN4q9S4oZqeHyYlw
	 HX+SUQ8tol813HsbtaXsmQOHIAIRBl5EnLoDq65jlYL1AF/zZymQsMYtIFRk+nZSQl
	 BVxzdaIwClYS+NKW4Qo/h54KPBtjqhM2/UC1VamK1yjiW1CW4VGR+kMAcWh1cxq4qg
	 BJDk4w7Y45eUmmm8O8T9H5W238o6PBW9IMpe1xwtBC7nN0G8OMBVa+Zg0o5rAsJdSn
	 n1ytmw6EllaYg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:38 +0900
Subject: [PATCH v2 13/20] can: netlink: add can_data_bittiming_get_size()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-13-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=6zg+qPvfilA0yhLj5lrUlqzYlcQX6SDNB9BNFfpT4YU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRV602Lfe8It7w/n/tm1x1q/WaXMF5ApWtGu0zqudN
 uGvnLZJRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgImIf2L4HyQhKTNPeU7C/Rkb
 mXyaQ7Z9CcvSe8e8I3CP1KmTjr6Fdxn+l3512ZzMZiC9rsk1N/hX5MuXVuv+yubOPm2i7coZM82
 GAwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add the can_data_bittiming_get_size() function to factorise the logic
to retrieve the size of below data bittiming parameters:

  - data_bittiming
  - data_bittiming_const
  - data_bitrate_const
  - tdc parameters

This function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index a49131f227d60e136ea31792a6e8c0157f3a8275..c30920761d25871ac2e73a56a54333c521b4f9d8 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -504,6 +504,23 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 	return size;
 }
 
+static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
+					  u32 tdc_flags)
+{
+	size_t size = 0;
+
+	if (dbt_params->data_bittiming.bitrate)		/* IFLA_CAN_DATA_BITTIMING */
+		size += nla_total_size(sizeof(dbt_params->data_bittiming));
+	if (dbt_params->data_bittiming_const)		/* IFLA_CAN_DATA_BITTIMING_CONST */
+		size += nla_total_size(sizeof(*dbt_params->data_bittiming_const));
+	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_DATA_BITRATE_CONST */
+		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
+				       dbt_params->data_bitrate_const_cnt);
+	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_TDC */
+
+	return size;
+}
+
 static size_t can_ctrlmode_ext_get_size(void)
 {
 	return nla_total_size(0) +		/* nest IFLA_CAN_CTRLMODE_EXT */
@@ -525,10 +542,6 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
 	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
-	if (priv->fd.data_bittiming.bitrate)			/* IFLA_CAN_DATA_BITTIMING */
-		size += nla_total_size(sizeof(struct can_bittiming));
-	if (priv->fd.data_bittiming_const)			/* IFLA_CAN_DATA_BITTIMING_CONST */
-		size += nla_total_size(sizeof(struct can_bittiming_const));
 	if (priv->termination_const) {
 		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
 		size += nla_total_size(sizeof(*priv->termination_const) *	/* IFLA_CAN_TERMINATION_CONST */
@@ -537,14 +550,12 @@ static size_t can_get_size(const struct net_device *dev)
 	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
 		size += nla_total_size(sizeof(*priv->bitrate_const) *
 				       priv->bitrate_const_cnt);
-	if (priv->fd.data_bitrate_const)			/* IFLA_CAN_DATA_BITRATE_CONST */
-		size += nla_total_size(sizeof(*priv->fd.data_bitrate_const) *
-				       priv->fd.data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
-	size += can_tdc_get_size(&priv->fd,			/* IFLA_CAN_TDC */
-				 priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
+	size += can_data_bittiming_get_size(&priv->fd,
+					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
+
 	return size;
 }
 

-- 
2.49.1


