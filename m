Return-Path: <linux-can+bounces-4392-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C4B3B6FE
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03CB464237
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A524F302CC1;
	Fri, 29 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbetGE4u"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F152F7477;
	Fri, 29 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459209; cv=none; b=Lx2klpbNqvFpHcQ/6MBHnVovSOhKgk4sBSeU56s783iIey6a+O1ZxMq//Ml8tv6WHHz9JJCEq8DCvKXZj/N2QUC8H854hqTl58kJlyP6QUWoDKDsiVwxMHvjQ2wvbA9kA/4UtT7BY6jnn8t+kuggKF9PZaZsTTfr4WHINAccUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459209; c=relaxed/simple;
	bh=e9oJU48kwwR1n987ObT+7546LsuGL6ky1UxE5lTo/QM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITDW6deu2GcFWfPhVyLR5anwyvrBcyQc1WiutmAmmhBOsqYkgb0F1u5XM0LC4Fs9irtXw7VzCLCT6S1R2Mh8x/roaojG/HsYQvs89xazQOb4CGyXd1jVwaqyTPhEo3QgMLzRyQlT3hTL3juhfTsObM11qKpa1d+2VL7+CzP99+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbetGE4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07C7BC4CEF5;
	Fri, 29 Aug 2025 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756459209;
	bh=e9oJU48kwwR1n987ObT+7546LsuGL6ky1UxE5lTo/QM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZbetGE4uzE/NNkJXUg61QYFv2J9kQW5HONoddm/kvzAAmHGkXR8xVBxRiF3txyt67
	 ENG8dArjqhaxR9Y1D2xpwDBZDgvU8/FzCN2CZedV6YC7MDkfdhQ7ggYhRxiIBnNWVr
	 acTX2ItnxnO/2TGbN5ZmhCmmd5rzyyrtRm/uTRWFmaWwnkfoiMYHVguLA2fgFbGwwc
	 d/hdgGDSTALf+NInLidLH+D8MQYmIjNNSy7xWqM7wFhZvi5Z0y7S7rvJysZsoy7WRP
	 dtpkgoWBomV4v4kekyx9pm9CZeaozhbkneh5GZ3XJ/uUZYpizGQrDEXS8QgTgkJUNi
	 3oC7cjXCAL+eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E335CCA0FF7;
	Fri, 29 Aug 2025 09:20:08 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 29 Aug 2025 11:19:58 +0200
Subject: [PATCH v2 1/2] dt-bindings: phy: add support for NXPs TJA1145 CAN
 transceiver
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-tja1145-support-v2-1-60997f328979@liebherr.com>
References: <20250829-tja1145-support-v2-0-60997f328979@liebherr.com>
In-Reply-To: <20250829-tja1145-support-v2-0-60997f328979@liebherr.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756459207; l=2257;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=HyA9JIPpFoZU2e8fz5wbxbdPtk5aIJ/PYblsn2zZTqU=;
 b=azp2LEUVPBr5nQtoNSNpF5YU5I8NI2qm/znmucDnga2GxQkDTKrFSoEnzkmtuE7JK9KEroFdw
 j1ppYZ0AyvmArI4As0KgynXp2c1ePuHdWvo5utaXHQ5D3gI59LEOhNo
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Adding documentation for NXPs TJA1145 CAN transceiver.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..12a8880267ef65cd9c55dd542f053ae967c7d6f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/nxp,tja1145-can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TJA1145 CAN transceiver
+
+maintainers:
+  - Dimitri Fedrau <dimitri.fedrau@liebherr.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: nxp,tja1145-can
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  spi-max-frequency:
+    maximum: 4000000
+
+  spi-cpha: true
+
+  spi-cs-setup-delay-ns:
+    minimum: 50
+    default: 50
+
+  spi-cs-hold-delay-ns:
+    minimum: 50
+    default: 50
+
+  spi-cs-inactive-delay-ns:
+    minimum: 250
+    default: 250
+
+  vcc-supply:
+    description:
+      CAN transceiver supply voltage
+
+  vio-supply:
+    description:
+      Supply voltage for I/O level adaptor
+
+  vbat-supply:
+    description:
+      Battery supply voltage
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        can-phy {
+            compatible = "nxp,tja1145-can";
+            reg = <0>;
+            #phy-cells = <0>;
+            spi-max-frequency = <4000000>;
+            spi-cpha;
+            spi-cs-setup-delay-ns = <50>;
+            spi-cs-hold-delay-ns = <50>;
+            spi-cs-inactive-delay-ns = <250>;
+            vcc-supply = <&reg_5v0>;
+            vio-supply = <&reg_3v3>;
+            vbat-supply = <&reg_24v0>;
+        };
+    };

-- 
2.39.5



