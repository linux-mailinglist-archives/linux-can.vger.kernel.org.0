Return-Path: <linux-can+bounces-3222-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516C0A71678
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621963A71C2
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7B1DF969;
	Wed, 26 Mar 2025 12:20:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266871E5B73;
	Wed, 26 Mar 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991648; cv=none; b=HPRrQxHATGXi++HYwf+9vkkUcNhmRpm8X06JTuWRoVPW8GCHKdia4Gh27sLC87i1MAMjcUvUXqLrOTMVBHZPUDcqTblJwE8NGQdnjZ8hyimmqUQwVLfFTBNENft0RE2G9ttfu1imVHYfZ3ztJmxNLds8xkiO04RPPXnDKXrGeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991648; c=relaxed/simple;
	bh=iluxQJNxmzSzwVZDtBN7JHmPDqYw4PyqOmnXuM6oT4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umxlf/QIEaY+NQk9Z5c3qumlwomaufzbtiUb0LPwafhH1RXR/UD+LaliT4+fa32qrEiTXfI4owgt72SLOwfQebcROO7cBtzJbNgJw0MC3pu9MW6j4JiHuKQ084F/SdXc/Y2AinkI9sil769TiBLtPuysrMNUwj2MJ1fSp+CmwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 0A61C4odSzybzTeAwd3Z9A==
X-CSE-MsgGUID: DItLMYkiSVqcXSvCdzRuog==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Mar 2025 21:20:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0188F40104FA;
	Wed, 26 Mar 2025 21:20:43 +0900 (JST)
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
Subject: [PATCH v7 09/18] can: rcar_canfd: Add max_aflpn variable to struct rcar_canfd_hw_info
Date: Wed, 26 Mar 2025 12:19:44 +0000
Message-ID: <20250326122003.122976-10-biju.das.jz@bp.renesas.com>
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

R-Car Gen3 has maximum acceptance filter list page number of 31 whereas on
R-Car Gen4 it is 127. Add max_aflpn variable to struct rcar_canfd_hw_info
in order to support RZ/G3E that has max AFLPN of 63.

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
index 62cde1efa0c0..7cef0673fbc8 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -93,7 +93,7 @@
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
+#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & (gpriv)->info->max_aflpn)
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
@@ -507,6 +507,7 @@ struct rcar_canfd_hw_info {
 	u16 num_supported_rules;
 	u8 rnc_stride;
 	u8 rnc_field_width;
+	u8 max_aflpn;
 	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
@@ -586,6 +587,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.num_supported_rules = 256,
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
+	.max_aflpn = 31,
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -595,6 +597,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.num_supported_rules = 512,
 	.rnc_stride = 2,
 	.rnc_field_width = 16,
+	.max_aflpn = 127,
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
@@ -604,6 +607,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.num_supported_rules = 256,
 	.rnc_stride = 4,
 	.rnc_field_width = 8,
+	.max_aflpn = 31,
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
-- 
2.43.0


