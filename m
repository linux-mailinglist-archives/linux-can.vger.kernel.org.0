Return-Path: <linux-can+bounces-4278-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8822B2FC42
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDB11BA009A
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA882E2F0E;
	Thu, 21 Aug 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkukShjw"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B208D2367CC;
	Thu, 21 Aug 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785675; cv=none; b=d2x8dR3/OIGOC2HbMvqmae7UTfv4XulSGgEovhd4jFE6KatQW5rVIOCaGCT3YpHMGRGIW593mn4XEpY2hJuHS/YlsMIO3kpUrcoq9HU09qGTvBwsv267uqucXZuVMwmYhsX2Cph3pcEEmz6EoIadidovkh63xvQr1AJ4ci1Td5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785675; c=relaxed/simple;
	bh=MlUVROSS8IxTyPkOmHB7VLMft9kWD6POL72nhreUhlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnG72+r8yP7NOGDkrf6h6Iv/sU18MyVwheenuGu+FgtgketuSnGPVa26EBOfZUcwCi5g3qNj/AkNTtIlqDNPYLGI5oqUUkTl0E1lM4E5o73plQ+tkI7a1v3VqvGsteHIFoBauoCYSpkwTHUjbUA7VdBLBQPOlXC9UottX1TNQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkukShjw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so6472135e9.1;
        Thu, 21 Aug 2025 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785672; x=1756390472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CDQXCRlF7DU93mM+EhQrbZzbs1hT88XCXBB628181I=;
        b=NkukShjwLLihkwsrw+CNsBm14FzMgINrGa8QrjWgs08+/0CdLQAwR0naXoob+7quxY
         x4rBO6+b4SMlNx8CxDX6j90OkcFPHnGCQOdIsP9NHDIX7QoUKAvOczChqUcg/6yGkQ9Z
         M6AVVnocEVrpURzM8/OabO0gA5usR0+u5Fg/kWWcMXOorSnCGvtio+gUmWN2TGITRDaF
         JbwsJbhpV0FzbBdpNp+Fu0vfH3gOVjZ7EilquW1TiETi0nlCXlNvWgqi0bqUDAmblzfl
         ePlwL13sOHmsFtxujk9R1E8QrGs0zEbLI4e3bchsBRnqvbrScsPICH4O44g1Pe6jMK/s
         137Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785672; x=1756390472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CDQXCRlF7DU93mM+EhQrbZzbs1hT88XCXBB628181I=;
        b=SmvqKbX/mjYRA7acUF16fxbb7ZjMV2FoJt6XSPAdfDhVKpmZICouCBQPrneQxTqGmk
         QyW9Ni4ogHEpQbN8Zs4/kf5SXLl3vGcXpD9DhOaLkRPTXUYcVQM1nXFqgQIYWTePPsj/
         1lQ03GEKYGKJ/0zKJqxeXakJ1Yln6wLQ3TCeezLV5ixxJaDzCVKaXHFJrRUZc3B6i9pE
         TVGU8XN3Iud3zzowo2GtXA02hORs9tdsvkPvSpc0AUo3X2mJS4qTbTuA27+vA30XHzys
         ONNRRtz0+dsFVMsMipmO2rEQphzBk5IbMx/8wbVlCr4UMyvCnh2Z85vs6NCnrQ3vv/sN
         7UNw==
X-Forwarded-Encrypted: i=1; AJvYcCUM9WN+1S+v2dKzLaA5kEsAiM+JT75bmJm/wuPSgerxz4FMKH7Q0TYql5YQqIO62qW+FZqGtizHeJJwyd33pgmhCiA=@vger.kernel.org, AJvYcCVNztfrCbLor+bzf1fc+wY0X1FEj00zz4aIBtdUhQDucKE012VtDRxyea/TOQNzODYEYtPaUi/qoUI=@vger.kernel.org, AJvYcCX0zcbtjefGKoznZpRGGB1hdkTFujSwExqpABB7TfL8PdtRM2K1pmeakmJBEp9tsYUIl4pYuixDv0YYFTX9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg3cbn7WpiiBSDtzFtEmFIPLh8favLGKN2Az/WrJ0p+gk1Nl5c
	vtuaosGzHXE9WZZLrPFj6qk24PZIYtXmqiAKN5krIh9aP7T8io56RPBi
X-Gm-Gg: ASbGncuwFvO86SCT9KKEWDWsAMnveS4f+/OYDy/PgZ37pvbQXMsbiO/HtoR8oOqFa5W
	2TBRO/rLAetK2PoHrm57Seo5Yp/htifbDWFeQM1Z74ozCgPdgdwz64LfUaUYPGg8UFK0TUNUhlJ
	2M6BzEX1dAU/dHmcqdUAidi0hCt2kUGfPDhnpE5Mm6fc2JEBktMBwcIbAyjH3/HzfDf4iIa5jNs
	eJRwlc5MI1VnABpwvzoPVHe0wLEeOMf/HQUBT/ZuFQ8D1fywmspEEowFilHeN3+O24q3ptzGh4T
	tSabEItWEzEeO9Jp4XYIEjscME/FaIqus4Nu8s7LyXriFDlkavNttAGqzgSwfhQJAUFDKJHNXyY
	1tbv3P54uguIMxmrKw6DMiwuYbXe59QJQOknZQKQm8hAiYdE1kCU4VwlxCMjjPoBCu+Pmis5Lsw
	==
X-Google-Smtp-Source: AGHT+IH0rCu80lOqLncd3uxGUpCxuAEkXVTRwGJVfPqOHeYX2FSeRRxYSHo/Zxj/KcMqSPS+F4+CTQ==
X-Received: by 2002:a05:600c:4e91:b0:459:d9d5:7f2b with SMTP id 5b1f17b1804b1-45b4d9f7b63mr28032445e9.16.1755785671639;
        Thu, 21 Aug 2025 07:14:31 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1be3csm33203505e9.1.2025.08.21.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:14:31 -0700 (PDT)
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
	Biju Das <biju.das.au@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v2 1/4] can: rcar_canfd: Add shared_bittiming variable to struct rcar_canfd_hw_info
Date: Thu, 21 Aug 2025 15:14:21 +0100
Message-ID: <20250821141429.298324-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The calculation formula for nominal bit rate of classical CAN is same as
that of nominal bit rate of CANFD on the RZ/G3E SoC compared to other SoCs.
Add shared_bittiming variable to struct rcar_canfd_hw_info to handle this
difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b3c8c592fb0e..ce355f79e6b6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -461,6 +461,7 @@ struct rcar_canfd_hw_info {
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
+	unsigned shared_bittiming:1;	/* Has shared nominal bittiming constants */
 };
 
 /* Channel priv data */
@@ -632,6 +633,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.shared_bittiming = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -649,6 +651,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.shared_bittiming = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -666,6 +669,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.shared_bittiming = 0,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -683,6 +687,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 0,
+	.shared_bittiming = 1,
 };
 
 /* Helper functions */
@@ -1912,7 +1917,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 		priv->can.fd.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
 	} else {
 		/* Controller starts in Classical CAN only mode */
-		priv->can.bittiming_const = &rcar_canfd_bittiming_const;
+		if (gpriv->info->shared_bittiming)
+			priv->can.bittiming_const = gpriv->info->nom_bittiming;
+		else
+			priv->can.bittiming_const = &rcar_canfd_bittiming_const;
 		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
 	}
 
-- 
2.43.0


