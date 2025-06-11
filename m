Return-Path: <linux-can+bounces-3819-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62905AD5ADC
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33F21890BC8
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E41D95B3;
	Wed, 11 Jun 2025 15:38:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB11D7E57;
	Wed, 11 Jun 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656289; cv=none; b=LHoJ7wJ+YBXLVgQjJ16ESKgMiCQm24i8yKmtTdYpCrm+RCSRQYN+YOBUm5dCE4hjIdvdRL6mQIHSXfAUQckXx4+2ZsW6Suwq8FgSg8pC38G4JjwKW4MdvsFPKf2O0uagDGtKsA7BQoJ00q7SrbPhF6ue4otQ/whrvh9pz0m2+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656289; c=relaxed/simple;
	bh=ARNyBWqSQlHld1ckD/mucjpwE+xdFpgDcnfVfO/s17g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my6SJVc9IIHTX8wng0m6kHqw2FpFrGDK4IcoSsDpoFeHrEugMZHZgMm6uYN0C0r9uEtxn/s6Xzn29IdxfXQbfVxRnLmbmM0ASQ8Gx2nzTXDCBrDimwSnsGqkmgg1GCzkPzldbSOkhdSyyWIQUx+6gwMaUanjoavTXPvfxhF2qfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E39C4CEE3;
	Wed, 11 Jun 2025 15:38:07 +0000 (UTC)
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
Subject: [PATCH v2 09/10] can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
Date: Wed, 11 Jun 2025 17:37:38 +0200
Message-ID: <35fcdcad026cfdd0fd361637f065842d99a6c19d.1749655315.git.geert+renesas@glider.be>
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

Return early after completing all setup for non-FD mode in
rcar_canfd_set_bittiming(), to prepare for the advent of more FD-only
setup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
v2:
  - Add Reviewed-by,
  - Rebase.
---
 drivers/net/can/rcar/rcar_canfd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9ee49ef57e4f9c8e..3340ae75bbecdb5b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1484,18 +1484,19 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* Data bit timing settings */
-		brp = dbt->brp - 1;
-		sjw = dbt->sjw - 1;
-		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
-		tseg2 = dbt->phase_seg2 - 1;
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
+		return;
 
-		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+	/* Data bit timing settings */
+	brp = dbt->brp - 1;
+	sjw = dbt->sjw - 1;
+	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
+	tseg2 = dbt->phase_seg2 - 1;
 
-		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	}
+	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
+	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+
+	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
-- 
2.43.0


