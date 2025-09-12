Return-Path: <linux-can+bounces-4687-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF58B54A3B
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 12:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598D417F7DF
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0B2FE591;
	Fri, 12 Sep 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNcVc/IG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C52FDC5F
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674061; cv=none; b=h8HTUZjc/D7w9uw9n/vDA/KebJwHbnk5vFgWoHcd7tEoLWA82QIqO73XdqcRbBZUsPijVUdbkdyD0cBL39Z8Qh1AMnxrz9IYOCveCMIb3RX39EHPITzrZGTd4JW371OLAoZ1SEeHeHABGPGDHIyUxZ66B7R0WJ4HvM1qH5nDG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674061; c=relaxed/simple;
	bh=KA+sI7ufjFyPZYwEYQoZfZGFYRielFswFPXUoh/FBo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDZ4d5prnuWqQ99Tj8sMlsejKZOZ/c3nUG6zNoQ96jSWS0xyXz2OU++KjK5onehVS1MHYYOSuij2fKYmci9q/hEkQXmCp87WbfrVNKoagNS3NM6nhPVlikfalZcMQHtf3exS/nD/72Fj1ajY/UNHn7ycYcOVDUV8Vyh3yzXSmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNcVc/IG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so537922f8f.1
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674057; x=1758278857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7yeEcm3Ced8ELUFuY76TaeRPtauHExqRBxvtKmA4Mc=;
        b=KNcVc/IGshwKGIDvMMrPcgnA/b/rIjGQ2gG77A/GvQzblWZbQHG6+ZL2delpTf2fvN
         TNSyTmLauk9bWoP8e7elMneJU+eaFuCWOZRNQwJq3ehYIbqvkcd7LlnxgEjqTjS2PVRJ
         fuYco0vYc8zbR5V/Qvpr7639vxFarPDXRMg6mrxJAnmOTA3nx23ihcOhcgJthVC9qG68
         qBrmZfHY7+DRzpsLawfAgkeArXqihShoLscbza4wmzdCuYRW+QvyLFaobmbqLsfTx8Zt
         odhBciwyNZTuU1o7p1waaVUaxT3gtSBDXiRBbovjLfcZd9uyOJH+0vai8s1lzGWPV2pr
         dI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674057; x=1758278857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7yeEcm3Ced8ELUFuY76TaeRPtauHExqRBxvtKmA4Mc=;
        b=PoCjb6Xa4tGJxmiaeY/gHD7tHoK43CitidMureHPx5CtL7Mck/5F11L6aQcZ2jqWpk
         3WO+1m8tQrNMb6oJroVCwpJQRJlw2QcfRnocV3U7lPwVm62crQw2B/osbvs3DQL5SWkq
         QmKhUvbkbmisLwW5/8h+z17oMJOOXrRsoHN9jjewBXWnXtX23MrQo0z2d/p0db/Xwo7x
         MKVuONjfF53GBYTgvv62z0+VBUBmplx7G4r0Tn1bPNLksJqTzkEzklVG4B/69peFB4j/
         TOtRD4g/6aPXXyCil15AiAREOFJfPS4TJlkfdLig0THXnQFrYE2FC/okyk2OXFMCxRdp
         gruQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXQG+d0DOs8c9iww2YiHiY52BWnnC90ZF0Uwn9Tyt2Zt+kqkD7nPcMB0lbEutEfwtiBgtbZ4lXgkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvlqsvvKm/32GFGnW49qdVuCzC2pW916SnBDnLLK03ScKNpQF9
	5TxdqnRNWfYeXrsgcd537OmRtRvEkbnFDTHC1I5gonrXF4e+fUZYbisP
X-Gm-Gg: ASbGncv753sHeBZ+A0k20EcamSUSKT4SrQAJPNLHjGKf3a+9EKl1mojVu5DRkVGMoWN
	LFafl39hPLCcwqUHrRaTEwf7U83Yb35ErT4N80XDAGquevu6Kz5RbJrm87eXsosBz9v7IECt3hD
	TrdaTOpWDWJK9LlpaClGhTIWd1HQ+nCMsBtT9CN7ECxH2si6upJuzLnzGBp9UgZmCG5409bLPwE
	yhb6cZ8PDNQKqu1k4xjab6bmFyt6Pjs4mpXCT4rS4T5uvBhSzRPQwQdyxsKD5SY/0CtAEYyRPq3
	UldXCmi0zerzK4gs6fJMb99xBbsfLINf8bFji2LBTAJmj8rIOK6OpZiyPUCvkOtrTT+Xl21RTOL
	RLbhH7qVDuzvRS60Iq4FMLSsAi4LYGHBCeHFXGorh0iAtLWZ4MEudSK7GqWpupV5QJYMul1JwdL
	Ek8A==
X-Google-Smtp-Source: AGHT+IGrhgEWEAy/UQRry9eO3Ixag9/wrNC8n1JxqWbGRYDy8gImXUuDgETKAkJ8vsUGzKh4KDII4Q==
X-Received: by 2002:a05:6000:22c5:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-3e7659f3385mr1834367f8f.18.1757674057078;
        Fri, 12 Sep 2025 03:47:37 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:36 -0700 (PDT)
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
Subject: [PATCH v2 3/7] can: rcar_canfd: Move enabling of RAM clk from probe()
Date: Fri, 12 Sep 2025 11:47:21 +0100
Message-ID: <20250912104733.173281-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RAM clk needs to be enabled in resume for proper operation in STR mode
for RZ/G3E SoC. This change also result in less power consumption.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/net/can/rcar/rcar_canfd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 460bb62bbd08..da469595be74 100644
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
@@ -1975,7 +1976,6 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
-	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2065,10 +2065,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
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
@@ -2134,10 +2134,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
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
@@ -2189,6 +2197,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
@@ -2213,6 +2223,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	clk_disable_unprepare(gpriv->clk_ram);
 	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
-- 
2.43.0


