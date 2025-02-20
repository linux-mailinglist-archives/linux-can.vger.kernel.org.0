Return-Path: <linux-can+bounces-2900-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A1A3DACD
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 14:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D574F16EDAC
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636A1F5845;
	Thu, 20 Feb 2025 13:04:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E51F6694;
	Thu, 20 Feb 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056696; cv=none; b=GT3qgm23UZnHvVeoIjBUVKkZMaicboPmUsU1TTjgzFDsa/viObK1DFr+VdWoMNwGwx4QzuUhnCtP/cgij7W/+50+204Gmu4Q7QLFNyzUJqhvlmiMeHZFz5XFZc7yAitm8GB8Zriuisgxt2uO8pOuVUGoyPOgsQYzAEcSSOWeEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056696; c=relaxed/simple;
	bh=avSU492k1TpeyBaiJ6d+8nFcaTlKueWSvhbKozu78pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIq8b1LaVsctzN29iwXtqmVfYoLLBJGBnPV1Gi034B8IN64hwM2EvxpafRTncVqd3f+U1tttIdgrSGsxo+3vccikwoYzH8MPTOaC3i1cee9NgQNv4b/6mZX6vdNlKpWw3Q3GCjvYqLu8wyrGhNvl92qpAm3fVuAz8RzPxAKagXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: zbA9Ls0IQwi6k2z58HF52w==
X-CSE-MsgGUID: ck+/fgFbQgOXd1IJVbWlZw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2025 22:04:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 57EFB42B36D8;
	Thu, 20 Feb 2025 22:04:50 +0900 (JST)
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
Subject: [PATCH v2 4/7] can: rcar_canfd: Add gen4_type variable to struct rcar_canfd_hw_info
Date: Thu, 20 Feb 2025 13:04:20 +0000
Message-ID: <20250220130427.217342-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
References: <20250220130427.217342-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both R-Car Gen4 and RZ/G3E SoCs have similar register layout. Introduce
gen4_type variable to struct rcar_canfd_hw_info for the preparation of
adding RZ/G3E driver support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8b326977ddf7..13eb6aa6ae45 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -516,6 +516,7 @@ struct rcar_canfd_hw_info {
 	/* hardware features */
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
+	unsigned gen4_type:1;		/* Has gen4 type reg layout */
 };
 
 /* Channel priv data */
@@ -596,6 +597,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
+	.gen4_type = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -607,7 +609,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 /* Helper functions */
 static inline bool is_gen4(struct rcar_canfd_global *gpriv)
 {
-	return gpriv->info == &rcar_gen4_hw_info;
+	return gpriv->info->gen4_type;
 }
 
 static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,
-- 
2.43.0


