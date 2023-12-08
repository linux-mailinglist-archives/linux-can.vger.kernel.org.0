Return-Path: <linux-can+bounces-79-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC280AA51
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E807B20BC7
	for <lists+linux-can@lfdr.de>; Fri,  8 Dec 2023 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B7B39AD0;
	Fri,  8 Dec 2023 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6PY/hgl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF643984F;
	Fri,  8 Dec 2023 17:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8994CC433B7;
	Fri,  8 Dec 2023 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702055599;
	bh=ZCkEJKSbYO46WRnXwuUSBhBTUa4iqWLls9v1ii/IqNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6PY/hglhQ1w3JJZwNubtebDN+QbGV6LA1LoPfwI0WujxyOH4OrJFVK+dWlL9YHSA
	 E5dVL/CuzfK+ds/e/JeBs2+J6uBCQZDK8ZIXrVHtNQ9ai/HF2sLpSJusrpI+tTz67Z
	 wwzkxlyQzTPUwxnjwoRa3N3+A6RGI68qUhKC0IHFcXPBTZMp7MFI3lrXaZFBcdh2gk
	 coaaIxeNY+HvADMolicYnMMkgg9qAW3FroiDzPIJMyNQphAiyO/mZTTWXK8hb0rTOj
	 H5ElzpGGh2JvPpOiJ72C6gseih85L1fyi+Qda7KzJg6CrAHGk8pcFuzxYdamtbz1Xo
	 nCHLtBbLJg8YA==
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
Subject: [PATCH RESEND v1 6/7] clk: microchip: mpfs: convert MSSPLL outputs to clk_divider
Date: Fri,  8 Dec 2023 17:12:28 +0000
Message-Id: <20231208-pretender-curtsy-3a04d8969c2b@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208-reenter-ajar-b6223e5134b3@spud>
References: <20231208-reenter-ajar-b6223e5134b3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=VdSF/MzrZnEXeRp1s66NVbnm6dEZIEnZVEN9BkdHG34=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFfhUlSa+aLuqfPc7mXNo1b5rKr5UlH1PtJvXaNS/+4 Jn/yra2o5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABO56MTwV9zxmL7epMbta98U GzlfyD8nemHdqi7Jx5t2ci4VnDuHcT3Db9YWtV2b11UeLtBlXbZyRo+mU8ApoTTe78q5we+vTxN n5gYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

After splitting the MSSPLL in two, the PLL outputs have become
open-coded versions of clk_divider. Drop the custom clk ops structs, and
instead use the generic clk_divider_ops.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 81 ++++++--------------------------
 1 file changed, 14 insertions(+), 67 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index f62269320b2a..ef4511186a23 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -61,13 +61,10 @@ struct mpfs_msspll_hw_clock {
 
 struct mpfs_msspll_out_hw_clock {
 	void __iomem *base;
-	struct clk_hw hw;
+	struct clk_divider output;
 	struct clk_init_data init;
 	unsigned int id;
 	u32 reg_offset;
-	u32 shift;
-	u32 width;
-	u32 flags;
 };
 
 #define to_mpfs_msspll_out_clk(_hw) container_of(_hw, struct mpfs_msspll_out_hw_clock, hw)
@@ -177,75 +174,25 @@ static int mpfs_clk_register_mssplls(struct device *dev, struct mpfs_msspll_hw_c
  * MSS PLL output clocks
  */
 
-static unsigned long mpfs_clk_msspll_out_recalc_rate(struct clk_hw *hw, unsigned long prate)
-{
-	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-	void __iomem *postdiv_addr = msspll_out_hw->base + msspll_out_hw->reg_offset;
-	u32 postdiv;
-
-	postdiv = readl_relaxed(postdiv_addr) >> msspll_out_hw->shift;
-	postdiv &= clk_div_mask(msspll_out_hw->width);
-
-	return prate / postdiv;
-}
-
-static long mpfs_clk_msspll_out_round_rate(struct clk_hw *hw, unsigned long rate,
-					   unsigned long *prate)
-{
-	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-
-	return divider_round_rate(hw, rate, prate, NULL, msspll_out_hw->width,
-				  msspll_out_hw->flags);
-}
-
-static int mpfs_clk_msspll_out_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long prate)
-{
-	struct mpfs_msspll_out_hw_clock *msspll_out_hw = to_mpfs_msspll_out_clk(hw);
-	void __iomem *postdiv_addr = msspll_out_hw->base + msspll_out_hw->reg_offset;
-	u32 postdiv;
-	int divider_setting;
-	unsigned long flags;
-
-	divider_setting = divider_get_val(rate, prate, NULL, msspll_out_hw->width,
-					  msspll_out_hw->flags);
-
-	if (divider_setting < 0)
-		return divider_setting;
-
-	spin_lock_irqsave(&mpfs_clk_lock, flags);
-
-	postdiv = readl_relaxed(postdiv_addr);
-	postdiv &= ~(clk_div_mask(msspll_out_hw->width) << msspll_out_hw->shift);
-	writel_relaxed(postdiv, postdiv_addr);
-
-	spin_unlock_irqrestore(&mpfs_clk_lock, flags);
-
-	return 0;
-}
-
-static const struct clk_ops mpfs_clk_msspll_out_ops = {
-	.recalc_rate = mpfs_clk_msspll_out_recalc_rate,
-	.round_rate = mpfs_clk_msspll_out_round_rate,
-	.set_rate = mpfs_clk_msspll_out_set_rate,
-};
-
 #define CLK_PLL_OUT(_id, _name, _parent, _flags, _shift, _width, _offset) {	\
 	.id = _id,								\
-	.shift = _shift,							\
-	.width = _width,							\
+	.output.shift = _shift,							\
+	.output.width = _width,							\
+	.output.table = NULL,							\
 	.reg_offset = _offset,							\
-	.flags = _flags,							\
-	.hw.init = CLK_HW_INIT(_name, _parent, &mpfs_clk_msspll_out_ops, 0),	\
+	.output.flags = _flags,							\
+	.output.hw.init = CLK_HW_INIT(_name, _parent, &clk_divider_ops, 0),	\
+	.output.lock = &mpfs_clk_lock,						\
 }
 
 static struct mpfs_msspll_out_hw_clock mpfs_msspll_out_clks[] = {
-	CLK_PLL_OUT(CLK_MSSPLL, "clk_msspll", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL, "clk_msspll", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
-	CLK_PLL_OUT(CLK_MSSPLL1, "clk_msspll1", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL1, "clk_msspll1", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV01_CR),
-	CLK_PLL_OUT(CLK_MSSPLL2, "clk_msspll2", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL2, "clk_msspll2", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV02_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
-	CLK_PLL_OUT(CLK_MSSPLL3, "clk_msspll3", "clk_msspll_internal", 0,
+	CLK_PLL_OUT(CLK_MSSPLL3, "clk_msspll3", "clk_msspll_internal", CLK_DIVIDER_ONE_BASED,
 		    MSSPLL_POSTDIV13_SHIFT, MSSPLL_POSTDIV_WIDTH, REG_MSSPLL_POSTDIV23_CR),
 };
 
@@ -259,13 +206,13 @@ static int mpfs_clk_register_msspll_outs(struct device *dev,
 	for (i = 0; i < num_clks; i++) {
 		struct mpfs_msspll_out_hw_clock *msspll_out_hw = &msspll_out_hws[i];
 
-		msspll_out_hw->base = data->msspll_base;
-		ret = devm_clk_hw_register(dev, &msspll_out_hw->hw);
+		msspll_out_hw->output.reg = data->msspll_base + msspll_out_hw->reg_offset;
+		ret = devm_clk_hw_register(dev, &msspll_out_hw->output.hw);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to register msspll out id: %d\n",
 					     msspll_out_hw->id);
 
-		data->hw_data.hws[msspll_out_hw->id] = &msspll_out_hw->hw;
+		data->hw_data.hws[msspll_out_hw->id] = &msspll_out_hw->output.hw;
 	}
 
 	return 0;
-- 
2.39.2


