Return-Path: <linux-can+bounces-3324-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D189BA78BEC
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9A83B27EB
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B17236454;
	Wed,  2 Apr 2025 10:21:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BD23496B;
	Wed,  2 Apr 2025 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589275; cv=none; b=mgvRnqWypJWqBjhD2r4vSXrZ7SSSvJguNj5g1ZyvCSZ94obYUO0aQXyIczA6bl+ekq+AZadkqLDoexeDm6OkVM8+6bUvrP15FBSwGWBvOJjcm+Gy2oMO8Atfq1TlOJd8ZkZ23xEijlmQdxYLWUq11GE8hOrXNgaziCFqXR30fTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589275; c=relaxed/simple;
	bh=jEH+/LY2v3Y2Gs6bIr6D97+DiiJDQe+aJAPPPZqWSyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9z2Pr/M4fG+Iz+Hc5jfmqiHg+dthc9eQZmbAGIn3AIWPhOv1/mzRd6YTe4yt8uJm+5sjbXDmauSYXi1vKB4OZcl3OVvM/JMogwSNlMBjC+9iBr99iN5WvqoHVCwMjJy2jo+5NjBUATLboFzKEVZK61sUm3hVcRyAFJSgbTSQzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 1nnSnnTHRiS8J01h8Z8V3Q==
X-CSE-MsgGUID: 9V54P9dgStesnMQ2nKlr0A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2025 19:21:13 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C9B1E401C75A;
	Wed,  2 Apr 2025 19:21:10 +0900 (JST)
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
Subject: [PATCH v8 04/19] can: rcar_canfd: Drop RCANFD_GAFLCFG_GETRNC macro
Date: Wed,  2 Apr 2025 11:20:24 +0100
Message-ID: <20250402102047.27943-5-biju.das.jz@bp.renesas.com>
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

Drop the unused macro RCANFD_GAFLCFG_GETRNC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * Collected tag.
v6->v7:
 * No change.
v5->v6:
 * Collected tag.
v5:
 * New patch
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2d9569fd0e0b..565a91c2ca83 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -94,10 +94,6 @@
 	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
 	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
 
-#define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
-	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
-	 reg_gen4(gpriv, 0x1ff, 0xff))
-
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
 #define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
-- 
2.43.0


