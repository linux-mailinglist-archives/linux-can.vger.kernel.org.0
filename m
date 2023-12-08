Return-Path: <linux-can+bounces-75-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E61580AA3B
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B301C20A1C
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300B38DFE;
	Fri,  8 Dec 2023 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHk8a5tZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F51DDF8;
	Fri,  8 Dec 2023 17:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56995C433B9;
	Fri,  8 Dec 2023 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702055581;
	bh=eOwkSq/WwMGsBDJxIoKyyiwasgmQQYpNauvY4yRRwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHk8a5tZwx6HzsT8T5BnndKAcsPltUq64Ek4Pr5fovixj2Aq/i9OEQXYhY+w6CuIB
	 iQ713l1de5Asz5Ax4hK6RGHX7DC9QEYGeaWRNgbiDq3hDTLN7j1D5mgaj0jjqzZ7Xu
	 1aB87nlMv7p+TlIYR4E4rcHY/JiUJpxGIg++fsAWcK87pRUKQYMBgZHsDiDJ5g+U8/
	 GtwCtIK7kY0TJZE4KCj4b6NFP89gICI5qYZkGl0Ja20tWFXDy8Y3/wQVROVliaZjzC
	 KkeyJScyQ+CQ8bkVKg1sPQwblR2SFrf4hHKg9DAsw6n0GcGtDVGerkBdQMiMAiG08l
	 NfWbBDmM8zYqQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH RESEND v1 2/7] dt-bindings: can: mpfs: add missing required clock
Date: Fri,  8 Dec 2023 17:12:24 +0000
Message-Id: <20231208-palpitate-passable-c79bacf2036c@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=t/lsdJsWux+0djN2ESjLKlgMF40rkcl8R8FM1XRhzgA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfuUPWvbyRO6Tbtj3XqD4/x2h2j8HPA3+TjArX7qZR 3nqsvs/O0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR9GaGP9yJsZf/zW2rSddd 9SykPKmwPsXIv9vR85b+VLVjN0PVQxn++zcH+hXx6GgvW2xp8sDt9Pna46/0LFtPtVv3PxGL+zW bAQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
CAN bus clock. The bus clock was omitted when the binding was written,
but is required for operation. Make up for lost time and add it.

Cautionary tale in adding bindings without having implemented a real
user for them perhaps.

Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/can/microchip,mpfs-can.yaml    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
index 45aa3de7cf01..05f680f15b17 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
@@ -24,7 +24,10 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    maxItems: 2
+    items:
+      - description: AHB peripheral clock
+      - description: CAN bus clock
 
 required:
   - compatible
@@ -39,7 +42,7 @@ examples:
     can@2010c000 {
         compatible = "microchip,mpfs-can";
         reg = <0x2010c000 0x1000>;
-        clocks = <&clkcfg 17>;
+        clocks = <&clkcfg 17>, <&clkcfg 37>;
         interrupt-parent = <&plic>;
         interrupts = <56>;
     };
-- 
2.39.2


