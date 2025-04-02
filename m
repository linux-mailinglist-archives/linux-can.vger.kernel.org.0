Return-Path: <linux-can+bounces-3339-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00EA78C0D
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA39F7A315C
	for <lists+linux-can@lfdr.de>; Wed,  2 Apr 2025 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D0235BE4;
	Wed,  2 Apr 2025 10:23:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D1E53BE;
	Wed,  2 Apr 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589386; cv=none; b=nHHVag7s8K9MX6qcDconDX3NsCNYu/GiUrv9yTDufdv38YdLDA8JBVJYB0EdPC436kxzvG5m/o1MzuVPZOPVYmxzYsRHsmB5aCakRr8T5sGBpM6ONQ5xBHuC1xp2YT7iJ+UeZfbYXH4O9IGUjas1BWT4QbkcLLY043hHZxVudeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589386; c=relaxed/simple;
	bh=+UZlOw47u+6+638D99dC1yO5TdFlW+yeBCc0XEkiBdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZKCIrtdM9mtOI3uFf9m4IVdaSazaarUUqTPvxfKfsrCDcFXP2Wx5UITvQOTCpmgVns7jXF+YaW4v8MlCeNU5KwFPMXirWmJaiDUN5Ew6Fa0fnRM1V91MHrRdS0r1hkjgB15Qkc/CPV7u+g2Cx5blxpkMVimSLlZ9eBKiqNHjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: WTWlbQ8iRrW8j4w3MJWYJw==
X-CSE-MsgGUID: 4B0IyejqQeC8hUCn6yT2qg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2025 19:23:05 +0900
Received: from localhost.localdomain (unknown [10.226.93.220])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2EAEF4224218;
	Wed,  2 Apr 2025 19:23:01 +0900 (JST)
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
Subject: [PATCH v8 08/19] can: rcar_canfd: Update RCANFD_GAFLCFG macro
Date: Wed,  2 Apr 2025 11:22:00 +0100
Message-ID: <20250402102226.28032-9-biju.das.jz@bp.renesas.com>
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

Update RCANFD_GAFLCFG macro by replacing the parameter ch->w, where w is
the GAFLCFG index used in the hardware manual.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v8:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 98532f4031b1..b2b87291dcf1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -289,7 +289,7 @@
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR			(0x0098)
 /* RSCFDnCFDGAFLCFG / RSCFDnGAFLCFG */
-#define RCANFD_GAFLCFG(ch)		(0x009c + (0x04 * ((ch) / 2)))
+#define RCANFD_GAFLCFG(w)		(0x009c + (0x04 * (w)))
 /* RSCFDnCFDRMNB / RSCFDnRMNB */
 #define RCANFD_RMNB			(0x00a4)
 /* RSCFDnCFDRMND / RSCFDnRMND */
@@ -677,8 +677,9 @@ static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
 {
 	unsigned int shift = reg_gen4(gpriv, 16, 24) - (ch & 1) * reg_gen4(gpriv, 16, 8);
 	u32 rnc = num_rules  << shift;
+	unsigned int w = ch / 2;
 
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch), rnc);
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(w), rnc);
 }
 
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
-- 
2.43.0


