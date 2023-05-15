Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC18703ECB
	for <lists+linux-can@lfdr.de>; Mon, 15 May 2023 22:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245404AbjEOUrg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 15 May 2023 16:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245336AbjEOUre (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2023 16:47:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F302A5C6
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 13:47:33 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pyf6R-0004pv-5k
        for linux-can@vger.kernel.org; Mon, 15 May 2023 22:47:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 6FFC61C5C51
        for <linux-can@vger.kernel.org>; Mon, 15 May 2023 20:47:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id BC7E01C5C15;
        Mon, 15 May 2023 20:47:25 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id edd218b5;
        Mon, 15 May 2023 20:47:24 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 8/9] can: bxcan: add support for single peripheral configuration
Date:   Mon, 15 May 2023 22:47:21 +0200
Message-Id: <20230515204722.1000957-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515204722.1000957-1-mkl@pengutronix.de>
References: <20230515204722.1000957-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Add support for bxCAN controller in single peripheral configuration:
- primary bxCAN
- dedicated Memory Access Controller unit
- 512-byte SRAM memory
- 14 filter banks

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/all/20230427204540.3126234-5-dario.binacchi@amarulasolutions.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/bxcan.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index e26ccd41e3cb..027a8a162fe4 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -118,7 +118,7 @@
 #define BXCAN_FiR1_REG(b) (0x40 + (b) * 8)
 #define BXCAN_FiR2_REG(b) (0x44 + (b) * 8)
 
-#define BXCAN_FILTER_ID(primary) (primary ? 0 : 14)
+#define BXCAN_FILTER_ID(cfg) ((cfg) == BXCAN_CFG_DUAL_SECONDARY ? 14 : 0)
 
 /* Filter primary register (FMR) bits */
 #define BXCAN_FMR_CANSB_MASK GENMASK(13, 8)
@@ -135,6 +135,12 @@ enum bxcan_lec_code {
 	BXCAN_LEC_UNUSED
 };
 
+enum bxcan_cfg {
+	BXCAN_CFG_SINGLE = 0,
+	BXCAN_CFG_DUAL_PRIMARY,
+	BXCAN_CFG_DUAL_SECONDARY
+};
+
 /* Structure of the message buffer */
 struct bxcan_mb {
 	u32 id;			/* can identifier */
@@ -167,7 +173,7 @@ struct bxcan_priv {
 	struct regmap *gcan;
 	int tx_irq;
 	int sce_irq;
-	bool primary;
+	enum bxcan_cfg cfg;
 	struct clk *clk;
 	spinlock_t rmw_lock;	/* lock for read-modify-write operations */
 	unsigned int tx_head;
@@ -202,17 +208,17 @@ static inline void bxcan_rmw(struct bxcan_priv *priv, void __iomem *addr,
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 }
 
-static void bxcan_disable_filters(struct bxcan_priv *priv, bool primary)
+static void bxcan_disable_filters(struct bxcan_priv *priv, enum bxcan_cfg cfg)
 {
-	unsigned int fid = BXCAN_FILTER_ID(primary);
+	unsigned int fid = BXCAN_FILTER_ID(cfg);
 	u32 fmask = BIT(fid);
 
 	regmap_update_bits(priv->gcan, BXCAN_FA1R_REG, fmask, 0);
 }
 
-static void bxcan_enable_filters(struct bxcan_priv *priv, bool primary)
+static void bxcan_enable_filters(struct bxcan_priv *priv, enum bxcan_cfg cfg)
 {
-	unsigned int fid = BXCAN_FILTER_ID(primary);
+	unsigned int fid = BXCAN_FILTER_ID(cfg);
 	u32 fmask = BIT(fid);
 
 	/* Filter settings:
@@ -680,7 +686,7 @@ static int bxcan_chip_start(struct net_device *ndev)
 		  BXCAN_BTR_BRP_MASK | BXCAN_BTR_TS1_MASK | BXCAN_BTR_TS2_MASK |
 		  BXCAN_BTR_SJW_MASK, set);
 
-	bxcan_enable_filters(priv, priv->primary);
+	bxcan_enable_filters(priv, priv->cfg);
 
 	/* Clear all internal status */
 	priv->tx_head = 0;
@@ -806,7 +812,7 @@ static void bxcan_chip_stop(struct net_device *ndev)
 		  BXCAN_IER_EPVIE | BXCAN_IER_EWGIE | BXCAN_IER_FOVIE1 |
 		  BXCAN_IER_FFIE1 | BXCAN_IER_FMPIE1 | BXCAN_IER_FOVIE0 |
 		  BXCAN_IER_FFIE0 | BXCAN_IER_FMPIE0 | BXCAN_IER_TMEIE, 0);
-	bxcan_disable_filters(priv, priv->primary);
+	bxcan_disable_filters(priv, priv->cfg);
 	bxcan_enter_sleep_mode(priv);
 	priv->can.state = CAN_STATE_STOPPED;
 }
@@ -931,7 +937,7 @@ static int bxcan_probe(struct platform_device *pdev)
 	struct clk *clk = NULL;
 	void __iomem *regs;
 	struct regmap *gcan;
-	bool primary;
+	enum bxcan_cfg cfg;
 	int err, rx_irq, tx_irq, sce_irq;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
@@ -946,7 +952,13 @@ static int bxcan_probe(struct platform_device *pdev)
 		return PTR_ERR(gcan);
 	}
 
-	primary = of_property_read_bool(np, "st,can-primary");
+	if (of_property_read_bool(np, "st,can-primary"))
+		cfg = BXCAN_CFG_DUAL_PRIMARY;
+	else if (of_property_read_bool(np, "st,can-secondary"))
+		cfg = BXCAN_CFG_DUAL_SECONDARY;
+	else
+		cfg = BXCAN_CFG_SINGLE;
+
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to get clock\n");
@@ -992,7 +1004,7 @@ static int bxcan_probe(struct platform_device *pdev)
 	priv->clk = clk;
 	priv->tx_irq = tx_irq;
 	priv->sce_irq = sce_irq;
-	priv->primary = primary;
+	priv->cfg = cfg;
 	priv->can.clock.freq = clk_get_rate(clk);
 	spin_lock_init(&priv->rmw_lock);
 	priv->tx_head = 0;
-- 
2.39.2


