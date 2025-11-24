Return-Path: <linux-can+bounces-5628-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04922C7FE1D
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 11:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC6D24E445D
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD092FA0DD;
	Mon, 24 Nov 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC+gxzE7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20BB221DB3
	for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980126; cv=none; b=opP+BR9XCpqmWeRzEEWScceIQpwSVAEfWr6yas/zABvchgcPvsGFY+P3LUjaXKSQpz4It+x4ZBsyfZFIUQTr5htIfr607CrMFCraj30586fQuO5VLFTr+SmmYVOwrQcNR0MVHKtalJPMUySCAMqZNe357ywg7BtbW4TqSW/v8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980126; c=relaxed/simple;
	bh=3+nnF588T378GBA+9QQgUACjWK+jYS7zewBllPyBRO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDRvOcyvHwc9xoSLcxJw/II3OUIMpmpiCdNBClmLiMHssijPUswgP0yU9pfyZphoatjSkWiE//1eISXTWDqn+CIVXA4L/6fiqPSL/BG+OkK6BvsOds+YHW+B5WS3jxI0GgPuaNBByrHvLfyRUkQda2YI7e1X6qVSV2qlOmTHPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC+gxzE7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so36213495e9.3
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 02:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980122; x=1764584922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5oBZG16/wN6GG9AM2JpUrMbboYKvUgGXIP4x48mO+I=;
        b=EC+gxzE7haF0S9RkQtrNX6HqYjPMR1G02Ts1FT7iyQ+S/mwxsk+ZCAYouuoWDmCgzA
         csP2hDwyZ0G5ri1+9MRJYnNYC56SSGbZObvP6iSO2KZrY2sP+6GcyIT0uwd1omY1RvHw
         y2C4aHx+AK+k8hKR6oyDO4lPVmCqqfTQfreWndATg3gbzmZjOlzvf9RxyTkJ7QHVUtgS
         CaRjDUqesHlIKWC4EHPUlLrsDavSpw9uPUkhnC/kHO0T4sknFQR9mGRjAQGdNnnzF6VM
         gR53s3PWM7R4fnScWOkKDZKN+n3t2BDLMEkpdz9C5s5n8PfSA+a5C+rrjyDVWPCp70aK
         nOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980122; x=1764584922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5oBZG16/wN6GG9AM2JpUrMbboYKvUgGXIP4x48mO+I=;
        b=FV6uNWbE0GufegsB2yomUcw75V8O9na8zbmHDDXqvs8/RUFlWNAnZe2n0cLcQC3SgC
         GszDnABdx8PkKcMciT7i/Q1ncmgvjaDVTOMlbZ5wS+/Tv778JKc17g4TB+KH5CF0QsYF
         4/oxWpx9Hz6t1kSo6xgqq/tAZdNBekDASXw+p9PJBW65isn2mEqbFaXM+5orOpmOqS4K
         32+8hyP+WDjYqCYiloNezV6EEKjlAMpkx6Qu0QaPCpbEhoeFw8tgnXFRV1fNQGK0yPAx
         e6CtJsWOLxrd9khJorPurMrvmY1j9l7y9k8X64aF0ZOLAgAGwYQxx4uVfVVZHm/PPDGK
         l9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxlGRSdl3g7DuHXkTWoFClAikDnaz4QbH7S8PZMWXddPWPO87SiqRMxxS7WmJU6Q7S3sNg+PWySVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduofaM1Mq2IgdZwbIjY1aXyulK3h6+UadD8MNvJByI/+mRjgk
	ir8p2cm8d7b0eX8pOl5epMtCJL42UgU4aZIIp9tbEmRlh6MSj1ri/zzr
X-Gm-Gg: ASbGncsoQbQL1W9CUHByc3XFwrxHPmvnKxInjMI1UH39aKQ6u/obaFMy3w25n/5bMoC
	unEDJersBG40RE/D+wyIYdQyN15krb0PZ3CL7G/Mc+rFCWof9G7HYel4JeEWUPiZI7PQw+P2hEt
	ExGeozjUifAdv6hflfsvZSZlzhZoYaIqOfyfAwLj67KKCXgbbSPYHp9XXsN20BBXc5h5UfvVprs
	eA6VmloT4RSAIblzJ3O0FogWVUzBNChh5NTpyuo+B/Xe3jFBHNOSGpy+mNi/x04atEh9QOGwb5K
	Pu7P68JmGKXUYlVf1x69jxD8Bi3yLq32EfzqARsLBblt8K1YPKac14EF5T4z+Il0HQFHXL3IzZL
	Br/rXoln0tjro9bJO98gBWg2+iZ1EE03vT2DY68+BKZBd/cwuY0mZU+v57jzL6Bb//rUygtOp9k
	F7+wArU5e0C5lhrvwvIXWaL44B+L8JcCHhOOwu+uTdQQSRgySaCy7FqEPvhwZVkslPV2nz8S2ce
	mR0LLBZkPdkMvxO
X-Google-Smtp-Source: AGHT+IGo1CVZwZ/FAWJme7Zy+9NRmnO4ycz8303KaODH2VEd772twsOxKeh/e9ysRmPRF1JNLoWrmg==
X-Received: by 2002:a05:600c:1381:b0:477:7a95:b971 with SMTP id 5b1f17b1804b1-477c01f55damr116622105e9.31.1763980121578;
        Mon, 24 Nov 2025 02:28:41 -0800 (PST)
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
Subject: [PATCH v3 2/7] can: rcar_canfd: Invert global vs. channel teardown
Date: Mon, 24 Nov 2025 10:28:27 +0000
Message-ID: <20251124102837.106973-3-biju.das.jz@bp.renesas.com>
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

Global state is initialized and torn down before per-channel state.
Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No Change.
v1->v2:
 * Collected tags.
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6098a3eebc43..c03e8dff6a20 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2224,14 +2224,14 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	rcar_canfd_reset_controller(gpriv);
-	rcar_canfd_disable_global_interrupts(gpriv);
-
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
+	rcar_canfd_disable_global_interrupts(gpriv);
+	rcar_canfd_reset_controller(gpriv);
+
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-- 
2.43.0


