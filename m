Return-Path: <linux-can+bounces-3818-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD1CAD5ADB
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C723B1890826
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6857C1C6FF6;
	Wed, 11 Jun 2025 15:38:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8481B0412;
	Wed, 11 Jun 2025 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656287; cv=none; b=slfSh+b3OmocRfzwlFG8WK0MxF+Vy3R0CUNiyd+4VSlF+1jgSefi5auQktb1Izggp03M1ohX1nF2sdO8/SSGbTu/KVxD1j79Qwn5aYBWXR6epZNqw9eM0z8vKpY1nU6YHqcbIvkr+pIqcsbyDvILu4kVRnbIdutQjXML6mq6AtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656287; c=relaxed/simple;
	bh=dimmqhDYU0Z34St94hqGCJE8xWOrI59s4WxXqzGzrGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv8A8jl+Q6974mijQB+9h1DBkYkZ61KlyNNA0q/0H2d21Mp/B4vig/eDffV646nPq8mHwLTXntuNjcyT4r3UABV72u5h1qwK3yoxQcqGZX1DbytjLGT2MzTdzNmoqYQTCrN8YkW++BMP7/tMU0r3GrfRp7Ww65bEFxhKYU/JJXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16339C4CEEA;
	Wed, 11 Jun 2025 15:38:04 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 08/10] can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
Date: Wed, 11 Jun 2025 17:37:37 +0200
Message-ID: <b7643a3c49777989d02145a85b85cf773ec2123f.1749655315.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749655315.git.geert+renesas@glider.be>
References: <cover.1749655315.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The configuration register format for nominal bit timings in CAN-FD mode
and the format for bit timings in CAN mode on CAN-FD controllers with
shared Classical CAN registers are the same.

Restructure the code to make this clear, also reducing kernel size by 80
bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
v2:
  - Add Reviewed-by,
  - Rebase.
---
 drivers/net/can/rcar/rcar_canfd.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c292694ae4d27ac4..9ee49ef57e4f9c8e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1474,13 +1474,17 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* CAN FD only mode */
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
+	} else {
+		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
+		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+	}
 
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
 		sjw = dbt->sjw - 1;
@@ -1491,21 +1495,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	} else {
-		/* Classical CAN only mode */
-		if (gpriv->info->shared_can_regs) {
-			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
-			       RCANFD_NCFG_NBRP(brp) |
-			       RCANFD_NCFG_NSJW(gpriv, sjw) |
-			       RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-		} else {
-			cfg = (RCANFD_CFG_TSEG1(tseg1) |
-			       RCANFD_CFG_BRP(brp) |
-			       RCANFD_CFG_SJW(sjw) |
-			       RCANFD_CFG_TSEG2(tseg2));
-		}
-
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 	}
 }
 
-- 
2.43.0


