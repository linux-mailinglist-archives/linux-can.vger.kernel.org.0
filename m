Return-Path: <linux-can+bounces-3342-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82648A78C0F
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4092916E3BE
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5423496B;
	Wed,  2 Apr 2025 10:23:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED2F53BE;
	Wed,  2 Apr 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589398; cv=none; b=XKoySl/lkCDN0ezInplGOxLmSEKcpc6x9bhsaajRxZdi7Z1p8LzA0bT/Guvq7Fc5cUKXH1OCobIMUbonDRhD6iJoOZdSa3E8TL5L2vWSGOzEWhbKdXbDyoBl+jeMbNeKxjAhYYeZ9F8NLVAgRwQH5TZtQxYAKL/oMQdaxiyyYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589398; c=relaxed/simple;
	bh=p6DtY5MTZkDcvhqyxDKHFC5yXF2yHt4uN9GBknrU2x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGTrAXyiY+xvK9SRBaVYm+wENHwc6/z1gxzXVR7KstaiO8aJfmskD6uKl8Td17PklBdUXNGiGuOof210WCLp3yCuolib1IOGPgIyQOjdin7l9TNube+Eyj3Gvyo8rmTu37RTBNiArmxZj4PRTcVC+mAnH29nzROGUPcwjzN+ISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: rPGawsxdSf+SxBPtzqVOTQ==
X-CSE-MsgGUID: WpVqteABT5SVEGDE2VkEjg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2025 19:23:15 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 707FF4224218;
	Wed,  2 Apr 2025 19:23:12 +0900 (JST)
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
Subject: [PATCH v8 11/19] can: rcar_canfd: Add max_cftml variable to struct rcar_canfd_hw_info
Date: Wed,  2 Apr 2025 11:22:03 +0100
Message-ID: <20250402102226.28032-12-biju.das.jz@bp.renesas.com>
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

R-Car Gen3 has CFTML max positional value is 15 whereas on R-Car Gen4 it
is 31. Add a max_cftml variable to struct rcar_canfd_hw_info to handle
this difference.

While at it, rename the parameter x->cftml in RCANFD_CFCC_CFTML macro to
make it clear.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v7->v8:
 * Renamed the parameter x->cftml in RCANFD_CFCC_CFTML macro to make it
   clear.
 * Collected tag.
v6->v7:
 * Collected tag.
v6:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 16fbe4be6782..569ee5925b55 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -224,8 +224,11 @@
 /* Common FIFO bits */
 
 /* RSCFDnCFDCFCCk */
-#define RCANFD_CFCC_CFTML(gpriv, x)	\
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 16, 20))
+#define RCANFD_CFCC_CFTML(gpriv, cftml) \
+({\
+	typeof(gpriv) (_gpriv) = (gpriv); \
+	(((cftml) & (_gpriv)->info->max_cftml) << reg_gen4(_gpriv, 16, 20)); \
+})
 #define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
 #define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
@@ -504,6 +507,7 @@ struct rcar_canfd_global;
 struct rcar_canfd_hw_info {
 	u8 rnc_field_width;
 	u8 max_aflpn;
+	u8 max_cftml;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -582,6 +586,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
+	.max_cftml = 15,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -590,6 +595,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
+	.max_cftml = 31,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -598,6 +604,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
+	.max_cftml = 15,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.43.0


