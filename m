Return-Path: <linux-can+bounces-5287-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2340DC1FEFD
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 13:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC569188DF41
	for <lists+linux-can@lfdr.de>; Thu, 30 Oct 2025 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20087313E2B;
	Thu, 30 Oct 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+c0wQjG"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F92C21C3
	for <linux-can@vger.kernel.org>; Thu, 30 Oct 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825914; cv=none; b=RLnk+2zElgiumk+ClXAlQmLefAfpqTj0h/ceWK+MOG7fJb48VAXIV+QXCQH3o3rJmVVCuoCjUHNo4HoCxyPgi6Eq4KRSmvnO4phRoZhkXmUGZUQK74NfRdMjNTyXYHprhamtucEjbm2N7mZD1tYGl084rXBYJbRblkWxICpLzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825914; c=relaxed/simple;
	bh=Nnmy/nhRXy1Jb2EolZDFX082PZeZ22LYX0yNSq8ROCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cu3iCzEL+byHQ4s3OQuSuEYtu/JZI1enNl+wEn8Gb1mbw8916Bma+6Vn6TDXXWAMAVOjHcQf22rGTK+WFQfhp8yTWKkkH9EOfYeDX5VVuAYmoREcSI3WVCUAUSSx4xs7kAabeaDnvkm7QnXOj+BHlOlL8aTGpcom/tQsM0MUMDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+c0wQjG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so9824535e9.1
        for <linux-can@vger.kernel.org>; Thu, 30 Oct 2025 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825910; x=1762430710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCpWVCeFoXMs1/EyJIuFGqtdg2vmYZ9/7tM7s70z/qU=;
        b=H+c0wQjGAMRqI3BM58JSCWRYsnmL6RELy9aBlGdO+v9a2eUJku4z08/XkbAGVY26j+
         8JVFUQ7Z9qOncEzCGwXN/tYAv0vhW28YkqFGNBwbqBYmlpo+3UNIxlEFn95diBkGnKfU
         IjmIFasmTsktL++A+MamH8kynWkPEu4Orp6colEwN10japUSkzvYYXyq4WHk1hQABosL
         4ZU7dgNI6kxuUVjsTPm2qwLOMtCPBteJ7/gIH1Z9AbXtHBaoqPkagiPgfPni2BjycveW
         8KwFFJxfNeToyWvhJa9IMSj2tUQ2xzRkKum1OJg20BBfdN/SkJBPWTewzBKLkZeCwn2e
         49vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825910; x=1762430710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCpWVCeFoXMs1/EyJIuFGqtdg2vmYZ9/7tM7s70z/qU=;
        b=R/1nqM9FCeijtCkCFmVLwC8cgBQn1bRb9y0cQyMqDPDkWYvaCq4AxJulGHHqm+o1Vz
         Hl9M0b3OuyHMuDdIlLb0ef8c5cZTdp1wmDc6k3fzj4a9JFZLPpR2FZvfZq4OUMvxhOoB
         M6eYWvhzgUii8UnBZz1MtEHPFtMG5gGjK7HQHmG1zjUbt1jDpaCENSZ6ER7QH7ed4a+D
         h/LdSQYbjy8AN8DL+Uj4miavKFuN8xZHv7chQzlS6Fq7hRr2rN/HI2CzRGsY19lOYqm5
         cT1N56W5IowzgJgRAosBKuF36BN2EWFfT+BtUxlN0vDknX1N+XqT1AXTMYm7ltCzJ37S
         jXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSToD9V+ZanXgeZRZ+Sw3RV2gldlpTZb+pBDhmtc21rys06cAATxPxDE1Q4oih66+h8CA42hddNKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8JNr3ufG7BEv6SAh+uPgptTrZbozlhfymlsP9GucJrKtFGiR
	BpPHxEHEva1/d8x20uEvu+yMqmzsgTThC4Qtnh6ItzAi1MKlO5VpEahf
X-Gm-Gg: ASbGnctR+YTqqTGRCIyac7ax18ilkjptI3JzMXWKr301/1qP2JXbg4uOKGTKgVgIeHI
	lVfQiK11jUWE/sa1Zp42npbSgpWWFOdED41oc1Y0DqWYxqBHUBCYpoQUfqSzQmK/xwtQAC4Eiez
	rUaO4+d6YH/O296biH+rUQ+vgfTq2tfuDbioCpibyyNjZnALr20WgYXbG2o4WQKc3EeWHxc24k4
	zALOih5WWMnTfnYD+ToiX0P2CLKeKit/kXMTemAuZfjqfkd6OE1Aeknph0GzvmYms9S7Z4x5aOR
	KN2j4af3fXPfcO2KktpUHZCqWkA9zka/VN7jX41FkHWv2CeyVudgC3fTlZrUMi+aAv0LtLOTYy9
	epQUAgflhU3b/PLyiM4aBx2ImhkV29pmoHBJ0/6wnQaX/k7qWVKVh7wyFXPrnzAPFX8C1i3JYoq
	NXJTWFfpGu18BncOjRxL8baSr+vNnFhTf5qraa6KbEXEXe3jrMLBMDZhzMa4SH
X-Google-Smtp-Source: AGHT+IFu0rRxNzi3BvOKL1lXRDq2cHd03YnzoBoOPePE4rUTNG1zrE1V3xFacaBHpTSekptbKXeGkw==
X-Received: by 2002:a05:600d:6355:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-47728c12b10mr14305245e9.7.1761825910183;
        Thu, 30 Oct 2025 05:05:10 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca569sm31018677f8f.12.2025.10.30.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:05:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Tranh Ha <tranh.ha.xb@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L SoCs
Date: Thu, 30 Oct 2025 12:05:04 +0000
Message-ID: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
applies to all SoCs except the RZ/G2L family of SoCs. As per RZ/G2L
hardware manual "Figure 28.16 CAN Setting Procedure after the MCU is
Reset" CAN mode needs to be set before channel reset. Add the
mode_before_ch_rst variable to struct rcar_canfd_hw_info to handle
this difference.

The above commit also breaks CANFD functionality on RZ/G3E. Adapt this
change to RZ/G3E, as well as it works ok by following the initialisation
sequence of RZ/G2L.

Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 49ab65274b51..1724fa5dace6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -444,6 +444,7 @@ struct rcar_canfd_hw_info {
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
+	unsigned mode_before_ch_rst:1;	/* Has set mode before channel reset */
 };
 
 /* Channel priv data */
@@ -615,6 +616,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.mode_before_ch_rst = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -632,6 +634,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.mode_before_ch_rst = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -649,6 +652,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.mode_before_ch_rst = 1,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -666,6 +670,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 0,
+	.mode_before_ch_rst = 1,
 };
 
 /* Helper functions */
@@ -806,6 +811,10 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
+	/* RZ/G2L SoC needs setting the mode before channel reset */
+	if (gpriv->info->mode_before_ch_rst)
+		rcar_canfd_set_mode(gpriv);
+
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -826,7 +835,8 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	}
 
 	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
+	if (!gpriv->info->mode_before_ch_rst)
+		rcar_canfd_set_mode(gpriv);
 
 	return 0;
 }
-- 
2.43.0


