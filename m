Return-Path: <linux-can+bounces-4439-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B19B41942
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DD5682C3B
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4466B2F60C4;
	Wed,  3 Sep 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2Hnkwvv"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC692F5492;
	Wed,  3 Sep 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889542; cv=none; b=ODuIkB04RavYZkiLxvx86N+61FIU/2NOPBnfrT0K3rZzMwaIm5h4yU05nSULyGRu6pFrOf5DvacJ587Zl9QG5C2YuatOj+0u8I29pXF6O353i6k8693Nhb7S3cB46z8OlmOwV3X9JuuGoUJi4ay7mkvBLsUk+F48W+23UL28aXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889542; c=relaxed/simple;
	bh=gEfdU3yBgU6P6DlGIboec2M/W+93yge5Ct1ObsI/Vm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWbQzYeiiZxKWCNVZKEqAPMi8XxqC1EPJJ+r8Z7uTtiIh6mxO/GV9xZKJEyu5HsIg80CKBL0DjN7BXhzUi/LErC2nfuhXsaImmpzGBj2vFgYsQfbZZTzrFCsFlapQOayCzZA2n4LUdcdFQHTP0DfyB1QZwsfDah7sYxaegAe8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2Hnkwvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FAFC4CEF5;
	Wed,  3 Sep 2025 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889541;
	bh=gEfdU3yBgU6P6DlGIboec2M/W+93yge5Ct1ObsI/Vm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p2Hnkwvv5txefRfTOr2myeip0uYFwI93Puhm2O+WSnwyihl8wntbGZ9SjVDfS9O0O
	 AlitqKLqTVMqs9AOID+oDrvzsNl/igmg7i0c9fE5wyXocMiAIFE1Yjp1gdwGrhuCHX
	 Si9CGitTSfFsQYqbYULzIWf4b4kOl6MCNlIsNaZ9tiXnH5SI9Ew1LWkJJcZTlZ73g6
	 coLXxULFMlquVaPdxUt++4ZKmX8HeblgTUa7DRSs9TiIH+wWnEV58GD5pi9n5uI5Iu
	 ZZ8YQZm5T4PG9ABnzZfpimxczNbSJX0ZLxgcSEcHIsUv8k8whKUF5KCDa6qLQubCU+
	 eJuTJnkn6//hQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:13 +0900
Subject: [PATCH 14/21] can: netlink: add can_data_bittiming_get_size()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-14-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=gEfdU3yBgU6P6DlGIboec2M/W+93yge5Ct1ObsI/Vm0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GGfGRX18u/DKIot+lftTr/uxpLfYu+Qyl+7Zy/6w+
 t8TF4ulHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZy8hTDb/ak1U9trGQS/JRP
 SMdbbXpzl08rVkpewdF3uoOgwkV2bkaGxksvxXa8XFcsneNRuLVa+ODqsrlJvGnpRbLtc15nivD
 xAgA=
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
index fc0d9d4ebc01fa56965a1c0d481c07bd5fee392b..e1ccb65bb555919a99cd9d71fe5f99399539fde2 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -497,6 +497,23 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
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
@@ -518,10 +535,6 @@ static size_t can_get_size(const struct net_device *dev)
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
@@ -530,14 +543,12 @@ static size_t can_get_size(const struct net_device *dev)
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


