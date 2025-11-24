Return-Path: <linux-can+bounces-5629-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB16C7FE1A
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6840345080
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508212FABED;
	Mon, 24 Nov 2025 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvXfwvqj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204622EFD9F
	for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980126; cv=none; b=Ph5BdWrIFKbJjBPmKISsF9W3oGYLZSX1BXGsmoSsHGAN4z0lK39JmC94tehCcfp4LB61d/eliGNz6/9tEOYizHzIoYMzPJM4odCLDSCTRO2uYLfdS3jkUs2S5kAKKEEaFBihkfDPCw9UXtVIbF8egmY+rmNXO/XbnVUMD7GB344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980126; c=relaxed/simple;
	bh=E/A8VrtH51z0lvb8lkMZcyZT4EdZZmFfF1gv521yMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5TFFb3IBcNQ6dKTuKJefSn+C9S1NXd6CsU64WK7MAs6wtqF4LYc9OThVhA0guhj4VCns7IjNv6Z4dpsW7yg4VQDK9K7eRcNfpccZLsWLVaRz5qn0tINIucMvXzpFnxgiPUzPHeKZmUPIBrz85vDH/pYHllrGHNJ8/vrlIYZj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvXfwvqj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a219db05so24460825e9.2
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 02:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980122; x=1764584922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3EGBpm7Z4624Ma2B0L7glleYByz0KLJbb7xFZAvoyY=;
        b=YvXfwvqjP/+/OCgDTLh4SvzDBHzl0JW86ZFdJ14cOcLyYl+EBZmzJSh1mr3GnLWkDK
         T0DSRIMESVYClMy+On5LN+3ifBuyGQQN9dIFBtaHhuU5WBoPThxQrSIAzBwJ7cBIM44G
         f7fJSTpoGAqlDXhYy0PxYY/XHScpatkOC4iSS2InGi4XOFQFuyPatABWMIrwV9pHTF0d
         dmFQhN45+tHFX/4pn5v2CxC1RY60ai2E2nOwJ96eUpCUmPKanlMMc3SY43zb5FTdDHQm
         z1IHjUQMIKikgMFR0JtU+r+qrWYPVfycNDYB2LUArzXg2EI4VaQrG33YZZhxkGFpDtYr
         35dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980122; x=1764584922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3EGBpm7Z4624Ma2B0L7glleYByz0KLJbb7xFZAvoyY=;
        b=dq8ysvxxecIuz/cZPithJeO/EqlsEbwgpOR9kFVkvMlv6rIM+XnkxfeuND/oSqbgBo
         hPVU3cM5Lt1PDCF9brZ8AGeoHSQ+dX4kHn27N9rZ4yR93YRFm4TDp9YejUh7arSLaReb
         CKLt+DpNPD46txHbxt/ghuDtUC9SbzvJfziMNskwAykfJ1NdokZC3ry0dt01IdAfD3g2
         tsL5EHO3LEXUFpArCCaOSd0hGG0ILvi2lsL4/QUJ56WnjM36mZYh98jzX6oyStKFGSnL
         7lDpzGfmzSZWOgULjF0g9E7VgVG2nQ7X0VC4vnNpXAGhgSt5bjutp92pjzFNRrDWYgqO
         cxuA==
X-Forwarded-Encrypted: i=1; AJvYcCWKicJ27BxVv/35tuXoLbg+4QaI8L95dUq/t6RyfagfaKHCO+d/btxuxG5RTr4MvrS/54BI+jvmoPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlHIcIVqc8QDk/FA4KA4PLoRrnEFRNF7BAfaeCZPn3cNCa728
	1HeIpAyvjC2Ar7zaWHEhII0awYNSD/FMThQtD+34Tmdu9JDdfr/agDcH
X-Gm-Gg: ASbGncvxaAkrs3qGLjEY4zEkpX1Uai8CBN2dQHi14Y1sIs2LsImOf2efF+C3yjp/ekm
	TfVK9kLO+dXF0aJw3oBbZBl+ebycUphePh+Gcy/254gE0ESGHKqSvW6GJLGUxNEDy6fvgtZdBPG
	UDURkGscKVdQOqlZzD58VNiqvfbh4oM9hAxlqvPRypMxwv1XtlbdbSRH6u6QtaE2M2ErfgDIq00
	CXlL5K5e2e0X/71X6BwMZMvClrCGiMDXucjIWQ994NCnEmTkFu3Rbc5nuZSuyf6sB68EbaHNhLd
	n8gGvDe5pDuBrXgRghbI2KD5kJ/TYO2NLo5vtAgqBNFr/aUWiklNLOFByoMA2Dt6KlfEKD1YA9u
	UQqbhxl/QtL34F7IfGB13iPX9yotEBB74q1/xHTTKwh3i9jlXE/CQWctmQ/afz2eabX+pGy7tD3
	FQk6dzZWiY+8hAvB56e8SI3hVq1Kc5RO8ihYlGJywWmqZS+NBdpVlXjFHu11o8uVGF/OMKijX/A
	+sdiyFtNsO8sjI/0YD1T5qpeM8=
X-Google-Smtp-Source: AGHT+IFpGKBj0WQRrF358OhLtccWrXcXV0btkWFGpcKOuCTzthrxs/C2CByHNJsGuuLvUcAyiaXsyQ==
X-Received: by 2002:a05:600c:310f:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-477c1125568mr131901425e9.24.1763980122229;
        Mon, 24 Nov 2025 02:28:42 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1df334sm186753945e9.3.2025.11.24.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:28:41 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 3/7] can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
Date: Mon, 24 Nov 2025 10:28:28 +0000
Message-ID: <20251124102837.106973-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
References: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Replace devm_clk_get_optional_enabled()->devm_clk_get_optional() as the
RAM clk needs to be enabled in resume for proper operation in STR mode
for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
 * Collected tag
 * Updated commit header and description.
v2:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c03e8dff6a20..a127c0845a3b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -468,6 +468,7 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
+	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
@@ -1993,7 +1994,6 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
-	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2086,10 +2086,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = gpriv->info->external_clk;
 	}
 
-	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
-	if (IS_ERR(clk_ram))
-		return dev_err_probe(dev, PTR_ERR(clk_ram),
-				     "cannot get enabled ram clock\n");
+	gpriv->clk_ram = devm_clk_get_optional(dev, "ram_clk");
+	if (IS_ERR(gpriv->clk_ram))
+		return dev_err_probe(dev, PTR_ERR(gpriv->clk_ram),
+				     "cannot get ram clock\n");
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
@@ -2155,10 +2155,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_reset;
 	}
 
+	/* Enable RAM clock  */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev, "failed to enable RAM clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_clk;
+	}
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_clk;
+		goto fail_ram_clk;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2210,6 +2218,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
@@ -2234,6 +2244,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	clk_disable_unprepare(gpriv->clk_ram);
 	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
-- 
2.43.0


