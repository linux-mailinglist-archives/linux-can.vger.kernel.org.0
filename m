Return-Path: <linux-can+bounces-4852-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDEB94762
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A8B7A3C07
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57331B10B;
	Tue, 23 Sep 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlNgbZDs"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8031B104;
	Tue, 23 Sep 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606075; cv=none; b=G/AF8s22LUOb0ng1engaUFGWKdpiI2k1WkM0wfCOYP2PsNjYKasyjX9ep/lyrNEUXtQzc6oQPwIf2syXDQ3/ankEcijuMkyZYHpvUbpOhaLHg/dwBOEMaduL9DXfUmsWUjaySwDmcp1oeqyqqNWwRlWAlwigwU4Lgvd2IkfWtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606075; c=relaxed/simple;
	bh=F7MyAD4vh5cxeyCtARMCnPwZM8B/TzhziXFFTs1nP/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZT9w6gfy5TR2DBiojyczKOWov2rQPgjZzEJP5UnvfDXX37IfLSUKQ9Yt2nYXH6yHJw8Taxngq2DO0T5iJnnDp0png5eyzqW8Ce2JSAw/9W0ZZlMYWwlLaa9jW3T+e4cD4/hILJyDf75q4j18t3eRRhA4Aco3jMOgxoe1/LT2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlNgbZDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE681C113CF;
	Tue, 23 Sep 2025 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606075;
	bh=F7MyAD4vh5cxeyCtARMCnPwZM8B/TzhziXFFTs1nP/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hlNgbZDsXuj3XkI7RN78ljQh798lxjGEt6eVUetp5fRJUP7wNj8isgwW9X2h5km/9
	 ZTiKiOcjdPTqJzEVBYC+u8zEBhuXyI+rcldgDGA4FoC75h/dvKWJk6m1M1oyjkVZC/
	 n3ntziseU7MOTbu85ByoWmMtkvSOrS6cDJOXBzE0Bby/5SLcDAnvk6aIORJS3VSpLv
	 03HZoJEPPXxKyP5YYopi9D/nn4mWK0yKlPGl1Wj1hWFrFOyQMV46eEpwNAdtNRf4sI
	 zZMKPJ9GsCUe7wAIr3bA8PrmpsF6xI/bhtTM6Xa8/nV7fHHEpnyJIYGRPBuOheMCqa
	 wXe7z/R67QILg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:53 +0900
Subject: [PATCH v3 18/20] can: calc_bittiming: make can_calc_tdco() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-18-87a7684333f3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=F7MyAD4vh5cxeyCtARMCnPwZM8B/TzhziXFFTs1nP/Q=;
 b=kA0DAAoW0WQ+QNd/fbMByyZiAGjSMtWhghCgzdPOWaE/4e6fC5YYuiaUGlZWP4/62qGzemgyf
 oh1BAAWCgAdFiEEpncJCyCIcUtWwv050WQ+QNd/fbMFAmjSMtUACgkQ0WQ+QNd/fbMTUQEAtnk+
 UUM/0q7kBa2qeLLqWiqeCXKL/XZtKAqA5ysa868A/Roroi0+u9xfh4JoLP81dWkRkJ2oyCfmadz
 rpgtWMCIB
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


