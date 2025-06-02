Return-Path: <linux-can+bounces-3748-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49DACADA7
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BEC165A95
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2120DD75;
	Mon,  2 Jun 2025 11:54:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE614F70;
	Mon,  2 Jun 2025 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865293; cv=none; b=fxmp/WJ3UqBydAute6crfQdQRURJd4S6zntso3F4UJI79DJssSy0jyVQEtf31xEPVSkTMyMN4A3AkM5XJaaujG00sAtJndWok8+ClQqPkz0W2+zQP9MLdm6DTBe/Ja45j9TLDVk750oI2I+9KDCCV2zvqBaD5LykgzTSDq+e16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865293; c=relaxed/simple;
	bh=mVKPnGfEKMAXxYOcoOubDT99/p7CfpFrE40WCoiKmDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIMctiJP4YxHjMEh2RUbv0EBW7MJmc9YCZp1iq9RLS2CUkbsHgfLmkot2YPnpiJyOKO7tIUbcTkHJtQ26S/VU12/kavWoYRHpeqlih7nord/Nx/UOvVpxbW+So51Mqkh+n2wNDrta6ViNkHiQJCa2r0nqu1wbv0WMd6nio63qk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840FBC4CEEB;
	Mon,  2 Jun 2025 11:54:51 +0000 (UTC)
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
Subject: [PATCH 7/9] can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
Date: Mon,  2 Jun 2025 13:54:26 +0200
Message-ID: <96d7e5584b9fbc8ba6f49124d683428e17b22648.1748863848.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748863848.git.geert+renesas@glider.be>
References: <cover.1748863848.git.geert+renesas@glider.be>
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
---
 drivers/net/can/rcar/rcar_canfd.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7a9a88fa5fb1a521..6e77e4844c3f63e9 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1450,15 +1450,19 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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
-		netdev_dbg(ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
+	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+	netdev_dbg(ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n", brp,
+		   sjw, tseg1, tseg2);
 
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
 		sjw = dbt->sjw - 1;
@@ -1471,23 +1475,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
 		netdev_dbg(ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
 			   brp, sjw, tseg1, tseg2);
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
-		netdev_dbg(ndev, "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	}
 }
 
-- 
2.43.0


