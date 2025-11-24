Return-Path: <linux-can+bounces-5630-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC149C7FE29
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B673A7AB1
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C72FB093;
	Mon, 24 Nov 2025 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD9x6lvU"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7482D1916
	for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980126; cv=none; b=cuHYZ9Gff6r7Hv1UUhPhrMlxkRoxZ4RNSBX1v1pr3u24akjb7BLuiAFqMjVGWllW2Z4JQNpZV0ZtW9z8xczppxYBw7Can63PQvBtnEX7Sj0JyPhpUhpKhYcVvs4WLyGKOaO8dlVPE83EMJoqDvJNQe5rp73AUCxcpagV5LGT1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980126; c=relaxed/simple;
	bh=Gv1p1qFtgqVq/hlWSzsyiuvBbNBS6q1HICEEW1Sy8N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh8hpsf0yChxvpEaIIC2aXRiky68J7JeOb1rnojJkp8HXNTNgEPLv+Ys2C2/AJIOMqAziLXjk6UTxfC5sQ8Hj5Qxp3Q5Kzud0MlDlhOb/75HZh7nDskoMvXepLvkoiJkoIiIkfVhpNIfZx6w7aFknOVT89UDYqaoGUkhx0z2Afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD9x6lvU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso25037015e9.1
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980121; x=1764584921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/lCM7b3NP2vHVQh7B6VQTEtsXsCikhEIHSatdbk53Y=;
        b=CD9x6lvUw8kaqIDKsdL2KzZKgmvzxjQ7UGqmqjh8/RxmR924iF+A1+bVxPd3KMsfyU
         513uTCqCQuyH63UTx1rW914FRxMXmmZzL54AMFk6vy6NDk5zOvQw0DGniTn0xV+y6R4P
         acC+fAzv72vPEiEIXwyN/bR6ftHtShj4wiWpkSyURKuAgLw3voMbxMlHE3njlUE3FnMG
         dBxPBZIB+5Ax8iegaOoJXDMDNFA002deW/L8k1+Y2Xx7cPF+v+k6FVY1ERYt35oHZl3k
         gUj+JWxKMycGnLtxAO0ngCKK25/lvEd1qpUmFvjb68LOqHSq/wGIJA7mLqakwtd7Jlzx
         Upyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980121; x=1764584921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/lCM7b3NP2vHVQh7B6VQTEtsXsCikhEIHSatdbk53Y=;
        b=r3IVukXhTcdn4RRTEvsfhx9L+qnEbsoHBix5YEZd14cdhrz8Rk9LyneIRC9FzuZPh+
         390UcRN/huNenCm8AxCJNPD5GqwobiXdIfwrvTXkjNhjI4nkPj4DO6TsYvMgjK4B0ZOA
         M8X0NhClh9WlGFI29Ji9EwnfqnmIiEvfwy58WN2DtkX+IPrI3oQf8MXVgCnAXF5qQ/Lq
         5g/jRkWsvWwEAT/Q94oLN0xlL4caQ3Dz9G9BvxbHO4Fsm9ebzRgXiju3uEc9Q6/Zu0yj
         I9Nm0MZiNmoC/lvjHMeFWwanMPVkpsdxfKrbKejIMX02b01WTyVXTPQ4TUOgHGaDmLds
         /cNw==
X-Forwarded-Encrypted: i=1; AJvYcCX4/1DKSpv9nVtKded2OmJnw1Hrr29V7LOTXLV2AYrj/Izkj5I+idVPK4+O8HLKhglBN9tWO97T7FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydhZJv9RWAqW/kRXwTHrrfyumDCzO4xC6ReyVLbRjRpIHRHK1r
	MTYHWwB6bB4ctZvVLsc3B8R3i6+Jyj/ZtJCXDfeqK+HZROcwF0bLaxmC
X-Gm-Gg: ASbGnctq0jCReiVwukAuRFJzpunGqI1eV91nGwt1lmiv0b0nidg+3t4kVtTJemIqOj8
	hsDbAdPJXyUKABAUox/0h0h1JBBBMG1R5j4MpZvKSo2doAswiZ6sHqfMZjKu+oRzNH5LDPpTide
	gr8rftMmr1S6L3QaW02k9xgNwn6KxflLYq8N6pOMLaywB7wYSo88832Sk7k8hB+5WerqYsRd9NZ
	lqBkjbp+nB8IloWOfrNePB/wUlAv4q5safTrMBGs9yYEugeqeAmGBeof5mJKTdXaNeqKXgb7kSV
	Yc8ppl+A/e0ZVHVlwfjoCR5LAwfZX+vPykN5FUldF1PFwj3/8Tgu3yVVr1jqI3u7yH31NL1GZH9
	73K4nMwLgqRQ2rPhKD7JIS+8NGx+Mb79hO/uA0lH64NPvv0gxgHNzLEOORo/UnAjYOK3aPptgj2
	u2UJPlBEZ33yem6y3YYY4Cm/+T3SkbzD0zSifOlC8EFMUckyfLsZ2Tx6/iMn3rWyaDdA6dADnba
	LVyCyrELHDqjXUb
X-Google-Smtp-Source: AGHT+IE1Wu4cnnS2yubMRh/9JOsB11KmbzSedpxoYaakH7zmTVKVbY5LsdGtqPUlk4li0q4DKBmVVQ==
X-Received: by 2002:a05:600c:3511:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-477c112f7b1mr104835185e9.29.1763980120947;
        Mon, 24 Nov 2025 02:28:40 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1df334sm186753945e9.3.2025.11.24.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:28:40 -0800 (PST)
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
Subject: [PATCH v3 1/7] can: rcar_canfd: Invert reset assert order
Date: Mon, 24 Nov 2025 10:28:26 +0000
Message-ID: <20251124102837.106973-2-biju.das.jz@bp.renesas.com>
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

The two resets are asserted during cleanup in the same order as they
were deasserted during probe.  Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tags.
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 00c3462fc975..6098a3eebc43 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2213,8 +2213,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2235,8 +2235,8 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


