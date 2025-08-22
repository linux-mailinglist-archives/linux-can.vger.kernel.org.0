Return-Path: <linux-can+bounces-4302-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEBAB31487
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A60C1C21582
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D8277CA4;
	Fri, 22 Aug 2025 09:50:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D4225390;
	Fri, 22 Aug 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856256; cv=none; b=bDe8TIjzV+xJLit9VcpV8xPQItnfBFjRMi86xv4Q3wPdiBqXGZJ0KIBhuRm6cYaTN7sqtY2PyYZABI+Ok7kf+BR6U/cdP4Pp8f6KngdlMaVYIZz+BgKlbTg2Oiqqb0SMY7243vf8ZKayBN03/ewikD8duJbmQOOtqacBwNhF8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856256; c=relaxed/simple;
	bh=cNFyIz43+XHhyKg0gToc3PSQl9r1mBVZ54LN2Dqy6EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bc6vyu2Ntl5MujggU86Fa3dJZzvb4tK+jRW00ZKGUw8Jn9yPLMW3MZzY+JWhDXxsuFLXVsEJnWkzZu7W0l1H/Cz3zebaJuXCeavZAUqScvbli9zihNR8/YOwnQ71+8b4p/qpTOFtRaQula7eAGwcWK0HSYtl6ha+koLreUtmvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DEAC4CEF1;
	Fri, 22 Aug 2025 09:50:54 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/6] can: rcar_canfd: Invert reset assert order
Date: Fri, 22 Aug 2025 11:50:39 +0200
Message-ID: <f48b37ece8058e0d94d79bfd9188fef046114c06.1755855779.git.geert+renesas@glider.be>
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

The two resets are asserted during cleanup in the same order as they
were deasserted during probe.  Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b3c8c592fb0e04ed..6f013f87f25c1494 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2182,8 +2182,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2204,8 +2204,8 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


