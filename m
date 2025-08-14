Return-Path: <linux-can+bounces-4236-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6BB264DE
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E52C4E0350
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF512FCBE0;
	Thu, 14 Aug 2025 12:02:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F402FCC0C;
	Thu, 14 Aug 2025 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172946; cv=none; b=pUWVAf7H74jXWt5NRD8vOw/6bV/L6M3eGLupxQrl2AktGFHgeO1thVvcqw9faG4IMtm1ctZnTHeVqlUUr87DVG5WZRcJZUXv3aobnDmBM4kanaWRuhCsaP0hCQR0PL7Rx18fLA/a6Fv3SywrCNZgAzK5+2TTp9pvyC+q6lLmAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172946; c=relaxed/simple;
	bh=xpCYB8DpwAm25jnIxonMh6YgUWBVYt8O309RbxR14tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIfL15V7N9EAZrNYufBL2efuVD6mHwTRKZM4PTmFG8Rq+LKNUyL5BLP3OKYPOwy7o086DCpz3bwisLooZeKXPFNH9sjNG1PyoUryUabDLEPgUvsY3l7NEq7bd4q2d67gwatiyQf5UXmVvfVS2KsxBWk7oa6FEuXkE56htbsNi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BBBC4CEEF;
	Thu, 14 Aug 2025 12:02:24 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/9] can: rcar_can: Convert to BIT()
Date: Thu, 14 Aug 2025 14:02:02 +0200
Message-ID: <499bb02f648611540959b19f01e976813b3902e2.1755172404.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755172404.git.geert+renesas@glider.be>
References: <cover.1755172404.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the BIT() macro instead of open-coding the same operation.
Add a few more comments while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I am not so fond of the need to add "(u8)" casts to various writeb()
calls that write an inverted bit definition, to get rid of "conversion
from ‘long unsigned int’ to ‘u8’ {aka ‘unsigned char’} changes value
from ‘<big value>’ to ‘<8-bit value>’"...
---
 drivers/net/can/rcar/rcar_can.c | 139 ++++++++++++++++----------------
 1 file changed, 70 insertions(+), 69 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index aecbb02c7dc9c90a..01e64a8b56e39be1 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 Renesas Solutions Corp.
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -116,36 +117,36 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 #define RCAR_CAN_CTLR_BOM	(3 << 11) /* Bus-Off Recovery Mode Bits */
 #define RCAR_CAN_CTLR_BOM_ENT	(1 << 11) /* Entry to halt mode */
 					/* at bus-off entry */
-#define RCAR_CAN_CTLR_SLPM	(1 << 10)
+#define RCAR_CAN_CTLR_SLPM	BIT(10)		/* Sleep Mode */
 #define RCAR_CAN_CTLR_CANM	(3 << 8) /* Operating Mode Select Bit */
 #define RCAR_CAN_CTLR_CANM_HALT	(1 << 9)
 #define RCAR_CAN_CTLR_CANM_RESET (1 << 8)
 #define RCAR_CAN_CTLR_CANM_FORCE_RESET (3 << 8)
-#define RCAR_CAN_CTLR_MLM	(1 << 3) /* Message Lost Mode Select */
+#define RCAR_CAN_CTLR_MLM	BIT(3)		/* Message Lost Mode Select */
 #define RCAR_CAN_CTLR_IDFM	(3 << 1) /* ID Format Mode Select Bits */
 #define RCAR_CAN_CTLR_IDFM_MIXED (1 << 2) /* Mixed ID mode */
-#define RCAR_CAN_CTLR_MBM	(1 << 0) /* Mailbox Mode select */
+#define RCAR_CAN_CTLR_MBM	BIT(0)		/* Mailbox Mode select */
 
 /* Status Register bits */
-#define RCAR_CAN_STR_RSTST	(1 << 8) /* Reset Status Bit */
+#define RCAR_CAN_STR_RSTST	BIT(8)		/* Reset Status Bit */
 
 /* FIFO Received ID Compare Registers 0 and 1 bits */
-#define RCAR_CAN_FIDCR_IDE	(1 << 31) /* ID Extension Bit */
-#define RCAR_CAN_FIDCR_RTR	(1 << 30) /* Remote Transmission Request Bit */
+#define RCAR_CAN_FIDCR_IDE	BIT(31)		/* ID Extension Bit */
+#define RCAR_CAN_FIDCR_RTR	BIT(30)		/* Remote Transmission Request Bit */
 
 /* Receive FIFO Control Register bits */
-#define RCAR_CAN_RFCR_RFEST	(1 << 7) /* Receive FIFO Empty Status Flag */
-#define RCAR_CAN_RFCR_RFE	(1 << 0) /* Receive FIFO Enable */
+#define RCAR_CAN_RFCR_RFEST	BIT(7)		/* Receive FIFO Empty Status Flag */
+#define RCAR_CAN_RFCR_RFE	BIT(0)		/* Receive FIFO Enable */
 
 /* Transmit FIFO Control Register bits */
-#define RCAR_CAN_TFCR_TFUST	(7 << 1) /* Transmit FIFO Unsent Message */
-					/* Number Status Bits */
-#define RCAR_CAN_TFCR_TFUST_SHIFT 1	/* Offset of Transmit FIFO Unsent */
-					/* Message Number Status Bits */
-#define RCAR_CAN_TFCR_TFE	(1 << 0) /* Transmit FIFO Enable */
-
-#define RCAR_CAN_N_RX_MKREGS1	2	/* Number of mask registers */
-					/* for Rx mailboxes 0-31 */
+#define RCAR_CAN_TFCR_TFUST	(7 << 1)	/* Transmit FIFO Unsent Message */
+						/* Number Status Bits */
+#define RCAR_CAN_TFCR_TFUST_SHIFT 1		/* Offset of Transmit FIFO Unsent */
+						/* Message Number Status Bits */
+#define RCAR_CAN_TFCR_TFE	BIT(0)		/* Transmit FIFO Enable */
+
+#define RCAR_CAN_N_RX_MKREGS1	2		/* Number of mask registers */
+						/* for Rx mailboxes 0-31 */
 #define RCAR_CAN_N_RX_MKREGS2	8
 
 /* Bit Configuration Register settings */
@@ -155,58 +156,58 @@ static const struct can_bittiming_const rcar_can_bittiming_const = {
 #define RCAR_CAN_BCR_TSEG2(x)	((x) & 0x07)
 
 /* Mailbox and Mask Registers bits */
-#define RCAR_CAN_IDE		(1 << 31)
-#define RCAR_CAN_RTR		(1 << 30)
+#define RCAR_CAN_IDE		BIT(31)		/* ID Extension */
+#define RCAR_CAN_RTR		BIT(30)		/* Remote Transmission Request */
 #define RCAR_CAN_SID_SHIFT	18
 
 /* Mailbox Interrupt Enable Register 1 bits */
-#define RCAR_CAN_MIER1_RXFIE	(1 << 28) /* Receive  FIFO Interrupt Enable */
-#define RCAR_CAN_MIER1_TXFIE	(1 << 24) /* Transmit FIFO Interrupt Enable */
+#define RCAR_CAN_MIER1_RXFIE	BIT(28)		/* Receive  FIFO Interrupt Enable */
+#define RCAR_CAN_MIER1_TXFIE	BIT(24)		/* Transmit FIFO Interrupt Enable */
 
 /* Interrupt Enable Register bits */
-#define RCAR_CAN_IER_ERSIE	(1 << 5) /* Error (ERS) Interrupt Enable Bit */
-#define RCAR_CAN_IER_RXFIE	(1 << 4) /* Reception FIFO Interrupt */
-					/* Enable Bit */
-#define RCAR_CAN_IER_TXFIE	(1 << 3) /* Transmission FIFO Interrupt */
-					/* Enable Bit */
+#define RCAR_CAN_IER_ERSIE	BIT(5)		/* Error (ERS) Interrupt Enable Bit */
+#define RCAR_CAN_IER_RXFIE	BIT(4)		/* Reception FIFO Interrupt */
+						/* Enable Bit */
+#define RCAR_CAN_IER_TXFIE	BIT(3)		/* Transmission FIFO Interrupt */
+						/* Enable Bit */
 /* Interrupt Status Register bits */
-#define RCAR_CAN_ISR_ERSF	(1 << 5) /* Error (ERS) Interrupt Status Bit */
-#define RCAR_CAN_ISR_RXFF	(1 << 4) /* Reception FIFO Interrupt */
-					/* Status Bit */
-#define RCAR_CAN_ISR_TXFF	(1 << 3) /* Transmission FIFO Interrupt */
-					/* Status Bit */
+#define RCAR_CAN_ISR_ERSF	BIT(5)		/* Error (ERS) Interrupt Status Bit */
+#define RCAR_CAN_ISR_RXFF	BIT(4)		/* Reception FIFO Interrupt */
+						/* Status Bit */
+#define RCAR_CAN_ISR_TXFF	BIT(3)		/* Transmission FIFO Interrupt */
+						/* Status Bit */
 
 /* Error Interrupt Enable Register bits */
-#define RCAR_CAN_EIER_BLIE	(1 << 7) /* Bus Lock Interrupt Enable */
-#define RCAR_CAN_EIER_OLIE	(1 << 6) /* Overload Frame Transmit */
-					/* Interrupt Enable */
-#define RCAR_CAN_EIER_ORIE	(1 << 5) /* Receive Overrun  Interrupt Enable */
-#define RCAR_CAN_EIER_BORIE	(1 << 4) /* Bus-Off Recovery Interrupt Enable */
-#define RCAR_CAN_EIER_BOEIE	(1 << 3) /* Bus-Off Entry Interrupt Enable */
-#define RCAR_CAN_EIER_EPIE	(1 << 2) /* Error Passive Interrupt Enable */
-#define RCAR_CAN_EIER_EWIE	(1 << 1) /* Error Warning Interrupt Enable */
-#define RCAR_CAN_EIER_BEIE	(1 << 0) /* Bus Error Interrupt Enable */
+#define RCAR_CAN_EIER_BLIE	BIT(7)		/* Bus Lock Interrupt Enable */
+#define RCAR_CAN_EIER_OLIE	BIT(6)		/* Overload Frame Transmit */
+						/* Interrupt Enable */
+#define RCAR_CAN_EIER_ORIE	BIT(5)		/* Receive Overrun  Interrupt Enable */
+#define RCAR_CAN_EIER_BORIE	BIT(4)		/* Bus-Off Recovery Interrupt Enable */
+#define RCAR_CAN_EIER_BOEIE	BIT(3)		/* Bus-Off Entry Interrupt Enable */
+#define RCAR_CAN_EIER_EPIE	BIT(2)		/* Error Passive Interrupt Enable */
+#define RCAR_CAN_EIER_EWIE	BIT(1)		/* Error Warning Interrupt Enable */
+#define RCAR_CAN_EIER_BEIE	BIT(0)		/* Bus Error Interrupt Enable */
 
 /* Error Interrupt Factor Judge Register bits */
-#define RCAR_CAN_EIFR_BLIF	(1 << 7) /* Bus Lock Detect Flag */
-#define RCAR_CAN_EIFR_OLIF	(1 << 6) /* Overload Frame Transmission */
-					 /* Detect Flag */
-#define RCAR_CAN_EIFR_ORIF	(1 << 5) /* Receive Overrun Detect Flag */
-#define RCAR_CAN_EIFR_BORIF	(1 << 4) /* Bus-Off Recovery Detect Flag */
-#define RCAR_CAN_EIFR_BOEIF	(1 << 3) /* Bus-Off Entry Detect Flag */
-#define RCAR_CAN_EIFR_EPIF	(1 << 2) /* Error Passive Detect Flag */
-#define RCAR_CAN_EIFR_EWIF	(1 << 1) /* Error Warning Detect Flag */
-#define RCAR_CAN_EIFR_BEIF	(1 << 0) /* Bus Error Detect Flag */
+#define RCAR_CAN_EIFR_BLIF	BIT(7)		/* Bus Lock Detect Flag */
+#define RCAR_CAN_EIFR_OLIF	BIT(6)		/* Overload Frame Transmission */
+						/* Detect Flag */
+#define RCAR_CAN_EIFR_ORIF	BIT(5)		/* Receive Overrun Detect Flag */
+#define RCAR_CAN_EIFR_BORIF	BIT(4)		/* Bus-Off Recovery Detect Flag */
+#define RCAR_CAN_EIFR_BOEIF	BIT(3)		/* Bus-Off Entry Detect Flag */
+#define RCAR_CAN_EIFR_EPIF	BIT(2)		/* Error Passive Detect Flag */
+#define RCAR_CAN_EIFR_EWIF	BIT(1)		/* Error Warning Detect Flag */
+#define RCAR_CAN_EIFR_BEIF	BIT(0)		/* Bus Error Detect Flag */
 
 /* Error Code Store Register bits */
-#define RCAR_CAN_ECSR_EDPM	(1 << 7) /* Error Display Mode Select Bit */
-#define RCAR_CAN_ECSR_ADEF	(1 << 6) /* ACK Delimiter Error Flag */
-#define RCAR_CAN_ECSR_BE0F	(1 << 5) /* Bit Error (dominant) Flag */
-#define RCAR_CAN_ECSR_BE1F	(1 << 4) /* Bit Error (recessive) Flag */
-#define RCAR_CAN_ECSR_CEF	(1 << 3) /* CRC Error Flag */
-#define RCAR_CAN_ECSR_AEF	(1 << 2) /* ACK Error Flag */
-#define RCAR_CAN_ECSR_FEF	(1 << 1) /* Form Error Flag */
-#define RCAR_CAN_ECSR_SEF	(1 << 0) /* Stuff Error Flag */
+#define RCAR_CAN_ECSR_EDPM	BIT(7)		/* Error Display Mode Select Bit */
+#define RCAR_CAN_ECSR_ADEF	BIT(6)		/* ACK Delimiter Error Flag */
+#define RCAR_CAN_ECSR_BE0F	BIT(5)		/* Bit Error (dominant) Flag */
+#define RCAR_CAN_ECSR_BE1F	BIT(4)		/* Bit Error (recessive) Flag */
+#define RCAR_CAN_ECSR_CEF	BIT(3)		/* CRC Error Flag */
+#define RCAR_CAN_ECSR_AEF	BIT(2)		/* ACK Error Flag */
+#define RCAR_CAN_ECSR_FEF	BIT(1)		/* Form Error Flag */
+#define RCAR_CAN_ECSR_SEF	BIT(0)		/* Stuff Error Flag */
 
 #define RCAR_CAN_NAPI_WEIGHT	4
 #define MAX_STR_READS		0x100
@@ -248,35 +249,35 @@ static void rcar_can_error(struct net_device *ndev)
 		if (ecsr & RCAR_CAN_ECSR_ADEF) {
 			netdev_dbg(priv->ndev, "ACK Delimiter Error\n");
 			tx_errors++;
-			writeb(~RCAR_CAN_ECSR_ADEF, &priv->regs->ecsr);
+			writeb((u8)~RCAR_CAN_ECSR_ADEF, &priv->regs->ecsr);
 			if (skb)
 				cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
 		}
 		if (ecsr & RCAR_CAN_ECSR_BE0F) {
 			netdev_dbg(priv->ndev, "Bit Error (dominant)\n");
 			tx_errors++;
-			writeb(~RCAR_CAN_ECSR_BE0F, &priv->regs->ecsr);
+			writeb((u8)~RCAR_CAN_ECSR_BE0F, &priv->regs->ecsr);
 			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_BIT0;
 		}
 		if (ecsr & RCAR_CAN_ECSR_BE1F) {
 			netdev_dbg(priv->ndev, "Bit Error (recessive)\n");
 			tx_errors++;
-			writeb(~RCAR_CAN_ECSR_BE1F, &priv->regs->ecsr);
+			writeb((u8)~RCAR_CAN_ECSR_BE1F, &priv->regs->ecsr);
 			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_BIT1;
 		}
 		if (ecsr & RCAR_CAN_ECSR_CEF) {
 			netdev_dbg(priv->ndev, "CRC Error\n");
 			rx_errors++;
-			writeb(~RCAR_CAN_ECSR_CEF, &priv->regs->ecsr);
+			writeb((u8)~RCAR_CAN_ECSR_CEF, &priv->regs->ecsr);
 			if (skb)
 				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		}
 		if (ecsr & RCAR_CAN_ECSR_AEF) {
 			netdev_dbg(priv->ndev, "ACK Error\n");
 			tx_errors++;
-			writeb(~RCAR_CAN_ECSR_AEF, &priv->regs->ecsr);
+			writeb((u8)~RCAR_CAN_ECSR_AEF, &priv->regs->ecsr);
 			if (skb) {
 				cf->can_id |= CAN_ERR_ACK;
 				cf->data[3] = CAN_ERR_PROT_LOC_ACK;
@@ -285,14 +286,14 @@ static void rcar_can_error(struct net_device *ndev)
 		if (ecsr & RCAR_CAN_ECSR_FEF) {
 			netdev_dbg(priv->ndev, "Form Error\n");
 			rx_errors++;
-			writeb(~RCAR_CAN_ECSR_FEF, &priv->regs->ecsr);
+			writeb((u8)~RCAR_CAN_ECSR_FEF, &priv->regs->ecsr);
 			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_FORM;
 		}
 		if (ecsr & RCAR_CAN_ECSR_SEF) {
 			netdev_dbg(priv->ndev, "Stuff Error\n");
 			rx_errors++;
-			writeb(~RCAR_CAN_ECSR_SEF, &priv->regs->ecsr);
+			writeb((u8)~RCAR_CAN_ECSR_SEF, &priv->regs->ecsr);
 			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_STUFF;
 		}
@@ -300,14 +301,14 @@ static void rcar_can_error(struct net_device *ndev)
 		priv->can.can_stats.bus_error++;
 		ndev->stats.rx_errors += rx_errors;
 		ndev->stats.tx_errors += tx_errors;
-		writeb(~RCAR_CAN_EIFR_BEIF, &priv->regs->eifr);
+		writeb((u8)~RCAR_CAN_EIFR_BEIF, &priv->regs->eifr);
 	}
 	if (eifr & RCAR_CAN_EIFR_EWIF) {
 		netdev_dbg(priv->ndev, "Error warning interrupt\n");
 		priv->can.state = CAN_STATE_ERROR_WARNING;
 		priv->can.can_stats.error_warning++;
 		/* Clear interrupt condition */
-		writeb(~RCAR_CAN_EIFR_EWIF, &priv->regs->eifr);
+		writeb((u8)~RCAR_CAN_EIFR_EWIF, &priv->regs->eifr);
 		if (skb)
 			cf->data[1] = txerr > rxerr ? CAN_ERR_CRTL_TX_WARNING :
 					      CAN_ERR_CRTL_RX_WARNING;
@@ -317,7 +318,7 @@ static void rcar_can_error(struct net_device *ndev)
 		priv->can.state = CAN_STATE_ERROR_PASSIVE;
 		priv->can.can_stats.error_passive++;
 		/* Clear interrupt condition */
-		writeb(~RCAR_CAN_EIFR_EPIF, &priv->regs->eifr);
+		writeb((u8)~RCAR_CAN_EIFR_EPIF, &priv->regs->eifr);
 		if (skb)
 			cf->data[1] = txerr > rxerr ? CAN_ERR_CRTL_TX_PASSIVE :
 					      CAN_ERR_CRTL_RX_PASSIVE;
@@ -329,7 +330,7 @@ static void rcar_can_error(struct net_device *ndev)
 		writeb(priv->ier, &priv->regs->ier);
 		priv->can.state = CAN_STATE_BUS_OFF;
 		/* Clear interrupt condition */
-		writeb(~RCAR_CAN_EIFR_BOEIF, &priv->regs->eifr);
+		writeb((u8)~RCAR_CAN_EIFR_BOEIF, &priv->regs->eifr);
 		priv->can.can_stats.bus_off++;
 		can_bus_off(ndev);
 		if (skb)
@@ -343,7 +344,7 @@ static void rcar_can_error(struct net_device *ndev)
 		netdev_dbg(priv->ndev, "Receive overrun error interrupt\n");
 		ndev->stats.rx_over_errors++;
 		ndev->stats.rx_errors++;
-		writeb(~RCAR_CAN_EIFR_ORIF, &priv->regs->eifr);
+		writeb((u8)~RCAR_CAN_EIFR_ORIF, &priv->regs->eifr);
 		if (skb) {
 			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
@@ -354,7 +355,7 @@ static void rcar_can_error(struct net_device *ndev)
 			   "Overload Frame Transmission error interrupt\n");
 		ndev->stats.rx_over_errors++;
 		ndev->stats.rx_errors++;
-		writeb(~RCAR_CAN_EIFR_OLIF, &priv->regs->eifr);
+		writeb((u8)~RCAR_CAN_EIFR_OLIF, &priv->regs->eifr);
 		if (skb) {
 			cf->can_id |= CAN_ERR_PROT;
 			cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
-- 
2.43.0


