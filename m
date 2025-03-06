Return-Path: <linux-can+bounces-3000-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EFA5490C
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D6F18945FF
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812A20F09C;
	Thu,  6 Mar 2025 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2xWofVtj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D0120F061
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259778; cv=none; b=DTWhkNFweK5ah9uFyCzBQZ7pAjTiMciaaAx3Fg8f1Cq66FUgdCTz5++6vuLuu7ydSfxsQCm5ht2O/eqRt0Flbasz8uViBKzJbNnBEHD+hw2xM/Xh84No1+emH4JD5EzWbgSVG1pcnTNP/Xt2QfZvWGSTctRHRIJz4gQCuE4U2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259778; c=relaxed/simple;
	bh=VbF63lIgRDIHEDh0j1eHwrNJ7kNRLfR5v3SvlStjSYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KzYC0Gt9OpalzX9dNl4cQ95FbW2vq0Fr/jdr/ws4Qn0HfCD2q7198MHMll/Ie6J4CGWaeCpPl+jmmds2A7APzXn+OewkY8wfW65FbGr5+bvDlpAU0id8oaXWXTNckpaU0nVAwxmVpR6ce1Xm/V0yqiahy2brFAVLYxcyU/g6hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2xWofVtj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf6f3b836aso82359966b.3
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259772; x=1741864572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjgCrc1CiYSLXkKYjoDdBunkgeyK0ACopuUn/gOO93Y=;
        b=2xWofVtjDHUJsmETawKlomhzAs/1tMm/8vITkiR8JMtOOrpqF5dChrzWrZVbMUPPKj
         zB/p23ne5O1Y0F4r3xx7/3Fw2iOvavxISFIrXwiokIHg96HgaAj/t23oYPHdtbkMzlMI
         k2f97dEF7pcd1fJsapOcEfWE4aiQiplYr7KauCoOCRtvnORqLBl97LC/Xer0Z8mAHqlY
         +fPmRnUefAvjbwL0DMvNq3d2Ozr4h+S8VTyu+2wO6fLseWsp0s3IsjMlw3WP5jwYrrit
         nykkJoG5qmpJV0WEvl8z2uzBVMz2RO6VVSgaPliQ+46v3S67cLHw4rVPvOKo2irU4vvN
         3mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259772; x=1741864572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjgCrc1CiYSLXkKYjoDdBunkgeyK0ACopuUn/gOO93Y=;
        b=w5Mf8vHBZXnivgYn4Y6/MRvnVUy5Z5Tn4x/3ZZZOU3JD+FfZez1G3gqVq49lF+4YjR
         MnBVl/gueIWb/ZwJMHMLQcJFwyV8+ldtysYJcx80OEabM2X8W9Vd0OIvfKIJ5lI8PFq6
         tB31ByTAkFqtn1Dp+IEAh/Jn9zNHR06Dxzhq4UL8GZVUbkBPMm8TovovOBcxGCnVslNn
         BVb9nYs8VKnLV5JyRzmWCbYsBAJsoJwoRVURKx4F+m3U1NVlPgWJBsS5u2Ov+I2UHMQ9
         SNBmjOLgHBPSxc64Qg+c2Sxzs+jUwQYiHwyrgm5HkRLppUKgeEbXHddada2rtaiC+FNf
         cY5w==
X-Forwarded-Encrypted: i=1; AJvYcCVVUL+ne4EnuibadTVfafLt5HjzQ3kEBH1Lis2qtyitagOxKI4g6rQlCP2PbWG6IOp/kUxtjcXxKXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8gV7ZAmC0kdrXvA62Nqo11sJ6Tljbp2bjc5tML3Nv8Sb6y21
	uZmcoWZ5a1QY40CxVCBed8/aE0oUBIf24FViQd431NF5mtDXA1zXfgfzVxRpRKI=
X-Gm-Gg: ASbGncvOOF7uBp00rO9EYH6IaRr/smrqrdyy1MbmzBRwVmYotYnOtw2pA27Q+V1BDn4
	16ZYMEreg9w5SVGC93LuI4/D3xbdKbLm5Y9nTs+Qmod+aLTDIozwr99QOxILilb6V0KSDj2WVEc
	hoTIkumBx4b7gxCoxI0Yg8cnPeMD5/LXby2O2ezZ1YWbc8ptlVjs5yXz4NMMiXB5OCdatMxmgUX
	uR51XmiUcaOeIYfVFMeBjk0ftDb2rif1MzktPI9gwz99xqrhW4A/wtN/qbWTVDyaLFwAgSgipLv
	bOCu3bKHH9Jqm/zpuuUn4wsb9b2usHlZkJdHjYoCNw==
X-Google-Smtp-Source: AGHT+IG97CEorYWv8MdBxdHawoR/D/CVLaTZdfILEdkNvt1Fn2+vDxmsARxSKsCxTfLEbIgksTW74Q==
X-Received: by 2002:a17:906:d54c:b0:abf:6f37:57df with SMTP id a640c23a62f3a-ac20e03ab40mr745282466b.51.1741259772562;
        Thu, 06 Mar 2025 03:16:12 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac23973a981sm77339566b.120.2025.03.06.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:12 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:51 +0100
Subject: [PATCH v5 13/13] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-13-f9323d3744a2@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3129; i=msp@baylibre.com;
 h=from:subject:message-id; bh=VbF63lIgRDIHEDh0j1eHwrNJ7kNRLfR5v3SvlStjSYs=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNj9bP3Om+c6c/W0NXvezuVwKil+enfVcUPiCfG3TX
 sFdPzilOkpZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJGGQz/BXwPWbXHCl3t6Ds
 ou+51SzTF11Ycez5J8vUJ6WGSXOvZnoyMpw4YGVWf+qQtSDHnA0qLGVPzNYuj9ggMoP3gjirztz
 UfmYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
powered during Partial-IO and IO+DDR and are capable of waking up the
system in these states. Specify the states in which these units can do a
wakeup on this board.

Note that the UARTs are not capable of wakeup in Partial-IO because of
of a UART mux on the board not being powered during Partial-IO.

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 76 +++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index d29f524600af017af607e2cb6122d3a581575ffc..35b950e444353c416e33344dfff42e2edeab3aba 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -683,3 +683,79 @@ &mcu_gpio0 {
 &mcu_gpio_intr {
 	status = "reserved";
 };
+
+&mcu_mcan0 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_io_ddr>,
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
+			<&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_uart0 {
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+};
+
+&wkup_uart0 {
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
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


