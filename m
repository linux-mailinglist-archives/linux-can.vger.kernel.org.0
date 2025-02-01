Return-Path: <linux-can+bounces-2710-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50653A24803
	for <lists+linux-can@lfdr.de>; Sat,  1 Feb 2025 10:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674301884B5D
	for <lists+linux-can@lfdr.de>; Sat,  1 Feb 2025 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09E114A099;
	Sat,  1 Feb 2025 09:47:01 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA713F9C5;
	Sat,  1 Feb 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403221; cv=none; b=HXPPRRMU+2b2vemfR7jOU75q6Y1ygDtcIR7uGJtvJOOm2UGgzWAWQw7++czBqhgfLZn9r++Ugg1JUMn2KcP4k1HQNPOJ7EGDT5EabW0gPHthSLFs7U3FEW4oe9mnGbtqWElVoIkl7Ej0D+e3GtC6x8kKMok6jQVjGdlHyZofuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403221; c=relaxed/simple;
	bh=H1mDewkfpJI6awDhoH4yoCf6K2AzDwcXiVlQUCNnx0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j5DcVt/KlAa6AagPiEZ/c3w/ISlu5xisDIFGNG1w3aWGYQ2hnJ2XOW4NtzjbWDzygwj0/XfAGjEk0s/txwA9XF5OnnZO8xQQk1VTCWMpvZcls36imrskiAm3Brtd/jeSbx1UFqpw308B4fdltAqdK4plqw8D5VeHRmFS396RBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 11gYQjqkTU2PwJ+UGm8giQ==
X-CSE-MsgGUID: frWol6YgSMiD5r29yq+hBg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Feb 2025 18:46:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9EDB741D879E;
	Sat,  1 Feb 2025 18:46:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-can@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] can: rcar_canfd: Use of_get_available_child_by_name()
Date: Sat,  1 Feb 2025 09:46:36 +0000
Message-ID: <20250201094642.16243-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify rcar_canfd_probe() using of_get_available_child_by_name().

Simplify rcar_canfd_probe() using of_get_available_child_by_name().

While at it, move of_node_put(child) inside the if block to avoid
additional check if of_child is NULL.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch is only compile tested and depend upon[1]
[1] https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renesas.com/
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index df1a5d0b37b2..619a21d68d82 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1862,13 +1862,13 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	for (i = 0; i < info->max_channels; ++i) {
 		name[7] = '0' + i;
-		of_child = of_get_child_by_name(dev->of_node, name);
-		if (of_child && of_device_is_available(of_child)) {
+		of_child = of_get_available_child_by_name(dev->of_node, name);
+		if (of_child) {
 			channels_mask |= BIT(i);
 			transceivers[i] = devm_of_phy_optional_get(dev,
 							of_child, NULL);
+			of_node_put(of_child);
 		}
-		of_node_put(of_child);
 		if (IS_ERR(transceivers[i]))
 			return PTR_ERR(transceivers[i]);
 	}
-- 
2.43.0


