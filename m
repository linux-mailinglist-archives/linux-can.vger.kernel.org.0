Return-Path: <linux-can+bounces-3814-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD3AD5AAE
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385A216E1F7
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5191CBEAA;
	Wed, 11 Jun 2025 15:37:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030331B0412;
	Wed, 11 Jun 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656278; cv=none; b=RqvUKiXdlIeTF35SgEPDvSWU5LTtLCpigq0t5dzwGwWyMiQdyD7VWM7O6BmVg4TgCobAoAPX6kFPKlA15+TFzuPPIMxXt2O1+SPT3TN8p+AUhsDla/UsWHxycvyhjzfjcpLIsnRsqR4W2DZtA+KE8lCPye+U5lNdkDXDE+o9xFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656278; c=relaxed/simple;
	bh=tGuBrZQAASU+yMyRpt4iubt4gYAVNyc1v7tKF9SRIdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwuJEra8QdR/7Laya7wvSY0Qo4auiiPQPJJNhUpqUO0MgOwh0FGGlJ5hJ1NIZPRdgp2zQ7aPo1WmnGlS1qQIAq4KFJypIV2eZRcLWPHkjIATrRGdcUkwWglaHQlQNu3SgsJe10GZntb/LmAc181rjQLVG5ihNre/6jEHr0iiDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B20C4CEEA;
	Wed, 11 Jun 2025 15:37:55 +0000 (UTC)
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
Subject: [PATCH v2 04/10] can: rcar_canfd: Add helper variable dev to rcar_canfd_reset_controller()
Date: Wed, 11 Jun 2025 17:37:33 +0200
Message-ID: <21e64816808eb3eba722f4c547f4f5112d5d62a6.1749655315.git.geert+renesas@glider.be>
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

rcar_canfd_reset_controller() has many users of "pdev->dev".  Introduce
a shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
v2:
  - Add Reviewed-by.
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ddf3b91d3d2bba97..3244584a6ee5d67b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -841,6 +841,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 {
+	struct device *dev = &gpriv->pdev->dev;
 	u32 sts, ch;
 	int err;
 
@@ -850,7 +851,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 !(sts & RCANFD_GSTS_GRAMINIT), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global raminit failed\n");
+		dev_dbg(dev, "global raminit failed\n");
 		return err;
 	}
 
@@ -863,7 +864,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 (sts & RCANFD_GSTS_GRSTSTS), 2, 500000);
 	if (err) {
-		dev_dbg(&gpriv->pdev->dev, "global reset failed\n");
+		dev_dbg(dev, "global reset failed\n");
 		return err;
 	}
 
@@ -887,8 +888,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 					 (sts & RCANFD_CSTS_CRSTSTS),
 					 2, 500000);
 		if (err) {
-			dev_dbg(&gpriv->pdev->dev,
-				"channel %u reset failed\n", ch);
+			dev_dbg(dev, "channel %u reset failed\n", ch);
 			return err;
 		}
 	}
-- 
2.43.0


