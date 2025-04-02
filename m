Return-Path: <linux-can+bounces-3326-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9268A78BED
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFB53B2371
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5CC236454;
	Wed,  2 Apr 2025 10:21:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF123534D;
	Wed,  2 Apr 2025 10:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589282; cv=none; b=oFJpJiGplzZmWftJ88uVqeMItHhp1COln7MgGVs45ZRsYCqPefbsihxdLbPLhifKNV69QHoqbO2LVA49r+WbscN7UuGSHTnjF2I0O+0iKjwnOq1YvcwC4GxOsj8JT/VqDA9i+tOI6wZ+AURikujzLGek8g2TVy7YujvSi+8PwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589282; c=relaxed/simple;
	bh=squ4J4KXqQBUlULcmYlzGzCJxkIWghsxDRs1Te4RYrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmFqx3QFjcX7N5OvNVm1PuvwN2hgbMl2iZSJRcgvVuVTk8qz3i+/J18B5QrjUeElZpiCVzesQTNeC1eMUerkCWaAMGj9wlY5Tj4JlySGeWzTcxb4nH8x5TIRhxFdMq1uhtDq4cz9HWgGOWeK9DAj5ZEBX//ppFY8vm1xFSLyuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: eFAjH13lSZ2nlzUXW4rT2A==
X-CSE-MsgGUID: +eaA0/hkQSyN0gdFBjx+jQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2025 19:21:20 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B0624401C759;
	Wed,  2 Apr 2025 19:21:17 +0900 (JST)
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
Subject: [PATCH v8 06/19] can: rcar_canfd: Drop the mask operation in RCANFD_GAFLCFG_SETRNC macro
Date: Wed,  2 Apr 2025 11:20:26 +0100
Message-ID: <20250402102047.27943-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402102047.27943-1-biju.das.jz@bp.renesas.com>
References: <20250402102047.27943-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the mask operation in RCANFD_GAFLCFG_SETRNC macro as the num_rules
can never be larger than number of supported rules.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8:
 * New patch
---
 drivers/net/can/rcar/rcar_canfd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 34b918e8ec1c..8205e4ada12e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -91,8 +91,7 @@
 
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
-	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
+	((x) << (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-- 
2.43.0


