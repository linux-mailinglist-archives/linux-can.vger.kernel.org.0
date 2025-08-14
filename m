Return-Path: <linux-can+bounces-4231-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA42B26444
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 13:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0EC1C85BC0
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4A92F90DF;
	Thu, 14 Aug 2025 11:26:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9942F90C7;
	Thu, 14 Aug 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170811; cv=none; b=f3D5n+nEmQuva3P73LReDg8mQ34fH/RlCyGgfmnwCxptsgn8bGh4/IXJZ5M4YM8YZ5CFVvL3Jj8iOujSBVzoNSTwTkQGC+kmIQFq0r9n/VovfLazfB/qDgaLmgaC3T8wuI4bQfIys9Tmmrb4ec1hxszrN7FbhLLVmrPMZ2K7gCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170811; c=relaxed/simple;
	bh=efQv7y9TxU5qNtQUH5OQdTeNpijoY7vHf2YV6H5V1as=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmYHrJZKAN76kykjqN4B7yoIHT5UklAJ7N2cT1g+v0PIqCOwNsy8gaa8DkV6OXH72gHRwS0k1xIKObQ19a+pEWfsHthKsCV4ANjijEMKauITP18lSFGS5J/Ef248BYUVcfICkPvkROx7WojWNg/Ht+kcsr+Ys2xsqfPj1BQhI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A569C4CEF7;
	Thu, 14 Aug 2025 11:26:49 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: rcar_can: Fix s2ram with PSCI
Date: Thu, 14 Aug 2025 13:26:37 +0200
Message-ID: <699b2f7fcb60b31b6f976a37f08ce99c5ffccb31.1755165227.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the
CAN interface no longer works, until it is brought down and up again.

Fix this by calling rcar_can_start() from the PM resume callback, to
fully initialize the controller instead of just restarting it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on Ebisu-4D with R-Car E3.

FTR, I am working on fixing the same issue in the (separate) R-Car
CAN-FD driver.  I already made CAN-FD work after s2ram on Ebisu-4D, but
unfortunately broke it after s2idle on R-Car Gen4 in the process, so that
needs more work...
---
 drivers/net/can/rcar/rcar_can.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 64e664f5adcc4ac9..87c134bcd48db559 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -861,7 +861,6 @@ static int rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	u16 ctlr;
 	int err;
 
 	if (!netif_running(ndev))
@@ -873,12 +872,7 @@ static int rcar_can_resume(struct device *dev)
 		return err;
 	}
 
-	ctlr = readw(&priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_SLPM;
-	writew(ctlr, &priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_CANM;
-	writew(ctlr, &priv->regs->ctlr);
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	rcar_can_start(ndev);
 
 	netif_device_attach(ndev);
 	netif_start_queue(ndev);
-- 
2.43.0


