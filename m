Return-Path: <linux-can+bounces-1629-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F199A4D7
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 15:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB37B24678
	for <lists+linux-can@lfdr.de>; Fri, 11 Oct 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2921D187;
	Fri, 11 Oct 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gwBzVQGZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B6218D79
	for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728652693; cv=none; b=azbh/HfshuryKyBLgRVW3RJZUdIxddzYdDKK0FtRgzMq2R0YzqNGNaR8jKGtdWxgeJlrWfTWAj+KAcpGoEKT6IJT21ClLiOntSh1c5PYAAyGQH+1s4JYTm8uGNWZPIo8yEW2sMz7+PjDgaKp9xyQ14phmofPKNn/g1HMX7lfKgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728652693; c=relaxed/simple;
	bh=Mzxbq0cogQNrwowj1zfIE0DVBGY5w4Uyxw7H3xobrQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fa1niuNBFfQ4qjHLD1aPdDM3hV+R896h2PTTGQahvpAm+7+Uo1S2Qxd3sucj1zdpnoIXceb7a4OSPQvk8uKc895z3Pq07/UisjpXhoGdpqgtKiPI64RZGZv/8yJ2BZ4DxXjRU/AqgGxWkcHSGEoLW/KVRJwApsiNcDZ3kdlfyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gwBzVQGZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9952ea05c5so317180166b.2
        for <linux-can@vger.kernel.org>; Fri, 11 Oct 2024 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728652690; x=1729257490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0ITVZ/ruKG/TLGpfGAwzLMygWSysjucbld18q4vTYY=;
        b=gwBzVQGZndUEnk7nqpMztkFRdJVhK1lS/IHjAzZZMCsoH3MudspQbAP8a3WGI3KwrC
         PUB4BFvgN4Q6NCRexlhEhTG9bKGR9044A2JJ342iElzdf9vcBC1M0vdYcpg+F/MOfzMo
         GpcDQeuDfiyHulOmFomxL8rm7LHuSFNWGiZkLHIrJsqI6LHtGNXIUWqcyjyi1aHZStqS
         7Zq4skNrcIpD4FahHfeczTPQ4Mz9wtOHWZjqgxD2OmXAVUN3+NznO77PONnA0G6nvYMF
         SKy2TmCmfBN5SZnLShyse/CfGatSl4C5JdWcGC6CNRj9jMLXPBLAk5HM/wRW0W855Aw6
         8oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728652690; x=1729257490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0ITVZ/ruKG/TLGpfGAwzLMygWSysjucbld18q4vTYY=;
        b=RDEPUF91/VgNbrb4iM6qWWm7gcNuDagVxuphFu1FfkOaXmaMV9yignspTOoh5pkaXv
         QFKmOG1fKeYYU3Dqz+MR4KAftpHLSr0EIzQ/KO38jlQ7QNawr6JUifUg1GafitYPKomU
         /aM6UmkIV1uXpItInfReVdZIAeMojCXLHlTvt/PHvPXuwJKF6tAysj2kLsXCALZqRZ92
         juisOr7/cynK48ppG8zIyIBvq/5nS9Rkc1YuiOV+1IQLxs42WMV9FJhigFaAF/FML3ft
         NAOAWzZipBh2mIWDH7YbmJ3q8LYeqeGf8YYM/twrCTJnu+nXOnLo2CjYcIJ5yXLVkkZ7
         9YgQ==
X-Gm-Message-State: AOJu0Yw6+y0rb/clpYrhOCkxg4cZIRwMcj1c0sWWg6UW57NfHUSopvB2
	BzevLszNoh4+Z7MRyT9XREBxa00wWF+iYe696MDK/Ds6tO6//U+IMmHPuVct1lo=
X-Google-Smtp-Source: AGHT+IG0Ub6gDX3IQh/3prA7jVWpquOOtRd9X2EDWha7QdWuTYm6Hzp02feEX0uQQCEAWTcDfR1ccw==
X-Received: by 2002:a17:907:7290:b0:a8a:78bb:1e2 with SMTP id a640c23a62f3a-a99b9415479mr218657166b.6.1728652690098;
        Fri, 11 Oct 2024 06:18:10 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec4cd0sm211838966b.1.2024.10.11.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:18:09 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 11 Oct 2024 15:16:46 +0200
Subject: [PATCH v3 9/9] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-topic-mcan-wakeup-source-v6-12-v3-9-9752c714ad12@baylibre.com>
References: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
In-Reply-To: <20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Tq/fbr0WhZHR5UVyg7x0DcqyPJVYjETLUN6TQAqpB5E=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNI5VesfX6o74PpSpyl1L/cP79iFPs5N6R87zlVHrVbf3
 ODYWdTcUcrCIMbBICumyHL3w8J3dXLXF0Sse+QIM4eVCWQIAxenAEzkqBTDH267DWZMkSz81mtV
 Hp0T6/9llxKY+8oi5irHtw9iRw4GxzL803umPvUb95Zdl44X/oiIijizXULx9rOMx4zSbI+9ZYK
 rmAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

From: Vibhore Vardhan <vibhore@ti.com>

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree. Based on the patch for AM62a.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
index b33aff0d65c9def755f8dda9eb9feda7bc74e5c8..3afa17e6592f39387a667547835c90f95a9af351 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
@@ -173,6 +173,7 @@ mcu_mcan0: can@4e08000 {
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -188,6 +189,7 @@ mcu_mcan1: can@4e18000 {
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 

-- 
2.45.2


