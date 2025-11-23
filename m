Return-Path: <linux-can+bounces-5613-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D9C7E017
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 12:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46F1B4E29DE
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183342D661D;
	Sun, 23 Nov 2025 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY+YIp8/"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCE2882B6
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763897016; cv=none; b=bQddCtAu3aHRANdTs8/Z1ulf8E1abhrf0kOrljY6llJbueqfFXXiJ8KfMkRjimKM3La9Mor8QBcWwWw2zW+OD/EQb//MEo6P9KoYFlBisxa8ld2K3hym/GqGrMewErJFY6dTfmjWyzrL9sw8R09cOUXPxNekNoaRk0s4X0Vt2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763897016; c=relaxed/simple;
	bh=judJf37ugx+9XxEA6+cURHD2HCi2BGwiplPtaY8oOCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlJ3hsfwNZT/fmssLz+C+gudC99JHcQwP8vTomwkZS9mzfAQix8TMeyNX0f3IbZoWja/SFwaG6wrUKuA132RQGs73/Kqfn6Hpwx63u+9RPAoAQz8eWzK/Cx6F0mQZuJsFk+RGQ+pRWtFY8lyt2b7y/5ulSAKJl05lda3eDlCsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY+YIp8/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so34527275e9.2
        for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763897010; x=1764501810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Emr/+4aLXcwA6DEHvcDwnUuj4foIIDMHEYBSGGBEokE=;
        b=jY+YIp8/cagtNgQnz0l8HNppUimTsVbREcRm6HFrbH11+wJy2+wbl6Zb4JQm8p7v2B
         SdEgXRljd1Mf5jq11TTM/FS+obi17ENWAM1MDkgEzT8w2DW6TUnV2AYC172Jrk0tw5i0
         gQJRcEeZfJOVd7f4MLPjLcfHYqkbVSKd+N38bwpFRzg23WKub6EKkBhlA7tNQmQeF3TQ
         aqIgggQpvm8BfTyH+y8ystpvpAPokNGvr8BhNnyF4etAUwFodMU81t7C0BCsNCqIrXXd
         eNZzG8htzKdr9xQT3nZuSwc/3xm23B5I7iD+Rf6QvLWF8SA9XhJuhdHg6vlbIUEAsMTz
         k8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763897010; x=1764501810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Emr/+4aLXcwA6DEHvcDwnUuj4foIIDMHEYBSGGBEokE=;
        b=fEzuDyKyQKzfq9X06Id6IUoSNHukLndY4/NTytqbY9vrReiDMIkJFCFXSa944KbHFH
         Co7YwcrgiYWAkJpAH6i12x4WSavmaOXx0aPfkY/7HHjoM37ZOGkzxrTyI16JE4LTvv5b
         yy3zysOvsWEieUHR/MU5/zbwTaCd0mu75EzaTp+a2WM5o8oKnjgYgOrepcuBLrbZQI/6
         BlskkYahstYneFla5d3pSAovh8Vd+XNtHl4LZ6uKO9IRqi2V80fkRT5yO7FyfFk7vnwg
         uqgUCq+ZufcPPzubk36FempZwwhMIOC/68Kc6FEPCZTi5TEnX3OzlA+lfpvF0FZCt58z
         GbJA==
X-Forwarded-Encrypted: i=1; AJvYcCXb0Ait/nkyGVa5iqKMXeAZewXJOsxEEokBiXBvaH1a4zLdIfowSNr9VFitathpkaPO0Z77HcUH4j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLr7Y2rylMake9Auv5pX8rWe2CsnmrmP9iSKcX9RoRs4pe2X/r
	oPB78rQ9JURTO+qa6kJo60slqW85V7YAmweIWsJC3T5LHijcXDrw9f7gdsFihA==
X-Gm-Gg: ASbGncshv6paoTjCYs94zqUrcnfamq1GhtkKU2kqKgRsMJM3x4glcE1mQaFO5arRKmg
	rJ+qfWB4OBXIHG9miBIBzA2ccNHYjt7Dr7Me3tRIMILe7v2nPTYhKVe1kIBqQVFMTKe9tZG2QAH
	Wmai1gmshOaJ3ckP9SBfpUFKv6lkuEVAN+NO2CPvXG55Akijsr1JsFhFwggiMws2iWWZibqK84g
	K8TH93YlBJ+u3KzjeWKTTBFNn4OBULeQ7AvukGggWp0n5sOYqvnlwdNrsOCbHyQ/YZS+iC2sI+y
	W0FS+DECvYK1VmBIDRh4WJGLS7gJVkFh16j+diruTBABfrWxmE+N6RoRVMXOBqBlzFvS5/mWAXb
	FrkFTY7lUTb+1h5SQb34imLz5TkiW8aiRkJI4V09rbJl52dpBa/XQMyzuWxR/osX2IqYUSWVhor
	EavKQ/0V27/0N9mKKfXnx7+vJ7KKSGaD0y3fLXxnT6oyjvSiy1ysN9Cygx7zJbeIDGMBDO9nk=
X-Google-Smtp-Source: AGHT+IGTTftybiQ2Gt6OA2V2ockpQieSM4HqvkIUoh8tdMLZ7vPfFmd2LOncO8JPMOWOsk/IZByI7w==
X-Received: by 2002:a05:600c:4f48:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-477c01e02e5mr76829755e9.28.1763897010101;
        Sun, 23 Nov 2025 03:23:30 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm21765703f8f.19.2025.11.23.03.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 03:23:29 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 2/2] can: rcar_canfd: Add support for FD-Only mode
Date: Sun, 23 Nov 2025 11:23:21 +0000
Message-ID: <20251123112326.128448-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
References: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode called
FD-only mode. In this mode, communication in Classical CAN frame format is
disabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Dropped has_fd_only_mode variable from the struct rcar_canfd_hw_info
   as it is checked by the dt schema validation.
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 05dbdf46dd6f..00c3462fc975 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -471,6 +471,7 @@ struct rcar_canfd_global {
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
+	bool fd_only_mode;		/* FD-Only mode for CAN-FD */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
 	const struct rcar_canfd_hw_info *info;
@@ -828,12 +829,20 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 						       RCANFD_GEN4_FDCFG_CLOE);
+			} else if (gpriv->fd_only_mode) {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_FDOE);
 			} else {
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_CLOE);
 			}
+		} else if (gpriv->fd_only_mode) {
+			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+					       RCANFD_GEN4_FDCFG_FDOE);
 		}
 	}
 
@@ -2041,6 +2050,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->fdmode = fdmode;
 	gpriv->info = info;
 
+	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
+		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */
+
 	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
 	if (IS_ERR(gpriv->rstc1))
 		return dev_err_probe(dev, PTR_ERR(gpriv->rstc1),
@@ -2190,7 +2202,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
 		 gpriv->extclk ? "ext" : "canfd",
-		 gpriv->fdmode ? "fd" : "classical");
+		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
 	return 0;
 
 fail_channel:
-- 
2.43.0


