Return-Path: <linux-can+bounces-2998-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4CA54901
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE1418897F3
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D620E309;
	Thu,  6 Mar 2025 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KLMh1fIQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827520C48E
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259773; cv=none; b=H1kKmqcb4x5ZcWRZzXnobuuqAy/ZRey5u/66j6eOf226bNQr3mnX0BZqB9GHuYRLiHUL8zU3aYD/K1ZSc9apF1TPx6ygapb8l+K0pmeB46+j9VJQoWuUfAJHJ8aUgjQt9Xz0zFeCcDV5m+WQ82uMjqXHH8XL1Axik+Z8wT/odvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259773; c=relaxed/simple;
	bh=bfpCmJTQoBzIZISGoC9GD8ed8b9ShNhE1/wdgbkmYxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFoVvZ6m1FsuKTZgTaoo/sJkR1mfVnaDmoioECA44brF12SL6TDSz/dBH6N8WvlXblKtDJbyxxU0rknQ3ur5Q3UR4rzdIrjVAqHxBbG/EBu/YfmsjzNCXNqUKfs3UZi6JOyUBJLpLIZpff4AF5s1302zJileGwZOPE36khTSPxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KLMh1fIQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso107991266b.3
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259770; x=1741864570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A87WxXAiQihDIxMHHvJCHeK/NU1G0OES32F8q9p/f7M=;
        b=KLMh1fIQhlUv8cqnYzy+ECkKBGN5viCx6qoGh/YphGgtTRyVFS+/DujySSovIEzgeG
         Zk3ptfChE55Lx984mnEa3eagPdtRqFVyrx7mVY7p8hfvNqytZvRjzKpGLarBKoYTp9fH
         nl+kljkU8K2NMMPN+TxhP1k3tCQgaJBmD5sSUMuy8sTBZAutdbJW8kHtt24xuOCqnhiH
         Rp3nWkBoEKsRFsMIx7ow9WrBxJHZWoB9/3TGmRVEwcbrBOwiZERr1vET6EhH3bV67o37
         DtaSVu6vUw4mqqdAJ9EvjuKGuyLl3qZRy6IXE9cSjtzjduk3uQQhgL4RwsqxvFeUIArV
         HFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259770; x=1741864570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A87WxXAiQihDIxMHHvJCHeK/NU1G0OES32F8q9p/f7M=;
        b=h7CdJzHGsEmdCZkA00lFkKKUtLObetMntTSIz3Hc2dBTkgTFA9v/XHidBlmS1Jj/J0
         eAepLg8FOTLr6NSjnalK1NNfHP/C7TNDVmBxIgj4+5AyEL2M0H/z16T4hl0QiascgX3A
         0WLI61ooPtJd+95lysNiTCXuqdTzHLM55bu0LSa/VSaJIRYgxsHFqaYdMsR+ZowOx1o/
         dKiYxKkIeWyPlGzx8G/FKfbitepSUo/vcZJcdXxQmYPVwpeizFIwGWBK56/CA4PfhV1T
         f8IoE5lb6VGcxbQFFLW1MF5u0Jfqa89gG9O4nwakvKS/jVbqsuY8VkF2kQkObe2xSQzk
         ugKg==
X-Forwarded-Encrypted: i=1; AJvYcCUpft5c3I/cwxTJW+XffVkXzEqwVXJBrgpL2xxrzXrP9sCdTl8xBhx8XBxzA9d7rZ8IWmscElgufUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAaDDI0BOJBqhvipIjM77qh6dRz7i3pMY8fZVKqdhTuZNNY+eL
	cBl6YNV8n+UI65gK4+kYaw/WehFRL6ub4Qckb+gwzH2G8+37FcN1SSNeeUxeTCc=
X-Gm-Gg: ASbGnctfGBrAZAxI7WcW8sW1Nrvvp5STTchtJZlbz9KQSEUSlEKEUsoszTcnJ4MwQ75
	+ydS0S1X3L55SxVE2j9LvDTFui0yT/Br3sR3v+79lK0kScLYhBZxSAejV7mmybOoSRjzgAwb2ub
	jNYTABS7nnL5ArLnu7GSXrj98c392TsmevWLbaQAQO8hIuG4/JirNs0Xxdu3p4Gg0JKbROxlTf5
	QxyxqUfbBAfQKWfCRNXlCpvmuTjNWZLLiN/iKcYM83yM4CnYFM4JKlDq6rgegbTdrALkS9Z+zvk
	pF9a1bix0urBuRIh/WV37Hv1MSnVJoCmbY83+VF9Tw==
X-Google-Smtp-Source: AGHT+IF+3TleQPQNdaT02wAZCvz9KEfqZLLnBNyHjof9bBJhmesmqxZ2NZ/PaJRAYALurfw6evrVvw==
X-Received: by 2002:a17:906:6a0a:b0:abf:78b6:c565 with SMTP id a640c23a62f3a-ac20d8437bamr803685666b.4.1741259769901;
        Thu, 06 Mar 2025 03:16:09 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac23988bdd8sm77769466b.138.2025.03.06.03.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:09 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:49 +0100
Subject: [PATCH v5 11/13] arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-11-f9323d3744a2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=msp@baylibre.com;
 h=from:subject:message-id; bh=bfpCmJTQoBzIZISGoC9GD8ed8b9ShNhE1/wdgbkmYxE=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNt+ZGvXqiuySuF3C/d/f7xAtdf+vIHAlPpYxWvnAw
 q79WucfdpSyMIhxMMiKKbLc/bDwXZ3c9QUR6x45wsxhZQIZwsDFKQATuTiJ4a8of04M35RIi/X+
 +2xs+ucJfPRZsO/nE3923X8K69q2segy/Pfp2+z7/PYK+RTvrV8k9uwqyKzxD66oLRdg/Z4nGTD
 bghkA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
powered during Partial-IO and IO+DDR and are capable of waking up the
system in these states. Specify the states in which these units can do a
wakeup on this board.

Note that the UARTs are not capable of wakeup in Partial-IO because of
of a UART mux on the board not being powered during Partial-IO. As
IO+DDR is not supported on am62, the UARTs are not added in this patch.

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 8e9fc00a6b3c7459a360f9e1d6bbb60e68c460ab..f19e53efabf30fc333e3a7d9832296140642fdf3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -232,3 +232,63 @@ &tlv320aic3106 {
 &gpmc0 {
 	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
 };
+
+&mcu_mcan0 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_pmx0 {
+	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT | WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT | WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+};

-- 
2.47.2


