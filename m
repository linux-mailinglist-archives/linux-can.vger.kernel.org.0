Return-Path: <linux-can+bounces-4280-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16E5B2FC38
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0901624811
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734492EDD60;
	Thu, 21 Aug 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MypMsrX5"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883922D8385;
	Thu, 21 Aug 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785676; cv=none; b=IrMIaP44M80zEpCVMtCSgO5LiaVMFAu4RDTILuRGLOiXBL5ZhicWrcs00otAfhDZGw0J0UMPMdNn/b1r5kDxL2Cs3GoTymxBLbYuhR39+A1z1UgfldLfS+0G4P7yYxS7gBjrFinEPGhuN6rIKbu8WdLo8YOQzDvBpNVmAuXCjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785676; c=relaxed/simple;
	bh=TAUrWAMO/Xod4rcdCGDBrTbU0Vpery16IzXqFv6qWFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtqi+FngRm/aI5HqAHYcUCETokxVeykEy4EvaQZ3kqJfPZx/N4kOuGHW1xCKkKfmLiRzeWVFAUHwr/AJ5b37Qt0dL+hUBlOC7GiRyOFXO2EJsAQokDqMAdkD9BfAcGc2epKeIeIonGUrPAQfrPFOQ3m9afC/dau6vg+DJWqkCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MypMsrX5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a286135c8so10958345e9.0;
        Thu, 21 Aug 2025 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785673; x=1756390473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgcbcsDvID7e1whiRDt62JcbDXcbBZK2hy2RfTohtc8=;
        b=MypMsrX5HiyTM4fnFlXaqedwzTkeXBbLOzgJDL8xoXCo9Fu0Rm0XFN4vw2YaDhVKUu
         3KyKx19Ycxjh9naPAsabFoONTOgsGBm5znBD4S8ZsOuPD740QVfS0d0O3v6cHnt8/ldb
         g86l9TpkMYKAl+vGmokFKcj6+N+JFx+9i+kCCqlZG+qDJTJ1ZJAikpavpmd3BS3ek7Op
         wGnphvJi4JRf/bO03wXmC7dBdvKC5MZlAlYwE7f4psaQsHsCME8RFMlO0XCtIGl312CO
         z7MXabAkNH8XN/9O3AJARcyxcuf3vGHPTrd/AkR6m0S18KYM+Ukkyc+qO+mgp9N77cJo
         3ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785673; x=1756390473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgcbcsDvID7e1whiRDt62JcbDXcbBZK2hy2RfTohtc8=;
        b=i6It0TFL9k/HShmu6g7GJeR8kHKPt1DpaqD3ylrM6l5ETtLrodg3fVr/B4ruP1+NWC
         CcQuTUprHY2dAalXgYFGln6LcOic7lA7QBnDfcAR5sIh5Lq7U1eB1ffilDCUFe+sx7a2
         lvIH80OrRnfXCUEFeDD2KMdIvaj4FRHztD4BfcSFs0jkFrN1tE8aCYlOwnm2Lxpx7Y2+
         bLWEzMg/jC4/q2+w5T5qDs11aPBQ+YzdUJUCIhGsJQ5+78NSVUuz5k4eh2S5Bihip5o4
         lnOTV0DO2j2wwVhEg6Q4h+AVfzKOufvePtYFWIDqeElLEwNGO8ZkGh0csumM1d1w7aNH
         HduA==
X-Forwarded-Encrypted: i=1; AJvYcCVN6Zszu6YV7tWjquHQask3zTf5slraK8XrxzAzvFmWX9Vki7iETZ2Q7fGQ3BAUXTfUS+HDbyUa+ro=@vger.kernel.org, AJvYcCVVdPhtE47NiOh37/bdob2uMErTUNbSTHzPrOBBiJu7dknjuARtKIKKCt6hfodrxTxmu7mWb4fUv/YDGeSI@vger.kernel.org, AJvYcCWqtgTWUQeXrqmIhSJS7T5Wj53a+JfgiuAXaZzV4VhEc7jQ3UWJ5cp/GunqE9TKR2ctaq4xuABN+wiw35C4D6ejMEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUk7P5y8AmtaNtvHubesIata+tJmFdfxTVbloh/LM9ZT9U85i
	b3J74bLPxhIVhJfxM89X19HyEQBVK7NhMmQRsepnSx0qzKK2Wam3LvWS
X-Gm-Gg: ASbGncv4OcUwZXh32aa8BYEL8NzgkJLoCSvmE2qIpjkLrWnFF4qXm8YN/tZLnPa9I/L
	aGlR2IBSZSVXYlXrXRRFJGg+W233YSfPPVTDMrJNRa7ZxJ95233sNYnDBqPlywu1UP8l9Pzu5Ht
	sculLOZxfNA94fT/vK91IYv0X/gzVsint+S7HW3htEy5F1oJFmJSordLDvL6cXeUOneEfzwj+9K
	rCF6Yz+Rm3qfWksERaLUTLqlmLpkFQ2Ewhbl6TBzy6BVEK5+4HFVvceUWDWNN/flilHRy0woRIy
	PQ8hkzdSPv9OgrItCcvPafFNJgFn/Nw1LjQKlyysMlyckoWl1hzkB9K8xC9ayL5pw3rc6rRCzRd
	vgsFgA9++CMrx77EZlWx+mP2vQqMpyn4RI6IO5V1l1ZcEtpahcYnqXQlcvcu/CkeeBgpKOgCSjw
	==
X-Google-Smtp-Source: AGHT+IH8biWaXMKYUlK61n2UyVAf+SKNCyPysNlAg/om16uY6df73W8aNdkE34qF6xdqI6F5j4ONqw==
X-Received: by 2002:a05:600c:4255:b0:456:2257:3777 with SMTP id 5b1f17b1804b1-45b4d79467fmr16329065e9.4.1755785672651;
        Thu, 21 Aug 2025 07:14:32 -0700 (PDT)
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
Subject: [PATCH v2 3/4] can: rcar_canfd: Simplify nominal bit rate config
Date: Thu, 21 Aug 2025 15:14:23 +0100
Message-ID: <20250821141429.298324-4-biju.das.jz@bp.renesas.com>
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

Introduce rcar_canfd_compute_nominal_bit_rate_cfg() for simplifying
nominal bit rate configuration by replacing function-like macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Split from patch#3 for computing nominal bit rate config separate.
 * Updated rcar_canfd_compute_nominal_bit_rate_cfg() to handle
   nominal bit rate configuration for both classical CAN and CANFD.
 * Replaced RCANFD_NCFG_NBRP->RCANFD_NCFG_NBRP_MASK and used FIELD_PREP to
   extract value.
---
 drivers/net/can/rcar/rcar_canfd.c | 45 ++++++++++++++++---------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8bae25758924..944b960c0b5e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -109,16 +109,7 @@
 #define RCANFD_CFG_BRP_MASK		GENMASK(9, 0)
 
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
+#define RCANFD_NCFG_NBRP_MASK		GENMASK(9, 0)
 
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
@@ -1393,6 +1384,28 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_channel *priv,
+							  u16 tseg1, u16 brp, u16 sjw, u16 tseg2)
+{
+	struct rcar_canfd_global *gpriv = priv->gpriv;
+	const struct rcar_canfd_hw_info *info = gpriv->info;
+	u32 ntseg2, ntseg1, nsjw, nbrp;
+
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
+		ntseg2 = (tseg2 & (info->nom_bittiming->tseg2_max - 1)) << info->sh->ntseg2;
+		ntseg1 = (tseg1 & (info->nom_bittiming->tseg1_max - 1)) << info->sh->ntseg1;
+		nsjw = (sjw & (info->nom_bittiming->sjw_max - 1)) << info->sh->nsjw;
+		nbrp = FIELD_PREP(RCANFD_NCFG_NBRP_MASK, brp);
+	} else {
+		ntseg2 = FIELD_PREP(RCANFD_CFG_TSEG2_MASK, tseg2);
+		ntseg1 = FIELD_PREP(RCANFD_CFG_TSEG1_MASK, tseg1);
+		nsjw = FIELD_PREP(RCANFD_CFG_SJW_MASK, sjw);
+		nbrp = FIELD_PREP(RCANFD_CFG_BRP_MASK, brp);
+	}
+
+	return (ntseg1 | nbrp | nsjw | ntseg2);
+}
+
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
 	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
@@ -1411,17 +1424,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = bt->sjw - 1;
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
-
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
-		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
-		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-	} else {
-		cfg = FIELD_PREP(RCANFD_CFG_TSEG1_MASK, tseg1) |
-		      FIELD_PREP(RCANFD_CFG_BRP_MASK, brp) |
-		      FIELD_PREP(RCANFD_CFG_SJW_MASK, sjw) |
-		      FIELD_PREP(RCANFD_CFG_TSEG2_MASK, tseg2);
-	}
-
+	cfg = rcar_canfd_compute_nominal_bit_rate_cfg(priv, tseg1, brp, sjw, tseg2);
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
 	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
-- 
2.43.0


