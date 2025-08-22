Return-Path: <linux-can+bounces-4306-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54D3B3149A
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6231DB05649
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FD2EF654;
	Fri, 22 Aug 2025 09:51:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890882EF673;
	Fri, 22 Aug 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856263; cv=none; b=JeUvKrhcV5sNY1iy62MClNFRCfL6ZQzHOIWwtyVWjFi4+c4+dpy7fN3/hXOp51tjx9lvGuq50lfe5/b8jv/drqCDrioWUVQKtuf43AW2pD+3AWlG/P7/KC/v4vqAdlDuDWIkYI8TG9ahNZNjQ/zN1TJ2K1vJPewreY/nA2WC8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856263; c=relaxed/simple;
	bh=QkkZ26dxA+dlIpXewqk/hNyaPeFLln5I2fXqYDnSBxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/aeeyxZnaB3NMpCTp0VRX/AEqolzBN/U1wqPIIXu2V7HkVvc9gW8nIB3+pTU2d4RRoI6L7Yz39GO91vAkgYkzkMSth9t8BIzoevhWibN98R4XSIaFec9mkR0x6krD3c9kgOUfzssrz7I3pQJX4/FuDq+ZeIVoNy5imAiFK0cOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355BC4CEED;
	Fri, 22 Aug 2025 09:51:01 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/6] can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 22 Aug 2025 11:50:43 +0200
Message-ID: <fa657e1c325a62e475ad9e01e0c2ad2c3cc940a6.1755855779.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755855779.git.geert+renesas@glider.be>
References: <cover.1755855779.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas R-Car CAN-FD driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotations from its suspend and resume callbacks, and
reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index de5121efdabdb6ed..eedce83b91414c57 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2234,18 +2234,18 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	rcar_canfd_global_deinit(gpriv, true);
 }
 
-static int __maybe_unused rcar_canfd_suspend(struct device *dev)
+static int rcar_canfd_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int __maybe_unused rcar_canfd_resume(struct device *dev)
+static int rcar_canfd_resume(struct device *dev)
 {
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
-			 rcar_canfd_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
+				rcar_canfd_resume);
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
@@ -2262,7 +2262,7 @@ static struct platform_driver rcar_canfd_driver = {
 	.driver = {
 		.name = RCANFD_DRV_NAME,
 		.of_match_table = of_match_ptr(rcar_canfd_of_table),
-		.pm = &rcar_canfd_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_canfd_pm_ops),
 	},
 	.probe = rcar_canfd_probe,
 	.remove = rcar_canfd_remove,
-- 
2.43.0


