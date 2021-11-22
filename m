Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27BE458CA0
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 11:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhKVKty (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 05:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbhKVKtx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Nov 2021 05:49:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB7C06173E
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 02:46:47 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c32so78693291lfv.4
        for <linux-can@vger.kernel.org>; Mon, 22 Nov 2021 02:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xWB86lLShMOvVXpcj6liSWQMqibhlefo7YzIyCndAFs=;
        b=NVM2yTFkeI20Q17ovDrj/12XWRhFICmqXXeCPY8oMh10umlW6fbpZMxDGGQ87jtORt
         BLv8AnvRYkzyu0GleR/yDgT8qWBOiZBpt9oNZ1GtDjr91O2qTGeNhKoeoucFORc2NXlE
         DloY7LVP88u+RofuHEoSzNxtAy8yPHJivPsoyaYJoJnc5MSt+3PeS8FHOpnIOniw1prC
         M4EuyRDomnXXorpj83CQvLP32a2piT/4bY1j7tezricJbWXH5+SiVz2sBSTCRaWtO/kt
         tbcV15Zj5iYn1hnH78nKXe8YswxdE8pDCbqQtjqUmleuKV0yUjMzAwDXiWr7h7PFkP8C
         olhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWB86lLShMOvVXpcj6liSWQMqibhlefo7YzIyCndAFs=;
        b=5WR4umo78J5WE65DiNKYyCrEbSuRI342g+bjux7vAOJqgTQO0ZhfVzceDej87uPjtt
         PaBHBUg0Ge9uWct6eLhSjyGADDzEBs/vi5II6Sl6quA1Dg2eSQ+RDzAqRLuJiwsUlcMa
         iNnZFfvPteGBR3CrjofOj2dcR0g9spOFl4Z6L8dXc5Az81a8FW6hi832DAF7rtlyyUAA
         3skUtVCUDfvC09xLnMEs6AvIEz0TjPn5qUujekD+yQMS9TfXrTAOCVNv4kAFy6B49UN7
         DqNFjoFPCrNHN0BPwuaUnwLsqKllViHnXnhpyxOsrOIk94wEc0zTxl/KPOE2cT54ll7h
         vnMA==
X-Gm-Message-State: AOAM531krqBUfbjF634Tp4KamgZa6XQaMqxfqGefvPDhFSx9TRDc44mK
        WI2EtFGntL+0hq0ZjBRaygwoj7V/cKdUWQ==
X-Google-Smtp-Source: ABdhPJx4YYbm7oORJJDG5wdR7Lb/yZeMhbEKW46eG/jE1YOu/FIUK0eNoiG1RFd8p1LtgUk/2NIXmA==
X-Received: by 2002:a05:651c:1787:: with SMTP id bn7mr47814602ljb.22.1637578005290;
        Mon, 22 Nov 2021 02:46:45 -0800 (PST)
Received: from boger-laptop.lan (81.5.99.121.dhcp.mipt-telecom.ru. [81.5.99.121])
        by smtp.gmail.com with ESMTPSA id bi24sm923538lfb.49.2021.11.22.02.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 02:46:44 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Evgeny Boger <boger@wirenboard.com>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-can@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: [PATCH 2/3] can: sun4i_can: add support for R40 CAN controller
Date:   Mon, 22 Nov 2021 13:46:15 +0300
Message-Id: <20211122104616.537156-3-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122104616.537156-1-boger@wirenboard.com>
References: <20211122104616.537156-1-boger@wirenboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Allwinner R40 (also known as A40i, T3, V40) has a CAN controller. The
controller is the same as in earlier A10 and A20 SoCs, but needs reset
line to be deasserted before use.

This patch adds a new compatible for R40 CAN controller. Depending
on the compatible, reset line can be requested from DT.

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
 drivers/net/can/sun4i_can.c | 61 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 54aa7c25c4de..24a61326915e 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -61,6 +61,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 
 #define DRV_NAME "sun4i_can"
 
@@ -200,10 +201,20 @@
 #define SUN4I_CAN_MAX_IRQ	20
 #define SUN4I_MODE_MAX_RETRIES	100
 
+/**
+ * struct sun4ican_quirks - Differences between SoC variants.
+ *
+ * @has_reset: SoC needs reset deasserted.
+ */
+struct sun4ican_quirks {
+	bool		has_reset;
+};
+
 struct sun4ican_priv {
 	struct can_priv can;
 	void __iomem *base;
 	struct clk *clk;
+	struct reset_control *reset;
 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
 };
 
@@ -702,6 +713,13 @@ static int sun4ican_open(struct net_device *dev)
 		goto exit_irq;
 	}
 
+	/* software reset deassert */
+	err = reset_control_deassert(priv->reset);
+	if (err) {
+		netdev_err(dev, "could not deassert CAN reset\n");
+		goto exit_soft_reset;
+	}
+
 	/* turn on clocking for CAN peripheral block */
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
@@ -723,6 +741,8 @@ static int sun4ican_open(struct net_device *dev)
 exit_can_start:
 	clk_disable_unprepare(priv->clk);
 exit_clock:
+	reset_control_assert(priv->reset);
+exit_soft_reset:
 	free_irq(dev->irq, dev);
 exit_irq:
 	close_candev(dev);
@@ -736,6 +756,7 @@ static int sun4ican_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	sun4i_can_stop(dev);
 	clk_disable_unprepare(priv->clk);
+	reset_control_assert(priv->reset);
 
 	free_irq(dev->irq, dev);
 	close_candev(dev);
@@ -750,8 +771,27 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_start_xmit = sun4ican_start_xmit,
 };
 
+static const struct sun4ican_quirks sun4ican_quirks_a10 = {
+	.has_reset = false,
+};
+
+static const struct sun4ican_quirks sun4ican_quirks_r40 = {
+	.has_reset = true,
+};
+
 static const struct of_device_id sun4ican_of_match[] = {
-	{.compatible = "allwinner,sun4i-a10-can"},
+	{
+		.compatible = "allwinner,sun4i-a10-can",
+		.data = &sun4ican_quirks_a10
+	},
+	{
+		.compatible = "allwinner,sun7i-a20-can",
+		.data = &sun4ican_quirks_a10
+	},
+	{
+		.compatible = "allwinner,sun8i-r40-can",
+		.data = &sun4ican_quirks_r40
+	},
 	{},
 };
 
@@ -771,10 +811,28 @@ static int sun4ican_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct clk *clk;
+	struct reset_control *reset = NULL;
 	void __iomem *addr;
 	int err, irq;
 	struct net_device *dev;
 	struct sun4ican_priv *priv;
+	const struct sun4ican_quirks *quirks;
+
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (!quirks) {
+		dev_err(&pdev->dev, "failed to determine the quirks to use\n");
+		err = -ENODEV;
+		goto exit;
+	}
+
+	if (quirks->has_reset) {
+		reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (IS_ERR(reset)) {
+			dev_err(&pdev->dev, "unable to request reset\n");
+			err = PTR_ERR(reset);
+			goto exit;
+		}
+	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
@@ -818,6 +876,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 				       CAN_CTRLMODE_3_SAMPLES;
 	priv->base = addr;
 	priv->clk = clk;
+	priv->reset = reset;
 	spin_lock_init(&priv->cmdreg_lock);
 
 	platform_set_drvdata(pdev, dev);
-- 
2.25.1

