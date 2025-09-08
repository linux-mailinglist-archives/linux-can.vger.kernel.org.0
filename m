Return-Path: <linux-can+bounces-4519-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FAB48CEF
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 14:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115D41785FA
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2582FDC58;
	Mon,  8 Sep 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmxJa18W"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142E2FB097;
	Mon,  8 Sep 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333389; cv=none; b=Q5cN/IMomijoLiTn2yG88aTuh0aKVYoYjpOV2l9Y26u5Icl+M9fZsQYbjqnm1qQw8fsT3lv4h0PZaiJuJlKPcApEb8oBp7aVsFrQj5pXh3yXFhyvViJOxXGNQByBvy5l3eeLIfa+/8uuzD5pWODkfV/CN9JR4e7xV7+H4cgJrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333389; c=relaxed/simple;
	bh=mqk8Q2Odh2u2gjgbz+kLIXaUNEL0ZU5RfR01wro3VkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKQqpFycMv2XRuUMy3CxqO7hB03ZY3YbD/UNmvQ8P9Yv09sVgUAoIEYXiXB11lKM2wWpktjScqsDTFvWWKZhfVDA619IPxn4PJuUQdbQXyztQKNEQTVVyVA+81mlPaJDL/ZeKzuBfsKq3pbFYvcWLNOR7w3HArYYB39KbmzpKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmxJa18W; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so28641795e9.3;
        Mon, 08 Sep 2025 05:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757333385; x=1757938185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVY7ik/srlY4hGPr/txfexWdJzrhhLv66TgN0CEbGxI=;
        b=DmxJa18WgmQ/KqmxVS6cTeWsj4u2EhNOOXVLZMmMWPZHBGE/eYS54ptAaHR0wQeogR
         f22eUaB+YPEt3a/iOohafF5QspCrrdLqsW1lTJwOSD0Yzz/ONtD7VFa3uIsk14C9xpaz
         RyemuhZskda6fLn/vongh4tkbHA6kCc0AR09bHPkmetRlvPjIceIPrKhZKwrK/iLtNm0
         fCmQBCUYVZmesea+6hUwMzSY4Tk+hrmFzmg4ov2AkYOE/wad26QOcgEMvnJHqb8B6KKU
         l8yaVGL8fpKVR3efG2cfdtDaYv+hXqay5R7q0PLGI9W5ki8+w60KV7Y6UflBFRRieeg5
         gJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333385; x=1757938185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVY7ik/srlY4hGPr/txfexWdJzrhhLv66TgN0CEbGxI=;
        b=fsOaa1k//0L7WQPFh4QEBfWJGHEjIHDCUyfl724NFPyR8qP4uXC22xq+yO7Qsavv5O
         1Ys88W7+mavcxFkDwu6aoKKStYhj5Ywc0S/p3NXQb1L3tQ+UTfJZUTpQ4tTZNkvgsxon
         oZQ0VRxm1Fj1DcH+XkD6quFODyS/8CmA4bgcIjLfi14JlAF3TMGQpDwie1jWnuL/f2uU
         u65OLmf97JN5TSmRdzzLiheCMRxXXxAFAJiLMfJp/QLuYVtN5MhuEToQdDQGB4CNafCN
         AAS+DmCBsnyMEnqu3mSDqV0FSDZEjQRQNxtjkhiC39Z5OGdCo3T7Mpi8wyAbAOxkH+em
         foFA==
X-Forwarded-Encrypted: i=1; AJvYcCVN520TxNxH+gr9FGjCQOCJ3YdRU0P2skD0j+KnY25DfvESJ8qjNtrPQOpIV5ub7RrlHzQhsobsGURjmV2h@vger.kernel.org, AJvYcCW4497FSJ7Ev173tNf3IN2G8bvsGTJsWA+bTl8OBlca7CIahMFWgjxMftov0BJ2TyudmolThoNGrQKhko4p4GzHLT4=@vger.kernel.org, AJvYcCWXfsNm+qRVJ2npB1HMdgmwapQi42y5vi//OGG0dWzR8LY6XSSGGpkfE6l2F9rerzrwwmgk2a8eHbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3o5ibdlckdt4VBhIf3mXtYt7DPjN3u56vmBADAlh+GFxF+ey
	RSOOEbK0/jzltNzQvFajOWLToFSU96doskrTjBiMCiWc9yKeWbQc3MCi
X-Gm-Gg: ASbGncuqEwsy2UhxO0qOEDTfofhYwbMmFTnnxLjKG9s29jqv1GhygWA/YvBpRD7wbo7
	gODHQPRj4R3mCaceo/UaEHkTCtvCmDUL374GPDBZc6BjGwRAOOgujjMk6upAFistxKKJxIcUCyt
	z6ZgzG1S7PMH2SdcfdcHSL3VoFww4vYTxuYGUCLL090kNFbc08IyINoRp+VELhBg+X24e8CZNh+
	r4OwM1te6N8F/VRv28YBY2lsb5Y0pIWmrX2g8Kn3FZH07rDFpQmoBZLBWAg8fhYyHb6RegwNC15
	oMfMP5APPMBxKXSJaIiRH81FCKwm7xlQqLABkf6/GeaTk1psbdL36ijNNIzvuzVeyl789toYkMD
	NtCSheBznJPP/pnkSSdYpXei1+2C8s6+M1ZBu5cUfrxvEcQ5AOhHoknHdkSNYuHr5cDYjf/CdGt
	bR1w==
X-Google-Smtp-Source: AGHT+IG47Gyw8GXuNhG9ijn02W4i1SBoZcoXFZ0ELFdZMF2suDHpY6rfOO5GuCPS15eTAPJ1NLbiXw==
X-Received: by 2002:a05:600c:4711:b0:45b:4282:7b60 with SMTP id 5b1f17b1804b1-45dddf01a4fmr56477305e9.34.1757333385207;
        Mon, 08 Sep 2025 05:09:45 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e543e9f444sm9646415f8f.60.2025.09.08.05.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:09:44 -0700 (PDT)
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
Subject: [PATCH v3 3/4] can: rcar_canfd: Simplify nominal bit rate config
Date: Mon,  8 Sep 2025 13:09:32 +0100
Message-ID: <20250908120940.147196-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
References: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Introduce rcar_canfd_compute_nominal_bit_rate_cfg() for simplifying
nominal bit rate configuration by replacing function-like macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added Rb tag from Geert.
 * Dropped _MASK suffix from RCANFD_NCFG_NBRP_MASK macro.
 * Followed the order as used in struct can_bittiming{_const} for easy
   maintenance.
v1->v2:
 * Split from patch#3 for computing nominal bit rate config separate.
 * Updated rcar_canfd_compute_nominal_bit_rate_cfg() to handle
   nominal bit rate configuration for both classical CAN and CANFD.
 * Replaced RCANFD_NCFG_NBRP->RCANFD_NCFG_NBRP_MASK and used FIELD_PREP to
   extract value.
---
 drivers/net/can/rcar/rcar_canfd.c | 43 +++++++++++++++++--------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8d0d0825cb54..99719c84f452 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -109,16 +109,7 @@
 #define RCANFD_CFG_BRP		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
-#define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
-
-#define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
-
-#define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
-
-#define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_NCFG_NBRP	GENMASK(9, 0)
 
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
@@ -1388,6 +1379,28 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_channel *priv,
+							  u16 tseg1, u16 tseg2, u16 sjw, u16 brp)
+{
+	struct rcar_canfd_global *gpriv = priv->gpriv;
+	const struct rcar_canfd_hw_info *info = gpriv->info;
+	u32 ntseg1, ntseg2, nsjw, nbrp;
+
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
+		ntseg1 = (tseg1 & (info->nom_bittiming->tseg1_max - 1)) << info->sh->ntseg1;
+		ntseg2 = (tseg2 & (info->nom_bittiming->tseg2_max - 1)) << info->sh->ntseg2;
+		nsjw = (sjw & (info->nom_bittiming->sjw_max - 1)) << info->sh->nsjw;
+		nbrp = FIELD_PREP(RCANFD_NCFG_NBRP, brp);
+	} else {
+		ntseg1 = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1);
+		ntseg2 = FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
+		nsjw = FIELD_PREP(RCANFD_CFG_SJW, sjw);
+		nbrp = FIELD_PREP(RCANFD_CFG_BRP, brp);
+	}
+
+	return (ntseg1 | ntseg2 | nsjw | nbrp);
+}
+
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
 	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
@@ -1406,15 +1419,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = bt->sjw - 1;
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
-
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
-		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
-		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-	} else {
-		cfg = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1) | FIELD_PREP(RCANFD_CFG_BRP, brp) |
-		      FIELD_PREP(RCANFD_CFG_SJW, sjw) | FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
-	}
-
+	cfg = rcar_canfd_compute_nominal_bit_rate_cfg(priv, tseg1, tseg2, sjw, brp);
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
 	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
-- 
2.43.0


