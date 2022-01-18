Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636D0491979
	for <lists+linux-can@lfdr.de>; Tue, 18 Jan 2022 03:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351369AbiARCyQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jan 2022 21:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345848AbiARCcG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jan 2022 21:32:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F40DC061746;
        Mon, 17 Jan 2022 18:31:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2316BB8122C;
        Tue, 18 Jan 2022 02:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CDCC36AEF;
        Tue, 18 Jan 2022 02:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642473098;
        bh=efwhqMUVu11F6VIjOBn0/lWVP3SRbyzArxdtcMX5RLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DS9vc8NEhItJRNS95HzaoWg77GNXndg1dQcytoH+G10PlOQqXZ7YCa2onIJmX3uqz
         spaP6oMrHJ5Flk5rvO/5T6p9SDKiX6rKpLXogz2AFaD2g3UDu2zjpIbctN/a8aTRRk
         PG0kHmrZ13pwOPferOOq14HYTU4uHxFCWIPLzo0QvDtydvRRqB5vQ/4LmRmcvbPWWc
         KITnKXYBbM7gOZv+CR33pCEemLTctAQIoMnNq7sqg7C1rizxXvKztmDdMBJtMxH5Dw
         PnHGkttA59JUKwSEBxw0LGX5hdkH/PGsymIPEFAClicv940nNX9Bv4kCpBN3UXllty
         3aCew+AYd5+YQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, wg@grandegger.com,
        davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 214/217] can: flexcan: rename RX modes
Date:   Mon, 17 Jan 2022 21:19:37 -0500
Message-Id: <20220118021940.1942199-214-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 34ea4e1c99f1f177f87e4ae7896caef238dd741a ]

Most flexcan IP cores support 2 RX modes:
- FIFO
- mailbox

The names for these modes were chosen to reflect the name of the
rx-offload mode they are using.

The name of the RX modes should better reflect their difference with
regards the flexcan IP core. So this patch renames the various
occurrences of OFF_FIFO to RX_FIFO and OFF_TIMESTAMP to RX_MAILBOX:

| FLEXCAN_TX_MB_RESERVED_OFF_FIFO -> FLEXCAN_TX_MB_RESERVED_RX_FIFO
| FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP -> FLEXCAN_TX_MB_RESERVED_RX_MAILBOX
| FLEXCAN_QUIRK_USE_OFF_TIMESTAMP -> FLEXCAN_QUIRK_USE_RX_MAILBOX

Link: https://lore.kernel.org/all/20220107193105.1699523-4-mkl@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan.c | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 26bf0a0a72f1d..ba52e70d6a166 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -173,9 +173,9 @@
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
-#define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
-#define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
-#define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP + 1)
+#define FLEXCAN_TX_MB_RESERVED_RX_FIFO	8
+#define FLEXCAN_TX_MB_RESERVED_RX_MAILBOX	0
+#define FLEXCAN_RX_MB_RX_MAILBOX_FIRST	(FLEXCAN_TX_MB_RESERVED_RX_MAILBOX + 1)
 #define FLEXCAN_IFLAG_MB(x)		BIT_ULL(x)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
@@ -234,8 +234,8 @@
 #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS  BIT(3)
 /* Disable non-correctable errors interrupt and freeze mode */
 #define FLEXCAN_QUIRK_DISABLE_MECR BIT(4)
-/* Use timestamp based offloading */
-#define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP BIT(5)
+/* Use mailboxes (not FIFO) for RX path */
+#define FLEXCAN_QUIRK_USE_RX_MAILBOX BIT(5)
 /* No interrupt for error passive */
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE BIT(6)
 /* default to BE register access */
@@ -406,38 +406,38 @@ static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
 
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR,
 };
 
 static const struct flexcan_devtype_data fsl_imx8qm_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SETUP_STOP_MODE_SCFW,
 };
 
 static struct flexcan_devtype_data fsl_imx8mp_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SETUP_STOP_MODE_GPR |
 		FLEXCAN_QUIRK_SUPPORT_FD | FLEXCAN_QUIRK_SUPPORT_ECC,
 };
 
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_RX_MAILBOX |
 		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_SUPPORT_ECC,
 };
 
 static const struct flexcan_devtype_data fsl_ls1021a_r2_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE | FLEXCAN_QUIRK_USE_RX_MAILBOX,
 };
 
 static const struct flexcan_devtype_data fsl_lx2160a_r1_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
-		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_SUPPORT_FD |
+		FLEXCAN_QUIRK_USE_RX_MAILBOX | FLEXCAN_QUIRK_SUPPORT_FD |
 		FLEXCAN_QUIRK_SUPPORT_ECC,
 };
 
@@ -1022,7 +1022,7 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 
 	mb = flexcan_get_mb(priv, n);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
 		u32 code;
 
 		do {
@@ -1087,7 +1087,7 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 	}
 
  mark_as_read:
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
 		flexcan_write64(priv, FLEXCAN_IFLAG_MB(n), &regs->iflag1);
 	else
 		priv->write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
@@ -1113,7 +1113,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	enum can_state last_state = priv->can.state;
 
 	/* reception interrupt */
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
 		u64 reg_iflag_rx;
 		int ret;
 
@@ -1429,20 +1429,20 @@ static int flexcan_rx_offload_setup(struct net_device *dev)
 		priv->mb_count = (sizeof(priv->regs->mb[0]) / priv->mb_size) +
 				 (sizeof(priv->regs->mb[1]) / priv->mb_size);
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
 		priv->tx_mb_reserved =
-			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP);
+			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_RX_MAILBOX);
 	else
 		priv->tx_mb_reserved =
-			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_OFF_FIFO);
+			flexcan_get_mb(priv, FLEXCAN_TX_MB_RESERVED_RX_FIFO);
 	priv->tx_mb_idx = priv->mb_count - 1;
 	priv->tx_mb = flexcan_get_mb(priv, priv->tx_mb_idx);
 	priv->tx_mask = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-		priv->offload.mb_first = FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST;
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
+		priv->offload.mb_first = FLEXCAN_RX_MB_RX_MAILBOX_FIRST;
 		priv->offload.mb_last = priv->mb_count - 2;
 
 		priv->rx_mask = GENMASK_ULL(priv->offload.mb_last,
@@ -1532,10 +1532,10 @@ static int flexcan_chip_start(struct net_device *dev)
 	/* MCR
 	 *
 	 * FIFO:
-	 * - disable for timestamp mode
+	 * - disable for mailbox mode
 	 * - enable for FIFO mode
 	 */
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
 		reg_mcr &= ~FLEXCAN_MCR_FEN;
 	else
 		reg_mcr |= FLEXCAN_MCR_FEN;
@@ -1631,7 +1631,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		priv->write(reg_fdctrl, &regs->fdctrl);
 	}
 
-	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX) {
 		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++) {
 			mb = flexcan_get_mb(priv, i);
 			priv->write(FLEXCAN_MB_CODE_RX_EMPTY,
@@ -1639,7 +1639,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		}
 	} else {
 		/* clear and invalidate unused mailboxes first */
-		for (i = FLEXCAN_TX_MB_RESERVED_OFF_FIFO; i < priv->mb_count; i++) {
+		for (i = FLEXCAN_TX_MB_RESERVED_RX_FIFO; i < priv->mb_count; i++) {
 			mb = flexcan_get_mb(priv, i);
 			priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
 				    &mb->can_ctrl);
@@ -2164,7 +2164,7 @@ static int flexcan_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	if ((devtype_data->quirks & FLEXCAN_QUIRK_SUPPORT_FD) &&
-	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)) {
+	    !(devtype_data->quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)) {
 		dev_err(&pdev->dev, "CAN-FD mode doesn't work with FIFO mode!\n");
 		return -EINVAL;
 	}
-- 
2.34.1

