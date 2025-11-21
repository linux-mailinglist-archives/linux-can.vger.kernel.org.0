Return-Path: <linux-can+bounces-5568-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B6C799CE
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 14:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 7DC3B2DF80
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B921B350D63;
	Fri, 21 Nov 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UabFJLBB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4034B415;
	Fri, 21 Nov 2025 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732568; cv=none; b=Rdkj4Uv/cU/rxq9HWm/QHzVczfOQe9YrO3Jfvk8dKwtClpgjDfyK/c63aOfHBjx4APwTL+vZGIx8RJjkFh317GNyBYlIf4aNIVqivpGqi5eS+nVDYXkMzjDzzgDgdLXm+Z+37DNpfBC86Z7VP6Q2IgIgu/Y7hQuIcz31Ew7S+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732568; c=relaxed/simple;
	bh=JWEH0EEiu3HL+mQccorOdCZ3B7sTUWJsB+/8RXQUlrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvOVc9H+pc1SanDJO9Wg6wgLqyEI/SQO9rjWmJuSFiZq/9uZVSSCRs7nrkAVGQgnrOHJ2PiFXK9nt1vHfhpD3UBR15scTQ0IzYy4WRU/faL5ZQffSrHpojOCgYti2Om1RZ/Y9GWO78lsbzNMeXyU4ejsE8QmIoiNvErjBVVun6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UabFJLBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28347C116D0;
	Fri, 21 Nov 2025 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763732568;
	bh=JWEH0EEiu3HL+mQccorOdCZ3B7sTUWJsB+/8RXQUlrs=;
	h=From:To:Cc:Subject:Date:From;
	b=UabFJLBBCAFml7+qNgB7VXXI+lMl4ffeKvg0NjnLbrVK8MBlQ7LWX5R+WQQW1XQMg
	 wZTyx1BS7vLTdOH8v9vyBF+pt5ne2kJiPW5+MyyC9fw8eCK1cUOKkeddAtLpAWorrK
	 OAnweA3HAYb1yLcQt4eTVtrKkkS3JorBNmsfj5d7SYHBBonaYyRuOGXJi+8ikntByy
	 yWcG9p+oDcIOL6xvWKwQf+kOBhblY4rHsxunnPVWUDjgjLMR3VEP4afkatmJhQ6PXe
	 QMISijh/2yAGqZwBXbGa+1TADN1bbeRRKfRzOHU2JOX1Iy+LD8A2SEYFdFf+ywzgem
	 Fr2Bjqsu9CoTA==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [net-next v2] dt-bindings: can: mpfs: document resets
Date: Fri, 21 Nov 2025 13:42:30 +0000
Message-ID: <20251121-sample-footsore-743d81772efc@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2274; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=H1pKxRw0xn3sBjDfosi1NAZI2A1U748fyOaF5di6rGM=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkKOS7plyf6zE2cUSiwcmn0ydYIp5y9R/vrlGd1uBpvY d/Zd1Klo5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOp3s3wP3CxyI2GIAn/zrf1 1dXP9kfUWJ3akd1+syop0e/KC/WfIYwMq7Mns0xpWu75Q7jba9tao2TNxJ4Zvzwn5X6VO6ejIXy bFwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The CAN cores on Polarfire SoC both have a reset. The platform firmware
brings both cores out of reset, but the linux driver must use them
during normal operation. The resets should have been made required, but
this is one of the things that can happen when the binding is written
without driver support.

Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
This is the second mistake in this binding, both spotted because of the
driver being written (although this one sat downstream for a while for
w/e reason). I wish I could say that I'd send the driver soon, but I am
busy upstreaming things I wrote and therefore understand at the moment,
so a driver that I'd have to go understand and review before sending is
low priority, sorry!

v2: update the example too...

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-can@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/net/can/microchip,mpfs-can.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
index 1219c5cb601f..519a11fbe972 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
@@ -32,11 +32,15 @@ properties:
       - description: AHB peripheral clock
       - description: CAN bus clock
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
+  - resets
 
 additionalProperties: false
 
@@ -46,6 +50,7 @@ examples:
         compatible = "microchip,mpfs-can";
         reg = <0x2010c000 0x1000>;
         clocks = <&clkcfg 17>, <&clkcfg 37>;
+        resets = <&clkcfg 17>;
         interrupt-parent = <&plic>;
         interrupts = <56>;
     };
-- 
2.51.0


