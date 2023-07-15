Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC9E754871
	for <lists+linux-can@lfdr.de>; Sat, 15 Jul 2023 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjGOLdT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 15 Jul 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGOLdS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 15 Jul 2023 07:33:18 -0400
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 04:33:16 PDT
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E277B35A2
        for <linux-can@vger.kernel.org>; Sat, 15 Jul 2023 04:33:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689420371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S19A3FkW85iI4MOdVdogxGLjgMY/8iwm4JrY7sESR78=;
        b=cdJmkzztUHM/iqtbwjQjVkdiFsgm/eGDU+PkljtPsRl3jELhJy42itIlhqCej7tose959G
        HWkaa2M7uo5U5q7zbvOC/FOMHeDWjCFgMcxg+RQHOApUy4hUhXc0MKiCbadQoSBhf6RdOq
        njc8oIOkK0qqMmjsh1mBB9anhgLqPBo/4+clV+6dwGjnD+TbTeBFNKmLi5pcDTKF5/XR2P
        4byUU9a8JmBl8z9SJOdhHRCxPi14lrPbaVhAuh5Go+4973EgQG6ZWtPFx2lo3kQg6knWsl
        S2kO8GLro8HxzMtATj90i3jnjWUxse3KO9ZqyKVouEaFBfiZT3P9QrgvV14kCg==
From:   Jookia <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     John Watts <contact@jookia.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 4/4] can: sun4i_can: Correctly set acceptance registers on the D1
Date:   Sat, 15 Jul 2023 21:25:22 +1000
Message-ID: <20230715112523.2533742-5-contact@jookia.org>
In-Reply-To: <20230715112523.2533742-1-contact@jookia.org>
References: <20230715112523.2533742-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: John Watts <contact@jookia.org>

The Allwinner D1's CAN controllers have the ACPC and ACPM registers
moved down. Compensate for this by adding an offset quirk for the
acceptance registers.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/net/can/sun4i_can.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 06f2cf05aaf5..c508a328e38d 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -91,6 +91,8 @@
 #define SUN4I_REG_BUF12_ADDR	0x0070	/* CAN Tx/Rx Buffer 12 */
 #define SUN4I_REG_ACPC_ADDR	0x0040	/* CAN Acceptance Code 0 */
 #define SUN4I_REG_ACPM_ADDR	0x0044	/* CAN Acceptance Mask 0 */
+#define SUN4I_REG_ACPC_ADDR_D1	0x0028	/* CAN Acceptance Code 0 on the D1 */
+#define SUN4I_REG_ACPM_ADDR_D1	0x002C	/* CAN Acceptance Mask 0 on the D1 */
 #define SUN4I_REG_RBUF_RBACK_START_ADDR	0x0180	/* CAN transmit buffer start */
 #define SUN4I_REG_RBUF_RBACK_END_ADDR	0x01b0	/* CAN transmit buffer end */
 
@@ -205,9 +207,11 @@
  * struct sun4ican_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @acp_offset: Offset of ACPC and ACPM registers
  */
 struct sun4ican_quirks {
 	bool has_reset;
+	int acp_offset;
 };
 
 struct sun4ican_priv {
@@ -216,6 +220,7 @@ struct sun4ican_priv {
 	struct clk *clk;
 	struct reset_control *reset;
 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
+	int acp_offset;
 };
 
 static const struct can_bittiming_const sun4ican_bittiming_const = {
@@ -338,8 +343,8 @@ static int sun4i_can_start(struct net_device *dev)
 	}
 
 	/* set filters - we accept all */
-	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR);
-	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR);
+	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR + priv->acp_offset);
+	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR + priv->acp_offset);
 
 	/* clear error counters and error code capture */
 	writel(0, priv->base + SUN4I_REG_ERRC_ADDR);
@@ -768,14 +773,17 @@ static const struct ethtool_ops sun4ican_ethtool_ops = {
 
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
 	.has_reset = false,
+	.acp_offset = 0,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.has_reset = true,
+	.acp_offset = 0,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_d1 = {
 	.has_reset = true,
+	.acp_offset = (SUN4I_REG_ACPC_ADDR_D1 - SUN4I_REG_ACPC_ADDR),
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
@@ -877,6 +885,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 	priv->base = addr;
 	priv->clk = clk;
 	priv->reset = reset;
+	priv->acp_offset = quirks->acp_offset;
 	spin_lock_init(&priv->cmdreg_lock);
 
 	platform_set_drvdata(pdev, dev);
-- 
2.41.0

