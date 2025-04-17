Return-Path: <linux-can+bounces-3430-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0349A9131F
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35226188C039
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E31DEFEC;
	Thu, 17 Apr 2025 05:44:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D4D1DEFD4;
	Thu, 17 Apr 2025 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868681; cv=none; b=GFruNMGS3HP4/YjeAiSY4ElWrFVNjaFw7Axn2UjNYjOCfQjuQxYe5O1jMrisIIFSmMQ17kh7K/VaYjt+l6nwkFB/2lZrFEvT4m9T54b6DIULaUaXLhYwebcVzV9CNX8OxrYX+4b5c1bAa9UTvJzF2a6DnH6LcyaOGVugeQICk14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868681; c=relaxed/simple;
	bh=rwydtBklBwmsaSZo+FR0j/idPDO2Cs1PqCVL/Hph+Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebl+EBx3UvG5Y0T/8TihNPkqu1K5Ejv4i6IkFxAosHhAZCGGiP2b8tlcZmpSA7+FTasmJ3lppNY7SxcFJlQFhz70u1Sst7xAqwZFBM386z5d3/Jmb0Ot3i3DNSlIjbVtCvUZGS//DAEP1BBkxM4QFED75zV7/DZWetUYmatF3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: LKiNPfk8QKSyjAyCJ1GOOg==
X-CSE-MsgGUID: trxuQt58Sb2YUu4wI41yjQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 14:44:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0851C44DBA2E;
	Thu, 17 Apr 2025 14:44:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	u.kleine-koenig@baylibre.com,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Simon Horman <horms@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v9 13/19] can: rcar_canfd: Add ch_interface_mode variable to struct rcar_canfd_hw_info
Date: Thu, 17 Apr 2025 06:43:14 +0100
Message-ID: <20250417054320.14100-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
References: <20250417054320.14100-1-biju.das.jz@bp.renesas.com>
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
v8->v9:
 * No change.
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
index d8380f38cdde..25c00abee9cc 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -516,6 +516,7 @@ struct rcar_canfd_hw_info {
 	/* hardware features */
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
+	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 };
 
 /* Channel priv data */
@@ -619,6 +620,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
+	.ch_interface_mode = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -630,6 +632,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
+	.ch_interface_mode = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -641,6 +644,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
+	.ch_interface_mode = 0,
 };
 
 /* Helper functions */
@@ -733,7 +737,7 @@ static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
-	if (is_gen4(gpriv)) {
+	if (gpriv->info->ch_interface_mode) {
 		u32 ch, val = gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
 					    : RCANFD_GEN4_FDCFG_CLOE;
 
-- 
2.43.0


