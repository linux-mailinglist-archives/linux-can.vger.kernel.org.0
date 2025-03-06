Return-Path: <linux-can+bounces-2997-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4FCA548FD
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AA11886B77
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774420E009;
	Thu,  6 Mar 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MG+c78OI"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89020D4EB
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259772; cv=none; b=NEfHrfbdrrlS3DitiFrnE7I+Yplr4igZBvtv5t+w5W1q1zpXsIyOu2bnxk1dRCfxDeqK+Lhuxf2VF3duhT+EtYM4fRf528yDv2YMgGgcA5M8ou+dgGUHbkYVfzp/MaUFz3ImNvRwKue4R6/s1UNe5rzhWiMjbHIEViSLeGAiVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259772; c=relaxed/simple;
	bh=d8JktRpsnXtExrDEQg8XETgLfj06OhFCRQiosuwspHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omCi0DvVJ1zfQLeZtKac2HEY8qdEMVxx9akJYbwTc77UUoXYpK1gIs4NIWeZJ421VM4FS7FYnYxC8J1IaMD5wUy5dNpkIIp74PHGUJ4M9RTs2j8gyArmYr2uqSg9p5gkGUI+8J73eHAYsXI80GPf+2eiCDxsdLB8WD7r9Wr7T/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MG+c78OI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso891199a12.1
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259769; x=1741864569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYtwui9Erh4I2K3zHdu+q0zTdYm3AFiykAHnPwI2sAM=;
        b=MG+c78OIvqGzFQzRgwF87ytvUBWB1c++4khhpuJ+67w8eqLwqWJirpTpiwJH+Hee9G
         bN+/+85WlTABJ0c/Ds+6m6WyMx0+XBnpb8EGkSrSsnajKl9wovaXw75WQ4n9exJAVbLc
         H3eh81Z63kSlmTB6NlSpENU0nplKWc4YZu9qaTbFA62xULp1N6xJrVftZRVso0ekmIAy
         ykOWYo/mNsu+rAmQY/PbBFHMghrMkdgKE1lim3eBkcn7MwFXaRK857v31Z6L/aEXrXpg
         bKMWrV63u45Lamp7Un1k8nTUlhRxROYb+bsP3e7JwfqkUL5+lFjgtHMl5BUHCg+6AUmY
         viLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259769; x=1741864569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYtwui9Erh4I2K3zHdu+q0zTdYm3AFiykAHnPwI2sAM=;
        b=dkxQSjTn3bDwZhAdthWE0aC0968m/dlmKnWU/F25rZBmGH1KDqLYWhrLwUh0mKYZxm
         UJFCicLC44/7b7n8tm579V9CZ4SXCJDWs0KAUe9K4yfz3hjTr6RiwU3ZXvj1lpdMdHHA
         AmPTykIZaFb+AvceGPNFlh255aVrvzTXkwuKIWELBox4XZ8ylyJla5yxKveKplP6hMzC
         Wa4A96sh5AW7j8lxg25+Niq5vEdjSBAtkuKwy04JMIJGbmaUwMS6NeSGrZztyYpEEicr
         F5jdWKFuLFswodWWu38dkB1goXTOjJD3RCx5y7fzbR88ILp6e5PWr7OgmHxiqfWiYf31
         sznw==
X-Forwarded-Encrypted: i=1; AJvYcCXnu8uGNSsz8s28cQvenondU6sDHTaK+6nkAFJ1cG4pCPyWDsS1I3jXkwL/3D0tiffJsawyZh+4DJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuAhKU+jT7TdeLqXQvH+YdJwim3VuySXkgS15k/+0qeBnAkFV
	fDfHOK2cM1PjYbFez7pjrIi5xHXbgP51zqYHjC2MHJI2Z9BkEZHVfIHE1XI7bF0=
X-Gm-Gg: ASbGncsYaddgqwEEKsbgBF9VgagIYTfcbgthHix0TpvEImDaXFHymW47yw27a6i+E0s
	8SIb8JIPvYO+7BrwVUalGKL3QHr5ipoYhsPe/pKdJLBLvvcoNQapI5b0rde7P/2WYAkJATE0Z/E
	OLvL0kzPPML1kBPqvg223gm/E+1eMoC2g5yjUqPXKjW8OSrUrPHAmCAIJQ5BKPOonvMxzxqPS8d
	GOi+r7R7hzOQyg/abUESlpZ/57bjL+RaEK7FEus40BEWjLHgzynNBx5YTe6KOTY6udV1a8sN+zv
	zOrFzHljPmu0w6kl51ulKDRfc+tB5PlOEKXvONG/OA==
X-Google-Smtp-Source: AGHT+IHLvSc6bXLemWdNMPjb7kOiDfMReioYbM1WlDggWAhYIkoRPKliPoiO8nRDtf8Q913t8YyBCA==
X-Received: by 2002:a05:6402:1e94:b0:5dc:7823:e7e4 with SMTP id 4fb4d7f45d1cf-5e59f3c6c25mr6989946a12.12.1741259768527;
        Thu, 06 Mar 2025 03:16:08 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e5c74a8f3bsm807671a12.44.2025.03.06.03.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:08 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:48 +0100
Subject: [PATCH v5 10/13] arm64: dts: ti: k3-am62p: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-10-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=msp@baylibre.com;
 h=from:subject:message-id; bh=d8JktRpsnXtExrDEQg8XETgLfj06OhFCRQiosuwspHg=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNl+Put9e/HPlKiWxlxzN29cIXz7lLa+W8/shT3pn5
 6Mn+fr3O0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJMH1k+O++VLSJ6dE2ltNu
 Zfm7Q3O447bICs7mazreEfUlz7LCiJGRYery4qOcrx5+iyvd1CasrftjFcfXA4v9kw/XPz/XdOG
 6NzMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on am62p SoCs.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11b068430362fe0b8d2d9ecc052588..64cd070f196fdd2999ddc7bfee3ac9a03f1366b4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -44,6 +44,33 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "Partial-IO";
+		};
+
+		system_io_ddr: system-io-ddr {
+			compatible = "system-idle-state";
+			idle-state-name = "IO+DDR";
+		};
+
+		system_deep_sleep: system-deep-sleep {
+			compatible = "system-idle-state";
+			idle-state-name = "DeepSleep";
+		};
+
+		system_mcu_only: system-mcu-only {
+			compatible = "system-idle-state";
+			idle-state-name = "MCU Only";
+		};
+
+		system_standby: system-standby {
+			compatible = "system-idle-state";
+			idle-state-name = "Standby";
+		};
+	};
+
 	cbass_main: bus@f0000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.47.2


