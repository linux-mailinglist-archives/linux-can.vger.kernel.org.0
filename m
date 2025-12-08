Return-Path: <linux-can+bounces-5828-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076ADCADA9B
	for <lists+linux-can@lfdr.de>; Mon, 08 Dec 2025 16:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A162304ED96
	for <lists+linux-can@lfdr.de>; Mon,  8 Dec 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4902E6CAA;
	Mon,  8 Dec 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJXQMGs7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB32DF138
	for <linux-can@vger.kernel.org>; Mon,  8 Dec 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209033; cv=none; b=ehId9UgzYHC8mJMRMRgyr8xKjrddc9k1tesLbM3wjc+CrEGdh7bYIdnMPN5WnE/VB28GC7UAwFvVdrSuhFdFBNjggyksMZ9ezUEIxieM2XLkkpF1bMcFwIJV2lpVJ1+xyyG1tBKwtiPC5Puy7OHLYPExWH9GqHGWxBqIXZ/fU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209033; c=relaxed/simple;
	bh=QNbDDwLuc9JZRRzDOGwD/xOPxUq6leUqNZZXLTjPJkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnZTibx2PDmzSK+S+SqpuibANEVgb02FnZq1FziAar1h11xmg+WugO2FSk+onFyJqulBvPfbjw9ITBB7oTWw0LHfHSNO+K4gKCjMROEMx1xmT0+LWpV06q3Lq/ONhM88Ck88p98KhX39Ajug9e/Orscu1nQFg2Q+LV15mZhA/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJXQMGs7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so43258955e9.2
        for <linux-can@vger.kernel.org>; Mon, 08 Dec 2025 07:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765209030; x=1765813830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x527E6uKOf42KbGTdBLjmQLImi6xcMvFsFTQ4sivsqc=;
        b=mJXQMGs7tt2CdKN/orxz2WBDBnSWbGAV0K5dc4heT05uPO3WodQf0IMXK9RZmcxjOO
         lf1jTBf2ajyOtv5d9c5Zdlkts2eeVon7+cGwQCljb6pnZI/NIMicXWmbvfQHjZLBDVX3
         B7oQgulvGYVcG9VYL3V+7zpVYgmiRCLnVW4wl3Mj3g5ycngJ1z5zB7Kf1mbC2yN1nIP0
         CL959boXi2eY7MPBNd5MQCFxwNel2O/F5yDXj3PDKB9dDARgrPAZ1QqpRMa5wGI3MrcM
         YjOTLEi/EXqpuc7rsH6cw/z+SIH/gsPsSDFCb36EbDOQQYf4nAxq4sVIEYL2K6rkn3lw
         5bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765209030; x=1765813830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x527E6uKOf42KbGTdBLjmQLImi6xcMvFsFTQ4sivsqc=;
        b=GJgTt5F1GGh60kndERwfQ2vo2fTf2T9B7/o2mfls91xSyDutF6jiTvTni+Cpxz3kGr
         2YAlcfPwK9GAWGUE+vZ3IALwc7tHfc0L0IGUbXOuDCK/UL/xtfD/EbpFvIEUjzgTkQd8
         ntmZD+1fVxg38YfWu82Rs4JHa3qoVj6Dl3ljxtwwlJj6XBn3Xo2KOJ89dz0OphH6ZFvV
         d0gfTYUjr7PyJcH/2q3QOXh3/JlYUggbbpfuFvxCMpAHIzTOiYCl4DN2aF9Oz4OjP6CL
         /dWMHTNq+quLV7lvakxGawrXGu9HSLDBtHw28i5fU/5v/hPifGrnx8PtehCprcSs0LtS
         wg3g==
X-Gm-Message-State: AOJu0YyRJ0KHfi1zOrxpjjDadrTzpySk4Du4pqQpkJ7l5Pk+xzLjdKoF
	CASliHLVb9PXcUB1McohrslQJ9FghUO0wwhFj3o1iV+OA4YxCEEOlgGl
X-Gm-Gg: ASbGncvDf9SjpLor+a52QJwwXZDJCetQFAmme+3xIlZVLmj7Dq5S13cW5PLKT40akAA
	5WZQ+BR/+sZufwEjMph26VcmsgYZiodcejNed4IbqaUWFEm8c+blwLEUU18juN45y1708VaIXFI
	HAVzXNWvJJ+I/1MsgPBhzhCOsFSq7LIoy434WTvaryaUYEp+dZ+IdAy6hze1IQdEr4Bc6I15LmB
	7sl9tc4EAgYwG5m6PHZjK1z1+BYc767CwPAr/VE6m48bFBh/Bwzv/LURvFZtbp/zcM9BqRZvl7I
	CbUIXOkBicyviRibKSlstPQ+n2YRG3ShzkiWrk1UNLZcL8oZQ16tI+vmha3ZWR636ynHLgg/Ex7
	h5iJM39+81Xmx3ZZWshDSk6DMqbsLq10IY07JeAxVoQO1oN5pJCOT6j1HfWwBuF8qETGhy4D6p4
	dTdlqKPk9NrUBeLYVLQnIbv8mpb75zUVgoQ9tFFQG8mZdI
X-Google-Smtp-Source: AGHT+IELv3HyBqVX0oHKmVkUANGckslLO3vK36bXV7AlfWxHA8Rsm8SHLGtTzBdm1cf0bnBgruDknw==
X-Received: by 2002:a05:600c:4707:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-47939df28d8mr67860885e9.4.1765209029622;
        Mon, 08 Dec 2025 07:50:29 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9aa6:8a23:82c5:2b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b150878sm147717845e9.3.2025.12.08.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:50:28 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] phy: phy-can-transceiver: Add support for TI TCAN1046
Date: Mon,  8 Dec 2025 15:50:19 +0000
Message-ID: <20251208155019.136076-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251208155019.136076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251208155019.136076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for the TI TCAN1046 automotive CAN transceiver. The TCAN1046
provides dual CAN channels and exposes STB1/2 control pins similar to the
NXP TJA1048. Reuse the existing `tja1048_drvdata` configuration for
TCAN1046.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/phy/phy-can-transceiver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 330356706ad7..41026bc2410a 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -106,6 +106,10 @@ static const struct of_device_id can_transceiver_phy_ids[] = {
 		.compatible = "ti,tcan1043",
 		.data = &tcan1043_drvdata
 	},
+	{
+		.compatible = "ti,tcan1046",
+		.data = &tja1048_drvdata
+	},
 	{
 		.compatible = "nxp,tja1048",
 		.data = &tja1048_drvdata
-- 
2.52.0


