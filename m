Return-Path: <linux-can+bounces-4321-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117ABB31523
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F897AA543E
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5038027C872;
	Fri, 22 Aug 2025 10:17:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491C263F22;
	Fri, 22 Aug 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857856; cv=none; b=r0CyfUD7ww147WrswQ8rse/he8GP0aix5IxqUC9vjHOOMjAfVLmjgtr0P73C4ZNPKrkInU/tvZAJMO5EQTFDdreLnU6hnRmIb+0QtGeGpYJfA1rzYIXBXO4dVlOHyedgmRReOYI3XRawsMXBKJNONxEW909ew+ZDsbCjBYBtr2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857856; c=relaxed/simple;
	bh=Lz2WKeBU5RvyGaxe5sI3ZmrwaVOcA2kWIgSs+4y6Kxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkolI3zQ+4VU4mPByhJFvODORKPH8IcdGiLk5j0z+GzdEgbsjkW70gDZDhKE6Y74k43NVU2F3bOu/4AJGmo27J+jEK/VexpcbGRCF5dnyIaU13OiExRbTt3NJ/yI2DWnEyeZ5UQ1CFGhtnsyZRtTxsuqKLK0IcXIvfE2cy+nFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A739DC4CEED;
	Fri, 22 Aug 2025 10:17:34 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 11/11] can: rcar_can: Convert to %pe
Date: Fri, 22 Aug 2025 12:17:12 +0200
Message-ID: <adb2dc49c78b45191de410f645a5e423d341f94e.1755857536.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755857536.git.geert+renesas@glider.be>
References: <cover.1755857536.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace numerical error codes by mnemotechnic error codes, to improve
the user experience in case of errors.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/net/can/rcar/rcar_can.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 51bf8f7e71824ac8..5f85f4e272054789 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -521,20 +521,20 @@ static int rcar_can_open(struct net_device *ndev)
 	}
 	err = clk_prepare_enable(priv->can_clk);
 	if (err) {
-		netdev_err(ndev, "failed to enable CAN clock, error %d\n",
-			   err);
+		netdev_err(ndev, "failed to enable CAN clock: %pe\n",
+			   ERR_PTR(err));
 		goto out_rpm;
 	}
 	err = open_candev(ndev);
 	if (err) {
-		netdev_err(ndev, "open_candev() failed, error %d\n", err);
+		netdev_err(ndev, "open_candev() failed %pe\n", ERR_PTR(err));
 		goto out_can_clock;
 	}
 	napi_enable(&priv->napi);
 	err = request_irq(ndev->irq, rcar_can_interrupt, 0, ndev->name, ndev);
 	if (err) {
-		netdev_err(ndev, "request_irq(%d) failed, error %d\n",
-			   ndev->irq, err);
+		netdev_err(ndev, "request_irq(%d) failed %pe\n", ndev->irq,
+			   ERR_PTR(err));
 		goto out_close;
 	}
 	rcar_can_start(ndev);
@@ -786,8 +786,8 @@ static int rcar_can_probe(struct platform_device *pdev)
 	}
 	priv->can_clk = devm_clk_get(dev, clock_names[clock_select]);
 	if (IS_ERR(priv->can_clk)) {
+		dev_err(dev, "cannot get CAN clock: %pe\n", priv->can_clk);
 		err = PTR_ERR(priv->can_clk);
-		dev_err(dev, "cannot get CAN clock, error %d\n", err);
 		goto fail_clk;
 	}
 
@@ -813,7 +813,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	err = register_candev(ndev);
 	if (err) {
-		dev_err(dev, "register_candev() failed, error %d\n", err);
+		dev_err(dev, "register_candev() failed %pe\n", ERR_PTR(err));
 		goto fail_rpm;
 	}
 
-- 
2.43.0


