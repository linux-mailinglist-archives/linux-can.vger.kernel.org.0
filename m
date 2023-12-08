Return-Path: <linux-can+bounces-78-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135180AA4B
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFBE1F21378
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101B38FBE;
	Fri,  8 Dec 2023 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gve4KbqH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B851DDF8;
	Fri,  8 Dec 2023 17:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0285CC433CC;
	Fri,  8 Dec 2023 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702055595;
	bh=cvHj0CJs3ephVaZuvj3Ux2wXR9Tblc/RuJQlfKnG8ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gve4KbqHqOssmkDZ0lw8ymDKMQGoo2hi5IvNvbBdYPjCb3N0MKm0HtT5z2J0Xec+V
	 jsldg0umkd1P0PGCydELajMD+g11QVTmT+ZCKGU1DqS7lfq4bMiNkeYNJydojFQnrX
	 fbLZ+llObV7Hnw1r+l/J9tKCfCiYjgC6Fp9tzo73Z/Bih3EUYKkxfCAEEWV16yC8XI
	 cOFdDJuAje5S8gzRjZR4QUgOnjDk6ZuDGOX6liDYgXjKW/BoD3641OscVp+RdukCxe
	 x3HB/TZMI8RmAs2tDvDKdCv15mYB8hpeSj3ZgtozHUx9XcaZn1f1ZuIwyaX3e65mZe
	 g/gUPqUGqWKHw==
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
Subject: [PATCH RESEND v1 5/7] clk: microchip: mpfs: add missing MSSPLL outputs
Date: Fri,  8 Dec 2023 17:12:27 +0000
Message-Id: <20231208-amends-thus-6d7963f33357@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=3gU1OSn3YxaVElJ8X4nK41xe7sOdS/RS/naYsgWnvQ0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfhVMKVsmuZetDbTUDZL5e2sNq1ATU89FrqKJ5d1Sv 880r+TpKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwESunWdkmH8shfl5/ZHcvAzX 0P8n5nlE2v7NeDtL/dW0+waXXMreL2T4p9EuZOO/6pfdAu8zClO0ba7Ibjx9zeIBx5SIXRP392o W8AEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The MSSPLL has 4 outputs, of which only the cpu/axi/ahb clock parent is
currently implemented.
Add the CAN clock too, as that'll be needed by the driver for the CAN
controller and uses output 3.
While we are here, the other two missing clocks, used by the eMMC/SD
controller and by the "user crypto".

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 9edd0333e693..f62269320b2a 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -28,6 +28,7 @@
 #define MSSPLL_REFDIV_SHIFT	0x08u
 #define MSSPLL_REFDIV_WIDTH	0x06u
 #define MSSPLL_POSTDIV02_SHIFT	0x08u
+#define MSSPLL_POSTDIV13_SHIFT	0x18u
 #define MSSPLL_POSTDIV_WIDTH	0x07u
 #define MSSPLL_FIXED_DIV	4u
 
@@ -240,6 +241,12 @@ static const struct clk_ops mpfs_clk_msspll_out_ops = {
 static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
 	CLK_PLL_OUT(CLK_MSSPLL, "clk_msspll", "clk_msspll_internal", 0,
 		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
+	CLK_PLL_OUT(CLK_MSSPLL1, "clk_msspll1", "clk_msspll_internal", 0,
+		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
+	CLK_PLL_OUT(CLK_MSSPLL2, "clk_msspll2", "clk_msspll_internal", 0,
+		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
+	CLK_PLL_OUT(CLK_MSSPLL3, "clk_msspll3", "clk_msspll_internal", 0,
+		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
 };
 
 static int mpfs_clk_register_msspll_outs(struct device *dev,
-- 
2.39.2


