Return-Path: <linux-can+bounces-3341-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D58A78C0E
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C985A16FDF5
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904923642E;
	Wed,  2 Apr 2025 10:23:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720D235BE8;
	Wed,  2 Apr 2025 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589393; cv=none; b=u5VSxGsBvbEZ9xN88Vy1QpaFqrd3fN3Dnr7l9Wct2Fe7Dkbax/ncNhdjNZ7UJdA1eIVMdfQhxdLnx+VaMOSIZRIAPVN8cbSqbp+7GOk77SOT6lT/0WpSHvA1OEZTFXAu+/fri9D35orbXNunbfq7KfnqEVXcq/TdA8ekX0q9fH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589393; c=relaxed/simple;
	bh=cf4kiArMQCApr4Cyso0vLIzfhTH1oSuq69f+roQcTAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqBYAihpES19WN6Bl2j0E6CzEqAAtIv6SA351Q2Lyt9kTuq9gSqrhLkrKsxw5/QTj9mxpFCaJxny45J4DF+NpPs61oqJy5aou2Ked2PA7c6eko7LSlY68v+lekyLarmltXR5ywXqsBq0ughgUYZtZ+r4cs2Zs9hMdLfUwYyjlig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Xc2VTveXR0eIXe+u38ak1Q==
X-CSE-MsgGUID: cnAqgh+0T5a56KBjnLrVFQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2025 19:23:11 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 056914224201;
	Wed,  2 Apr 2025 19:23:08 +0900 (JST)
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
Date: Wed,  2 Apr 2025 11:22:02 +0100
Message-ID: <20250402102226.28032-11-biju.das.jz@bp.renesas.com>
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


