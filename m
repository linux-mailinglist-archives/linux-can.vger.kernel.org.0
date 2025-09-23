Return-Path: <linux-can+bounces-4873-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94197B94A64
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4062A5C96
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AF130FC3E;
	Tue, 23 Sep 2025 07:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pysIleVr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB7313D71;
	Tue, 23 Sep 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610805; cv=none; b=jyvj3dYIlWISdy/LtWa7ahoXmMkW5tVXpwOlsoDpkldt4S2ewxtpruVGPGVm+hyz1K61VVkuTYZHwbQPI23y+sf9I/S1KulDw/d+jX/OG/A1YYe1K3QcsT1qU6nAqbJn2JU9cvoDpnDrpTD/3JO+jheGYQYrJyjaGk8xgMgtkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610805; c=relaxed/simple;
	bh=OHRQFZqsnTAMm/R0kHHlL+RdEIOPDbia69+QsOEPrOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkGjM7LLcEV5udUw7cVbOtRknVtlNoaIxZ6ASatH5lHMomFLbECYpHzbW2u0R5dqB4W7y1dlSgY0xk3JDmxgQx9GyNEuyp6xrcEm004B6Zjwae2XmeCFYfUVuy3OljWOCxl2KfUTOVpNLmMdL3G+b8i4QjjiqlJN/+tHZGl66d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pysIleVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB1C4CEF5;
	Tue, 23 Sep 2025 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610804;
	bh=OHRQFZqsnTAMm/R0kHHlL+RdEIOPDbia69+QsOEPrOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pysIleVrQQ7ImCXi/ZZTATOXXryOXWT6opjbSweUOWquGxzSNznF81pAHbMkAzO0r
	 fZYOh+3Kao8O+AM//d2EjrRoqLRsUe4QC0xBiSMixc+4V3/SHuvuLV5ew7nolLcKVq
	 Ejd9g1S9zps27flYFYLLKOlQXaUKaLcrTRnVWAwGIVBsya/5r5FIfB/VI0oPNy+gLY
	 9cp95GMvdBNU9CVFVaDHv2ZECSSbYeMcI5akv1DMjqTMFJb4uFrOwOBCsbfJqj8LYl
	 cZFB1epW55oNCp5EgT4O2C++UQ7g+c96AVthEdZQweZeUrrVaP5nqnSmjfng38P017
	 oAmzfL32gTnpQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:37 +0900
Subject: [PATCH v4 12/20] can: netlink: make can_tdc_get_size() FD agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-12-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=OHRQFZqsnTAMm/R0kHHlL+RdEIOPDbia69+QsOEPrOc=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXJ3XCgWu2BCVdjnxpnhoVNu8O9P7a5W0bu7210x73
 TXlas6WjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABOx7WL4H9Q0d92VFqkjL212
 2P2/8ClxDluj6mn2eVccTsxlfB24L4eRYXL+/50dEg1HIhomHpLfaTPrbvznwF9/nqtXMq6wlBK
 z5QcA
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
index e1a1767c0a6cfeeb06b7d53f9ec4c48d76387b62..3c0675877f5ef84a2b84d5852a0e91d23b164eeb 100644
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


