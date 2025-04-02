Return-Path: <linux-can+bounces-3329-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F132A78BFB
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D61F16DDE7
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16FF23496B;
	Wed,  2 Apr 2025 10:21:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFA5235BE8;
	Wed,  2 Apr 2025 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589294; cv=none; b=MbhXE6+qCunmBZ8Pw0poW7o7pKzWfGJ7yPDcLmYYBJ3O2L7I9/43uZJ0iUUrrxCaniKf5GKOO3kl/HRc3zwz1sWvTixwoU50kK54zVhr65u1GKgBsY4I5//yE0tn9/jc/OY07WC6HqcpitMAE3/BCu73U+uikyNW3l9AZqvehUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589294; c=relaxed/simple;
	bh=cf4kiArMQCApr4Cyso0vLIzfhTH1oSuq69f+roQcTAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJu5Dik7iulcPO5HpD7HJlWCaN2o6FC2Bi3/0YvJHSFwM8Rt/wOrqBP95+SI7y5gdrQXwY7nAmSXFcv2sPXN1YqbvABN6IqfxN92WWTw+Nd4cW3BR72A9TjlQf+lN8yFv7L/65XXarYB+q4TcHA3L3wXxpiGw5/2DiNlGQ6DHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 4O0FVlmVTQ+OBuOF46IhRA==
X-CSE-MsgGUID: SN7X21GESwGeOPyTBQEUnA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2025 19:21:31 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 22727401C75A;
	Wed,  2 Apr 2025 19:21:28 +0900 (JST)
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
Subject: [PATCH v8 10/19] can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
Date: Wed,  2 Apr 2025 11:20:30 +0100
Message-ID: <20250402102047.27943-11-biju.das.jz@bp.renesas.com>
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

R-Car Gen3 has maximum acceptance filter list page number of 31 whereas on
R-Car Gen4 it is 127. Add max_aflpn variable to struct rcar_canfd_hw_info
in order to support RZ/G3E that has max AFLPN of 63.

While at it, rename the parameter x->page_num in RCANFD_GAFLECTR_AFLPN
macro to make it clear.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * Renamed the parameter x->page_num in RCANFD_GAFLECTR_AFLPN macro to
   make it clear.
 * Collected tag.
v6->v7:
 * Collected tag.
v6:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ee4d24646b2d..16fbe4be6782 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -91,7 +91,7 @@
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
+#define RCANFD_GAFLECTR_AFLPN(gpriv, page_num)	((page_num) & (gpriv)->info->max_aflpn)
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
@@ -503,6 +503,7 @@ struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
 	u8 rnc_field_width;
+	u8 max_aflpn;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -580,6 +581,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.rnc_field_width = 8,
+	.max_aflpn = 31,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -587,6 +589,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.rnc_field_width = 16,
+	.max_aflpn = 127,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -594,6 +597,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.rnc_field_width = 8,
+	.max_aflpn = 31,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.43.0


