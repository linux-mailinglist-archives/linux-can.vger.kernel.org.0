Return-Path: <linux-can+bounces-3124-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F41A64F12
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 13:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4904E188DB60
	for <lists+linux-can@lfdr.de>; Mon, 17 Mar 2025 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BDA19E966;
	Mon, 17 Mar 2025 12:36:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFF23959F;
	Mon, 17 Mar 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215011; cv=none; b=ehvT4XDkb5rzLltZAfmYengrUeH4agcLKMD00z3MCxDro3RhjmBXHBlxJGDJz6D9TUVYsLNAKHq63KvJXY212OKeiWStT54HHWjzP/BpQrxX8nQRwzuNeMVPC0tb66dj6hDXAezmSlljQajbe+GPu7DjU5MLaStLptUIWeuuGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215011; c=relaxed/simple;
	bh=n1K6ED8odu1cQiTMyFKho/dClLfX2W7uhnVfbJxc9TU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLnitAtETtmAnBQmtqj2jGBccDbNUn4y58/zElhQyu5kRjdN0alITJjrqQfmObAQh/4ZruhD8mOWVi7LV+vLPZYI24e4dpFJRWFI04vqI54UFsDIqupOLnHkHwAc7zbYYRy3HrH2J++hjgARi4i56s4HoOGEW/dBllcLvFbpLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: /mm3732uSHm5uD/nSiOiRg==
X-CSE-MsgGUID: vLk92Rj5TA21Y88s6b0VTQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Mar 2025 21:36:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.84])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8B5A1400262C;
	Mon, 17 Mar 2025 21:36:46 +0900 (JST)
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
Subject: [PATCH v5 05/16] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros in RCANFD_GERFL_ERR
Date: Mon, 17 Mar 2025 12:35:59 +0000
Message-ID: <20250317123619.70988-6-biju.das.jz@bp.renesas.com>
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

The macros RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by
gpriv->channels_mask << 16.

After this drop the macro RCANFD_GERFL_EEF0_7 as it is unused.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v5:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 565a91c2ca83..a9e962a1510e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -74,7 +74,6 @@
 #define RCANFD_GSTS_GNOPM		(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
 /* RSCFDnCFDGERFL / RSCFDnGERFL */
-#define RCANFD_GERFL_EEF0_7		GENMASK(23, 16)
 #define RCANFD_GERFL_EEF(ch)		BIT(16 + (ch))
 #define RCANFD_GERFL_CMPOF		BIT(3)	/* CAN FD only */
 #define RCANFD_GERFL_THLES		BIT(2)
@@ -82,9 +81,7 @@
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
-			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
-		RCANFD_GERFL_MES | \
+	((x) & ((gpriv->channels_mask << 16) | RCANFD_GERFL_MES | \
 		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
 
 /* AFL Rx rules registers */
-- 
2.43.0


