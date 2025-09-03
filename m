Return-Path: <linux-can+bounces-4438-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138DFB4193F
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786B53AA4CF
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CB2F4A16;
	Wed,  3 Sep 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5qqi1s7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743042F4A0B;
	Wed,  3 Sep 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889540; cv=none; b=Zq7xg0rUK/0SSjhKY4kr4obqRuI4E7IOzikmJkbEc9V4pe1wHrvpje1qiJ1Q5OSlP8HdPOj5j0np6uIWXoMgL9xFeXJhQGOppAQZPf8cb8Bg79fhcDUQWKoJzrX3J+8wkjoIpO+EwTNk6YjNCTt3IwoAaGtN0q8cISVxzdDL3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889540; c=relaxed/simple;
	bh=2cE885bZ3ITTXuERma0Uf5Ne4R1XoOxisulxvZnvmb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBXZR3WpNZ7hLj2XlIUHmP0g2sJGMVUVEWX0U+BaBk5u+qLYqXmNirwb0xxao2c42aKkZ9VDzWFXMayXmL216uknc8ffO9To++V+7Mbm0OUaEM8vDE6sLbF34IJ7IWxHJFBCjo/6x3JZDFignfBcmwumEZoCYUGqnCK/iOjhzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5qqi1s7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3CDC4CEF1;
	Wed,  3 Sep 2025 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889540;
	bh=2cE885bZ3ITTXuERma0Uf5Ne4R1XoOxisulxvZnvmb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b5qqi1s7PZSitmNcQ3jrWgV+kaHP8tHTlNCe8eVMnzRAGs1f9FCwSRplxqbeWSOAZ
	 BLRcwq2XR5BmOro1RswJj7TPzFZcYtBKqGjSBy/7mXvMnIJiXOPh3EkHOrWwMBbgJ6
	 60OriAqr6XhjRal6FIO0xf2shNtw7DAgBVlsvVau1YpbaHz3owAUrAn6wmm9PpHAyz
	 IpOJOKnpYyBPm7SmkMg60O/KTE13jlxT+XLVUuX5rhljd8I30Al3FFx9CFtH7ISzPA
	 dWW0vUR7tgVvDtQEEt8cG3ZBflfLfxBn2wu0ukgnsKuKtBTtieYXLzxL97jPeCDmVZ
	 mdHseOT22BCvA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:12 +0900
Subject: [PATCH 13/21] can: netlink: make can_tdc_get_size() FD agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-13-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2714; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=2cE885bZ3ITTXuERma0Uf5Ne4R1XoOxisulxvZnvmb0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GKftU7B+MOlMQ31vS9pWAY6V5Y7eCsWCwZaF+y0Yf
 jKKaYV0lLIwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmIjhUob/bqUyN1x26V1NffTM
 zIt1uXwW00ZtoasXL7AdlmKWFNiXyfC/qGErh97G+33ZyimXdLY5BCg0FHhqfU34/KPUod2C6RE
 TAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_tdc_get_size() depends on some variables which are specific to CAN
FD. Move these to the function parameters list so that, later on, this
function can be reused for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 2f6192fc439bc3a7528aea2ad17efd18fce91c2c..fc0d9d4ebc01fa56965a1c0d481c07bd5fee392b 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -465,32 +465,32 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
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
 
@@ -534,7 +534,8 @@ static size_t can_get_size(const struct net_device *dev)
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


