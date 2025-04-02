Return-Path: <linux-can+bounces-3344-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7000A78C12
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B42D16D772
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3CB235BE8;
	Wed,  2 Apr 2025 10:23:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7998D53BE;
	Wed,  2 Apr 2025 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589404; cv=none; b=fIj+zIV5+uObgKVu05bxoT9tc6u4TTZT4lf1mLnE32E4/0FWh1+t1puwojT9Hgn1dDt6eYa7bifWFgfZXNFwgsXiUQeSl1AtBW78JFc2U0BXHEl2llJjVdKnOY33xtLyCBho7nOJfRbw3V1yN2Mp0V+duloyu0kbHJtjEc5MtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589404; c=relaxed/simple;
	bh=xM3YsvI4jkB659bhyGDR1H/gzwGdJrH7mW09Jm/6i+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQpUTHxMlnymVRyHa1d/Sa92JV55ieCbUT1afPKzm62CdrsdhYzS4qvngRGgbY7SlcrgWekSM+hpeiBo0w0fbpQ5Qxjd2cbvG8JVf98ihmWjEuKnFyFTzc6AW0HfHDNoIP0kIfetkq9dMxb+VS10xOiZU5rsMPyhE1nXcywzM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: IxHSEnc8SeCKh+/fFfs70g==
X-CSE-MsgGUID: qUxn7gBxQ3my6v+XFAV4bA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2025 19:23:22 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5EB374224218;
	Wed,  2 Apr 2025 19:23:19 +0900 (JST)
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
Subject: [PATCH v8 13/19] can: rcar_canfd: Add ch_interface_mode variable to struct rcar_canfd_hw_info
Date: Wed,  2 Apr 2025 11:22:05 +0100
Message-ID: <20250402102226.28032-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
References: <20250402102226.28032-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen4 has channel specific interface mode bit for setting CAN-FD or
Classical CAN mode whereas on R-Car Gen3 it is global. Add a
ch_interface_mode variable to struct rcar_canfd_hw_info to handle this
difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * Updated {rzg2l,car_gen3_hw_info} with ch_interface_mode = 0.
 * Collected tag.
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * Collected tag.
v3->v4:
 * No change.
v3:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 54f5b8842cb2..bcdf6e4aafc4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -515,6 +515,7 @@ struct rcar_canfd_hw_info {
 	/* hardware features */
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
+	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 };
 
 /* Channel priv data */
@@ -618,6 +619,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
+	.ch_interface_mode = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -629,6 +631,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
+	.ch_interface_mode = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -640,6 +643,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
+	.ch_interface_mode = 0,
 };
 
 /* Helper functions */
@@ -732,7 +736,7 @@ static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
-	if (is_gen4(gpriv)) {
+	if (gpriv->info->ch_interface_mode) {
 		u32 ch, val = gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
 					    : RCANFD_GEN4_FDCFG_CLOE;
 
-- 
2.43.0


