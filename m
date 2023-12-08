Return-Path: <linux-can+bounces-80-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A080AA56
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0479B20BE5
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D139855;
	Fri,  8 Dec 2023 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAmcUMkQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12001DDF8;
	Fri,  8 Dec 2023 17:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C14FC433CA;
	Fri,  8 Dec 2023 17:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702055604;
	bh=8ebnwItR1hA/vG3C99K441+Vr5JnEbuXL+hnQjJvrlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAmcUMkQgVIofiBroeXwmP8mYZXdKSioXvQqiTLBvW9FPtTQyLwDLPGNmlvNVFqQR
	 +uvda5arfvyt8eCWgXSMAye8qqDTSZ+PSAkqV9bZW28SldC4Mw0RJeD6uu91Vjcriu
	 apQz1mzct1m0LYg4klTqSlxLE6qgOEHKpKekm9fZgg4X2Zh7EVsseQWYA+a6yR/TF1
	 9zSisp+eO+ecV1QL2SW4sMhh42lDxErTvJ0MQZ+UB4l9Ja+swIeeXTfyFUjtrSV1Hb
	 Mt1jyhNSDg3fI/xKqdCPocb/CmYyU61CqN5q/3jKVB5H2LdS812ZRlZ1R57I/HbuXA
	 alZ+axg3839rw==
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
Subject: [PATCH RESEND v1 7/7] riscv: dts: microchip: add missing CAN bus clocks
Date: Fri,  8 Dec 2023 17:12:29 +0000
Message-Id: <20231208-resample-selection-3c2c8cecc489@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=RYPfJmYcs7V5ACe/34q2uMhx5X6TiyQw/MbNSCCgx2w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfhWd25pCLOOPcTcWOnLsarjXMGNLbUqY/C/Nuy4uX ksOVJ3pKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwEQazzL84f1mHnxx+6Gvt77X 30v2q376f8XhnOeVFya7hUQJGGkFrmb4H/WOae21x1cDEzZY1l1xvbswMWRqwJp1er9vPps4sey TOzMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
CAN bus clock. The bus clock was omitted when the binding was written,
but is required for operation. Make up for lost time and add to the DT.

Fixes: 38a71fc04895 ("riscv: dts: microchip: add mpfs's CAN controllers")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 266489d43912..4d70df0f908c 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -416,7 +416,7 @@ i2c1: i2c@2010b000 {
 		can0: can@2010c000 {
 			compatible = "microchip,mpfs-can";
 			reg = <0x0 0x2010c000 0x0 0x1000>;
-			clocks = <&clkcfg CLK_CAN0>;
+			clocks = <&clkcfg CLK_CAN0>, <&clkcfg CLK_MSSPLL3>;
 			interrupt-parent = <&plic>;
 			interrupts = <56>;
 			status = "disabled";
@@ -425,7 +425,7 @@ can0: can@2010c000 {
 		can1: can@2010d000 {
 			compatible = "microchip,mpfs-can";
 			reg = <0x0 0x2010d000 0x0 0x1000>;
-			clocks = <&clkcfg CLK_CAN1>;
+			clocks = <&clkcfg CLK_CAN1>, <&clkcfg CLK_MSSPLL3>;
 			interrupt-parent = <&plic>;
 			interrupts = <57>;
 			status = "disabled";
-- 
2.39.2


