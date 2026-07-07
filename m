Return-Path: <linux-can+bounces-8060-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ME24LOLYTGpBqwEAu9opvQ
	(envelope-from <linux-can+bounces-8060-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:45:54 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE87271A962
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:45:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8060-lists+linux-can=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-can+bounces-8060-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A399C30A6754
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A63E2ADC;
	Tue,  7 Jul 2026 10:25:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D233E2768;
	Tue,  7 Jul 2026 10:25:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419902; cv=none; b=Lc3ssc97N5GHW3y2NrtVRcbPTOO2MduN/PxfWidfHEP7fUArypsfj/e7dbAQ9X8AsPV9+8RJIGLeWJdZUTtKeknlC8hABxL+dTHW7LFeG4Q7YvbrPukZ4Ldy9ewJBDT1wXnp2di1Jivh0DfJNhawhIfyykuY42fn9hA7IHEIaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419902; c=relaxed/simple;
	bh=Bf9n4g7Nb0yfZEVNcSCDaR0vz5U63uuyFbZ9NcNtKOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAXPdcv0kSwox5sdeNqescpcBNWNvI3su4rNnqwnLjDKPOEr1mvFTQaDmD4R1l1xq075dh6HG6zXwM32XeibodqsbmwPh6B1MeB9E0hiRfv00Xuhmn9E/7gN5sB0OvKAJkJeWlBT8xmrXqyZHtu/DLolfiNhpHgFICgGnhJWRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14571F000E9;
	Tue,  7 Jul 2026 10:24:56 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	tu.nguyen.xg@renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
Date: Tue,  7 Jul 2026 13:24:18 +0300
Message-ID: <20260707102418.1646159-9-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:tu.nguyen.xg@renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8060-lists,linux-can=lfdr.de,renesas];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,renesas.com:email,tuxon.dev:mid,tuxon.dev:from_mime,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE87271A962

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The two CAN FD channels available on the Renesas RZ/G3S SoC are routed
through the Renesas SMARC Carrier II board when used with the Renesas
RZ/G3S SMARC Module.

The CAN transceiver on the Carrier II board has its standby pins connected
to GPIOs that are selected through the SW_GPIO_CAN_PMOD switches. By
default, these switches route the GPIOs to the PMOD interfaces.

Enable the CAN FD controller and its two available channels.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 +++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 46 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
index bbf908a5322c..198874ad9a65 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -37,4 +37,16 @@
  */
 #define SW_OPT_MUX4	SW_ON
 
+/*
+ * SW_GPIO_CAN_PMOD[x] switches' states:
+ * @SW_GPIO_CAN_PMOD1:
+ *	SW_OFF - GPIO8 connected to CAN0_STB (position 1-2)
+ *	SW_ON  - GPIO8 connected to PMOD1 (position 2-3)
+ * @SW_GPIO_CAN_PMOD2:
+ *	SW_OFF - GPIO9 connected to CAN1_STB (position 4-5)
+ *	SW_ON  - GPIO9 connected to PMOD1 (position 5-6)
+ */
+#define SW_GPIO_CAN_PMOD1	SW_ON
+#define SW_GPIO_CAN_PMOD2	SW_ON
+
 #endif /* __RZG3S_SMARC_SWITCHES_H__ */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 70af605168b0..2be684f55914 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -68,6 +68,24 @@ codec_dai: simple-audio-card,codec {
 		};
 	};
 
+	can_transceiver0: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+#if SW_GPIO_CAN_PMOD1 == SW_OFF
+		standby-gpios = <&pinctrl RZG2L_GPIO(13, 0) GPIO_ACTIVE_HIGH>;
+#endif
+	};
+
+	can_transceiver1: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+#if SW_GPIO_CAN_PMOD2 == SW_OFF
+		standby-gpios = <&pinctrl RZG2L_GPIO(13, 1) GPIO_ACTIVE_HIGH>;
+#endif
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI1 Vcc";
@@ -92,6 +110,22 @@ &audio_clk2 {
 	clock-frequency = <12288000>;
 };
 
+&canfd {
+	pinctrl-0 = <&canfd_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	channel0 {
+		phys = <&can_transceiver0>;
+		status = "okay";
+	};
+
+	channel1 {
+		phys = <&can_transceiver1>;
+		status = "okay";
+	};
+};
+
 &ehci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -171,6 +205,18 @@ audio_clock_pins: audio-clock {
 		input-enable;
 	};
 
+	canfd_pins: canfd {
+		can0_pins: can0 {
+			pinmux = <RZG2L_PORT_PINMUX(6, 1, 3)>, /* CAN0_TX */
+				 <RZG2L_PORT_PINMUX(6, 2, 3)>; /* CAN0_RX */
+		};
+
+		can1_pins: can1 {
+			pinmux = <RZG2L_PORT_PINMUX(17, 0, 3)>, /* CAN1_TX */
+				 <RZG2L_PORT_PINMUX(17, 1, 3)>; /* CAN1_RX */
+		};
+	};
+
 	key-1-gpio-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(18, 0) GPIO_ACTIVE_LOW>;
-- 
2.43.0


