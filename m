Return-Path: <linux-can+bounces-5015-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D44B9F213
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E24E3572
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992A303A1E;
	Thu, 25 Sep 2025 12:14:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0CA3009DC
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802447; cv=none; b=XHUDf0bvveVUzEhyOPDQHkpGiOjppYmdFuxDo2uCFJeipQMFsO73DN6bsOLihOT4D0jPJ84vaWI2jfB21vFMRx6oO07nRg3dgyY2yP6tFoz2wf8LDQbP1PcnD3G5jTZsBI+p9vMUiwdhxnhQw4IaGWuvGv0cNgrUT9AxBVWgg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802447; c=relaxed/simple;
	bh=PPjGq6YyzY38oqPjB4eLCcS0+shCV2s3Vaeoyo1cQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJ5A1WXUAyldLuHKNmXWEdSD62XC/sqjcgaxi/qLQ6eQyggz9nYZVZyEVzZuObIMHcaRxZ78jJkC8cbtCcbrRTt0rNtbB4CfTGxip+mXV8QXYPq5an/azT/xZ+ukKa4BJFi6mN7lOsOl40azWxIBh+W2UIASk1NSkJLbQ5R9+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqx-0000Zb-T3; Thu, 25 Sep 2025 14:13:39 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqw-000Pxc-0X;
	Thu, 25 Sep 2025 14:13:38 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DB48647999A;
	Thu, 25 Sep 2025 12:13:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 46/48] can: calc_bittiming: make can_calc_tdco() FD agnostic
Date: Thu, 25 Sep 2025 14:08:23 +0200
Message-ID: <20250925121332.848157-47-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

can_calc_tdco() uses the CAN_CTRLMODE_FD_TDC_MASK and
CAN_CTRLMODE_TDC_AUTO macros making it specific to CAN FD. Add the tdc
mask to the function parameter list. The value of the tdc auto flag
can then be derived from that mask and stored in a local variable.
This way, the function becomes CAN FD agnostic and can be reused later
on for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250923-canxl-netlink-prep-v4-18-e720d28f66fe@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 10 ++++++----
 drivers/net/can/dev/netlink.c        |  2 +-
 include/linux/can/bittiming.h        |  4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index a94bd67c670c..394d6974f481 100644
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
index 99038e0fb25f..92d8df13e886 100644
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
index 71f839c3f032..d30816dd93c7 100644
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
2.51.0


