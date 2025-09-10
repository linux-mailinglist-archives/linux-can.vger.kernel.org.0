Return-Path: <linux-can+bounces-4617-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B044CB50DC8
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABC74480891
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB930DD3D;
	Wed, 10 Sep 2025 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdhYQNbi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A230DD30;
	Wed, 10 Sep 2025 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484315; cv=none; b=Zxe0R+1uZX+WBkYlGBUFQr+3KK3RBE+EwEY43uZKJjokM0dCNqEgGUhFpYsDIuvjp1bQC6Ju6yu3ZzpR1+VOG5ZcSEwkhqlRdZBY+Nhvq5G/YnRswhqr2Zoo+34cCq7gHHsZI15Y/0O1iVCe7CyfAuHDf6OUNZVEIP7te4FVxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484315; c=relaxed/simple;
	bh=gNhjrSZLMYXMYOaNsgMgxJ/NxYyO1ZyY1MCboW6u/EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POPthnfLRswIEDxsnRlGp/wTpmeNIzLBZcvpBh1Q1lLvZhAfcdKG+3AJERCSbzAEyjIX9KeaFZ7UfTV4l63DfVK1Q7X5zNLGFVu/L5laG92e1bqBVqstOKNUY1L0C29SWAhs1tcdtrEQOp1S/sDcH4Ptw9Jv3ppitHpsYacyfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdhYQNbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E27CC4CEF0;
	Wed, 10 Sep 2025 06:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484314;
	bh=gNhjrSZLMYXMYOaNsgMgxJ/NxYyO1ZyY1MCboW6u/EQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CdhYQNbit0lp56vsDzdNRcqp0sjKsLui/24GC/doGn9cCyE6a0A45fZcdeGefDwVS
	 xjZE3wMDgLwNAQOMvURXGw0WO63o0tt5g+lhGyxsbjvt1tRdgU2XyKnsDYifLAQyDK
	 sUV3ARGeYl5q5RBPdZyg7h0IOLR3UgUl554iIx2ZdlgBm2C06C4u/LO20C7lV+vHn7
	 BBDpuWe4M90ffUWbPa/NxVl027WnsbYzOrWnBvY7Xwv0U8oF6bhm4tNMvpl7Dty5tv
	 C0bMhJ+kMAo+A4munQYSTBcqw1YLve0v57xDCLRxi+priDFrnCHFqaWs5Edgh76OLo
	 6DHqLUGYog9JA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:43 +0900
Subject: [PATCH v2 18/20] can: calc_bittiming: make can_calc_tdco() FD
 agnostic
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-18-f128d4083721@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=gNhjrSZLMYXMYOaNsgMgxJ/NxYyO1ZyY1MCboW6u/EQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRb5sd1uoYzGn7TgTt0X2h5293Mdqfnv+31UmpVH8V
 Syg+E5JRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIkknmJkWN37WPyHgJNy7847
 uj/mPP3cmXB17afTbCl1J18/5ih9YMDI0PfKe+Gnpfb6+pNOLD/Yl7vSbNHRhQc+zHHOeXvr4GO
 dC/wA
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
index 8c0830fb2d1e729a65aeb8a2eaa0db83959a71a1..48a74808dbc881d1d46ff7d03d347ddb8af3d16c 100644
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


