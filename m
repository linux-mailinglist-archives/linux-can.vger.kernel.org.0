Return-Path: <linux-can+bounces-74-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0280AA39
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD5BB20BED
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F0F38FAF;
	Fri,  8 Dec 2023 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VABdvc3X"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691071DDF8;
	Fri,  8 Dec 2023 17:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4568C433CD;
	Fri,  8 Dec 2023 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702055576;
	bh=iSOH3A5QgqhsUj9+GFj8Hb2u5gLp0VTCfaRJ8xMnQ1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VABdvc3X+HfnTcOrHRSGRUAlP3Uu1ZxOXC3BOmQniPEwEvKAIf8IoNlcMYa50lrJz
	 16uCHntwA8hPcEbJoeoKu2M++xYwFNPcdVp1/y8/HTN/E6lut08HsKyVl+uuSvVlXE
	 C+M8qRtJipr+GhcqeMabuac5x1ckqTkeFgLuZc7xPGkQut7S3o+BFoZuqiPKK9TAeP
	 4/+rkiXDgyE6I3nrkkmkb26s1+916Xhb7XXKxph1y0nTUeqD/7sbFNZv5jtCAvPo6/
	 78anyRettPtws0obn4n8Q4SbOIYDTUSqHTZFRm2oYjHO8u3R+T/++NxLql6pVxT7ec
	 hwCqrh4TCECJg==
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
Subject: [PATCH RESEND v1 1/7] dt-bindings: clock: mpfs: add more MSSPLL output definitions
Date: Fri,  8 Dec 2023 17:12:23 +0000
Message-Id: <20231208-unripe-maximum-fc77f4967561@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=880; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IbMe5Hhtp7MV7Ctc98IUVkgW0I0cOo4e8OWx+9g0CX8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfuU+JieKTecHfDe752ckWn/icPKJfy8j7nDpGagsS b4oX2DdUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInYaTP895jzPVshhKlxzoHU gpCrj+ZY3rrPoMV6z5xjYsLJe2rc3xn+KfKuLrouzmB/5vnhywLhrufmzys1Y37vX5fz11SfwWI ROwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

There are 3 undocumented outputs of the MSSPLL that are used for the CAN
bus, "user crypto" module and eMMC. Add their clock IDs so that they can
be hooked up in DT.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 include/dt-bindings/clock/microchip,mpfs-clock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/microchip,mpfs-clock.h b/include/dt-bindings/clock/microchip,mpfs-clock.h
index 79775a5134ca..b52f19a2b480 100644
--- a/include/dt-bindings/clock/microchip,mpfs-clock.h
+++ b/include/dt-bindings/clock/microchip,mpfs-clock.h
@@ -44,6 +44,11 @@
 
 #define CLK_RTCREF	33
 #define CLK_MSSPLL	34
+#define CLK_MSSPLL0	34
+#define CLK_MSSPLL1	35
+#define CLK_MSSPLL2	36
+#define CLK_MSSPLL3	37
+/* 38 is reserved for MSS PLL internals */
 
 /* Clock Conditioning Circuitry Clock IDs */
 
-- 
2.39.2


