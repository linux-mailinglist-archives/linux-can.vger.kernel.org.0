Return-Path: <linux-can+bounces-3122-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5D4A64F0D
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903071722F3
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C483B23A566;
	Mon, 17 Mar 2025 12:36:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C88238D32;
	Mon, 17 Mar 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215004; cv=none; b=b7bBvUeNXEu4/IBZINtSAYYXCVcax7D42czUrlWjX4V2LqYo3jepx+9ROfckXc51h5prR5Vf/45cR2F5mDI/25GuPcwTvaiBFX6a5Ke/yl2q0MKDaIz2laGz+G6g90SRrZQb4tVKJuTytRZjfKjPBtLwy/YJmQvzgqsXQuDOvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215004; c=relaxed/simple;
	bh=dFbaDxJiwNbdGAIlThELh7cqr9OA+MyFfoVtuiBtMTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QK7oL1v0Z/a+cJX4MPBPDfBg18UG33hLfdXIRPaWRr9O6ZzblW9kvBgREMVYJUSnlDl9u7gmAIdbqoavPx4yXCRMnwKqFKDPjATpCJTaeQRryXueDIRK4DWTz7j0uvnKe1DbtYTjsZ1OBdrWEUiwWOXv4HJNZHFkwvnQr8Wgw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: txl6UlSrQmmbxRXO1Op+mQ==
X-CSE-MsgGUID: MDvjreXzQ7uj19uKvVtUKg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:36:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 367EA4000FBD;
	Mon, 17 Mar 2025 21:36:38 +0900 (JST)
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
Subject: [PATCH v5 03/16] can: rcar_canfd: Use of_get_available_child_by_name()
Date: Mon, 17 Mar 2025 12:35:57 +0000
Message-ID: <20250317123619.70988-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
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


