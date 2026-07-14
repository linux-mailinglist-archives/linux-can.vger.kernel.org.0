Return-Path: <linux-can+bounces-8451-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +uq6GW90VmqS5wAAu9opvQ
	(envelope-from <linux-can+bounces-8451-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:39:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B921B7578AE
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 19:39:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8451-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8451-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968C1318489F
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E4412C0D;
	Tue, 14 Jul 2026 17:34:05 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC9412BED;
	Tue, 14 Jul 2026 17:34:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050445; cv=none; b=ZhJlE8LnTdPOSKZRPEt0K/CCqYwPMOcUaH45RA0kl9gMrMRNAa0RUhroGWHTBZDpePLSGJpSKGpmLbwM5Ce+4lz2PuTEFKSLsSz+UfF8EdjDGKVf/EyLjwCADu3BdhJ+etHvKVqFfCmrmQlOMwrgNY1/WUaihW4guq5TfVoom64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050445; c=relaxed/simple;
	bh=kpsV++C9WrOZZ5JntFDCjSPIbIlEv7orzSyhCEFAjF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=se7NHaPMxy9OM/kYp8u24SrO7inoWVr4B1V4ZGj5aRpJurGDMjP145iPToPGEWpfps5kocBy4dLp86t0lGFsdY+Ipp19x2vx0JSLKkMHHR+htB1M2723jNOccNZsUu3NZ63eSttPLCpMbIMpDcrEeq6RF085nTK6v4kN+rExV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD461F000E9;
	Tue, 14 Jul 2026 17:34:00 +0000 (UTC)
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
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
Date: Tue, 14 Jul 2026 20:33:15 +0300
Message-ID: <20260714173315.1981708-9-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8451-lists,linux-can=lfdr.de,renesas];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tuxon.dev:from_mime,tuxon.dev:mid,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B921B7578AE

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The two CAN FD channels available on the Renesas RZ/G3S SoC are routed
through the Renesas SMARC Carrier II board when used with the Renesas
RZ/G3S SMARC Module.

The CAN transceiver on the Carrier II board has its standby pins connected
to GPIOs that are selected through the SW_GPIO_CAN_PMOD switches. By
default, these switches route the GPIOs to the PMOD interfaces.

Enable the CAN FD controller and its two available channels.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- collected tags

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


