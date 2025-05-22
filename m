Return-Path: <linux-can+bounces-3655-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A519AC0772
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 10:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EA61BC4F7B
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B50289814;
	Thu, 22 May 2025 08:41:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A19288CA2
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903308; cv=none; b=neHU5w1wzjXl8D0fi8msQORwkdhpN2ReJQvUwQJwO/L6uv6iF9lpYoO4Ib3UVO7kA9jv5mJ5j5TtKJCLAwb4DTvymAz44AiDSXLY1yjk1RKorPsLrZsNyWKYW7hblKevNttZv+qsIHQwajDHlVjEUqHiLeBhZctwSm3kJe0J5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903308; c=relaxed/simple;
	bh=Rpx9ffJfSp1eCUcOfsWh3R5d1wf8cImvFKZw7e/aMuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNlnIfztuYsS89Lu6woI9vgRhzrg99xzZAk5hsckvCiqOGdlrD7Dgv4lYntvc63msQDEMCUzBtvUAEG+JBmttqCMa94U1WwTGRLGDowTUWrmbXL34Pa25yU8pQ36XsEMzT+NzSVgE9wxJUAbhZBwU7MsU8attA0YE/J4ZhwplkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ul-0006Fy-Pq
	for linux-can@vger.kernel.org; Thu, 22 May 2025 10:41:43 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uI1Ui-000hp7-0g
	for linux-can@vger.kernel.org;
	Thu, 22 May 2025 10:41:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id CC9A5417352
	for <linux-can@vger.kernel.org>; Thu, 22 May 2025 08:41:39 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C0AA5417310;
	Thu, 22 May 2025 08:41:37 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f63b11e2;
	Thu, 22 May 2025 08:41:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 16/22] can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
Date: Thu, 22 May 2025 10:36:44 +0200
Message-ID: <20250522084128.501049-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522084128.501049-1-mkl@pengutronix.de>
References: <20250522084128.501049-1-mkl@pengutronix.de>
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

R-Car Gen3 and Gen4 have some differences in the shift bits. Introduce a
struct rcar_canfd_shift_data to hold these values and add the struct
rcar_canfd_shift_data variable sh to struct rcar_canfd_hw_info to handle
these differences. After this, drop the unused functions reg_gen4() and
is_gen4().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-17-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 64 ++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fbfe2d6484f1..67f7b5f6376c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -110,13 +110,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
+	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -181,10 +181,10 @@
 #define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
+	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->dtseg2)
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
+	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->dtseg1)
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -228,11 +228,11 @@
 #define RCANFD_CFCC_CFTML(gpriv, cftml) \
 ({\
 	typeof(gpriv) (_gpriv) = (gpriv); \
-	(((cftml) & (_gpriv)->info->max_cftml) << reg_gen4(_gpriv, 16, 20)); \
+	(((cftml) & (_gpriv)->info->max_cftml) << (_gpriv)->info->sh->cftml); \
 })
-#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
+#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << (gpriv)->info->sh->cfm)
 #define RCANFD_CFCC_CFIM		BIT(12)
-#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
+#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << (gpriv)->info->sh->cfdc)
 #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
 #define RCANFD_CFCC_CFTXIE		BIT(2)
 #define RCANFD_CFCC_CFE			BIT(0)
@@ -515,10 +515,22 @@ struct rcar_canfd_regs {
 	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
 };
 
+struct rcar_canfd_shift_data {
+	u8 ntseg2;	/* Nominal Bit Rate Time Segment 2 Control */
+	u8 ntseg1;	/* Nominal Bit Rate Time Segment 1 Control */
+	u8 nsjw;	/* Nominal Bit Rate Resynchronization Jump Width Control */
+	u8 dtseg2;	/* Data Bit Rate Time Segment 2 Control */
+	u8 dtseg1;	/* Data Bit Rate Time Segment 1 Control */
+	u8 cftml;	/* Common FIFO TX Message Buffer Link */
+	u8 cfm;		/* Common FIFO Mode */
+	u8 cfdc;	/* Common FIFO Depth Configuration */
+};
+
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
 	const struct rcar_canfd_regs *regs;
+	const struct rcar_canfd_shift_data *sh;
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
@@ -643,10 +655,33 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
 	.cfoffset = 0x6400,
 };
 
+static const struct rcar_canfd_shift_data rcar_gen3_shift_data = {
+	.ntseg2 = 24,
+	.ntseg1 = 16,
+	.nsjw = 11,
+	.dtseg2 = 20,
+	.dtseg1 = 16,
+	.cftml = 20,
+	.cfm = 16,
+	.cfdc = 8,
+};
+
+static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
+	.ntseg2 = 25,
+	.ntseg1 = 17,
+	.nsjw = 10,
+	.dtseg2 = 16,
+	.dtseg1 = 8,
+	.cftml = 16,
+	.cfm = 8,
+	.cfdc = 21,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = &rcar_gen3_regs,
+	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -661,6 +696,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
 	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
@@ -675,6 +711,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = &rcar_gen3_regs,
+	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -686,17 +723,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 };
 
 /* Helper functions */
-static inline bool is_gen4(struct rcar_canfd_global *gpriv)
-{
-	return gpriv->info == &rcar_gen4_hw_info;
-}
-
-static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,
-			   u32 gen4, u32 not_gen4)
-{
-	return is_gen4(gpriv) ? gen4 : not_gen4;
-}
-
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
 	u32 data = readl(reg);
-- 
2.47.2



