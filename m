Return-Path: <linux-can+bounces-3125-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF01A64F15
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B865C1719D2
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3507D23A566;
	Mon, 17 Mar 2025 12:36:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B7F23959F;
	Mon, 17 Mar 2025 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215016; cv=none; b=J1E1ZHFs/u5laD3WKqcVpRMwTPGkvvizuTrRpKglpIGCGVaJ1rWj+AIaDbTwi/20U1Gm01F1eDrTgWSUhy6AYUtcpq9+uokRzRVhP8LqrlLarQNB8/9ncExDTI2gED7O9nzq22IkLgdYSlL8aOiSJVzpoetoFugv7Iyd9P+VFls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215016; c=relaxed/simple;
	bh=Xz6GiSoOzs/DVxhxW9h0OeyCAv0i3rJO8oNUI9lvbWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTGEseELyE4d4NOCBzCu6I0uzH2peJurrnpfXVoiXkh37f5wHIJtwWIBtdQ5gbt3zY5qaShaXqcWNRT70vjixI9DjE+l2cgVOqK8AyAC5QxqDf4BHyN0M7Bk+vnBGHOQwXCXwngs4LM8qQIvHmyuNNcC4Jt/8CwUHNGNPCOwXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 3n09CrrcSki7dGrLZbkBiQ==
X-CSE-MsgGUID: 1I6ulw4tREmE6bibiUKV7Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2025 21:36:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F008E4000FBD;
	Mon, 17 Mar 2025 21:36:49 +0900 (JST)
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
Subject: [PATCH v5 06/16] can: rcar_canfd: Add num_supported_rules variable to struct rcar_canfd_hw_info
Date: Mon, 17 Mar 2025 12:36:00 +0000
Message-ID: <20250317123619.70988-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
References: <20250317123619.70988-1-biju.das.jz@bp.renesas.com>
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

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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


