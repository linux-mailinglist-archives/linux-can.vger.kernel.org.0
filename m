Return-Path: <linux-can+bounces-4943-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E88B98D27
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B9A4C38FA
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FE2882DF;
	Wed, 24 Sep 2025 08:21:53 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0539276058
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702112; cv=none; b=WyuleHB8umCM+x3aRaeAl5dliBRAYADEY4r32cQolxzaNTrs+/wfsTyulMlYYUFoCRh68koGFV5Gji6vOEvxazfg5NcwsDpHtyHYEPZ9QzpM6R04G3DGQ74rJA9Iw3y29okbuiMz0bw1rlEKWp9jzkmENcYVJHDmsDzL2eoymd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702112; c=relaxed/simple;
	bh=PPjGq6YyzY38oqPjB4eLCcS0+shCV2s3Vaeoyo1cQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAY6NZaji3lg/taP3oqN6DHX1oQdzoj/JYBsGakWBd2nQcp5P8Etvy4+v6BHq4xobvDPEQRWUlrLXGo47Gqm5EhnBix7OS2a27PFnptXWf4jFrsgu2ajtJi0Pi3OyJzYqPIWzhy1vg3TG4SILcE9U+wbX82x+12HkoqbGsABln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001EB-T1; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000Dvd-2A;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 398224788C0;
	Wed, 24 Sep 2025 08:21:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 46/48] can: calc_bittiming: make can_calc_tdco() FD agnostic
Date: Wed, 24 Sep 2025 10:07:03 +0200
Message-ID: <20250924082104.595459-47-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
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


