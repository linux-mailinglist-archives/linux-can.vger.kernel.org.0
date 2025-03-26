Return-Path: <linux-can+bounces-3226-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFBCA716A3
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C52E19A06F1
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4691E00A0;
	Wed, 26 Mar 2025 12:21:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0E282EB;
	Wed, 26 Mar 2025 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991663; cv=none; b=Zuiw8m2rQHSS4RG8Rjt7zooxx1yW3LbmhD7NmRvHD9eZH8psVDl/E44SlHPC7UU9OQEgVp7yFEZPS26ZhCqPBbKfnHjjwg15B9Jb12qJLvMFtVGl3rmtmjikFSOGHZutu62wYZYpiCVDq8i5EeNwTt16cV3Eu5y1/hBPw5Uf9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991663; c=relaxed/simple;
	bh=FhHhamYTUkZolUHcA6sUChfCDlGrbzZyB4W1vAkKfoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM7IkAFDRgEKVtlIRJSz6hNLbEKB6jPJPakAcfre9xedD8UrfDvuNRY/PumQQdjxdsEb903MtCrXvS61j7IKhsO/RIqQNxVhBVbrn/o5GCP1hxqa/GZcFRmC4YR6ee5Mr5HRqvseUKbRvmOiHCLLWydjl6e+sEd/h6Ap27kbVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: nMlnJ4EeTeyqxgQtMh0B0A==
X-CSE-MsgGUID: Vun4EqI0QqGppp9pI5Gz1Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2025 21:21:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BBF0040104FA;
	Wed, 26 Mar 2025 21:20:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-can@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 13/18] can: rcar_canfd: Add shared_can_regs variable to struct rcar_canfd_hw_info
Date: Wed, 26 Mar 2025 12:19:48 +0000
Message-ID: <20250326122003.122976-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen4 has shared regs for both CAN-FD and Classical CAN operations.
Add shared_can_regs variable to struct rcar_canfd_hw_info to handle this
difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * Collected tag.
 * Replaced the variable name shared_can_reg->shared_can_regs.
v3->v4:
 * No change.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 85542e78e3bf..360999e6ab45 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -517,6 +517,7 @@ struct rcar_canfd_hw_info {
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
+	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 };
 
 /* Channel priv data */
@@ -636,6 +637,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -849,7 +851,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 	/* Write number of rules for channel */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(gpriv, ch),
 			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
-	if (is_gen4(gpriv))
+	if (gpriv->info->shared_can_regs)
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
 		offset = RCANFD_F_GAFL_OFFSET;
@@ -1385,7 +1387,7 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 			   brp, sjw, tseg1, tseg2);
 	} else {
 		/* Classical CAN only mode */
-		if (is_gen4(gpriv)) {
+		if (gpriv->info->shared_can_regs) {
 			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
 			       RCANFD_NCFG_NBRP(brp) |
 			       RCANFD_NCFG_NSJW(gpriv, sjw) |
@@ -1550,7 +1552,7 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 	dlc = RCANFD_CFPTR_CFDLC(can_fd_len2dlc(cf->len));
 
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_gen4(gpriv)) {
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		rcar_canfd_write(priv->base,
 				 RCANFD_F_CFID(gpriv, ch, RCANFD_CFFIFO_IDX), id);
 		rcar_canfd_write(priv->base,
@@ -1609,7 +1611,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 	u32 ch = priv->channel;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_gen4(gpriv)) {
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		id = rcar_canfd_read(priv->base, RCANFD_F_RFID(gpriv, ridx));
 		dlc = rcar_canfd_read(priv->base, RCANFD_F_RFPTR(gpriv, ridx));
 
@@ -1660,7 +1662,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 		cf->len = can_cc_dlc2len(RCANFD_RFPTR_RFDLC(dlc));
 		if (id & RCANFD_RFID_RFRTR)
 			cf->can_id |= CAN_RTR_FLAG;
-		else if (is_gen4(gpriv))
+		else if (gpriv->info->shared_can_regs)
 			rcar_canfd_get_data(priv, cf, RCANFD_F_RFDF(gpriv, ridx, 0));
 		else
 			rcar_canfd_get_data(priv, cf, RCANFD_C_RFDF(ridx, 0));
-- 
2.43.0


