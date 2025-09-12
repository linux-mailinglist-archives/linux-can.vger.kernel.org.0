Return-Path: <linux-can+bounces-4689-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5811BB54A48
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 12:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B94586FC3
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1162FFDC0;
	Fri, 12 Sep 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBgbfLUo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114782FE585
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674064; cv=none; b=A/h603DA0bzSu7tlTOei4RABeQER786b+x4IvIqis2YI/fQyihxSojfY8CC1fv6Oq15Ov95kagQSOcqD5hy7GiLKaOt30ozHP6RTFH8K30ST6LtpSnNwcoGMoPEfAYvpmMX84C7faT+pUiKBnonSD5CmSy9hg7eCtelNXrVghlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674064; c=relaxed/simple;
	bh=FLVOM1yiYyuAFtJIVpam2KGFjLS7vml22aG5VkRxxpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGczAZdY55KyN6egjJcqUKVnQ70PFH8vPCxmQVKTweRPXlkO0Vtmk979RGuTqdZmkjIeP5ZQ8mBZG1qEDQ4wneZ3UR18tGJx32L3ebQDrw2YS3vmZOn6ZPJc9kcTLQZEGnWvsN+cnT3RcCalalYsmWCb7q0yyCNq1lyXt2Xdnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBgbfLUo; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e7636aa65fso1170257f8f.1
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 03:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674059; x=1758278859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOFjcyob18/q6ECu1uYjWXtT3k120lD6uL6jj6365H0=;
        b=kBgbfLUonxox/sKmbToMx1NBuoJbRMJveK5mp/chObYYlOJLCHWmFEKIgVfWkUYnT8
         DhQqb5Y0gonYGr4mc9uKyNhp9tuSFTABh/Trt9qNShBM1EyhbnTChdltjVNcOn+vfXaa
         MNE6vwEHE/1IgAnLsKdXrdT6gF8+un+aSf92MEsc81Y/shIKN8G+rS6rrAQ5CdoTiN5g
         nX3DNthPHtxBsMuMksjxjwTqo4hxj6R4Yz1e4eGgkTZ1mdQORqiSSD8WqBULJWDl4ZBa
         RgCohY7o6ucSsZ3lA3XG8TLgsBNwxKKR8HT8eOTNxp/fHkWxjRykeK+q2DsEC+PVE7mE
         zNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674059; x=1758278859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOFjcyob18/q6ECu1uYjWXtT3k120lD6uL6jj6365H0=;
        b=PllqY1uyCYQVkllTGnNEdEzRv0mOpuHYwrut/j645ABYGkY3DpwOUx50hxEoFtqCPH
         jQzcx7PlZQcLgSY7ntrxUO5HgKjvtLudmI5CBVgHVrzDo+uAUW3oCseZWitNClwFSG+Y
         HMZhEtaqIYj+hXX7EAUMEXGSEoOXId+0PW2ph2bNFvLs3uc8ujHE2NoRTvW4L6k/IVfI
         An/CemmADvyCHIm9SGE6L0l1GOo5sy6c87ABuN2pL/3xnmw9+jFfjgf80uvbUiZXq6S+
         /YWSVFldt74SGUn537p0CcpMP8j9PAh9CduJqUBK0b44gBydbhtDxovExTGCmriSNvds
         k5fA==
X-Forwarded-Encrypted: i=1; AJvYcCUYpJ3SFkFSHBVURSVY+AoNt+m37tHPmk/IcGSTt0pwmJV38ArpPR3BoXnaNo0Q+1bxGoiMMu0Z14k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwREPyXqN6gwP/XQnNS0fbRQ6cD3uk21gyjuRRrU5eL0cGK356x
	7TK2hfW3e2V0xFRN0jaNDb56cJPsIBw3c7Ldvjfnmtd1H4GKZj5DlQqr
X-Gm-Gg: ASbGncuL3K7E6Sn8u7qziVIQwQR4ihXVr2uweN06TnlkXsp7kW+UUAKY8+g8h1E6kNa
	Z/wRARsKd31tWcGvVpOt9UGDJUl5ZM2dYB4VTNX5U7MV5nxffIWm2M4HCMSbcND08nMS+E46A88
	8p5FJ0/SwjYQ0cawbaYaYLqlZpDnK+9OxQ48QPZynCpULzA+3UeckCthAKl+VI9ZglNzyP3c0+Q
	T5vHY7yg/6lCyu6PTiF1NFAxiAGvdyfJvKNpkR9qOMEnzWSWfXTNdNCXjrGoG0tw7ruo6gx92+7
	fPZ3NI/h9238iEKLjc09pX6D0dJDQY3tqE6NjcuGBfYtGqio7aR7BX/DnCvVnZm0sbDaLYJmzw/
	GVzAqdsWCDgvJCnCbVD7JZHGjhQn2gxdzdejW+AuOwcECrAjR/8/A1TAys0bTuWpukMsRidkYoC
	pTaA==
X-Google-Smtp-Source: AGHT+IG+MQ3VtX94CzZfBzHv/ax7NYQ5GX85/Fpluu2HaIVgidvgyUMgFKd0uhvvk9hwI25G0f/Uvw==
X-Received: by 2002:a05:6000:18a4:b0:3e4:f194:288f with SMTP id ffacd0b85a97d-3e765a56cf5mr2172263f8f.62.1757674058849;
        Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
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
Subject: [PATCH v2 6/7] can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Fri, 12 Sep 2025 11:47:24 +0100
Message-ID: <20250912104733.173281-7-biju.das.jz@bp.renesas.com>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the Renesas R-Car CAN-FD driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotations from its suspend and resume callbacks, and
reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag.
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index f0dfab177b98..a0c16a95808c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2255,18 +2255,18 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	rcar_canfd_global_deinit(gpriv, true);
 }
 
-static int __maybe_unused rcar_canfd_suspend(struct device *dev)
+static int rcar_canfd_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int __maybe_unused rcar_canfd_resume(struct device *dev)
+static int rcar_canfd_resume(struct device *dev)
 {
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
-			 rcar_canfd_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
+				rcar_canfd_resume);
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
@@ -2283,7 +2283,7 @@ static struct platform_driver rcar_canfd_driver = {
 	.driver = {
 		.name = RCANFD_DRV_NAME,
 		.of_match_table = of_match_ptr(rcar_canfd_of_table),
-		.pm = &rcar_canfd_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_canfd_pm_ops),
 	},
 	.probe = rcar_canfd_probe,
 	.remove = rcar_canfd_remove,
-- 
2.43.0


