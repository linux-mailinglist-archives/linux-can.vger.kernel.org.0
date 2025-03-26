Return-Path: <linux-can+bounces-3218-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16BA7168E
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 13:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA3B188FC52
	for <lists+linux-can@lfdr.de>; Wed, 26 Mar 2025 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3EE1E00A0;
	Wed, 26 Mar 2025 12:20:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DCB1799F;
	Wed, 26 Mar 2025 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991636; cv=none; b=fX4yB2mZ795cY6Asqm3iIZamk+m2iTygbso5uANo+ZX4OF2CxFhJm7J9sNlaKpwIKLpLkSq84hPI0D2FIoMJP+yXg7Ag3d3r6Yl1EKE9uzeq/iOULq1I76dKy2pF9twY+tPlHQD50Leq8wlsuX0nABOZU9eqAKwMWjoCQJvKT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991636; c=relaxed/simple;
	bh=/z+NQXUmW8iu4pTcSDCl2k92lNgva5WpYy0+NMp+wx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0CXcSb/BztsABNBp/pzZI72UPTm/qhbfF3OOwJtxwqQSgKsZBkgcDOQsKMbA7ccimyuZEPJj4B42FZ9kkJ4TsoQudLMK8mwm1JVJkws19hFuGfE1wmnCVdtaT3cdNSRZooRFjCOp+ief7qHB956xSHw0qitS2JgMl0R/ICpgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Ysj/moIYQB2buwhfjTnRfg==
X-CSE-MsgGUID: Ph++b9xSRbW/835QPJqbgQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Mar 2025 21:20:33 +0900
Received: from localhost.localdomain (unknown [10.226.92.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 37F5140104CB;
	Wed, 26 Mar 2025 21:20:29 +0900 (JST)
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
Subject: [PATCH v7 05/18] can: rcar_canfd: Drop RCANFD_GERFL_EEF* macros in RCANFD_GERFL_ERR
Date: Wed, 26 Mar 2025 12:19:40 +0000
Message-ID: <20250326122003.122976-6-biju.das.jz@bp.renesas.com>
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

The macros RCANFD_GERFL_EEF* in RCANFD_GERFL_ERR can be replaced by
gpriv->channels_mask << 16.

After this drop the macro RCANFD_GERFL_EEF0_7 as it is unused.

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


