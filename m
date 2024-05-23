Return-Path: <linux-can+bounces-679-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88CB8CCD7A
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 09:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD921F21E7D
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2024 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36751442F7;
	Thu, 23 May 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JtIopPW8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06913D621
	for <linux-can@vger.kernel.org>; Thu, 23 May 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450876; cv=none; b=C7HN/b67gfanr/zwV0AqOjtD9iQJMPPbRuoUcVR4HPNECydKGStCRq9Cqg344wz/CMTddAHSnMxbt6/pfrHRcfEd3J9ue6wlbv2I7NxqPfvCZ8TGn/UWexQxDyzzWJ8RCmtxWqTnO1Ans1KDHwKlzewYvgJ2EpHxou1xjQDlWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450876; c=relaxed/simple;
	bh=gzJFhUg0cO/7XPm7qt/P1liTC0JjrYR2UXojMcIxR7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E63ZlGSjksDGDZqp9z752r0brTNFAoXHjMaiJt+9HrOnuNasCYix9+7NwcRn42spOgZmiYcfykBy6GVzSvY9rcENEOwn4dZLYT0zQ1/ph6z6hRNFgfJKzAVmNJw4EhH1dG/qTRj5UhFZf++/ORJn9whM05kqfWGl2YQdyErfydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JtIopPW8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-351d309bbcfso1133365f8f.3
        for <linux-can@vger.kernel.org>; Thu, 23 May 2024 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716450872; x=1717055672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT7+JtKss4DjYZVOz3FuZCZuNxMX3BDv4ta8RztPqv0=;
        b=JtIopPW8Iy/s2TFGTEd0kOj3c6KRjSV9pN7Vw7cuTi4s5XzG+z7r/+RMBN/waQAv/4
         Jpx8J5o/6n29GYe/PAVW4PiLhcSpRFO9ACJXOmyVIcKEczmXYOlUW6Q+q922QnDrQJIl
         Ufl1rRrw9aF84vS5GE/gOTWz0qZgpNB8OBGBoJIhpILxANcJ735kx70cw5Hhr6YdgDQp
         Fl0mTLDZ5iEZ5pwlEp+hsyuOF1ryojLH+iOBKJPsktrNbXWEbE6qYzLEOCVoVRHQCmuM
         LQta7ht/O+oe5WkzyqdZEe/JzqdQshZj9jWBHoJArhfkeL4QpN3kzHEKq321jhOxWVWk
         XdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716450872; x=1717055672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xT7+JtKss4DjYZVOz3FuZCZuNxMX3BDv4ta8RztPqv0=;
        b=DEJ2Q38Wc4cpr3DesXq6fYBcpWxsU2pIF9BxQO+iRwi98z+aiSU7pISlTvmdQAr2Se
         4k87k+y9TwuAO5U/bkH2t9zPlSPRGek83qh3citH76vB6QBOvolYTKFuIW+EakzQOOzh
         z64v/TX3xXPz3OewHwhtXfUqDAmBGN3+Tf2lzT4cziW/8QsBZK0dmlcv0nD1d1Ytsi6E
         PncFBPPhEodBJ+cXcP7c2X2hOnUJ/O3IrLSb4WsqJq5jE4sojAnyEVOAaCLhvHovidzA
         FBVnHMbfAQ4owD2VZZwyMN4dnixJSLwEozAvEA7bX41Y1V5P3u3qIz3NJkfJVbko9t7I
         OdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUbOjPGxvmtef09kMabxlaqWH/vab79ici1WjMHu0bZqLo65/Wz8KycD1iCifzauUEDHb89RKV49gHCaeMy2u0ugHACCBzNNvD
X-Gm-Message-State: AOJu0YwrqigZOdRBjxoBZxi7mOk1BUxDjXVYQ3qblEKLDj8zj7LOha0Q
	RvPEbS+xGxKSQ4guofrt4K/spEmvYuJBFNrmKvq0dFi+LuMVzHq11SOlU+nHrU8=
X-Google-Smtp-Source: AGHT+IEUHrJ0KdpXh+C+VgytBP/PyrYIZr7cy2feoJNZUjfuK0W25diSS+LmHL7ZAdPTYxlWEqO+sA==
X-Received: by 2002:a05:6000:196a:b0:34d:b42d:b666 with SMTP id ffacd0b85a97d-354d8d98cfamr3368702f8f.56.1716450872391;
        Thu, 23 May 2024 00:54:32 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad074sm36501833f8f.70.2024.05.23.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:54:31 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 7/7] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as wakeup-source
Date: Thu, 23 May 2024 09:53:47 +0200
Message-ID: <20240523075347.1282395-8-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075347.1282395-1-msp@baylibre.com>
References: <20240523075347.1282395-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vibhore Vardhan <vibhore@ti.com>

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree. Based on the patch for AM62a.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
index b973b550eb9d..e434b258e90c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
@@ -162,6 +162,7 @@ mcu_mcan0: can@4e08000 {
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -177,6 +178,7 @@ mcu_mcan1: can@4e18000 {
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
+		wakeup-source;
 		status = "disabled";
 	};
 
-- 
2.43.0


