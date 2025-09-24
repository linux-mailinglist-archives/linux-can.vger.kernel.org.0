Return-Path: <linux-can+bounces-4916-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC2B98CAD
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 10:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A052917F7DF
	for <lists+linux-can@lfdr.de>; Wed, 24 Sep 2025 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E23B28468D;
	Wed, 24 Sep 2025 08:21:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708627877B
	for <linux-can@vger.kernel.org>; Wed, 24 Sep 2025 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702104; cv=none; b=qBsrvwIUnDifJTCv+6XielMsrg59/A01LwDICXr+P3p9R+ekcZJrLbQ5zbPOw8IqvfLYKfCMg/9JKBebQy5vJGFxXJpz3WYw7pO6xAuXDZa2i5rEnR5P1mYC6VbV9XuxtueKM01Udz75RGIQMQ5h5zb6G37sd4ob3fKFjfa1xJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702104; c=relaxed/simple;
	bh=Z+mgbIeQ8c9l3ZfAwtgEeaWU5F5iZIfcMZO7EZcrn6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePWqxr+h4GQEstGORDMdmNdqL1lM+IzVaynUmPmcWerT3M0BGNQuh9iJexPp294xeoc8w8dx5qi/WFaq2GDuk91Uk2bNyWdn5udMqlj/NMHZM0wXPxtKkm0npoCtz2UGQ8TFW/jv1PDXGB8gYsZBOskszhNew6rYKdkP9sfeXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkd-0001E9-BC; Wed, 24 Sep 2025 10:21:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1Kkc-000DvZ-1o;
	Wed, 24 Sep 2025 10:21:22 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 37AAB47887C;
	Wed, 24 Sep 2025 08:21:08 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 12/48] can: rcar_can: Convert to BIT()
Date: Wed, 24 Sep 2025 10:06:29 +0200
Message-ID: <20250924082104.595459-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924082104.595459-1-mkl@pengutronix.de>
References: <20250924082104.595459-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use the BIT() macro instead of open-coding the same operation.
Add a few more comments while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/78fb16beb74975f6f6140ec9abb48beb94fb0afa.1755857536.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 137 ++++++++++++++++----------------
 1 file changed, 69 insertions(+), 68 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 15dbaa52a7b1..c47ee4e41eb6 100644
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
+#define RCAR_CAN_TFCR_TFUST	(7 << 1)	/* Transmit FIFO Unsent Message */
+						/* Number Status Bits */
+#define RCAR_CAN_TFCR_TFUST_SHIFT 1		/* Offset of Transmit FIFO Unsent */
+						/* Message Number Status Bits */
+#define RCAR_CAN_TFCR_TFE	BIT(0)		/* Transmit FIFO Enable */
 
-#define RCAR_CAN_N_RX_MKREGS1	2	/* Number of mask registers */
-					/* for Rx mailboxes 0-31 */
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
2.51.0


