Return-Path: <linux-can+bounces-5968-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C629FCE99B2
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 13:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 846EB30433EA
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 11:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B23F2EC084;
	Tue, 30 Dec 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isUNO4Rp"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B82EB878
	for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095904; cv=none; b=gXNIO5M0wOc29OEMO19++EV5cliAcHY0+kfHctMTZcEvoNbSdDT+y3ldbtVEbyL7IyHMlEeRQUSI0X+G5E7N2l4ziXzXWdBifNJXE175g8HIWEReYOVuQ/3lyNf/l9wwlcPjxmXPR4/mOWr6DSsXz3YE+rKZ5GkpysRwT0sAb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095904; c=relaxed/simple;
	bh=fyRh3NDfYI2G2pxDNRqvuJsGnCEa1C3EXnnGh0e8NZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMw465ntm+AuUrmGHkRXLauGQKNMVk7Q4S/c8GQAupgIycATvIRooyIqci9hN/nCwNmVAUgFC0lKLhJJtFbYQM1LVjwAJfXbPHqPD7QQCBNd9bLvA7mgruxPWVzj7HIhmUp3xqufCCiMAEfm6tqn6eDCFfp9hGZBTSQ6WGtQ+pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isUNO4Rp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43277900fb4so1623419f8f.1
        for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 03:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767095900; x=1767700700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mrVqbtRlpbpcL6kvwA96sNyCMACeAaD1ypExVsExyw=;
        b=isUNO4RpRvmeBb/SewrfLUxGBVOlt1KNSwulqiSCDd4SU6wPuB7VXvynTj1KLnJWNZ
         zdZB0JgIgbvJx8tyJ+vo0BlFowcIeAQd/WXrVdBjErz9k2Qn8cqca+ZiQUwSDgekv1dg
         rGYuNp83MhShxYq3gHazwiwjEgvTgoS8guiaTaSN3XTvt2Wu74f4Y4NV28+rGHFFnVfR
         B/l+80G6ahiTF0lGEqW8MYlD1AYrTrTlfGSFwAEivdkIdiReomPCCJnzxNL/TCqwmBhl
         VsRwwQw2AhIdFq8tpwFr5f0eSL6k2pGwgAVXULZ9lAM7Fwz7nzWR1On4vIYarcn8G1rA
         BEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767095900; x=1767700700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1mrVqbtRlpbpcL6kvwA96sNyCMACeAaD1ypExVsExyw=;
        b=Rk2/DMeMog5obHuIJCuhfs9zw9E7UtCsfMIZpGv9a7bBGbNqWhZwIcwL1FoIsJIPQU
         8/jLriShCzaWp2Y+GxVW+e+j9Ft+tniEg+zgOTzXqTzbgEVAaoqECvklzKhaeTtyar42
         x6SG2O7vN7lufIR+CoP+KQTMvPDiGesPKMpCyVDM7LPsTxUwU8KnitLQSaIuYmHP2vz8
         7gm9pWIk8OtdgSLK/jgAQ/BNaiYm84ohKXONQb92HDEqLWinIBHxVfxeYx4XYtDoE772
         BZw/BDFitNhrzTSfw+h/XAxYy6DOP/ZKLULdvO7ezG+7XSuTGFR6TwljQWa/YkJqV6v8
         Qrrw==
X-Gm-Message-State: AOJu0YzLPuVvNIqW/FEkuKKzv1CamvXP7WzSaR/YClktj0lCOsI9UFgx
	O0lyqlT9JRehpwvKbSoPBkStdADpKPkW+Ory1vTg+v6KleBKMY2pzJ54
X-Gm-Gg: AY/fxX7DgxSipBtzDVqImLRJauCDTeqRsKcpMbdwHCyxXQDwifZ2CE/VB4p7k+mGa5k
	LMJDTDPgQxt7KNzHklVqrsu5am5Vu/FJsFdfh2PsNYQlg03ZiMyxAUXUwZbhQjB6eLiUVIJUaZA
	1Hx/mzlO5fEt4cI7qdHgst5yy6egWLvT7nU9+5O6MJ4vyZK3Q3PNj/GblcFepohPP29yBQ67oWG
	4RV34zdiIckrw6YSunzIh+vFawWQTiAXVqDR8cjPDgrUt0SLlnKFFaUS5fFScV1PlUtt+yhj+kl
	MNkaTK6s70V6piUvBSbXQBvlj13zc7v3dWnKry/aBhs7LNdHXQ45CBLAZw1XmHVJxVK9Gl2/L/Z
	SyCBBeY3g3PEeLBa7CudwfeOuqOz3J9A2wGH9cE+gFK6RF3YvoLHOkHIvJAVtUEcOIGhst3VfAw
	swkoVJvw89IuLqCvab9bS8aCiHAYlSWalAMItiFgva4x2qcj2JYDXE4DBZ3vLqSPjn3wCOo6QDr
	y5+90Pnw4Tsl9qfEv94YX8A
X-Google-Smtp-Source: AGHT+IFkCky57Uay6sBkG6xB9auHzI69jD1MaNT3gszPM4wT3bxIuOsRBOVRIqN2JH/ov9C69vdqcw==
X-Received: by 2002:a05:6000:2008:b0:430:ffdb:e9bd with SMTP id ffacd0b85a97d-432447a714amr49360943f8f.10.1767095900408;
        Tue, 30 Dec 2025 03:58:20 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:efaa:981e:926e:8957])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm68337227f8f.35.2025.12.30.03.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:58:19 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/4] can: rcar_canfd: Add RZ/T2H support
Date: Tue, 30 Dec 2025 11:58:14 +0000
Message-ID: <20251230115814.53536-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The CAN-FD IP on the RZ/T2H SoC is similar to R-Car Gen4, but differs in
the AFLPN and CFTML bits and supports two channels with eight interrupts.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No changes made.
---
 drivers/net/can/rcar/rcar_canfd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4a653d8978ba..eaf8cac78038 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -670,6 +670,23 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.external_clk = 0,
 };
 
+static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 15,
+	.max_cftml = 31,
+	.max_channels = 2,
+	.postdiv = 1,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 1,
+};
+
 /* Helper functions */
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
@@ -2345,6 +2362,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
+	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
-- 
2.52.0


