Return-Path: <linux-can+bounces-4990-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D196EB9F1DD
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734824E4B5F
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36BF2FE579;
	Thu, 25 Sep 2025 12:14:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BD2FD7D6
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802440; cv=none; b=asu8V4uJ7wqYJXo4BGkTcHAd24JTWdhbRLEn7G7IHhWbCnnwYzObXavMWtB0nGpXfKKmeoKi5NhH16NsynfR4gerPDD5/WsevYJ+80DfnwtJE1tV+XGFk0ofYEeUeIwLqy+mJQQS6V2f78ehOkbExn7pYtpCWPDlCITuz4fyzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802440; c=relaxed/simple;
	bh=RlgXtJK66d/dnjHuZlitSlt997NrfrAKoXPr16LPgtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkX6q67PL/Rw7OtqoXAQUJDCCMsaFT2SqhxIdSy6L1t33zpyE2jOoQ7NA0HDihnzDdEicMTbxyzyZL5QVbxbuc1IQtWdwelUkzMTEly4yX9Gq06Z9y9Cq+/UIRFSMm6sFRz3Lthtipi747pS8qXQ5Ty+75UBUKINlOAmQZq3FI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-0000Vj-Gv; Thu, 25 Sep 2025 14:13:36 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqt-000PvK-1t;
	Thu, 25 Sep 2025 14:13:35 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 525FF479973;
	Thu, 25 Sep 2025 12:13:35 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/48] can: rcar_canfd: Simplify nominal bit rate config
Date: Thu, 25 Sep 2025 14:07:44 +0200
Message-ID: <20250925121332.848157-8-mkl@pengutronix.de>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Introduce rcar_canfd_compute_nominal_bit_rate_cfg() for simplifying
nominal bit rate configuration by replacing function-like macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250908120940.147196-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 43 +++++++++++++++++--------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8d0d0825cb54..99719c84f452 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -109,16 +109,7 @@
 #define RCANFD_CFG_BRP		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
-#define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
-
-#define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
-
-#define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
-
-#define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_NCFG_NBRP	GENMASK(9, 0)
 
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
@@ -1388,6 +1379,28 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_channel *priv,
+							  u16 tseg1, u16 tseg2, u16 sjw, u16 brp)
+{
+	struct rcar_canfd_global *gpriv = priv->gpriv;
+	const struct rcar_canfd_hw_info *info = gpriv->info;
+	u32 ntseg1, ntseg2, nsjw, nbrp;
+
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
+		ntseg1 = (tseg1 & (info->nom_bittiming->tseg1_max - 1)) << info->sh->ntseg1;
+		ntseg2 = (tseg2 & (info->nom_bittiming->tseg2_max - 1)) << info->sh->ntseg2;
+		nsjw = (sjw & (info->nom_bittiming->sjw_max - 1)) << info->sh->nsjw;
+		nbrp = FIELD_PREP(RCANFD_NCFG_NBRP, brp);
+	} else {
+		ntseg1 = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1);
+		ntseg2 = FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
+		nsjw = FIELD_PREP(RCANFD_CFG_SJW, sjw);
+		nbrp = FIELD_PREP(RCANFD_CFG_BRP, brp);
+	}
+
+	return (ntseg1 | ntseg2 | nsjw | nbrp);
+}
+
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
 	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
@@ -1406,15 +1419,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = bt->sjw - 1;
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
-
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
-		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
-		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-	} else {
-		cfg = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1) | FIELD_PREP(RCANFD_CFG_BRP, brp) |
-		      FIELD_PREP(RCANFD_CFG_SJW, sjw) | FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
-	}
-
+	cfg = rcar_canfd_compute_nominal_bit_rate_cfg(priv, tseg1, tseg2, sjw, brp);
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
 	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
-- 
2.51.0


