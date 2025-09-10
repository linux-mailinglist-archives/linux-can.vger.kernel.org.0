Return-Path: <linux-can+bounces-4611-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FAAB50DB8
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4186C4E1DF1
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FDA30B505;
	Wed, 10 Sep 2025 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFI+b9Z6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D50530AD0F;
	Wed, 10 Sep 2025 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484305; cv=none; b=qFzJgWpqD0WDnJQUTHVEbWYWYH6fZNosEY7X/PMmX966lk+GetL1gBt/EWjxrpy7dmQWAxjgUtOY51zpEc03wVYfnTsjrf7nvxEZSL9zkL7oWGlf8PEhUGnNk6lGF9lTt/1X6jYUlTBHdoJQUPkHU3IE2CnQxXH4AqWO4zaUE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484305; c=relaxed/simple;
	bh=faDZlEWoYKdD4YhjAFOCXbGZcfZShi5Iz2aATXdGBQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQews+J99brOxHKXf+w1G6Fkrw16KnBwfPl+NTtu4oEnr+zF8tL0+H2OfE0LmvoQvBr8klQciYa6nXlT07s332obmlCY8559R8AGlkWinIVUx11lqs8Q510SvJSHDSdR0g/QbCRmy2MuFxCYq4WwQv9Xxc1ED3jLO+kqXURKscs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFI+b9Z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A26C4CEF0;
	Wed, 10 Sep 2025 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484305;
	bh=faDZlEWoYKdD4YhjAFOCXbGZcfZShi5Iz2aATXdGBQo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CFI+b9Z6xaBesNyOe/K6o52jDj4B22A7f8WsMrcBygPqi/DZI7Hh2UHxTAK5IQqYE
	 JonpDnkti4jR3X/C6RDtKv7tYIRegJPLr7lJoq7HnzIla0kk2o1mWWhnxdCJmidwkS
	 qWO24UFIVwRvf5N1u/bBP9dMZWmiDr6y30Bo7woBHXrhvRZ5hAnMJC+ti1iwAVR5R2
	 0E/LdSiIQEzyI3JWB32vViw7pEFtd7ip8kevQOm/JOGC89ufzK8MELM2ANCktFKMv+
	 QOvJJzZh69UDAl82UlppDkOpp40Ysnl1YS8KZxnwWN5AB+nbqbh9sQVNtSXHTZOf0L
	 lC+1wBRzO0WCQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:37 +0900
Subject: [PATCH v2 12/20] can: netlink: make can_tdc_get_size() FD agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-12-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=faDZlEWoYKdD4YhjAFOCXbGZcfZShi5Iz2aATXdGBQo=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRZ5VK2k+KGqWfrD7/h6P9/M/2KzjtJxlW9PGuaUiq
 dZF6NXHjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABO5E8nI8KiQvc27VslnzY4L
 CsdVOr1/PdNaqWSi5CIR1d/pfF7QlJGhyVXv75SsMMHqyzoNP7ILl5ifeHPr366C7iNMzkVs85e
 yAgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_tdc_get_size() needs to access can_priv->fd making it specific to
CAN FD. Change the function parameter from struct can_priv to struct
data_bittiming_params.

can_tdc_get_size() also uses the CAN_CTRLMODE_TDC_MANUAL macro making
it specific to CAN FD. Add the tdc mask to the function parameter
list. The value of the tdc manual flag can then be derived from that
mask and stored in a local variable.

This way, the function becomes CAN FD agnostic and can be reused later
on for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

v1 -> v2:

  - Small rewrite of the patch description adding one more paragraph
    with further details.
---
 drivers/net/can/dev/netlink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index ab2c9e75347704132b4dfe3b3d29b2c3f1c98908..a49131f227d60e136ea31792a6e8c0157f3a8275 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -472,32 +472,32 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
-static size_t can_tdc_get_size(const struct net_device *dev)
+static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
+			       u32 tdc_flags)
 {
-	struct can_priv *priv = netdev_priv(dev);
+	bool tdc_manual = tdc_flags & CAN_CTRLMODE_TDC_MANUAL_MASK;
 	size_t size;
 
-	if (!priv->fd.tdc_const)
+	if (!dbt_params->tdc_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_TDC */
-	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL) {
+	if (tdc_manual) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MAX */
 	}
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MIN */
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MAX */
-	if (priv->fd.tdc_const->tdcf_max) {
+	if (dbt_params->tdc_const->tdcf_max) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX */
 	}
 
-	if (can_fd_tdc_is_enabled(priv)) {
-		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL ||
-		    priv->fd.do_get_auto_tdcv)
+	if (tdc_flags) {
+		if (tdc_manual || dbt_params->do_get_auto_tdcv)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
 		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
-		if (priv->fd.tdc_const->tdcf_max)
+		if (dbt_params->tdc_const->tdcf_max)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF */
 	}
 
@@ -541,7 +541,8 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(*priv->fd.data_bitrate_const) *
 				       priv->fd.data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
-	size += can_tdc_get_size(dev);				/* IFLA_CAN_TDC */
+	size += can_tdc_get_size(&priv->fd,			/* IFLA_CAN_TDC */
+				 priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	return size;

-- 
2.49.1


