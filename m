Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37EF488665
	for <lists+linux-can@lfdr.de>; Sat,  8 Jan 2022 22:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiAHVoR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Jan 2022 16:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiAHVoJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Jan 2022 16:44:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9598EC06173F
        for <linux-can@vger.kernel.org>; Sat,  8 Jan 2022 13:44:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n6JVP-0004dM-Kq
        for linux-can@vger.kernel.org; Sat, 08 Jan 2022 22:44:07 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A7F016D3A9E
        for <linux-can@vger.kernel.org>; Sat,  8 Jan 2022 21:43:54 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 1926B6D3A2C;
        Sat,  8 Jan 2022 21:43:49 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 365afe52;
        Sat, 8 Jan 2022 21:43:46 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 18/22] can: flexcan: add more quirks to describe RX path capabilities
Date:   Sat,  8 Jan 2022 22:43:41 +0100
Message-Id: <20220108214345.1848470-19-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108214345.1848470-1-mkl@pengutronix.de>
References: <20220108214345.1848470-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Most flexcan IP cores support 2 RX modes:
- FIFO
- mailbox

Some IP core versions cannot receive CAN RTR messages via mailboxes.
This patch adds quirks to document this.

This information will be used in a later patch to switch from FIFO to
more performant mailbox mode at the expense of losing the ability to
receive RTR messages. This trade off is beneficial in certain use
cases.

Link: https://lore.kernel.org/all/20220107193105.1699523-5-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 66 +++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ba52e70d6a16..57cebc415661 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -252,6 +252,12 @@
 #define FLEXCAN_QUIRK_NR_IRQ_3 BIT(12)
 /* Setup 16 mailboxes */
 #define FLEXCAN_QUIRK_NR_MB_16 BIT(13)
+/* Device supports RX via mailboxes */
+#define FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX BIT(14)
+/* Device supports RTR reception via mailboxes */
+#define FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR BIT(15)
+/* Device supports RX via FIFO */
+#define FLEXCAN_QUIRK_SUPPPORT_RX_FIFO BIT(16)
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -386,59 +392,78 @@ struct flexcan_priv {
 
 static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16,
+		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
+		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN,
+		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_imx25_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE,
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
-	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE,
+	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO,
 };
 
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-		FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR,
+		FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_imx8qm_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW,
+		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
 };
 
 static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
-		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC,
+		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_ECC,
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_USE_RX_MAILBOX,
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
-		FLEXCAN_QUIRK_SUPPORT_ECC,
+		FLEXCAN_QUIRK_SUPPORT_ECC |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
@@ -2164,8 +2189,25 @@ static int flexcan_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
-	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)) {
-		dev_err(&pdev->dev, "CAN-FD mode doesn't work with FIFO mode!\n");
+	    !((devtype_data->quirks &
+	       (FLEXCAN_QUIRK_USE_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+		FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR |
+		FLEXCAN_QUIRK_SUPPPORT_RX_FIFO)) ==
+	      (FLEXCAN_QUIRK_USE_RX_MAILBOX |
+	       FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+	       FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR))) {
+		dev_err(&pdev->dev, "CAN-FD mode doesn't work in RX-FIFO mode!\n");
+		return -EINVAL;
+	}
+
+	if ((devtype_data->quirks &
+	     (FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX |
+	      FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR)) ==
+	    FLEXCAN_QUIRK_SUPPPORT_RX_MAILBOX_RTR) {
+		dev_err(&pdev->dev,
+			"Quirks (0x%08x) inconsistent: RX_MAILBOX_RX supported but not RX_MAILBOX\n",
+			devtype_data->quirks);
 		return -EINVAL;
 	}
 
-- 
2.34.1


