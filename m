Return-Path: <linux-can+bounces-5143-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50945BD23CE
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCFD3C2995
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B1A2FD1C6;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsSCWnVx"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A102FBDF7;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347170; cv=none; b=ropEr4g2J8RhwkkuR5iCZPbo6aaKg1984SWuykdppdS5wD7BsbXGT2W28ax/u5AaRo0fWy1vZRgG/yeSksH9YL+ur/KtIGCAPciylh+K4mR4ZT4JLJtqOWOurKRpH3JIjdDLZkViVaaifVImBDA4aBhOz4NIC00kWSKIljAu0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347170; c=relaxed/simple;
	bh=bgolRaQ7BSwO52ik6W5T8O/j73mt5m2zQwGbn+DdJf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWJ7JxRcHHmyuA6Z4Ahh1mc6dLjnKwM364yiQmY/FOizYfaMGkKrSr7nBs/YtGEvIDbbgoa95EwrVdKRNyfgOtzdfhzuDa2hbuf8TlzQ1uI8b9ClgrTcutCpggEfh4xinE8twMpKlhZvswRlN1PL8ux/ThImfSfXOyyQy8AKB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsSCWnVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33867C4CEFE;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760347170;
	bh=bgolRaQ7BSwO52ik6W5T8O/j73mt5m2zQwGbn+DdJf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KsSCWnVx8ROh4D/mTuNYd3f4q9Q6dx6AYf5ojLFBosvKDrYwbCf0PEkdGjohkkZkI
	 0uD5lvqEj/O/NNvLCgzyIFJlZJ1ho6SGTvO+3O7xCoqKzJibY1YnmHgNWsmZWZKZhU
	 cGPfYzRPKpkJKC3qLJqiK5xbe9hAq6K32+mf1r7NlfuyKOVKbJx/XiWezXpMJ1osfy
	 ssNjaw4s23JdFyYPhC2jRArWMBhT1ojMKjC7EGr1FBRgICjpscIvjVMEj4GHe7MFPA
	 fen0dZ+l3X30+gfgCbTtULc4uHCw9mXP3Ra2oNip7K55+z982ZoN27xhjGRmheLJCE
	 ac5zZcJ/9m+Qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE3CCD183;
	Mon, 13 Oct 2025 09:19:30 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 13 Oct 2025 11:19:18 +0200
Subject: [PATCH v3 1/2] dt-bindings: phy: add support for NXPs TJA1145 CAN
 transceiver
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-tja1145-support-v3-1-4a9d245fe067@liebherr.com>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
In-Reply-To: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760347168; l=2562;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=L8wDSbzu2IryFS38VxJyJrljRgOL8hmgwJHNplg6eCg=;
 b=7CsISOALU7FGCXRkzl2zMa3BMJfne5/v8sYAg99qdRdsh5o14Zs4BYNYpS1g0o/jpf6myzHvV
 BTpT9GghhUoBVo8VXrrzDAyupAGJX4dhaJCzHwkmHVjjRePw6qmuiLO
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Adding documentation for NXPs TJA1145 CAN transceiver, which resides like
the ti,tcan104x-can.yaml in the same directory as other generic PHY
subsystem bindings. At the moment there is only support for simple PHYs
by using regulator bindings in combination with can-transceiver.yaml or
PHYs that implement the generic PHY subsystem like the NXP TJA1145.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml b/Documentation/devicetree/bindings/phy/nxp,tja1145-can.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..3b81a2e1ead8452ed5fcf2021f33d628d4e12346
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
+        can-phy@0 {
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



