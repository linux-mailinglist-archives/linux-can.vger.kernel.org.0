Return-Path: <linux-can+bounces-3172-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5EA6A231
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 10:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF593189D335
	for <lists+linux-can@lfdr.de>; Thu, 20 Mar 2025 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B083D214A74;
	Thu, 20 Mar 2025 09:11:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DFE1A238C;
	Thu, 20 Mar 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461911; cv=none; b=o5iaDHub65+GTKelbT3sOdhNrkOz8cS4Q2agEPDzVEh6a2Y2k6W0W5cdY2MfDmOM5yY5aEjHRw2dzVLfjvgiIKUc+wPD05ZbPMK6Z5/TxEMCCgWrKQhGxOADVKphgglG3iKOvn0G3tJRJuENEebAlpOZrs/ZEUil6mWzEfw7RVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461911; c=relaxed/simple;
	bh=EptvTJXWeXJTiq374U7MrpfP/tOgEIpzTfxgEmMz2TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbjFKvAT3RosShXkP8kVyNPY4qwXBIBIY9opA+qp0nOqCzRWQ8QOqfNT8Koa+PbPKp4/KAEfo+uKOF1ZEAGdHFNhOef/H6W7y1eSUo/q5WD6Vdnrhe/LOzmEem1Ul/pi6CAICkqgtkNJExjzIAr/XIJ/e7Gsk/3doG21HNNeNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: MZfwCviKTAiVZHy+oTC1Pg==
X-CSE-MsgGUID: 3W4IjqXbSFSJ/WYqBDEl2g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Mar 2025 18:11:49 +0900
Received: from localhost.localdomain (unknown [10.226.93.24])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CA7FD4001B61;
	Thu, 20 Mar 2025 18:11:46 +0900 (JST)
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
Subject: [PATCH v6 10/18] can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
Date: Thu, 20 Mar 2025 09:10:41 +0000
Message-ID: <20250320091101.33637-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
References: <20250320091101.33637-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen3 has CFTML max positional value is 15 whereas on R-Car Gen4 it
is 31. Add a max_cftml variable to struct rcar_canfd_hw_info to handle
this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7cef0673fbc8..c37fb85fe478 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -227,7 +227,7 @@
 
 /* RSCFDnCFDCFCCk */
 #define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
+	(((x) & (gpriv)->info->max_cftml) << reg_gen4(gpriv, 16, 20))
 #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
 #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
@@ -508,6 +508,7 @@ struct rcar_canfd_hw_info {
 	u8 rnc_stride;
 	u8 rnc_field_width;
 	u8 max_aflpn;
+	u8 max_cftml;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -588,6 +589,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
+	.max_cftml = 15,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -598,6 +600,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.rnc_stride = 2,
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
+	.max_cftml = 31,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -608,6 +611,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
+	.max_cftml = 15,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.43.0


