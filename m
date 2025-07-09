Return-Path: <linux-can+bounces-3954-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE07AFF0F4
	for <lists+linux-can@lfdr.de>; Wed,  9 Jul 2025 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4671C47E7E
	for <lists+linux-can@lfdr.de>; Wed,  9 Jul 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8DD23ABA1;
	Wed,  9 Jul 2025 18:36:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60328239E7D;
	Wed,  9 Jul 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086186; cv=none; b=SGx/UXPxOmYiAbwNYiNJDQB1QIndM1RNh5kLM6MNqq8ZyQf0XOnier9rGicjVCaczMkaap91ePjxmg3FUOqMqsG6v2Sp9krEcAvlHti5XyiLoc8TI3EIUX+dk51HQeyJUKJJu6LzPivbLH1MvFWOj0hvFyGb7fflJKauNbbg28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086186; c=relaxed/simple;
	bh=/1OvZHdrKYtZ8bTN5F7n5QasWCPN+qIkcDVXFoU7dRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9PK4yiwrb3v6dhMI/W4dyttisX11Bq9SSVD3yZfWZ2pPBV0fK5Gg7doNlyBSmCJttAih2PQ+yvo79RxWKmQrEEvZTXfkA0hovFkVoLOtZVW2nWEVsM1yflSIMM0PTKcG8gbgEwFn6X/aK7s912mjeaewH/I10WLiKf0gq+mkT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD3AC4CEEF;
	Wed,  9 Jul 2025 18:36:24 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: rcar_can: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed,  9 Jul 2025 20:36:21 +0200
Message-ID: <6ffe085f6e2548f53674dd11704b388cf4b303e9.1752086078.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas R-Car CAN driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotations from its suspend and resume callbacks, and
reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_can.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 2b7dd359f27b7dd8..64e664f5adcc4ac9 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -834,7 +834,7 @@ static void rcar_can_remove(struct platform_device *pdev)
 	free_candev(ndev);
 }
 
-static int __maybe_unused rcar_can_suspend(struct device *dev)
+static int rcar_can_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
@@ -857,7 +857,7 @@ static int __maybe_unused rcar_can_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rcar_can_resume(struct device *dev)
+static int rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
@@ -886,7 +886,8 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_can_pm_ops, rcar_can_suspend, rcar_can_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_can_pm_ops, rcar_can_suspend,
+				rcar_can_resume);
 
 static const struct of_device_id rcar_can_of_table[] __maybe_unused = {
 	{ .compatible = "renesas,can-r8a7778" },
@@ -904,7 +905,7 @@ static struct platform_driver rcar_can_driver = {
 	.driver = {
 		.name = RCAR_CAN_DRV_NAME,
 		.of_match_table = of_match_ptr(rcar_can_of_table),
-		.pm = &rcar_can_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_can_pm_ops),
 	},
 	.probe = rcar_can_probe,
 	.remove = rcar_can_remove,
-- 
2.43.0


