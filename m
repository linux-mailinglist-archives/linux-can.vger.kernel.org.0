Return-Path: <linux-can+bounces-3004-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43743A54B19
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 13:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75503AF384
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F46120A5D3;
	Thu,  6 Mar 2025 12:43:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5389D190051;
	Thu,  6 Mar 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265000; cv=none; b=J7tP3FZr0qSnQIKk3zTN7vp5mJZJBdt/FN8hEwjBz4h0qleVtCSxlZyzyl/o2jRN8/BYdgmJau74/CTYdZ0zGxxpdVT0WY+Ivz3LNVvLd0xmB/Ovb7IFijYMaO6oFSAbTgTn61kCUpnXqdLvGV/HCk+YHijmA993RXlVaXL1r8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265000; c=relaxed/simple;
	bh=f6uFof6SyNFkJU1P45UAyllVaMxXt68tkS7/hZn5qsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/zF34KkJt/7CF9g7HFjD4c9ZSeJA6UJewkOKPTZsWmIN8KbCzUVeyA8+EKFw8DTuBsUUq0PaaezZQ2Qk3brF5wb2KALDR4K+g+5gK+IQlzGfxuOcG1NaZI55tlDzwqlavee77L/KMrMIcNemZ0ctDmIrY3oy+I0TcjiGnpAvLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Jl9jmP9CTz6RGjR5lJpBoA==
X-CSE-MsgGUID: 9oeTNwGSR02aQodyO7eFUg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Mar 2025 21:43:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A38E94281B03;
	Thu,  6 Mar 2025 21:43:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
	linux-can@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 03/11] can: rcar_canfd: Use of_get_available_child_by_name()
Date: Thu,  6 Mar 2025 12:42:42 +0000
Message-ID: <20250306124256.93033-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
References: <20250306124256.93033-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify rcar_canfd_probe() using of_get_available_child_by_name().

While at it, move of_node_put(child) inside the if block to avoid
additional check if of_child is NULL.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * Added Rb tag from Geert.
v2:
 * Added to this series as dependency patch hit on can-next.
 * Added Rb tag from Vincent Mailhol
 * Dropped redundant comment from commit description.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 270f50d836f5..8b326977ddf7 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1864,13 +1864,13 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
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


