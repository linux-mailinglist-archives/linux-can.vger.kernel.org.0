Return-Path: <linux-can+bounces-1030-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601A93EEC3
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8225B22441
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 07:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010E813AD2F;
	Mon, 29 Jul 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zuyB+ay1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE523136E21
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238926; cv=none; b=QGEWPaKE9uYNnlwSdjRtjKSF8lcGKYDjdY+uNQ3lLH/4FeDvirQiLO8wQ/buy+9UiGs3I+07xn8YnJ9/QoKjk8HeuQPZGwJv9unDyP0+TfQybaql0D4rcfugnKvqCzuo+XfqgMw+h4qqKxWkw4AYpfnNz9nL0SeROhXPQ58psss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238926; c=relaxed/simple;
	bh=OoIQayK0GGA9cK/vSVlMPO84bmsDhlZIY0+9n9eet2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1Gbpe6X7s6BfKJxsTPCpr1VuIpnvmWyww2vPTmbzXdfTLjVYToeDjIHNnwy/sYhjDOEMjkqAad4NLusou/MdadHSF6FUwf258vD2mPqWSh3Pn8CZp3Nybk3is36mlcP6PNBsNBWwGJU0g6FckL6cxWZPHtTfEp8fGqYe1lFT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zuyB+ay1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428141be2ddso13678315e9.2
        for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722238923; x=1722843723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikCMpwAbPw7mQsN8sJFhcp+yiR3UIpfqm9/aaxfL+zg=;
        b=zuyB+ay1M2xscVKUuxSm0gOpctF3InI9wfBeXmVXDZecZSgjg7rGe+XfJf+T161h3L
         Rwv7vJVICSLWbSVNE0V1dMuCMolYLJyG7Y8LYWJCOq0Wt6H5lwPMSv3wfLQZVMithe0w
         QbwrHGnhXCmN/mxwpx7CUS+EvyhGn2WRc2vgus3zpR4bHfdZG/XyGjjw9hm69SI95VeD
         fCArbtn0vIwi1Ga1i47wfOR3eJ98uRuVryr9aJw6JWoEWKpM4JOPMm2XHcAUfgNtblpQ
         MGiHjVvCw2QFCBGlGmsbJ5lF6dGp6DHgkuDa5GDHnKcY+IWWMJIH1gDRiL9aIbtQjuPS
         L4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238923; x=1722843723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikCMpwAbPw7mQsN8sJFhcp+yiR3UIpfqm9/aaxfL+zg=;
        b=w/mvCMOi+E/zPiH4zvJiG18Co6V8KlJkhWbvjTA5H2X9gNTX7N4Az/iGhr2VuBWs4s
         ZNyTRAtzx/Ud/a5np3j49/5YgJxBEUy00oFUHv9u4xoxdy4gKzZnTV2xUrBtdCjrLHuc
         RonGSQVVsRAgEdvot4z24eAcfML+Sdw0A+knwNvlnQgPt1e2JJk1r1Yb2+hcyM+oQHFn
         LN8KzHki2+axYqDhM01T8C3+/Km3UXF+Zn3ZC3BFcgGV9XtiEuI0pybkIFsfoFi5NaYq
         J0B/z1ztL9DfGbiUZ3ytaKRrdDDw7mHXeK1pw2fQwXxqGSaEYhZW/537tHY0xlvDPSyp
         6fYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/LyMOSERZpTfe7G0WhsBB2OdmApz9fKuu8NFgVnc/Jy7YFmMwvHBNl98CRsQlGd2OBlJw3fVkOMQ71Jl6CkG2YHSTjD+vFlf4
X-Gm-Message-State: AOJu0YyJNH1yk4HCRSiVtsGRQWpERie8qc5FEGFk6wWIb8FC4i2B0bqB
	tSNQYgN6cQO/LuxUgkHXJuLH8y+zMtxfYRL5TI6ETGutoSkMr6EH3OnuC+rqk7o=
X-Google-Smtp-Source: AGHT+IEN5l0VmZxAx8ThMQxyOgQM8hkfK54kUHCfRNpsKszh+kxzwa4ljts9ev+T1yyFnMhTX3O0rA==
X-Received: by 2002:a05:600c:444d:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-42811d71018mr42435605e9.4.1722238923363;
        Mon, 29 Jul 2024 00:42:03 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm11460879f8f.109.2024.07.29.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:42:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/7] arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as wakeup-source
Date: Mon, 29 Jul 2024 09:41:33 +0200
Message-ID: <20240729074135.3850634-6-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729074135.3850634-1-msp@baylibre.com>
References: <20240729074135.3850634-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index e66d486ef1f2..56a40b641667 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -159,6 +159,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -171,6 +172,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 };
-- 
2.45.2


