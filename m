Return-Path: <linux-can+bounces-3223-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE79A716A1
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DB119A0607
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D31DF963;
	Wed, 26 Mar 2025 12:20:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ACD1E1DF9;
	Wed, 26 Mar 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991652; cv=none; b=SgL8twEi2b1mBI9l9IuJ5NigbUtB7JMqwB+m5uES9AMD4wK5V9s9ekM+fj0CAqOiQsOgFkOUC/qo2xNsoazkwETJal/eyhMgITZpDuHUkliYorTV+TAnaDBI/1pahgSOep7EIiQUjca2NhAhB2AqMRHCGTAneaNXzh3vQwnEFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991652; c=relaxed/simple;
	bh=d1O2PKc2kvVszRV9ErO7GDNYrcdzZaE/WHRhc7LRPRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPlzgS3KLS4wv8JPcPn5daGKV2ipPMXX1ISYMHhQOzS7YA5cIs9w68dflnH1b+/Cs9E9NAtPK0+gWX4BHJEjXq6k/8B+t7N1FUXZtSW4g+ozkcy8rkmSeoHaoF+gOAjK8sir1DkwM+3w+NulbKv+Qn+MvZ1RGauhjUnkxTYkZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 2XbnXISdQtydSY9DjK6osQ==
X-CSE-MsgGUID: 7+JRJaajQ5WzUUiDXzWI8A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Mar 2025 21:20:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6DFA440104CB;
	Wed, 26 Mar 2025 21:20:47 +0900 (JST)
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
Subject: [PATCH v7 10/18] can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
Date: Wed, 26 Mar 2025 12:19:45 +0000
Message-ID: <20250326122003.122976-11-biju.das.jz@bp.renesas.com>
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

R-Car Gen3 has CFTML max positional value is 15 whereas on R-Car Gen4 it
is 31. Add a max_cftml variable to struct rcar_canfd_hw_info to handle
this difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Collected tag.
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


