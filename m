Return-Path: <linux-can+bounces-4281-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82CB2FC49
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1681BA30E6
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2D2DAFA1;
	Thu, 21 Aug 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB+Z8put"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C12EDD40;
	Thu, 21 Aug 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785676; cv=none; b=Aws7dfKMj/6SzVH3J/bsmyBCcqidzmXF3Eje4VhXasNsXq5eFHZm1JxvKzNR4JYY1184jKP867mkiSjPnJ1amwnHZk/E2Xwkpna7lcD8iahInH2PCkQNKun0GdC/RvLiYIVK1W3wrZKgrC+JdaazoSb3XvdR01GSsZO69/VldsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785676; c=relaxed/simple;
	bh=gw18hevqmIxFwrZV1sIG6fUjWbi1i9XDyZT3qrIxT7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYinrv4xJVWdF+4BOG6zOskdTMOh6SCi1KiIqFB/Kd56sKEKGd+HALXu2e92RE0Yi0+zxkhwu6TN4aKhpiGthkNf+2jolz5s0nUDyCumR3D29xjS1saUzrM0JpnKfr204K+qlMYMG9MazBmqCo0gvq4wuiQ+eBVTboc9exzcgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB+Z8put; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so832657f8f.0;
        Thu, 21 Aug 2025 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785673; x=1756390473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvOUlOSPPOsXB/3zWThy1pwPfkK9g4MWMHVB27lxX6I=;
        b=TB+Z8put/XZHbxn1OMU+cyi4MuO35XZzhk4HAvRA0NiGGiN8bBlYdGyENzqfKCSYtk
         J6HLaT3BcmDtn+oJSzC1bJCEpX9wYIkWKGpo0y3/gSEM6Dkx4etYaWt1UA2Eq7dWtvLW
         TR3wYV3zMPnlV/j3BxNfpyFyVDM6n9tA1GCFhrFohpAm+8GCl1TxQTSclg2c2IqCTG1b
         5hynb949GEw8swXQPQ+eDs0FfpPxxOvFQLTzs7DNUcslauQ08vpcqAwB/Px3iW5LUmyN
         cepyNau38NqNIIzqyTX619vcIb97HAM2nXArr/HudTS9nbiQtZuaqnYoOZ8RxfvoYC32
         qd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785673; x=1756390473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvOUlOSPPOsXB/3zWThy1pwPfkK9g4MWMHVB27lxX6I=;
        b=QwIYrfCwQIoFYhp1cbzN9gR+jQsLFET65rppNpJNNIsd0oYa9rjAxhweymPfIcEIh7
         DSNG79/bAIv+M9Oa94DS2UsmpmYEUepEJejXLKghAtjYVAjQMFOdD6dvpqDqSgx16u0y
         CGeJ/ZnYvLBlElGJscUcrZbUHgEzNptxOdRZ6C0f1lq+2mDGoZCSZ6xBe4KtfZiiUaQb
         SntKZDyetzfqUgZvTsUtZ0dJ4R39820VKOIb2cchQmoVRK0nDsGBwwvoQidmyeBYl1jc
         lK5HYJWlVl2ta7ngaN1yFG/sGC1ZokZ6B/qRrGzXl+FxGUs8WEytJzA+tEQFWGX/xTu7
         Klpw==
X-Forwarded-Encrypted: i=1; AJvYcCUsv1RB1+JIomkbDX4J4yEK3nxvxTsJJZPwT2JrdGlyJHs7KOB5AOEqM+hTtSgC2ZnLcI25/Mb6bcP7otQKsrcnxzw=@vger.kernel.org, AJvYcCW2iH3ufa50m9GKsAmwkiSromoTt/iJWggsQB2kEp8nX0pDGIjXcBGULW5gqFQ8jDQ4ei/4HtnOzvM=@vger.kernel.org, AJvYcCWU585Z8u/8VhwKtmNk8RR4s4TSnB1qId/15ct4U2bhd+esQIXcOFCBxkvAe4sz+qKj1mwlBTneEWOHfuAL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Y9R8YvbkI5SRuOfu76CN7Sxlwh+ndaMPJ4bV5xukSWkSgu28
	hIbl3pJeyRlWZtBf6TlMlnYVRKjllwiG2bUxKf3gPfmjjM81d64jaf4O
X-Gm-Gg: ASbGncsUJ1lPxLu80yjiXfPvpiryqkA6g3JXROspimxqOzGNI+PrnkpJ6cgvaISDKMI
	+lVXzW3NbiqQ0i3h99JsJVC3rMxSQ0C6/90XDE4wkTLkv8RKGWkmrL2s85/eZyeME9teyznblui
	J2LRc08knB+flxGBun7qLtHxa84IOYOFMNV0eiXCp8CH0Hl1LXp9bZxuLdK67+l7uZHyw00SJAF
	HO5XPjf+cgNlrDeIj6XKJ31ukvFGhEvIKPbQRUYEQi4OtE/Zc+s74/T5RS/fhF5e7feB5TP/gbN
	pM2SK1x1SUDnI7Ok8Odgo00LHhmSlqFvFxyS/OIu/ezUbjVc3RyxkETJLQBM10r75dJU1ptVB5L
	nBtDmRucZMsPWPTs/IWpQlO+kdE4PpsXLPI9YkNJwxOJ4sErKUkVrRb1Hxhw7v0VvqJl3XBwehA
	==
X-Google-Smtp-Source: AGHT+IFO54QOz/DgXpOL4k9NcnTJZl5Mpjp4u748get5hxocrDQP/h9xWALOdO6Iipr/C4XNKv2vrw==
X-Received: by 2002:a05:6000:2901:b0:3b9:16e5:bd03 with SMTP id ffacd0b85a97d-3c49405d32fmr2356062f8f.6.1755785673210;
        Thu, 21 Aug 2025 07:14:33 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1be3csm33203505e9.1.2025.08.21.07.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:14:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 4/4] can: rcar_canfd: Simplify data bit rate config
Date: Thu, 21 Aug 2025 15:14:24 +0100
Message-ID: <20250821141429.298324-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Introduce rcar_canfd_compute_data_bit_rate_cfg() for simplifying data bit
rate configuration by replacing function-like macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Split from patch#3 for computing data bit rate config separate.
   separate.
 * Replaced RCANFD_DCFG_DBRP->RCANFD_DCFG_DBRP_MASK and used FIELD_PREP to
   extract value.
---
 drivers/net/can/rcar/rcar_canfd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 944b960c0b5e..f56ed8967212 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -169,15 +169,7 @@
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
 /* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
-
-#define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->dtseg2)
-
-#define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->dtseg1)
-
-#define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
+#define RCANFD_DCFG_DBRP_MASK		GENMASK(7, 0)
 
 /* RSCFDnCFDCmFDCFG */
 #define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
@@ -1406,6 +1398,19 @@ static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_chan
 	return (ntseg1 | nbrp | nsjw | ntseg2);
 }
 
+static inline u32 rcar_canfd_compute_data_bit_rate_cfg(const struct rcar_canfd_hw_info *info,
+						       u16 tseg1, u16 brp, u16 sjw, u16 tseg2)
+{
+	u32 dtseg2, dtseg1, dsjw, dbrp;
+
+	dtseg2 = (tseg2 & (info->data_bittiming->tseg2_max - 1)) << info->sh->dtseg2;
+	dtseg1 = (tseg1 & (info->data_bittiming->tseg1_max - 1)) << info->sh->dtseg1;
+	dsjw = (sjw & (info->data_bittiming->sjw_max - 1)) << 24;
+	dbrp = FIELD_PREP(RCANFD_DCFG_DBRP_MASK, brp);
+
+	return (dtseg1 | dbrp | dsjw | dtseg2);
+}
+
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
 	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
@@ -1435,10 +1440,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = dbt->sjw - 1;
 	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
 	tseg2 = dbt->phase_seg2 - 1;
-
-	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
-
+	cfg = rcar_canfd_compute_data_bit_rate_cfg(gpriv->info, tseg1, brp, sjw, tseg2);
 	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
-- 
2.43.0


