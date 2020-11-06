Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9130C2A9A83
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKFRLX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:23 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:34361 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgKFRLV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 8D09CFFAB1
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gCYsWKNl2jVm for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:05:40 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 15/17] can: ems_usb: In CAN error handling routine checking which CAN controller type is issuing the error
Date:   Fri,  6 Nov 2020 18:02:04 +0100
Message-Id: <20201106170206.32162-16-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
References: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 77 +++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index c36f02eeec85..4a67c57c4760 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -103,6 +103,9 @@ MODULE_LICENSE("GPL v2");
 
 #define SJA1000_DEFAULT_OUTPUT_CONTROL 0xDA
 
+#define SJA1000   2 // NXP basic CAN controller
+#define LPC546XX  5 // NXP CAN FD controller
+
 /* CPC-USB/ARM7 actually uses a 16MHz clock to generate the CAN clock
  * but it expects SJA1000 bit settings based on 8MHz (is internally
  * converted).
@@ -441,6 +444,9 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	if (!skb)
 		return;
 
+	/* The CPC_MSG_TYPE_CAN_STATE works for both
+	 * CPC-USB/ARM7 and CPC-USB/FD
+	 */
 	if (msg->type == CPC_MSG_TYPE_CAN_STATE) {
 		u8 state = msg->msg.can_state;
 
@@ -458,40 +464,43 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 			dev->can.can_stats.error_passive++;
 		}
 	} else if (msg->type == CPC_MSG_TYPE_CAN_FRAME_ERROR) {
-		u8 ecc = msg->msg.error.cc.regs.sja1000.ecc;
-		u8 txerr = msg->msg.error.cc.regs.sja1000.txerr;
-		u8 rxerr = msg->msg.error.cc.regs.sja1000.rxerr;
-
-		/* bus error interrupt */
-		dev->can.can_stats.bus_error++;
-		stats->rx_errors++;
-
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-		switch (ecc & SJA1000_ECC_MASK) {
-		case SJA1000_ECC_BIT:
-			cf->data[2] |= CAN_ERR_PROT_BIT;
-			break;
-		case SJA1000_ECC_FORM:
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-			break;
-		case SJA1000_ECC_STUFF:
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-			break;
-		default:
-			cf->data[3] = ecc & SJA1000_ECC_SEG;
-			break;
-		}
-
-		/* Error occurred during transmission? */
-		if ((ecc & SJA1000_ECC_DIR) == 0)
-			cf->data[2] |= CAN_ERR_PROT_TX;
-
-		if (dev->can.state == CAN_STATE_ERROR_WARNING ||
-		    dev->can.state == CAN_STATE_ERROR_PASSIVE) {
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] = (txerr > rxerr) ?
-			    CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
+		// CPC-USB/ARM7
+		if (msg->msg.error.cc.cc_type == SJA1000) {
+			u8 ecc = msg->msg.error.cc.regs.sja1000.ecc;
+			u8 txerr = msg->msg.error.cc.regs.sja1000.txerr;
+			u8 rxerr = msg->msg.error.cc.regs.sja1000.rxerr;
+
+			/* bus error interrupt */
+			dev->can.can_stats.bus_error++;
+			stats->rx_errors++;
+
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+			switch (ecc & SJA1000_ECC_MASK) {
+			case SJA1000_ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case SJA1000_ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case SJA1000_ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				cf->data[3] = ecc & SJA1000_ECC_SEG;
+				break;
+			}
+
+			/* Error occurred during transmission? */
+			if ((ecc & SJA1000_ECC_DIR) == 0)
+				cf->data[2] |= CAN_ERR_PROT_TX;
+
+			if (dev->can.state == CAN_STATE_ERROR_WARNING ||
+			    dev->can.state == CAN_STATE_ERROR_PASSIVE) {
+				cf->can_id |= CAN_ERR_CRTL;
+				cf->data[1] = (txerr > rxerr) ?
+				    CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
+			}
 		}
 	} else if (msg->type == CPC_MSG_TYPE_OVERRUN) {
 		cf->can_id |= CAN_ERR_CRTL;
-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
