Return-Path: <linux-can+bounces-1076-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7DA942AB2
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD1283D47
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2024 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF831AB53A;
	Wed, 31 Jul 2024 09:37:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED421AB501
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418674; cv=none; b=Mlp3GDtHN57PRjRYUu7DMnO29fa8t3cs3yV9WKT7ca7rvI0U1XyovvL1oHciL0MjbKd2HV9+zXqhA/oEHBt1GgDzW38JIrywWvRAVW7Vru9Ie3pNAFms8o5CsWI63APvh2iAHfxhEs2xhyiEbf1J1w/J7nQlHPUOqr43k+/FMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418674; c=relaxed/simple;
	bh=BiJ7qNrkEQBjaGS4ORJTWUVTIdKOaaucW4JNT0TPfgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2z+CvQE8ERABsSIgdJuq5vkD5/l8LQf/fPpKbeujDCKg0iJy8iH/Lsog4HroNndkDjy96qeJLHZVaCcWp7jbIX9sOqoXis2V/aJoxaTEeurJffdi+EyKCrhZ/YTx9Euguh5PJecFgyoUR/cw0E5bswuwe+ge2dOs1HhIkn6UTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mJ-0005Ro-F5
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:37:51 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sZ5mI-003UfD-PW
	for linux-can@vger.kernel.org; Wed, 31 Jul 2024 11:37:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 651993127F8
	for <linux-can@vger.kernel.org>; Wed, 31 Jul 2024 09:37:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BA7AA3127B7;
	Wed, 31 Jul 2024 09:37:44 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2a2126ad;
	Wed, 31 Jul 2024 09:37:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 31 Jul 2024 11:37:03 +0200
Subject: [PATCH can-next v2 01/20] dt-bindings: can: rockchip_canfd: add
 rockchip CAN-FD controller
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-rockchip-canfd-v2-1-d9604c5b4be8@pengutronix.de>
References: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
In-Reply-To: <20240731-rockchip-canfd-v2-0-d9604c5b4be8@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=2993; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BiJ7qNrkEQBjaGS4ORJTWUVTIdKOaaucW4JNT0TPfgQ=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmqgXFv4KNmLu5UHqpvoy+25jeyn9jeMePFAaek
 h0/NtHQbgWJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqoFxQAKCRAoOKI+ei28
 b31FB/9+r3vPjZMxdO5PGmtVYQnTcIn4Fu6wpc390CnmNaCZ5oKK8wKMTepgZH87z3vi4vlxkCK
 bTcmv9xsH+1dP54oH6em9d+Yn/n49ZMh+p9ubuzNPperoBZWZAybu4G5xnfG2dNliiV3ZBNHe0e
 sRkHlp/KnQ0uLUETBaiD4ynTO5IJW4H0ualqq5iSZGU73LeHmrnbMfG9EvPvzOQPthLpxSuVsBQ
 1pNws00SUIi+2DrQqADf4nOjWYTHryoriRK8PFVQKkH9uUPjDtjpwDC4CjUIB4r9adKYe+mqqM2
 2E4sV0n0grCtixdjCfsuqrQR52TvCBl7+gsgrt+7f5dFQhjj
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Add documentation for the rockchip rk3568 CAN-FD controller.

Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/rockchip,canfd.yaml           | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml b/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
new file mode 100644
index 000000000000..444269f630f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/rockchip,canfd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Rockchip CAN-FD controller
+
+maintainers:
+  - Marc Kleine-Budde <mkl@pengutronix.de>
+
+allOf:
+  - $ref: can-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3568-canfd
+      - items:
+          - enum:
+              - rockchip,rk3568v2-canfd
+              - rockchip,rk3568v3-canfd
+          - const: rockchip,rk3568-canfd
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: baud
+      - const: pclk
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: core
+      - const: apb
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        can0: can@fe570000 {
+            compatible = "rockchip,rk3568-canfd";
+            reg = <0x0 0xfe570000 0x0 0x1000>;
+            interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru CLK_CAN0>, <&cru PCLK_CAN0>;
+            clock-names = "baud", "pclk";
+            resets = <&cru SRST_CAN0>, <&cru SRST_P_CAN0>;
+            reset-names = "core", "apb";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..d225dc39bd89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19694,6 +19694,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CAN-FD DRIVER
+M:	Marc Kleine-Budde <mkl@pengutronix.de>
+R:	kernel@pengutronix.de
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/rockchip,canfd.yaml
+
 ROCKCHIP CRYPTO DRIVERS
 M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org

-- 
2.43.0



