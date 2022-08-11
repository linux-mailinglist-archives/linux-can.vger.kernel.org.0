Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB6458FA25
	for <lists+linux-can@lfdr.de>; Thu, 11 Aug 2022 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiHKJgX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Aug 2022 05:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiHKJgX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Aug 2022 05:36:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0319F92F73
        for <linux-can@vger.kernel.org>; Thu, 11 Aug 2022 02:36:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1oM4c0-0003He-Ep
        for linux-can@vger.kernel.org; Thu, 11 Aug 2022 11:36:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E3308C7564
        for <linux-can@vger.kernel.org>; Thu, 11 Aug 2022 09:36:19 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id AFE8DC7562;
        Thu, 11 Aug 2022 09:36:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bc0f0032;
        Thu, 11 Aug 2022 09:36:18 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next 2/2] can: flexcan: fix typo: FLEXCAN_QUIRK_SUPPPORT_* -> FLEXCAN_QUIRK_SUPPORT_*
Date:   Thu, 11 Aug 2022 11:36:17 +0200
Message-Id: <20220811093617.1861938-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811093617.1861938-1-mkl@pengutronix.de>
References: <20220811093617.1861938-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fix typo "FLEXCAN_QUIRK_SUPPPORT_*" -> "FLEXCAN_QUIRK_SUPPORT_".

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 56 +++++++++++++-------------
 drivers/net/can/flexcan/flexcan.h      | 20 ++++-----
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f857968efed7..bbe5b0c997f8 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -295,45 +295,45 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
 static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_imx25_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_imx8qm_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
 static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
@@ -341,23 +341,23 @@ static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_ECC |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_USE_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
@@ -365,8 +365,8 @@ static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
 		FLEXCAN_QUIRK_SUPPORT_ECC |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
@@ -2085,20 +2085,20 @@ static int flexcan_probe(struct platform_device *pdev)
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
 	    !((devtype_data->quirks &
 	       (FLEXCAN_QUIRK_USE_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR |
-		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO)) ==
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SUPPORT_RX_FIFO)) ==
 	      (FLEXCAN_QUIRK_USE_RX_MAILBOX |
-	       FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-	       FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR))) {
+	       FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+	       FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR))) {
 		dev_err(&pdev->dev, "CAN-FD mode doesn't work in RX-FIFO mode!\n");
 		return -EINVAL;
 	}
 
 	if ((devtype_data->quirks &
-	     (FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-	      FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR)) ==
-	    FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR) {
+	     (FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+	      FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR)) ==
+	    FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR) {
 		dev_err(&pdev->dev,
 			"Quirks (0x%08x) inconsistent: RX_MAILBOX_RX supported but not RX_MAILBOX\n",
 			devtype_data->quirks);
diff --git a/drivers/net/can/flexcan/flexcan.h b/drivers/net/can/flexcan/flexcan.h
index 8621a8ea1dea..025c3417031f 100644
--- a/drivers/net/can/flexcan/flexcan.h
+++ b/drivers/net/can/flexcan/flexcan.h
@@ -63,11 +63,11 @@
 /* Setup 16 mailboxes */
 #define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
 /* Device supports RX via mailboxes */
-#define FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX BIT(14)
+#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX BIT(14)
 /* Device supports RTR reception via mailboxes */
-#define FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR BIT(15)
+#define FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR BIT(15)
 /* Device supports RX via FIFO */
-#define FLEXCAN_QUIRK_SUPPPORT_RX_FIFO BIT(16)
+#define FLEXCAN_QUIRK_SUPPORT_RX_FIFO BIT(16)
 
 struct flexcan_devtype_data {
 	u32 quirks;		/* quirks needed for different IP cores */
@@ -121,7 +121,7 @@ flexcan_supports_rx_mailbox(const struct flexcan_priv *priv)
 {
 	const u32 quirks = priv->devtype_data.quirks;
 
-	return quirks & FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX;
+	return quirks & FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX;
 }
 
 static inline bool
@@ -129,10 +129,10 @@ flexcan_supports_rx_mailbox_rtr(const struct flexcan_priv *priv)
 {
 	const u32 quirks = priv->devtype_data.quirks;
 
-	return (quirks & (FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-			  FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR)) ==
-		(FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
-		 FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR);
+	return (quirks & (FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+			  FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR)) ==
+		(FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
+		 FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR);
 }
 
 static inline bool
@@ -140,7 +140,7 @@ flexcan_supports_rx_fifo(const struct flexcan_priv *priv)
 {
 	const u32 quirks = priv->devtype_data.quirks;
 
-	return quirks & FLEXCAN_QUIRK_SUPPPORT_RX_FIFO;
+	return quirks & FLEXCAN_QUIRK_SUPPORT_RX_FIFO;
 }
 
 static inline bool
@@ -149,7 +149,7 @@ flexcan_active_rx_rtr(const struct flexcan_priv *priv)
 	const u32 quirks = priv->devtype_data.quirks;
 
 	if (quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
-		if (quirks & FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR)
+		if (quirks & FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX_RTR)
 			return true;
 	} else {
 		/*  RX-FIFO is always RTR capable */
-- 
2.35.1


