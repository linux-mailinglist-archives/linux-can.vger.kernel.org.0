Return-Path: <linux-can+bounces-3420-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74FA912FE
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339023A7B90
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703201E32C6;
	Thu, 17 Apr 2025 05:43:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4781DF252;
	Thu, 17 Apr 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868629; cv=none; b=CeCr2fzRrpqPMdGe2zhI+8PIXqAE3WWjltwjRoouNbTV0bIZyAAI+AH+FLU3TrdofaUciPRm+R5FuQpBxgusuMU1JLcCExIvvuq0EvX9MI0944aXLoLjJUqwht2XB9omU26En2+c2YvOHcOFBH98uKqBzEKeaWQhfAVk6tEmO68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868629; c=relaxed/simple;
	bh=plngJGYdi+NFHGYS9kcmOVDBYijhVkkeWcd1bakFSA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgZmLHtuAWTDGh31maMC+XKdWYadCCb2aHm9fzT6/V0aWP/0K/Rxfb7fvBRtciP40Jo36Xc/ryjOIsBiBEeCejFSoy3XVCZhC+NuCslP71OYbq+/DNbMh9RduigADAcOiuIbdKJ4zM6fHe3H1IQx7DGdGpuKdfmjF4g2Vp8bALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: OJCUSngdRCepIs78Hjuwyw==
X-CSE-MsgGUID: ENrMeeOCS5SXXVn2KqHvLw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 14:43:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0E50F403A5B9;
	Thu, 17 Apr 2025 14:43:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	u.kleine-koenig@baylibre.com,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v9 03/19] can: rcar_canfd: Use of_get_available_child_by_name()
Date: Thu, 17 Apr 2025 06:43:04 +0100
Message-ID: <20250417054320.14100-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
References: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
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
v8->v9:
 * No change.
v7->v8:
 * No change.
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * No change.
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
index aa3df0d05b85..2d9569fd0e0b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1855,13 +1855,13 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
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


