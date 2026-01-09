Return-Path: <linux-can+bounces-6074-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADCFD0A4B2
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 14:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53F21331AF63
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886A35BDC2;
	Fri,  9 Jan 2026 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy5smHXd"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2733C53B
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963102; cv=none; b=WmxedySum+vK89oNFp4j0qOOrk9S15DnyMTDtBQPhd/hjlwM/6ZhRklx5RwtosWpu55JJDZN69Or4i3p3hwhp840sHdebzQq+OqnPjCvj/OLxF5oeWBaa3DxiekJjFvMzQhlkcWLhhC9/hDnoICp8M4TGHa+r1YwJPp2RsZYTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963102; c=relaxed/simple;
	bh=6M0A2GbnpU7y1dZDgyoxESjVTAqEkUK/7gRrJoml4mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUvkWSK7ozP8MXx/hOTDwRxX9sDrH2YmRmPlk1CZ+tCkOvIyUBv6ahL596UWQ8x+9IuRSgEVMS/b2rzfREMrQCelb2AJMcCJ+kl0P3RBpCdA1BdFcPPCUfZbeOXay1VUo0sDP9BflfuSQ09nE+moJp+Ho/m0GmsisYeNcingoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy5smHXd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2c96215so1322794f8f.3
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963096; x=1768567896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E07/5Alv/k1fLxScoFHyRvASnZW+sn/ztNoch2rUZ4=;
        b=Cy5smHXd3mRwL+Lbq/Kn787Ck+37Gg3EylC4RLErp7GCR49NOPl1DEBsF7yOAc0Uhh
         slko3xsYAQBj0TMFsLVeLlgBai/vyFEPRvE6AJ6343wXyX1p9iJGf8QTjcULt9IuSB3D
         a5RIF9Jcn4IAQ+lLvsHZltxleWT24R1dQfkFIu9tq1BOLLPMyLq71Or9NL3yrBb8jrSo
         nW9oLxi/2hTOxwu/NVHDt48qzt3SI9I2VPUhFpDJ+0G5UiAgtYljOtGeKCTgOTK0zFX1
         96rhv5XJv7j6/aZVdBfbpV8P2j1hll4r9+U15Z3D3QXvcs5F1IqyuD9pY5V4i0zBS7A2
         4/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963096; x=1768567896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6E07/5Alv/k1fLxScoFHyRvASnZW+sn/ztNoch2rUZ4=;
        b=VkFTHHZ2wuu4+4Xq2o3rsot4ZlOZyuUFUBOd2kLMcAZCHSj3E82KF9hh6ESAKghpF8
         5wgB8hilUJIPwF8IZhZO20OIU4mhko7WQkLcEvZbzZPIAfZ43i+6c1YdYrce3OLvDr98
         WjfI32OFbAlOYea5OPM6iEXw8RC0UiGJ+/9nuEepoNK6nDI36ivw5DqjM7ONeTMoteiH
         6+NP8D6j5cRZtS0+FVdne3SgHT3HScM1u++ILDbILGbd4wck+F/GW7DOmCiYhlIbYNoF
         n4NweB5vbNGuFSH2bgi7DO5bkO+F9lzIKEgJ8CObvWwV12UaU5xPegNgWQwusMkyIyrY
         0AAw==
X-Forwarded-Encrypted: i=1; AJvYcCWPFuLlRfWDcWfuLXGxKreAN9PNTi9oVINmv3EniJOaphscM5yej2pK73Kth//nqWJ/sD6butAD1ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2aLfamicay+ILW39/nYwqoSCUR9RGDNHmkGSMVPn6ebMnAW4w
	poDrVj2UZ3VqNHEHNBpTJByx8T/qPG/pCMSejysjSMe0UUZ27oKd+MSG
X-Gm-Gg: AY/fxX5FG4LDHQYX5QDaXEsMdJO+R+P+QZgPdE9OxR2xPL+O/msxy6pHq4MHHnHDfiJ
	g+ZsBZBDF9Py+9TcxEjXVaE+AdVZnJIOOy0ewdKVqlxJVEeIjd4lpgUNI1swdwcZFM1lDQYbRhv
	zFfdPf/+1sal8EdmIJpHIoYa2TgUZ7bQQoFM25jDkrzmthpRnC+LA1l7Sm/eoK6EEkFLbFXNO9j
	KouKUdBDPb2p6dVTOZiEUspclPZ018fdXbfS1cx7NFnXX864tCw971Rq9gtnhLskyericKw04cy
	pDMDj8C//YNj9oiOZ3lblCIXTYoCg1b+RY1ORb9IkXUR2V1xM/J1VupfgA2R8FMc3ARyms/jEAN
	MWjcPZVYe21w6bYEG9ygciRp0xvFBsLkjIrz0r962Ob/d7HBsKUnY2gtaVxacY31UwyeRNDfApy
	MhU+vh9uOD+DXK9jAjtU6ppZhr56qcWwfEtJzmmA19/5x41qcCSGJK8MvUSGchh/v6agD7+6fNV
	a27A7A6pcKF2K3a9Zcb6lY=
X-Google-Smtp-Source: AGHT+IEkaec2DJAcmcdYTZ4WeNL57VYygEyhOsHh/vgBLr/DEwtH+/DmtVbd8y2X4N6EhLQKFf0ZvA==
X-Received: by 2002:a05:6000:40dd:b0:431:2ff:1289 with SMTP id ffacd0b85a97d-432c3790856mr11413484f8f.16.1767963095431;
        Fri, 09 Jan 2026 04:51:35 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm22837291f8f.8.2026.01.09.04.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:51:34 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 4/4] can: rcar_canfd: Add RZ/T2H support
Date: Fri,  9 Jan 2026 12:51:28 +0000
Message-ID: <20260109125128.2474156-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
- Added Reviewed-by tag.

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


