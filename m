Return-Path: <linux-can+bounces-4305-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6E9B3146D
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EABF5E1485
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5EB2EE5F0;
	Fri, 22 Aug 2025 09:51:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CD2EB86B;
	Fri, 22 Aug 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856261; cv=none; b=pc+pdtbaYIzHtq/MI52Lw25ZeekFPGXR1G3Yn9RaK45R7Q6tXwd0FS7teM/3WIHIN4nfRVoM+DusMnj/BnI+BTv8snWRYbKWluoKnjtpD/ab8Ou9blOfup8itbdbARAX8xdxgPLGBfsCjoAcW77eOyx9XZ27Qzu5IgvP4VdaMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856261; c=relaxed/simple;
	bh=A6UPMNDuW7ttr4PyjGeRHzt9MrZTyBXoBv8du/YOZ68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ye3qZAYjDtxtGZSt+U+8orAY50Pk6rMIaSE6u0kaOuPnzo1zYFcLg+NZkaBfZSRxmGTS3CWBK2HaR4KhvCgfKJvx0sK+WZcLzKSSYMHj6LuojSDA+0w+bPNy51+wrGvi9dBOV497g/Hd9AoCF8TwBv+uMBxIy8UgM7C8/Y9lbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A3CC4CEF1;
	Fri, 22 Aug 2025 09:50:59 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/6] can: rcar_canfd: Invert CAN clock and close_candev() order
Date: Fri, 22 Aug 2025 11:50:42 +0200
Message-ID: <e5e09af5bc8ac530b7be6a958beea1941166b0b2.1755855779.git.geert+renesas@glider.be>
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

The CAN clock is enabled before calling open_candev(), and disabled
before calling close_candev().  Invert the order of the latter, to
restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 38c1b327f6b1d540..de5121efdabdb6ed 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1561,8 +1561,8 @@ static int rcar_canfd_close(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	rcar_canfd_stop(ndev);
 	napi_disable(&priv->napi);
-	clk_disable_unprepare(gpriv->can_clk);
 	close_candev(ndev);
+	clk_disable_unprepare(gpriv->can_clk);
 	phy_power_off(priv->transceiver);
 	return 0;
 }
-- 
2.43.0


