Return-Path: <linux-can+bounces-3945-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88946AF8030
	for <lists+linux-can@lfdr.de>; Thu,  3 Jul 2025 20:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B533B5616
	for <lists+linux-can@lfdr.de>; Thu,  3 Jul 2025 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395752F49FF;
	Thu,  3 Jul 2025 18:34:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC282F2372;
	Thu,  3 Jul 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567675; cv=none; b=ltlZhL2IxCZkgFOBinEUcW9UVUawDlgViLM2yzkSRhHWp9BFFKWh+3AJo6jCF/ZNXJZw8XpVUKIWY5xjXd66NMP4ZCqJ7b/bpjgAf3iPUPZMezWFi/I4h95W7fn3KZX6kGxK+UpLL7w03CN4Luon94WvirxPpJw+E1mOzxFuJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567675; c=relaxed/simple;
	bh=mpWqcXuS0ML7BvrUerZSSfgv2FiifVn5w5SGwaHYBpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD/TkH0bvjO/Qb1fZbCtpk4pNj5JcTT5Om7tG2sk2rlmtuab93AKR+ceYc6O8rAtZgmrnP7XhgMhAR4eIP/K11xLaGoUoEfknIj26Knf4XCrjKiF90yvzOkmfHoIkP18ArxFNeB8zQo9WQEf2S9P4zWDWpPQwLrc4Ql9fLKH/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 69HFzsYgQmuU8C4HTz+i+w==
X-CSE-MsgGUID: jQZM59EUSu2x2kiyubOoYA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jul 2025 03:34:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7324E401D165;
	Fri,  4 Jul 2025 03:34:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 4/4] can: rcar_canfd: Replace RCANFD_CFG_* macros with FIELD_PREP
Date: Thu,  3 Jul 2025 19:34:02 +0100
Message-ID: <20250703183411.332828-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
References: <20250703183411.332828-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace RCANFD_CFG_* macros with simpler FIELD_PREP macro.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b5b059e83374..dd87b4e8e688 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -102,12 +102,6 @@
 
 /* Channel register bits */
 
-/* RSCFDnCmCFG - Classical CAN only */
-#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
-#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
-#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
-#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
-
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
 #define RCANFD_CCTR_ERRD		BIT(23)
@@ -1418,8 +1412,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		cfg = rcar_canfd_compute_nominal_bit_rate_cfg(gpriv->info, tseg1, brp, sjw, tseg2);
 	} else {
-		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
-		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+		cfg = FIELD_PREP(GENMASK(19, 16), tseg1) | FIELD_PREP(GENMASK(9, 0), brp) |
+		      FIELD_PREP(GENMASK(25, 24), sjw) | FIELD_PREP(GENMASK(22, 20), tseg2);
 	}
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-- 
2.43.0


