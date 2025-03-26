Return-Path: <linux-can+bounces-3219-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E8BA7168B
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7383E17AC51
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D942C1E1DE9;
	Wed, 26 Mar 2025 12:20:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8611799F;
	Wed, 26 Mar 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991638; cv=none; b=glN3+CDNExmjhV8i3Rfbgu2T+ZFV70aLqBS2Adg/9ZOFrytNsNxrAPzWAWS5qtedxk3CRaAlF6mqBs/OvTKStwtv7v7Y4YhZ8VwnVXf5/T63uRDsX1pPSJVvuXs4vADxN+3jGKurMBU+wmMYzpWI9uHGKNJadYmC/BDP3y1N4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991638; c=relaxed/simple;
	bh=TzEMV6KUgL19pMquHrMWzBMpNCmm34ZGnQXlEruvvsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKQlxXnluNaAWgOJwsgknqC4lKTDrRuB6L+ZcRWKiArArgFpDFgGqnF7VSXX2sKqE8ZzGkS3LlfE5x/+chmBPxjVwnhSWefhBBAPwTf4j+XhkXgQ5lVIHYU66k7ujCVqcrWu6THlVttT5wYia6awoYb+Z6AJITw+PhrfOW/TA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 09JkYCTuTwivYRrKxp/hGg==
X-CSE-MsgGUID: 4CjPEXzsSB6AtV2W4+JALQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Mar 2025 21:20:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AADF340104CB;
	Wed, 26 Mar 2025 21:20:33 +0900 (JST)
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
Subject: [PATCH v7 06/18] can: rcar_canfd: Add num_supported_rules variable to struct rcar_canfd_hw_info
Date: Wed, 26 Mar 2025 12:19:41 +0000
Message-ID: <20250326122003.122976-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
References: <20250326122003.122976-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RNC mask is the number of supported rules - 1. Add num_supported_rules
variable to struct rcar_canfd_hw_info to replace RNC mask in
RCANFD_GAFLCFG_SETRNC macro.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * No change.
v5->v6:
 * Collected tag.
v5:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a9e962a1510e..32d700962d69 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -88,7 +88,7 @@
 
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
+	(((x) & ((gpriv)->info->num_supported_rules - 1)) << \
 	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
@@ -504,6 +504,7 @@
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	u16 num_supported_rules;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -580,18 +581,21 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.num_supported_rules = 256,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.num_supported_rules = 512,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.num_supported_rules = 256,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.43.0


