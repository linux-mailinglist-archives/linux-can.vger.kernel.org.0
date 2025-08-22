Return-Path: <linux-can+bounces-4320-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0AB314F7
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04CF1C8758E
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6E284682;
	Fri, 22 Aug 2025 10:17:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A079218AD1;
	Fri, 22 Aug 2025 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857854; cv=none; b=EQ5i6ZsZkpf8/Ryo5x0auiIQtcmPWKX/jAbpYSkBILNo7Nbc+Tiv7WWlDOx+78VbLBcIP+1ne+eQpjqpSGOx07UKc9kYIofh1xJkPMHphPxAKsL4oL9Ukrixt9QVaEhvT3e8aUcKK5K2Z8Reo6R4fRoeVNmzsozdv5YC07fQm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857854; c=relaxed/simple;
	bh=dlhvVwxFwfVp4o+laz1o6Stv1CaIw+gs8k6ipymydWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSg80YF3U48VsrpLiDO5u3sx7KPJDWobGEdh/h5egvDsGyK+LLWdok9foGCKVvjtOnDRsZfwnoPJoMB5CaJX1y6XKd0Z4KPh6zjRB+VRz8FBfzsqFMCj2D80LkAai4YwTGuqKTuuKF82CEr2SVi2gbAiBQI3mYVemrR/u37n2f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D00C4CEF1;
	Fri, 22 Aug 2025 10:17:32 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 10/11] can: rcar_can: Do not print alloc_candev() failures
Date: Fri, 22 Aug 2025 12:17:11 +0200
Message-ID: <2d6ad4be211a35492570fd7219ca7a89b384bfad.1755857536.git.geert+renesas@glider.be>
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

If alloc_candev() failed due to out-of-memory, the core memory
allocation code has already printed an error message.
If alloc_candev() failed for a different reason, alloc_netdev_mqs() has
already printed an error message.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/net/can/rcar/rcar_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index de1829477659757c..51bf8f7e71824ac8 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -773,7 +773,6 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	ndev = alloc_candev(sizeof(struct rcar_can_priv), RCAR_CAN_FIFO_DEPTH);
 	if (!ndev) {
-		dev_err(dev, "alloc_candev() failed\n");
 		err = -ENOMEM;
 		goto fail;
 	}
-- 
2.43.0


