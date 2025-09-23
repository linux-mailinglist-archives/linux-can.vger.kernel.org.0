Return-Path: <linux-can+bounces-4836-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57FB946F9
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DE61885203
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1630E859;
	Tue, 23 Sep 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0UZPO8+"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DCE30E84F;
	Tue, 23 Sep 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606050; cv=none; b=q4zZStQ90vdyplZNu4GZ70d3s9PC1BB1iLyQWjYTc9WyX+Qt1YhTNjHTfMfixjzEJ2YsyfgqcnAe8inUeN0u87Ye5xriupnR3JZFqijEcuVsLJIuGB7sBVUJ9eqMWX7tixb+bV6TbpN9SjC5MsA+Tkat6CWLSKSmAFhIqSBrU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606050; c=relaxed/simple;
	bh=REFhokzmVq+Rh1cbGlF+fG8TBZl94LtWmTGe+FAHboc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/g4/tSpX7RQ4cYFTAnLKyWUYcBKN6VFrsnqKUfJpr5WFtfoLbdp8+Gssu/Gjp8QkkqO4eakEulN3io7bQ3tFU3acAbpGSxbD5ckKIWyOk1ZJQkYlkU5HvhCwoQOrcWjQLQzaLsXgWBtYcByVC76gPO2a3GiiD9gFMMSEYBgAYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0UZPO8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F63EC116C6;
	Tue, 23 Sep 2025 05:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606050;
	bh=REFhokzmVq+Rh1cbGlF+fG8TBZl94LtWmTGe+FAHboc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a0UZPO8+baR3pcyAUsNwssN/buR5qf2TTgbiAnv7m1RGZf4v0EAzGxy6BksFnVRqz
	 w5HIUC7GurNS08dRUgr4B/w62JBwR/RrmUJvwVvy+MVCNSzoZKabDIy7LsEqXErflW
	 wXffaYBD80dOdefjQ0j2rb8OzTikRr636cCv7wvzqw3WNVpnhSXlwpumIDWTxBYJYj
	 w82/f8j45PC1OdOKpFt8BNlYsHMteddZbmkJmiD60MtLRWHHpZ6jeKNp/Dz0vu/DAa
	 nodLSrSVBJoauVCa3nW3mCQYMkm4IyxUvSxWZ3ukEWKpR2hmHOTefTBV1Z6E45Qlqf
	 n8jj0FV2cMY0A==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:37 +0900
Subject: [PATCH v3 02/20] can: dev: make can_get_relative_tdco() FD
 agnostic and move it to bittiming.h
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-2-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4085; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=REFhokzmVq+Rh1cbGlF+fG8TBZl94LtWmTGe+FAHboc=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjNbc/hawoMjlx06eX/e4El613vr6Qaz9nn2w7AItX
 gt2jc9vOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzkfSYjw6wtaTcrvV6dmjBX
 caNheXDPSuUJ0nzhCXK/v27v3i250ZXhf021z3SvePHqY3uMdoh95b7DkO31hKe1M7RbZE1kfWc
 rEwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_get_relative_tdco() needs to access can_priv->fd making it
specific to CAN FD. Change the function parameter from struct can_priv
to struct data_bittiming_params. This way, the function becomes CAN FD
agnostic and can be reused later on for the CAN XL TDC.

Now that we dropped the dependency on struct can_priv, also move
can_get_relative_tdco() back to bittiming.h where it was meant to
belong to.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

  RFC -> v1:

   - Just pass the IFLA index instead of passing each argument
     individually. Instead, derive these as local variables depending
     on whethe the IFLA index is IFLA_CAN_TDC or IFLA_CAN_XL_TDC.
---
 include/linux/can/bittiming.h | 29 +++++++++++++++++++++++++++++
 include/linux/can/dev.h       | 29 -----------------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 6572ec1712ca2df8db7fe1453ae5a4d5699712b1..4d5f7794194ab13641c7854c2d66625c4e942f6c 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -160,6 +160,35 @@ int can_get_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 		      const unsigned int bitrate_const_cnt,
 		      struct netlink_ext_ack *extack);
 
+/*
+ * can_get_relative_tdco() - TDCO relative to the sample point
+ *
+ * struct can_tdc::tdco represents the absolute offset from TDCV. Some
+ * controllers use instead an offset relative to the Sample Point (SP)
+ * such that:
+ *
+ * SSP = TDCV + absolute TDCO
+ *     = TDCV + SP + relative TDCO
+ *
+ * -+----------- one bit ----------+-- TX pin
+ *  |<--- Sample Point --->|
+ *
+ *                         --+----------- one bit ----------+-- RX pin
+ *  |<-------- TDCV -------->|
+ *                           |<------------------------>| absolute TDCO
+ *                           |<--- Sample Point --->|
+ *                           |                      |<->| relative TDCO
+ *  |<------------- Secondary Sample Point ------------>|
+ */
+static inline s32 can_get_relative_tdco(const struct data_bittiming_params *dbt_params)
+{
+	const struct can_bittiming *dbt = &dbt_params->data_bittiming;
+	s32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
+				  dbt->phase_seg1) * dbt->brp;
+
+	return (s32)dbt_params->tdc.tdco - sample_point_in_tc;
+}
+
 /*
  * can_bit_time() - Duration of one bit
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c2fe956ab7761f45a87e77131bb57e9d5d51dd7f..8e75e9b3830a7a0dab16b6450622fc4a98219a9c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -85,35 +85,6 @@ static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
-/*
- * can_get_relative_tdco() - TDCO relative to the sample point
- *
- * struct can_tdc::tdco represents the absolute offset from TDCV. Some
- * controllers use instead an offset relative to the Sample Point (SP)
- * such that:
- *
- * SSP = TDCV + absolute TDCO
- *     = TDCV + SP + relative TDCO
- *
- * -+----------- one bit ----------+-- TX pin
- *  |<--- Sample Point --->|
- *
- *                         --+----------- one bit ----------+-- RX pin
- *  |<-------- TDCV -------->|
- *                           |<------------------------>| absolute TDCO
- *                           |<--- Sample Point --->|
- *                           |                      |<->| relative TDCO
- *  |<------------- Secondary Sample Point ------------>|
- */
-static inline s32 can_get_relative_tdco(const struct can_priv *priv)
-{
-	const struct can_bittiming *dbt = &priv->fd.data_bittiming;
-	s32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
-				  dbt->phase_seg1) * dbt->brp;
-
-	return (s32)priv->fd.tdc.tdco - sample_point_in_tc;
-}
-
 static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 {
 	return priv->ctrlmode & ~priv->ctrlmode_supported;

-- 
2.49.1


