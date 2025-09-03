Return-Path: <linux-can+bounces-4427-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD92B41927
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E466456214F
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED602EC56B;
	Wed,  3 Sep 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG93bKg3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021832ED854;
	Wed,  3 Sep 2025 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889524; cv=none; b=UW6uUE64Ra8RZLqt/anJBzKZUFtXHVXJpEHSUlkwJxMw9LqykQbt6JZ9zB8kVG6VyTSZVzqhy0No16ZvaxRq9O1xA62n67WqjliF7HJYecA/nezwMMx2QzmhQdC3efMXAGcLzVc7GrntKznrcmTA1KJ70mHpz87BDUSkp6o0K0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889524; c=relaxed/simple;
	bh=sWHZaOqLzX2L2GpQTcYE/d6XotteDzKRJz/cgKPJ+a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+PpMZ2b4Ekr315XMZ1aJ0RGr8cDvsx1jbIc3NWUXtrPzCLWWcqZNgqsjclkSvxRQhpe0DAerTqVAvxuM1G1KMvUpA3Ae0wIqTJntcH8UpRZXv4T74Lw8MZA4JU+iss2q7eKVANTth97J8E8xnUzBJrI5G655DE+qbkF9IemAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG93bKg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A59BC4CEF5;
	Wed,  3 Sep 2025 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889522;
	bh=sWHZaOqLzX2L2GpQTcYE/d6XotteDzKRJz/cgKPJ+a4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HG93bKg3KvPkZ0KC5v3pZVziVqPQLuXO3a0CyvJBmDecUscsxuIauvRW7aU+X71yG
	 0vuiTDqU3F70tTsXI07Qdme9AY/Fevd8Pv48Y4kJeyTqb1E+a6WrbHc0jIxbGm7yj1
	 5xl/MTf8jrIA2mgbY6qS77l71RkVjQQk23bg1qj5oV3RDJAeU669J09zvkRQRzgKad
	 njfEagdLzNMGsg82ZkbgsVZeL2UF8kOzMgSJfCvpzOIzOzwhYN2RlRZVc1jMRdgd12
	 9Vh2ShPnatwVlS71nxkDruHT18wsrDAyFwr68v6hCI8+vbdn2Otx6pYfcJ/9qUDNMD
	 Dt+tw/eMOGTmw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:01 +0900
Subject: [PATCH 02/21] can: dev: make can_get_relative_tdco() FD agnostic
 and move it to bittiming.h
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-2-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=sWHZaOqLzX2L2GpQTcYE/d6XotteDzKRJz/cgKPJ+a4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GMsqGJ+Fzzz4eM20lz4yS8uqfFRzfh+2nlIbbK283
 Hyi4KH8jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABOp28HI8OXALLZX1Z0PvJJv
 xue+PxLOVMDiyXZOevuX+O/JJ9rNvjD8d4u3OnvB8IdmTo3q4/Oa/Z2pnKunMN9a8Ojmm6ou2+0
 SjAA=
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
index 76022f48a97673d81676c39c697eadc6d7063ff7..55aaadaacf68f940fa1b71f7c438e68b84080292 100644
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
 /* helper to define static CAN controller features at device creation time */
 static inline int __must_check can_set_static_ctrlmode(struct net_device *dev,
 						       u32 static_mode)

-- 
2.49.1


