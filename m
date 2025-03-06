Return-Path: <linux-can+bounces-3012-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D2A54B17
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 13:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0961888FC7
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E903C20B7E1;
	Thu,  6 Mar 2025 12:43:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA220A5D3;
	Thu,  6 Mar 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265023; cv=none; b=RiY1SeDicNcgCapjElRVEBF8Rniw7FulAbcM/EfYS5npF2smCpk6sXpG6NaqbECZTIG4R3ExxTpP11d3Axl+P3tZEZ2y+n2apSq/edOQY7VyaJI9+IBeSzfcEz0POss9PnjZ8/b8g1GNZ7GAaav30F/fYaWTiXYjfUc9XAcBjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265023; c=relaxed/simple;
	bh=oTPxzs6L6PLWAFi6Ef4dZQamWeDthoynra8ztmRYGvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXWa4iaqrOtvAwb2tk3DhSDNSdEWMC5HTXP5D9Zok6O7oXvSgus4izHi4B0uklHlclq9faOir6ZGMYOuNfhRhyYdxMoZC0BeBNeBEpIgwCyhPJ/eKCR/9w/LGZZ1IJbCHWYFqjLNou+1J1PZgZyDiWY9euhILEXcP61X2rND4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: oiK4GdSYQ3C70xvl2JFx1g==
X-CSE-MsgGUID: +X2oy4OLReu5P3pWIM+6wg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Mar 2025 21:43:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.10])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1659B4281B0F;
	Thu,  6 Mar 2025 21:43:38 +0900 (JST)
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
Subject: [PATCH v4 10/11] can: rcar_canfd: Enhance multi_channel_irqs handling
Date: Thu,  6 Mar 2025 12:42:49 +0000
Message-ID: <20250306124256.93033-11-biju.das.jz@bp.renesas.com>
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

Currently multi_channel_irqs has only 2 channels. But RZ/G3E has six
channels. Enhance multi_channel_irqs handling to support more than two
channels.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 0042b1e06c76..862f06b4b91e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1866,16 +1866,19 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	if (info->multi_channel_irqs) {
 		char *irq_name;
+		char name[10];
 		int err_irq;
 		int tx_irq;
 
-		err_irq = platform_get_irq_byname(pdev, ch == 0 ? "ch0_err" : "ch1_err");
+		scnprintf(name, 10, "ch%u_err", ch);
+		err_irq = platform_get_irq_byname(pdev, name);
 		if (err_irq < 0) {
 			err = err_irq;
 			goto fail;
 		}
 
-		tx_irq = platform_get_irq_byname(pdev, ch == 0 ? "ch0_trx" : "ch1_trx");
+		scnprintf(name, 10, "ch%u_trx", ch);
+		tx_irq = platform_get_irq_byname(pdev, name);
 		if (tx_irq < 0) {
 			err = tx_irq;
 			goto fail;
-- 
2.43.0


