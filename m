Return-Path: <linux-can+bounces-5632-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF6C7FE3C
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73243A7E59
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58E2FABE3;
	Mon, 24 Nov 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdR8QoPj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0E2727EB
	for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980129; cv=none; b=duXL4tAEiq+bn6LLYwhQEoX2KbtbJ8iUpxJqyJL6Q3XG+AztLT4u0pJSTdfhEPIvkaOmjWSLq5vgsp+nQEb1rjoOYPx9sMlKLv2svKrs3HXqiK2InpJWLqCTDr18y/L+g08yXaxqaBfI07WsOFCfuEohhsJfnNvgNC2O/8mWExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980129; c=relaxed/simple;
	bh=3FFcIwwYriug7ZUsRvZtpA4ornGPAgBeIh1+Dyy5yUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4UXe7lXJRVB2hLfXe/kf+1etgl8P/8hOV2T3UqdXotkowNmTgpXpVA+yfhb6hTy9FhBfGRQ5GTcT4i9fLXF3P8/myh30QrH37hTkRyUaGj3powi/8PkeY9Ao3Sa5QphrZk+nwCZ+asOuvUUPksK3xY+g1RjEeiUfl2PLoZ7nqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdR8QoPj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632d9326so25148765e9.1
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980123; x=1764584923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUOYA1b8SBq1b21L2dmKM9K+y2a8C28CD3QZDMvwcSM=;
        b=FdR8QoPjnWsBziYInWu8ee7D0IWxicMySjRMXx1fqEe41/gLbzqWB3Qa7vhrK4TFm4
         ubA4JTwi0vu+9iV8veUmoJrb+/xUviNkdwYSC8wDmCCDLjIXq5rKT+PK63pRoHH1I3H1
         8jp9b3dkUxUV5jYiJPH72RCQYYGMai0V9ttyFySFanIdGmdpvmOmSVaGN6kpiweVFlWq
         RWQEGrjwxld0gUByduOuQ/b5oWxfwUyPbuDhyuPe+iBvoSc38B4pSlze5ao8UAT/TM1x
         YQh7kPsO16fPr7psINbQZYFNZauTya0OPr+uP6m1ND6Ao2kpmCX6jBFuE5uS51n5ApCK
         qSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980123; x=1764584923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUOYA1b8SBq1b21L2dmKM9K+y2a8C28CD3QZDMvwcSM=;
        b=VPH+rjBIsc2WAjR99aHM45mFG+LIm+1H05xOhPHs5uPkg++/9NcxQDVZYWhp6bo0Na
         LbIidTWMQHRcWDCOnGM49N3JBjyXrdNlyqlYdVYkyn1xodyjjKJDoD+n8h2vwQl0MXqh
         8dmWbGXj0xSjGGyWJRQDhJTL3TpkrvfS8IYyxyOFGnWUG4XnLp3EkeeUBCRg2ZlNSXV9
         QZsouZAOiWZkhIQUx5KbS6GH64MyHwCHm+sxdQhJEQ/Uw03te0DQ3A9q9eHi3MwE8BV+
         UvSdz7PT2GXnkaMF7HEZV53rCX1qGfhkbXe+Wa5F7SKoFgrzRrgpn25wsZQ29ZDuSqgJ
         t1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWZZpTX2KGZe7YhLnvUL2MtOzDFs3ydeJ5J1u74U7BSLa+n62PgvPjnXaIwYFR4/CemAINr0B7OZP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8iUZswyv+rZ1Lhlv1OQ+4GeB0Ry46kFTu429XX7tDZBKE3kXp
	RoXXOb4fSVuBokHXFM7S7IhlhVUb0awlLpzKTxp2l+LQLQyDAnGpX7XW
X-Gm-Gg: ASbGnct6vj4Gqx2QRYZd/DWxcMfe7ecEQJTxJSHqUVaTUPXqFkaxsiXxaw8/wBu/+h5
	ncUlWBkYHTre9dVabMl+nRAIqh46w5WsZDfwyI5c3hfciZGlAfgyJ0aPnEuHO7iE6U00CVCBm+w
	8l/MXA/Js4LYRZEFYND7FiHsVKQiBFI8NCZKohfRZLV7UnLvQG9zjTqcSfPSDEH9kSxCGFGueQL
	vbb2iSN5JqMjV49dGaHhTUoMziYfYMv2ZqpEI/p7nd6kFgWKyE0ecch6nJJXzqCKalf6sLU0vgT
	1pFwZyXEgbA2CAaelMXqXbV00SLfZ0NdHoZR8arN+GX7c1oLC3vGS4LylnHphUaf+aw7Mq0mOjc
	o1/dyOKMqSiHuxhtUN+mB3K+zsiYZVRixO0xPKupgne1JChDanXpDvVLJxD0b/nF9tysN4tn5r0
	ThxzX0biFiMJiqwQ9EK2Axke2JbuVYeyblFg2KIttubAXvitrpm7RDJPB4RuZZGbeUwFlRmFMWt
	wAbcF4IHVYNzsZR
X-Google-Smtp-Source: AGHT+IF49raXKkvoRvdoYDn+lqsPH/MJp/pljnNNLgOj0o6RHZ+kJVvyExqQjzPP8kcLilcNbvI/6A==
X-Received: by 2002:a05:600c:470d:b0:471:1717:411 with SMTP id 5b1f17b1804b1-477c01edab1mr145394135e9.24.1763980122842;
        Mon, 24 Nov 2025 02:28:42 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1df334sm186753945e9.3.2025.11.24.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:28:42 -0800 (PST)
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
Subject: [PATCH v3 4/7] can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
Date: Mon, 24 Nov 2025 10:28:29 +0000
Message-ID: <20251124102837.106973-5-biju.das.jz@bp.renesas.com>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Extract the code to (de)initialize global state into separate functions,
for future reuse.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Added RAM clk handling in rcar_canfd_global_{,de}init().
---
 drivers/net/can/rcar/rcar_canfd.c | 182 +++++++++++++++++-------------
 1 file changed, 104 insertions(+), 78 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a127c0845a3b..d77d28d0ca6b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1979,21 +1979,120 @@ static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u32 ch)
 	}
 }
 
+static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
+{
+	struct device *dev = &gpriv->pdev->dev;
+	u32 rule_entry = 0;
+	u32 ch, sts;
+	int err;
+
+	err = reset_control_reset(gpriv->rstc1);
+	if (err)
+		return err;
+
+	err = reset_control_reset(gpriv->rstc2);
+	if (err)
+		goto fail_reset1;
+
+	/* Enable peripheral clock for register access */
+	err = clk_prepare_enable(gpriv->clkp);
+	if (err) {
+		dev_err(dev, "failed to enable peripheral clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_reset2;
+	}
+
+	/* Enable RAM clock */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev,
+			"failed to enable RAM clock, error %d\n", err);
+		goto fail_clk;
+	}
+
+	err = rcar_canfd_reset_controller(gpriv);
+	if (err) {
+		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
+		goto fail_ram_clk;
+	}
+
+	/* Controller in Global reset & Channel reset mode */
+	rcar_canfd_configure_controller(gpriv);
+
+	/* Configure per channel attributes */
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		/* Configure Channel's Rx fifo */
+		rcar_canfd_configure_rx(gpriv, ch);
+
+		/* Configure Channel's Tx (Common) fifo */
+		rcar_canfd_configure_tx(gpriv, ch);
+
+		/* Configure receive rules */
+		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
+		rule_entry += RCANFD_CHANNEL_NUMRULES;
+	}
+
+	/* Configure common interrupts */
+	rcar_canfd_enable_global_interrupts(gpriv);
+
+	/* Start Global operation mode */
+	rcar_canfd_update_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GMDC_MASK,
+			      RCANFD_GCTR_GMDC_GOPM);
+
+	/* Verify mode change */
+	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
+				 !(sts & RCANFD_GSTS_GNOPM), 2, 500000);
+	if (err) {
+		dev_err(dev, "global operational mode failed\n");
+		goto fail_mode;
+	}
+
+	return 0;
+
+fail_mode:
+	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
+fail_clk:
+	clk_disable_unprepare(gpriv->clkp);
+fail_reset2:
+	reset_control_assert(gpriv->rstc2);
+fail_reset1:
+	reset_control_assert(gpriv->rstc1);
+	return err;
+}
+
+static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
+{
+	rcar_canfd_disable_global_interrupts(gpriv);
+
+	if (full) {
+		rcar_canfd_reset_controller(gpriv);
+
+		/* Enter global sleep mode */
+		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	}
+
+	clk_disable_unprepare(gpriv->clk_ram);
+	clk_disable_unprepare(gpriv->clkp);
+	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
+}
+
 static int rcar_canfd_probe(struct platform_device *pdev)
 {
 	struct phy *transceivers[RCANFD_NUM_CHANNELS] = { NULL, };
 	const struct rcar_canfd_hw_info *info;
 	struct device *dev = &pdev->dev;
 	void __iomem *addr;
-	u32 sts, ch, fcan_freq;
 	struct rcar_canfd_global *gpriv;
 	struct device_node *of_child;
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
-	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
+	u32 ch, fcan_freq;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2138,67 +2237,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = reset_control_reset(gpriv->rstc1);
+	err = rcar_canfd_global_init(gpriv);
 	if (err)
-		goto fail_dev;
-	err = reset_control_reset(gpriv->rstc2);
-	if (err) {
-		reset_control_assert(gpriv->rstc1);
-		goto fail_dev;
-	}
-
-	/* Enable peripheral clock for register access */
-	err = clk_prepare_enable(gpriv->clkp);
-	if (err) {
-		dev_err(dev, "failed to enable peripheral clock: %pe\n",
-			ERR_PTR(err));
-		goto fail_reset;
-	}
-
-	/* Enable RAM clock  */
-	err = clk_prepare_enable(gpriv->clk_ram);
-	if (err) {
-		dev_err(dev, "failed to enable RAM clock: %pe\n",
-			ERR_PTR(err));
-		goto fail_clk;
-	}
-
-	err = rcar_canfd_reset_controller(gpriv);
-	if (err) {
-		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_ram_clk;
-	}
-
-	/* Controller in Global reset & Channel reset mode */
-	rcar_canfd_configure_controller(gpriv);
-
-	/* Configure per channel attributes */
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
-		/* Configure Channel's Rx fifo */
-		rcar_canfd_configure_rx(gpriv, ch);
-
-		/* Configure Channel's Tx (Common) fifo */
-		rcar_canfd_configure_tx(gpriv, ch);
-
-		/* Configure receive rules */
-		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
-		rule_entry += RCANFD_CHANNEL_NUMRULES;
-	}
-
-	/* Configure common interrupts */
-	rcar_canfd_enable_global_interrupts(gpriv);
-
-	/* Start Global operation mode */
-	rcar_canfd_update_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GMDC_MASK,
-			      RCANFD_GCTR_GMDC_GOPM);
-
-	/* Verify mode change */
-	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
-				 !(sts & RCANFD_GSTS_GNOPM), 2, 500000);
-	if (err) {
-		dev_err(dev, "global operational mode failed\n");
 		goto fail_mode;
-	}
 
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
 		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
@@ -2217,14 +2258,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
-	rcar_canfd_disable_global_interrupts(gpriv);
-fail_ram_clk:
-	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
-fail_reset:
-	reset_control_assert(gpriv->rstc2);
-	reset_control_assert(gpriv->rstc1);
+	rcar_canfd_global_deinit(gpriv, false);
 fail_dev:
 	return err;
 }
@@ -2239,15 +2273,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
-	rcar_canfd_disable_global_interrupts(gpriv);
-	rcar_canfd_reset_controller(gpriv);
-
-	/* Enter global sleep mode */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
-	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc2);
-	reset_control_assert(gpriv->rstc1);
+	rcar_canfd_global_deinit(gpriv, true);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


