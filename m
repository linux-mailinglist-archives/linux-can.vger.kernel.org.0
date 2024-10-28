Return-Path: <linux-can+bounces-1815-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F39B3807
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 18:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A25B1F227E0
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8C1F4283;
	Mon, 28 Oct 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iMV3DoKR"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3D1E133E
	for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137234; cv=none; b=SiC9Tu2ehEGxWkfzGrpeaAK+i69Iwy0NI7ZT+oxzTaDtS9zNpkCSOrU9xE+w9aNDl9Mlwke2R8UvRUiL5Bvug7mxlVFUGy7vrjjVhrg2gssyrUr5qZtUgtsY1nIf0xD08VHcl4/JcdvqbYzEtiZBT9clAhetD3uWRS/AiBpAxMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137234; c=relaxed/simple;
	bh=Mzxbq0cogQNrwowj1zfIE0DVBGY5w4Uyxw7H3xobrQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngkGvTUJY+wAH4hWgDsQ1r95dVqg1rT69tVFvQgYCXx8RPl0Dd4qGVjK8kYHWtEtXS5+yJopgLnzbdN76b41+MGNkknU/SbQ6Z/rUTva7oVPvfaiQgdYGHsmW/Ynd8CqEyFS21vX6JEwP1E0crEM3OQ7GJn2TLTmKVuDDGW/2Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iMV3DoKR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so3445669f8f.3
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 10:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137231; x=1730742031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0ITVZ/ruKG/TLGpfGAwzLMygWSysjucbld18q4vTYY=;
        b=iMV3DoKRRpNIDMkkiEPWeH3jb/6MZNHLIgdXXdlzGCch6dojvGlvgGl4FQ25DaTccN
         ErzNPrxgA1s6jhvc4YL0FdX/Npy/ww0uZLTgZSLkYd7h2MqT+u10oIjZYOHt7A/Acsox
         p40gyd07Oj/T7MGuEf634+hqbJdXF4f+1Py1yL4bGvytQWRWVrXJlqusYDL59+BvKiiD
         E5jEDSHh02oQgPrssuqwerJb//SLcyoviABZN81ZaQJTQh+uf4DS47B6mTuNDxerrAIb
         m24EqqpZ3OCE/nuPbAka5/iaDdxoCBRjL4ndvgXhycMKwkjvTJw1VhAxvvU6QzJAoZpV
         ir6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137231; x=1730742031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0ITVZ/ruKG/TLGpfGAwzLMygWSysjucbld18q4vTYY=;
        b=QcrB2y0Qykn7ezhrANwsHMs6bLpFcVmT6U36iAFEeqk336Omk/Tdht9LUTEYvpFfJ3
         vIyuo7v2LwAJSy0ZwOrkMeO/UBGJAHNpokK2EDXbcsSVBH2bO+DICcx56aC5G4G7IymU
         iNMGaf15SzqbdpLWzwtpN6tho3CTqHcdjs6a6s/9nyaGcQ4LBnWdhI3GBipk8QYP0RPq
         QadTV1MZsoBx7gwOr62sSy5x3yORBnSGv6tWAUdrEaNx82KYxO6aX8gwSlGNM9KT/Om1
         rzt9rBp8P3PGXZEBjaQOAxZq9mRii6pouT9KoyzsjJ7S0fUnjcugNYi+t6GY1mq86c+N
         UDbQ==
X-Gm-Message-State: AOJu0Yzjl3oh5HJzRl0GLo/Nnd3lme/rSooBwgTPypL/VDKp6hz21YQz
	R6AyQx3stZVLdNQj4KgWQv0rPtsok8DjaKCBTthJdt+X4nCqnWAHCekfa4LtW90=
X-Google-Smtp-Source: AGHT+IFLz+kMolvcZZxnHsJqfE4G0Nz/GW/Zkf9/d2T203wI1tYzTYM+qzVyQH5oPcQLAmMdMoEp/g==
X-Received: by 2002:a05:6000:dcc:b0:37c:cd71:2b96 with SMTP id ffacd0b85a97d-380612008f1mr6773135f8f.36.1730137230728;
        Mon, 28 Oct 2024 10:40:30 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b928cesm10176299f8f.102.2024.10.28.10.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:30 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 28 Oct 2024 18:38:15 +0100
Subject: [PATCH v5 9/9] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-9-33edc0aba629@baylibre.com>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
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
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Tq/fbr0WhZHR5UVyg7x0DcqyPJVYjETLUN6TQAqpB5E=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlz1QyzdQW6Wafxrhl8zL7h8zPPz36vakyx5n/FdNag
 zg23n+SHaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBEZvAwMpz8YVn959dP51+C
 HlPT9itpm33meOze4jNJ5GlLaqamVgPDb7a0zuifaQx+cmx6H6u+cz6a+NKj7M6J5R/Yog3PWBc
 85AMA
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


