Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C130E48B172
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 16:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243649AbiAKP5j (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jan 2022 10:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbiAKP5j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jan 2022 10:57:39 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC7C061748
        for <linux-can@vger.kernel.org>; Tue, 11 Jan 2022 07:57:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id k21so58025086lfu.0
        for <linux-can@vger.kernel.org>; Tue, 11 Jan 2022 07:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47xSV+aaBbv5R4/VZxIMXkl87pTBxA8gxKimR52zIw4=;
        b=xYt51TdBtGKqbhNBcKJ1NegEp9roXnfM0Awac3Ot4lBOZrN6bU7K1mmGM7sS6IA9dk
         PfKR/4fIe9N/K7Ysr9vbNeThsKwfkjB0/sMDMqQfQSGBXL4XD8Nln+mkIAajX5pk8c37
         Jj+5Eq9ekE/nke1mb2yL4NfB+Y5Rbpyh5C7fjkeH7cmhU9NZoeBIxHq/a9jgGc8KQzY7
         zg+cuKhA//SCsiHqshYQXGfx0jDQZ7scTlGVSJ2KY1UeViFPfwEgzRfKYJbvcyjrbu7T
         X2pIVwwqPPwoJukIIWAHPeVTEJ21qh17FpLXtGsRwyemwSbrkxnCxg4Ze6MJKXa7lb4f
         J6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47xSV+aaBbv5R4/VZxIMXkl87pTBxA8gxKimR52zIw4=;
        b=Qcsburb8SDYSQv65bP+mg7qJ5sSMpER7AxwVIudEkmcjNtNuRZJoCeIxvwR2MrmBO5
         8cntDLdbQ4dEKtDHxPLoPgGn1+boxLDCy8C7c8TEWSEnovrhxmE77OgCtIVYOn/3Ks2h
         56yFW+7y5bAlp5qpQfR+ou7JalhdID+zquMTKakb3BgnP9BaBENRkX7/piA1wC/pdEpo
         z91giEZG23v+Qu42VSktG90LBSR+UotW/IAW4B/9Th+9Znv8tJxkie+4+pLqxY+BrlOR
         34OMjj03cVxYVdzkZ9yMbvysiCS6u4z61Mf62CB5JJDww9DIfXjTO/QGyZichJnTpprz
         j3SQ==
X-Gm-Message-State: AOAM530Pg7/N1MgI2tbJdnimXZRXnAgogySgQyZ9ASeNgJascI01vUU8
        kvcgX+WTBjP+QppEMl0YFMJb5A==
X-Google-Smtp-Source: ABdhPJyO255tJMptzPXJzXNfFkOg0Wu92ztH4j40AdRIvV89TtHlMz6T2+uPCWJYvncbd5NL9VF04A==
X-Received: by 2002:a2e:8781:: with SMTP id n1mr3408385lji.96.1641916657189;
        Tue, 11 Jan 2022 07:57:37 -0800 (PST)
Received: from boger-laptop.lan (81.5.110.253.dhcp.mipt-telecom.ru. [81.5.110.253])
        by smtp.gmail.com with ESMTPSA id y7sm1370706lfa.92.2022.01.11.07.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:57:36 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH v2 3/3] ARM: dts: sun8i: r40: add node for CAN controller
Date:   Tue, 11 Jan 2022 18:57:09 +0300
Message-Id: <20220111155709.56501-4-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111155709.56501-1-boger@wirenboard.com>
References: <20220111155709.56501-1-boger@wirenboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
controller is the same as in earlier A10 and A20 SoCs, but needs reset
line to be deasserted before use.

This patch adds a CAN node and the corresponding pinctrl descriptions.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 1d87fc0c24ee..2ba0e681a7ac 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -511,6 +511,18 @@ pio: pinctrl@1c20800 {
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			/omit-if-no-ref/
+			can_pa_pins: can-pa-pins {
+				pins = "PA16", "PA17";
+				function = "can";
+			};
+
+			/omit-if-no-ref/
+			can_ph_pins: can-ph-pins {
+				pins = "PH20", "PH21";
+				function = "can";
+			};
+
 			clk_out_a_pin: clk-out-a-pin {
 				pins = "PI12";
 				function = "clk_out_a";
@@ -926,6 +938,15 @@ i2c3: i2c@1c2b800 {
 			#size-cells = <0>;
 		};
 
+		can0: can@1c2bc00 {
+			compatible = "allwinner,sun8i-r40-can";
+			reg = <0x01c2bc00 0x400>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN>;
+			resets = <&ccu RST_BUS_CAN>;
+			status = "disabled";
+		};
+
 		i2c4: i2c@1c2c000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2c000 0x400>;
-- 
2.25.1

