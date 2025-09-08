Return-Path: <linux-can+bounces-4520-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE1FB48CF4
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433203A9DEB
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90212FE060;
	Mon,  8 Sep 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCVlGXDq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FF2FC02F;
	Mon,  8 Sep 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333389; cv=none; b=m/U8S8EMsv+0OSAXNLFDPgTcZhNCqUXM8JbY23+uKPCzwlwbCiKj7O/JHG97EoVCGGWNT8DqP1svmkApKaknrVTDzh8Jo5hNR/CKnzPhZmFSS5o4wQETq03ZJcG0NoAvboqwDzkShYeTFvKzzyUjSPGVpndM3hDs2lSOvJUoCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333389; c=relaxed/simple;
	bh=LJBZR3g3tMapr1pcv05tu4758efqyzYypnEmmug+2k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EV4seaRp5Cragb3Bksaby210VCeP6oihR+2EqfzLaBMzwZoNifzfQDJyP93vqpgudI1UW1kfCvY2WoIXtuh2H+ybx5HKUwHlYQAHc6bqQQAIg3OGlaWPUTLkJ6hRCjm8bivuw+mjJ8t+oXTYSuXqEOJzdJZpkUGZPbKuGb3sh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCVlGXDq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso18706465e9.2;
        Mon, 08 Sep 2025 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757333386; x=1757938186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8djXVjM/tAen/yqZaA8g4X2SrzUVVaFVlQlWculVlI=;
        b=PCVlGXDqvpRHBJAVrMo6jG4wSHtFgb+RF1Yl6X7Cji2jkNIFhEO55wxIJ2mme0gF5Q
         gHNMettEeHUSoZ1Jv6AUW0SRtlOUscbWLp9HextA0a2KStq8aQTAyWezxSzLgJuKxNo+
         QP7kZR/mOXxf3TmYQKMlAeFHJ3x5Y9tnwMHw5rJukdOOo5A3DxbX0w2UsN9cmNw3Eew8
         v/0v+D9L3XY2pSdn9r8o3LtPHsrVFNdzWDJ62IFIk6oi3Ad4bj5y86Bzcx5EN8bZYLQh
         gnKHRPstxPTHHCOFHdW1Ug5pQR1pBqjlbxhN2JA+EGdGUso51VgaJ/IotEYhIir8/J4f
         j0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333386; x=1757938186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8djXVjM/tAen/yqZaA8g4X2SrzUVVaFVlQlWculVlI=;
        b=E4/K37mvW01UaS9BJlxu/16lD29TRe+HYxHNzhpIG6YwmFAo1IJzABnwJdD1FOiyq0
         kp+WpGmw/qgc0DcoFb7xyY/uEunst6Ekr4Ehp4qAgaswx0hkYCdbWWCUq3TEAgY6EHny
         0cbmybSfl6Z1mV3l2e6/TFhZvldOiRV71OaIKNWWIFE6WlgBjcas+KLf5OFJ2zAW4L01
         Gnw5yX+QW2ZF53jOLJwvHebWUSa/lo6IirvnI7Gdkq7lhDaipK1M2Dt33XSjMnuuAZzV
         h6hjo0JFu7Y7pv9s8v+vxuEHTzU5ImrOd3rcBIqubPvhaTrNeMstpgcc4EWnGm/UqbN9
         oSPg==
X-Forwarded-Encrypted: i=1; AJvYcCVL9T1Bwf7kyUtyUtnrgu8Lh9aPM44yhlycbqMHQeXdF29LcKeQ9agI2HEKKEriYly2a3d30N5DNPvSeYGiuQPYQv8=@vger.kernel.org, AJvYcCWeNkAn1KAmRNaYBXo0o0zVDeRwaQWySCcHVNcDz4JVcWoSRu6dZ+YQ3L4uak5F/iv167sxySWGu4M=@vger.kernel.org, AJvYcCWzgZuiYnP4oRGJGCaL/QWN8skFGykEsTLV+6UnZwQ5yGO/ZptH0HCmXbyD2ia+5R8mNsbNhgDT0QjFkws7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AiBwkxkVuc51XxyFYSAgpiaahiS8goDX1RTOf2fCu0IOUfcH
	ES0nO9hlptfi1Vk5ZSnSB2giYWgs6VRWoDjILEDOgeB5BQNfPCRiIWPWJizWSw==
X-Gm-Gg: ASbGncs8b0bb8gQ0Z4442wts5D/MzwuNEKSAfIGt71dbg/RWZXdBIvgpaKG1EzBaUMH
	O0QQ9xdbO0Sh1sub+0Wxg9Zqy7UJsTQ0XNiWC5ng/R/y9EJ+SzZ7KPp7LCoGMAKdtVkDrOrEeeO
	HhoX1RVB0Pux0apn64JvPYi0an16Qrj17ZmKNSC8EkjgvB6D/1tBs/ywkAmjjxg0tF/oR4aDJPk
	ROvApdfQnLU8vqB7hibh0fn9zK+pqI5QSIKnvpiPsOoU93EBnXfKHE/rdUn4gLrCLk9OJGElSZO
	IS/nVPp1ug9eOp9TUKkR9OwIUsVN2vC3IBRDF004N7ywcfLR+BqP/Fj6j+KNViGS56gBm4LsJer
	SWsatWOLu0WP+zWRewgUODBuKJDE+LcA8/Sd3yKSlh1IcQozmpbKfYl/vTHrua+pystg73awcq6
	teZzdFw4zDYVZLUSwGJ+PzIsg=
X-Google-Smtp-Source: AGHT+IFjpk6nqhdVNDShGcxzbiNs4vrs3gpWpDN9fuWPpdIRFPnfd3J6qig+JsyHX7ik5Tokjyp/Eg==
X-Received: by 2002:a05:600c:1f13:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45dddee8ec7mr73239255e9.18.1757333386069;
        Mon, 08 Sep 2025 05:09:46 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e543e9f444sm9646415f8f.60.2025.09.08.05.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:09:45 -0700 (PDT)
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
Subject: [PATCH v3 4/4] can: rcar_canfd: Simplify data bit rate config
Date: Mon,  8 Sep 2025 13:09:33 +0100
Message-ID: <20250908120940.147196-5-biju.das.jz@bp.renesas.com>
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

Introduce rcar_canfd_compute_data_bit_rate_cfg() for simplifying data bit
rate configuration by replacing function-like macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added Rb tag from Geert.
 * Dropped _MASK suffix from the macro RCANFD_DCFG_DBRP_MASK.
 * Followed the order as used in struct can_bittiming{_const} for easy
   maintenance.
v1->v2:
 * Split from patch#3 for computing data bit rate config separate.
   separate.
 * Replaced RCANFD_DCFG_DBRP->RCANFD_DCFG_DBRP_MASK and used FIELD_PREP to
   extract value.
---
 drivers/net/can/rcar/rcar_canfd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 99719c84f452..401505264676 100644
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
+#define RCANFD_DCFG_DBRP		GENMASK(7, 0)
 
 /* RSCFDnCFDCmFDCFG */
 #define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
@@ -1401,6 +1393,19 @@ static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_chan
 	return (ntseg1 | ntseg2 | nsjw | nbrp);
 }
 
+static inline u32 rcar_canfd_compute_data_bit_rate_cfg(const struct rcar_canfd_hw_info *info,
+						       u16 tseg1, u16 tseg2, u16 sjw, u16 brp)
+{
+	u32 dtseg1, dtseg2, dsjw, dbrp;
+
+	dtseg1 = (tseg1 & (info->data_bittiming->tseg1_max - 1)) << info->sh->dtseg1;
+	dtseg2 = (tseg2 & (info->data_bittiming->tseg2_max - 1)) << info->sh->dtseg2;
+	dsjw = (sjw & (info->data_bittiming->sjw_max - 1)) << 24;
+	dbrp = FIELD_PREP(RCANFD_DCFG_DBRP, brp);
+
+	return (dtseg1 | dtseg2 | dsjw | dbrp);
+}
+
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
 	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
@@ -1430,10 +1435,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = dbt->sjw - 1;
 	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
 	tseg2 = dbt->phase_seg2 - 1;
-
-	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
-
+	cfg = rcar_canfd_compute_data_bit_rate_cfg(gpriv->info, tseg1, tseg2, sjw, brp);
 	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
-- 
2.43.0


