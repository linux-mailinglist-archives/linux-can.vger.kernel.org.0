Return-Path: <linux-can+bounces-4879-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D5B94A90
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74DB2E3F85
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5406315D43;
	Tue, 23 Sep 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbh5ivIm"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA07314B64;
	Tue, 23 Sep 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610815; cv=none; b=K9/RgQ4h6e+OF/uVIgDiBayv/1pIZjQRM7bibmtnGDxhLU/ZZrZ4Cb6brWJU9dklnom9yO9Z6PRA/3MJM8/iVuwHOHhjGi3rv5e+8RYsW+y45KK8gyfSAz5sJ4dCji2tooa9yyPx6xgP9mxj5OwObrG3UCK7cDDbo0bwpQUVFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610815; c=relaxed/simple;
	bh=F7MyAD4vh5cxeyCtARMCnPwZM8B/TzhziXFFTs1nP/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvrSPXXcAzbBXMsYH7gsIC61ZX5aGUlErPzbD385rACnLJbt7xmHf3R8aSHHBPl9S3yWHc9Nbrad7ah0f9oAat+AmGzpkoTXSVVz+CwUAPKh/legaEEdwRJ3K6AnDu1qOLieIpIEkVDlLGOQo8JxbPuEFn3WY7ktKBW0uWUeFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbh5ivIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A1FC4CEF5;
	Tue, 23 Sep 2025 07:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610814;
	bh=F7MyAD4vh5cxeyCtARMCnPwZM8B/TzhziXFFTs1nP/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbh5ivImEODhIldKlqfp8ASVq4x57k8RMTrb7+7CP5ZDaRGdM5TsHwkAKI88S39vW
	 IpYGtW25x8/GjRB3FKlYHghd7C1lm+xxgwqSL1QgVCkdJFfk8Mij6QDdKiQ4Q0MJhj
	 5hipREmvxaMWNDLBiuG4UxWJtMIzQat4XRgsVCphBqwKtnCSkc0Ki81D9MmJmSK1sq
	 00QSLiiuCRuNOmq3nRQFf48DzIvecYWIRJXhfqdumVtvDhHa2xeySdpFhANB9nIqox
	 eZjLAM9wKsZ9Jbdem3PhOw8NQNrGRM3ME0Be47MV7bHPoY87vKGqsETxcrSAZKeBLN
	 SYZRyDkHcVsmg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:43 +0900
Subject: [PATCH v4 18/20] can: calc_bittiming: make can_calc_tdco() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-18-e720d28f66fe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=F7MyAD4vh5cxeyCtARMCnPwZM8B/TzhziXFFTs1nP/Q=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXCPqJ/U+O3NicqeT/9m61/MVJpTctIzjP6KnsZLN6
 +Hyw7HmHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYSt4bhnzG3jt/EpyJTallZ
 /4TsX7IvN/v30131e/aHx0r9nZb+fAvDH75Vy0t9eC123Nh+5rf/jJbLIr63xOPy19ke91w9+8h
 TI34A
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

can_calc_tdco() uses the CAN_CTRLMODE_FD_TDC_MASK and
CAN_CTRLMODE_TDC_AUTO macros making it specific to CAN FD. Add the tdc
mask to the function parameter list. The value of the tdc auto flag
can then be derived from that mask and stored in a local variable.
This way, the function becomes CAN FD agnostic and can be reused later
on for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changelog:

  RFC -> v1:

   - new patch. I overlooked this in the RFC and the CAN XL's TDC was
     broken because of that.
---
 drivers/net/can/dev/calc_bittiming.c | 10 ++++++----
 drivers/net/can/dev/netlink.c        |  2 +-
 include/linux/can/bittiming.h        |  4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index a94bd67c670c4801344e1fed6372d0182c46271f..394d6974f48151230510d7f43c80d75e1429dd37 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -173,13 +173,15 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
 void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 		   const struct can_bittiming *dbt,
-		   u32 *ctrlmode, u32 ctrlmode_supported)
+		   u32 tdc_mask, u32 *ctrlmode, u32 ctrlmode_supported)
 
 {
-	if (!tdc_const || !(ctrlmode_supported & CAN_CTRLMODE_TDC_AUTO))
+	u32 tdc_auto = tdc_mask & CAN_CTRLMODE_TDC_AUTO_MASK;
+
+	if (!tdc_const || !(ctrlmode_supported & tdc_auto))
 		return;
 
-	*ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
+	*ctrlmode &= ~tdc_mask;
 
 	/* As specified in ISO 11898-1 section 11.3.3 "Transmitter
 	 * delay compensation" (TDC) is only applicable if data BRP is
@@ -193,6 +195,6 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 		if (sample_point_in_tc < tdc_const->tdco_min)
 			return;
 		tdc->tdco = min(sample_point_in_tc, tdc_const->tdco_max);
-		*ctrlmode |= CAN_CTRLMODE_TDC_AUTO;
+		*ctrlmode |= tdc_auto;
 	}
 }
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 99038e0fb25f4e05cd181b188d5aeea25de8f77e..92d8df13e886c8832c4ed8450675c22dc2e5b009 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -341,7 +341,7 @@ static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
 		 * do calculation
 		 */
 		can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
-			      &priv->ctrlmode, priv->ctrlmode_supported);
+			      tdc_mask, &priv->ctrlmode, priv->ctrlmode_supported);
 	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
 	   * turned off. TDC is disabled: do nothing
 	   */
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 71f839c3f0325b2a496a4bc447044a4853541338..d30816dd93c7082c774ca4c01ee42465cd042ca0 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -135,7 +135,7 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
 void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 		   const struct can_bittiming *dbt,
-		   u32 *ctrlmode, u32 ctrlmode_supported);
+		   u32 tdc_mask, u32 *ctrlmode, u32 ctrlmode_supported);
 #else /* !CONFIG_CAN_CALC_BITTIMING */
 static inline int
 can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
@@ -148,7 +148,7 @@ can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 static inline void
 can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 	      const struct can_bittiming *dbt,
-	      u32 *ctrlmode, u32 ctrlmode_supported)
+	      u32 tdc_mask, u32 *ctrlmode, u32 ctrlmode_supported)
 {
 }
 #endif /* CONFIG_CAN_CALC_BITTIMING */

-- 
2.49.1


