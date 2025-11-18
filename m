Return-Path: <linux-can+bounces-5497-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D01C69F09
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B16D7349284
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE5D358D23;
	Tue, 18 Nov 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgQg4aI5"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C035A93E
	for <linux-can@vger.kernel.org>; Tue, 18 Nov 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475527; cv=none; b=Fr9l3g4VLgxk9vjWm17hg1XAYhmGoS8ViUMme9zNCO9qmGJ+1tJdt+aENvZLbSlozGaaPQgpXeEbCC7SrWFUdbkVF6pzSBOlBC05qvMYSd9WTt5ZW8cEVVPs+fV1Tm6e1TmAY5ycdCQDAVtHPWmUH38LX9a7ldO38iIk0Owr+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475527; c=relaxed/simple;
	bh=ESfc4lmM000hxPs1T7wREEyL2wiaetDc5kCNenT/MyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lk920wMGCIqIMu207DzbthK75yObY2LppFwZchxTbMzL+TIb4ORsGtGiVK6zjXcDlllaTLXW71y1wRTj9kOsxwVbQcK/8AIDUTOC5uWYOqHOEmVWSxRhjTtH1+LRdpHLNVU0kF9wrx8yF4/5DpPKoq2WeQH7Mr8TnspcA1UsA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgQg4aI5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a1c28778so29299615e9.3
        for <linux-can@vger.kernel.org>; Tue, 18 Nov 2025 06:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475524; x=1764080324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfleWXWYkA8T4DWwWwdz6Bog4GFKZ6GX//vQe/Y0chg=;
        b=bgQg4aI5OfozFztAZX/mdclTGyt0DuWl8nObExxBrQyGnl5EpvOYjEzBaUXi6qbxd6
         GD6yoTiJ5QKLSgaV+2WrcAm1Z+bboB2hu+VZCXV5MGqTkIsJCCyJH9LcRLCZNV4a+JqH
         A8qLMBzB/bVqcTwTtylEY8cjzIOmbHj3xTRHOiFm3GV5J57lI55abydTL5L3QeVmCBY+
         JSd/hf60B4D+vR09pC5l4pX9vgI+nmVYyx2We/rLDwr2y117Otiq6Ghbz7mU/27j//dK
         xvMKvB4mOuTT7g3pyQGtsodYTXjOB250a3kyHEsXgAd5si8iT0IkJook/tPM3dfPDUzh
         WKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475524; x=1764080324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfleWXWYkA8T4DWwWwdz6Bog4GFKZ6GX//vQe/Y0chg=;
        b=OvNSa5tDAeEq6qhfrSVIAimqwfhU/hPgHlNl1BHOsbAxa81fKIxyi6+DHYOUadKRPv
         0hmrDZVyqSmIMhx0kuhtdE46HaCDAeSHQKiqLNGatQT0eRD2w1F/R1jxIRR7WbcXsEFG
         FM9paP277RGScAF/QO7IQwfQr/UfJBNemK3G5dQOi2NBW49oW9gi3ZXTQSYc+F9lWGuF
         ESGhxWz77tA+aDTtnWkZOtjnz+qM+QcQgZebivM6hIeLzsQRbswAVMtOAtjDRfeBsK5u
         ePWkaHGrauX9gY3VPwIquvQ6icurOEDg6VIOB6OA6K0A0uOvzYOAmnopkQkTspa55wrS
         NNAg==
X-Forwarded-Encrypted: i=1; AJvYcCU2+hAv+puxV965GLNf6lqd52dBfUfjXzrrCYmlBKxdU8EhqQQUD79yirt/tKj4p26j8SRMUbcLI64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHXyl7qOUOmaPcm6wQ0PionLbeK2PIc8gE8dHESpAmXBKNZTY
	7PKfWWY3lZOi36rFOvkltnRkkNYUxj8UAPAuEddCH9HmCU24mMlmLJwU
X-Gm-Gg: ASbGncu6bJzLVqbsem1Y+9wLHus5amuR806g23vdVLxLRio9zZxuzM1IZkv6oXJoIMJ
	zarc1a7qEiw1YHamSHhB7mM92pBTT86EY2I7W2MzJ+sL6addUzh7V+UHTicNc3XK4NSUntLJU3w
	FdKI4ga4OOhr0a2rJ75wL9Vn1a0rowdDbmh/+Ip3sZKEIssrhnRL1YRRPmxS4UgwuTmNPwiSU/y
	1VyHp4sRtu2CMH/v1mkVA59S53YfmB9Mq03t6p/NN5Y6oq92zYRxjn8UxeY3gVx2u0QJaiKpLYj
	9yAfUUXFJm+EU6jJTuoZudN0ZPcY2bniadEhHQXNIhhAoROpC3YEHn9gBNvKPGMoReTp1ABRU/C
	IQYKw9b0uO52volFV38NrEr3kgrKynQ+GSeU+J3RUG/8utdmHlYgKUCGS/10PYoc0G2h2OiXhky
	mW1l8WD8sYfZlmmlOS3+OdD753KM9sajtdpCQ3BawGxEls/n3yLCIiBMuX1itsIryRIcVs/LmyY
	Xhslm5Abb8tZ+XPek489H46elk=
X-Google-Smtp-Source: AGHT+IEVpdrkfltLXxpXdL5RjYloCGLiPPHypnBbgZXTFPIEhV0ywA8ESZijWzqcCG7zPCazVyKhCg==
X-Received: by 2002:a05:600c:45d5:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-4778fe59054mr159011895e9.14.1763475523879;
        Tue, 18 Nov 2025 06:18:43 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm32487590f8f.18.2025.11.18.06.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:18:43 -0800 (PST)
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
Subject: [PATCH 2/2] can: rcar_canfd: Add support for FD-Only mode
Date: Tue, 18 Nov 2025 14:18:35 +0000
Message-ID: <20251118141840.267652-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118141840.267652-1-biju.das.jz@bp.renesas.com>
References: <20251118141840.267652-1-biju.das.jz@bp.renesas.com>
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
 drivers/net/can/rcar/rcar_canfd.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 05dbdf46dd6f..6dc6bb1efceb 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -444,6 +444,7 @@ struct rcar_canfd_hw_info {
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
+	unsigned has_fd_only_mode:1;	/* Has FD-Only mode */
 };
 
 /* Channel priv data */
@@ -471,6 +472,7 @@ struct rcar_canfd_global {
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
+	bool fd_only_mode;		/* FD-Only mode for CAN-FD */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
 	const struct rcar_canfd_hw_info *info;
@@ -615,6 +617,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.has_fd_only_mode = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -632,6 +635,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.has_fd_only_mode = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -649,6 +653,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.has_fd_only_mode = 1,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -666,6 +671,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 0,
+	.has_fd_only_mode = 1,
 };
 
 /* Helper functions */
@@ -828,12 +834,20 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
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
 
@@ -2041,6 +2055,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->fdmode = fdmode;
 	gpriv->info = info;
 
+	if (of_property_read_bool(dev->of_node, "renesas,fd-only")) {
+		if (!info->has_fd_only_mode)
+			return dev_err_probe(dev, EOPNOTSUPP,
+					     "fd-only mode not supported\n");
+
+		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */
+	}
+
 	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
 	if (IS_ERR(gpriv->rstc1))
 		return dev_err_probe(dev, PTR_ERR(gpriv->rstc1),
@@ -2190,7 +2212,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
 		 gpriv->extclk ? "ext" : "canfd",
-		 gpriv->fdmode ? "fd" : "classical");
+		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
 	return 0;
 
 fail_channel:
-- 
2.43.0


