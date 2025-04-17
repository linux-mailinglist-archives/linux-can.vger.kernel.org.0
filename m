Return-Path: <linux-can+bounces-3422-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E4A91303
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 07:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C22B3A7811
	for <lists+linux-can@lfdr.de>; Thu, 17 Apr 2025 05:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390B1E98ED;
	Thu, 17 Apr 2025 05:44:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4671DF252;
	Thu, 17 Apr 2025 05:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744868640; cv=none; b=l2o4SSptx8imJAgoHoZ97FKRiZCJIinwNM4KNGJDwB0gntgkuxDYMF0ieaHOe298Cmspciitwfwjc9N9auha0xGVT4DfuwwZSpD/SUGh1eIJHkFkWjVx7Kszx1JbX6L0HV3UEvkQ34qk8jVJlAhr00ddHSLZK0R2VfXL3iyP3PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744868640; c=relaxed/simple;
	bh=HdZ51MP0ohHEVLbDSX+q0Ikvana5QRU6mxxgMF7QLS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERa9XUbmzDDNZ0+oz5RezzH0rCYR+IKpgPoR4uniRHMp28OVvV0F5I090okRNl1Mdirt8eVRoJuNW3wzJlJ3ICfG3s6h/w5D+dWmPiN6nlm0VpUVfgHAeBnmRS9KqzIkH/+spu25CrrMrQICiUDfK48zyycKvJDx+EKBxyt987A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: ykPbSBVuRRCXHE+4XbDnSg==
X-CSE-MsgGUID: Gd3jkyQsSIGbO0YlLJxq2g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 14:43:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9A1CF4037634;
	Thu, 17 Apr 2025 14:43:52 +0900 (JST)
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
Subject: [PATCH v9 05/19] can: rcar_canfd: Update RCANFD_GERFL_ERR macro
Date: Thu, 17 Apr 2025 06:43:06 +0100
Message-ID: <20250417054320.14100-6-biju.das.jz@bp.renesas.com>
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

Replace the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF. The macros
RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by FIELD_PREP() and
drop the redundant macro RCANFD_GERFL_EEF(ch).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8->v9:
 * Added missing header bitfield.h.
 * Fixed logical error ch->BIT(ch) in rcar_canfd_global_error().
v7->v8:
 * Updated commit description.
 * Replaced the macro RCANFD_GERFL_EEF0_7->RCANFD_GERFL_EEF.
 * Dropped the redundant macro RCANFD_GERFL_EEF(ch).
 * Dropped the tag.
v6->v7:
 * No change.
v5->v6:
 * Collected tag.
v5:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 565a91c2ca83..d53aa71f11c4 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -21,6 +21,7 @@
  * wherever it is modified to a readable name.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/can/dev.h>
@@ -74,18 +75,18 @@
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
-#define RCANFD_GERFL_EEF0_7		GENMASK(23, 16)
-#define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
+#define RCANFD_GERFL_EEF		GENMASK(23, 16)
 #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
 #define RCANFD_GERFL_THLES		BIT(2)
 #define RCANFD_GERFL_MES		BIT(1)
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
-			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
-		RCANFD_GERFL_MES | \
-		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
+({\
+	typeof(gpriv) (_gpriv) = (gpriv); \
+	((x) & ((FIELD_PREP(RCANFD_GERFL_EEF, (_gpriv)->channels_mask)) | \
+		RCANFD_GERFL_MES | ((_gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0))); \
+})
 
 /* AFL Rx rules registers */
 
@@ -938,7 +939,7 @@ static void rcar_canfd_global_error(struct net_device *ndev)
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
 	gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
-	if (gerfl & RCANFD_GERFL_EEF(ch)) {
+	if (gerfl & FIELD_PREP(RCANFD_GERFL_EEF, BIT(ch))) {
 		netdev_dbg(ndev, "Ch%u: ECC Error flag\n", ch);
 		stats->tx_dropped++;
 	}
-- 
2.43.0


