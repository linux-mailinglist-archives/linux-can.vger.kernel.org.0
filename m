Return-Path: <linux-can+bounces-2995-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F5A548F7
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260C53A31B8
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0761FCFE4;
	Thu,  6 Mar 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3WS3jD5z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02D20C037
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259769; cv=none; b=bIdc46rq8spwC4/atT1naSraxNt2FhgcxArLcsm7KwMtbM/O11KV2+a5JbEKct8nZOLCaq9vd+OfSPSHQBAt8PJeqE162XQRWc0abQ6H/2RhnB+PxIUrDh2hPkjbOsuMN8j/dD7CBJQNCCj/enDkLSLwTfKAbmdm5ezvkjca+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259769; c=relaxed/simple;
	bh=qOYKpbMRlS3QK+lIBKOrbvUoEPJGZTbJFamIqalYLfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l9a0ScDASpOzIZE7wbKqO9EVfr0U7VIw01QIsnhIiwXlhRg112cYK2QqjdCF9PFR0jboYFQZPdBUmvIciHiXqyX/DH0nH5u7JdzCHCg+5o/VBTbBHohqusopCP8v47xFDljggJ4TRZrM/i2/HFXPck3NPBkHNnOPCkm7RWR0Ilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3WS3jD5z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf4b376f2fso94862966b.3
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259766; x=1741864566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBtLLuJtQawAmT+r32Eq/8y5p2QwBqnC69olS/VYW6A=;
        b=3WS3jD5zlh82DfEGReKrM12LNTcS7LsAOuM653vdCkcmagUOvJ9eOXx2/FBx35I5XH
         zWgQVgLvWzFFVC7J6VxSadgKK1yxOXtYk//5rrPCqKlsbc89BIzuj7QyPHv46Ee+jIcz
         lz0+jy+eCFzyHmgiyVecaASutA7vuPPmmlR9aQqditVRzM2sqTTmFJ8gkhzW6yb6kUfp
         ZPaeB9QL2s/DWpEqci0JPNzJQl2fXpvA+DuDee70XiaWW7EahcQjXEnac/Q4E/G9jtH6
         gYoeVNwoFcT1BoHwc6tem6kCTv9Y1bf3ymEVNay7sBFI4Rl+nTinQBMyyuG/OmoErONH
         M+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259766; x=1741864566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBtLLuJtQawAmT+r32Eq/8y5p2QwBqnC69olS/VYW6A=;
        b=VO70ZGKJIV6fbD0RGFpUjEQAU33X/CfYkSXb4FiZsDMCkomiSwSEpCblPfrlry6cYY
         pLAeEasK9k/lSBgwaWKBS+FrHhhT/7ni/HR/80gYqVZrY2P6Q7XHfhFjPaRN5pB2sT0D
         tS+1WEMplbKWSu0BjIY0bxsIYnvSCEz/AEwXxZ6ZPVLPHW4YOF70vVSy2kDvWLRIMTue
         2UfLYt8dCepijjxoaWqXt/BlBBwTTbxGTzhlMTASGRuNb6x8VpkPlYu4ucBHGQnybu4y
         sAmpQ+Ybt7DpWXv7pPUg91T6NPt6iOoM7v7IhQj5WQoko5JvwMaXDvNnmY7Y5HtQX+jH
         E2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1D05IkNYW/GN3ogvgcazUv+H628Ht6ah6ZePQtlj3JoRw+A83A/Uxxe+aE75DfD/BfjzS5KJTfkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCs01zfdJapa3VhUPwoqRP+CbyB3F1eOrxq3tbc6gyR2/6rqY
	qxGVfxaC/NshQVhJiSS8DEJvS2Thl+RC/knMe463POuIHrb6OXq0B57ee92vg4o=
X-Gm-Gg: ASbGncvfxe2A91ZjEkFzYf9n/kIVOBt6qxoIGHC7ndNNDftK9Rqf5DBaUfz9fZ3U3+P
	TcHOUil9IIObYtguIo/3ZGEdxOpsQkbLseJ0dq6l3CUW1q6RJ110mQ6LtCrd4Xy7P4Is396XqVX
	+AT9mktnliaarKI/ympZKtlOUZYDHoMJjoTZJSyC/Z3eb7MTAsjHPEnp++n/zMidWSdkbhdBtgS
	L3Q8TVIpmNgBLHPsjRLN/paT3CJ14+vMVEBM+UxBhq/Dc5ahSYKkjBIkpuJtPwsgjTDwu2OXa6k
	agFwmKV5N01UIJAaauhDJpQITh1vFyfZccvNv/skJQ==
X-Google-Smtp-Source: AGHT+IHDKbTWou3q5mDxSt8FHLnziuo08sCEglEWRUMKQ7Y9hisLFsVJQsvUMtxNQ6c+a5VsArcttw==
X-Received: by 2002:a17:907:d092:b0:abf:56e3:e88b with SMTP id a640c23a62f3a-ac20e152abdmr626151966b.38.1741259766007;
        Thu, 06 Mar 2025 03:16:06 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac2399d850esm79391966b.173.2025.03.06.03.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:05 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:46 +0100
Subject: [PATCH v5 08/13] arm64: dts: ti: k3-am62: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-8-f9323d3744a2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=msp@baylibre.com;
 h=from:subject:message-id; bh=qOYKpbMRlS3QK+lIBKOrbvUoEPJGZTbJFamIqalYLfY=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNp+V3yGc+qNG9BiLi/1LVZOmpd9PbbxY+8p5uma6l
 sKOh0tNOkpZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJnNnCyLC2pS7zTY2GyuU2
 rtOs2frTs8s5hU92/EzotdTSWrxF6QTDP8W7Na5HLMqn8k+5/UBff/mNm6UR+3/sdr2S8/7K3ZS
 DXhwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on am62 SoCs.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index bfb55ca113239be4367a1cf8edf219187fafa8a0..acc8cbc7e57bc5712ada8b4b225e302ffc368e26 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -46,6 +46,28 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "Partial-IO";
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
 		bootph-all;
 		compatible = "simple-bus";

-- 
2.47.2


