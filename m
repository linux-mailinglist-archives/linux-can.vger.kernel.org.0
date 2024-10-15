Return-Path: <linux-can+bounces-1703-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B699F70E
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 21:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97F01C23874
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA121FE101;
	Tue, 15 Oct 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KO6S99S9"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1761FBF61
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019841; cv=none; b=P1qx2NyayiinX3TLppX5wHaeMp20bGFMh6dTXmaN7HAuS3aR6O2PIXqYiieW59fOCqhsAX1asSXWDuyNvj+nh3+GdVjuvoo6AStsKzpkiNIqMcT2nAQo5xnc8NJ15Ug7UO5OJ/y0WXnoSomW4rBHqEPf+vbr17EmCzhk6+LaP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019841; c=relaxed/simple;
	bh=L5jePk++a0uY91JQrASnpEj/bjSiMyJjUq1CjjPGGl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNazzHAG4G4S5hLaQmH5Bk8YrxAuo/HjmE16Xcb9h7f1cCrShfgBWuJ82Ppl/2Y+odUwGybAZepZ+UFa9TMPpgJDhS1iyovDIQy0Nw1hRkja0dKyfFO3G30V540ySdOvte6kpmumJ1TWU/W52mSErMd3Dc3ScKHp6vGTzU/DqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KO6S99S9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a994ecf79e7so863481266b.0
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019838; x=1729624638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81ZVnQPK5cdOXNd0U587x7C4r0h4m8ObdC4H2ODABA8=;
        b=KO6S99S9vvJC6jPwferK4Qdwsv3qaOE13nUZWqwJ0ZcbEsoxDEamDK7YKwSHV5Hm5z
         zwzHV0HqOIKYGNnPQyHu9j1XRfruafAwsFOlb76Nty6agI1sVXPbljeC8yOmT7R3u+xs
         PRuEyMVFZKIk9ZJPDX7gnuhYYlUsv8h1BsVSuNAtUxB7pm9bbiBA2Y6TA5uAd5S7S1d2
         eNVfpyHLviBQi+yvZtPuAeWlRVzdIAS3ZCdxlv0xPPiKoxTOZyN7/c9+ZR2ITAIPkoW+
         dG9L7zxK6xB1oS7MHgkA3KwQdjbz7VLZIeWp3A9/mTJyBN6QcLqLZxUVavgbzc73RHqO
         Tp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019838; x=1729624638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81ZVnQPK5cdOXNd0U587x7C4r0h4m8ObdC4H2ODABA8=;
        b=TbM0sXOrstIdxcPGN0pQQktR2E95tYHK9q+AhGRCtb+5IejqPzz5NltYXh85PdwfkH
         xAAJPU3d5Scx39bhhWJ3XDSxTK2J9vFSkysOgda/wjDgMqAmbVt+3K+GhgZohndE0OkO
         D19R7AT2vX4JYuJ49YsAV7E+VF66K1tm1oj8zbyW99zceU7iHrii5VsJFC5PCUsRSv6c
         twghKAoZ4HlS9znRHiW9wlKfkVdlFmSsJbl0n+XIFE6z32GuyrsM4zVhdFQKGz/bROxj
         LZ8SikY85Qxw21yUAmdcuHWhD1BXCs6LT4RtWS6KB367Aa6UBQn4mIQgX+yAxIMGnbDB
         ibDA==
X-Gm-Message-State: AOJu0YyYP4ZCKQNgaN4iQS4twx7rafRr9ao1ekrRHDeSZ2Ulb3wD586R
	cSDzE+X49r284e4DUK18Aib4mDFCm6rmvQyEre1Hp6GoxjvnuINbrPX63LpJh/M=
X-Google-Smtp-Source: AGHT+IFe6y5YxcAp7iE8drp6DyY0gA3+wgMZd7L0bgY5EMYWR88rCbdnKDAk49FEAypBphut0IJ6yA==
X-Received: by 2002:a17:907:d2e7:b0:a99:ffef:aec5 with SMTP id a640c23a62f3a-a9a34d6e9aamr112640966b.23.1729019837837;
        Tue, 15 Oct 2024 12:17:17 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29719196sm102080566b.33.2024.10.15.12.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:17 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:16:01 +0200
Subject: [PATCH v4 7/9] arm64: dts: ti: k3-am62: Mark mcu_mcan0/1 as
 wakeup-source
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-7-fdac1d1e7aa6@baylibre.com>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=msp@baylibre.com;
 h=from:subject:message-id; bh=L5jePk++a0uY91JQrASnpEj/bjSiMyJjUq1CjjPGGl0=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59i+ZPGmy1PW/eRuvPTjolT7riMnqP14vVzI8zrkwQ
 ZTN5MC9VR2lLAxiHAyyYoosdz8sfFcnd31BxLpHjjBzWJlAhjBwcQrARBYwMjIsYM/J0lA7kHP4
 Q/++E0fME6Re9uxXntPq4Zd84HR8z+/vDP8Lzq/Z6PgoQWlP5tqAreWOy+cnel2cfj5mb2c653X
 Jl4XMAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
accordingly in the devicetree.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index bb43a411f59b281df476afcb1a71b988ca27f002..e22177b9dfecb541e99b0807f8b79e7b878b6514 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -160,6 +160,7 @@ mcu_mcan0: can@4e08000 {
 		clocks = <&k3_clks 188 6>, <&k3_clks 188 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 
@@ -172,6 +173,7 @@ mcu_mcan1: can@4e18000 {
 		clocks = <&k3_clks 189 6>, <&k3_clks 189 1>;
 		clock-names = "hclk", "cclk";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		wakeup-source;
 		status = "disabled";
 	};
 };

-- 
2.45.2


