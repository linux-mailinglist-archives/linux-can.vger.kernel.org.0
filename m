Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB62A9A7F
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgKFRLW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:22 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:33177 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgKFRLV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:21 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 14B64FFAAC
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:05:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DK8GzqEYYuEF for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:05:48 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 16/17] can: ems_usb: Added error handling part for CPC-USB/FD. Get some structures packed
Date:   Fri,  6 Nov 2020 18:02:05 +0100
Message-Id: <20201106170206.32162-17-uttenthaler@ems-wuensche.com>
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
 drivers/net/can/usb/ems_usb.c | 108 +++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 4a67c57c4760..7ede3ac08ed5 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -103,6 +103,23 @@ MODULE_LICENSE("GPL v2");
 
 #define SJA1000_DEFAULT_OUTPUT_CONTROL 0xDA
 
+#define LPC546XX_ERROR_MASK  0x07
+#define LPC546XX_ERROR_STUFF 0x01
+#define LPC546XX_ERROR_FORM  0x02
+#define LPC546XX_ERROR_ACK   0x03
+#define LPC546XX_ERROR_BIT1  0x04
+#define LPC546XX_ERROR_BIT0  0x05
+#define LPC546XX_ERROR_CRC   0x06
+#define LPC546XX_ERROR_EP    0x20
+#define LPC546XX_ERROR_EW    0x40
+#define LPC546XX_ERROR_BO    0x80
+
+#define LPC546XX_ACT_MASK 0x18
+#define LPC546XX_ACT_SYNC 0x00
+#define LPC546XX_ACT_IDLE 0x08
+#define LPC546XX_ACT_RX   0x10
+#define LPC546XX_ACT_TX   0x18
+
 #define SJA1000   2 // NXP basic CAN controller
 #define LPC546XX  5 // NXP CAN FD controller
 
@@ -217,20 +234,25 @@ struct cpc_confirm {
 };
 
 /* Structure for overrun conditions */
-struct cpc_overrun {
+struct __packed cpc_overrun {
 	u8 event;
 	u8 count;
 };
 
 /* SJA1000 CAN errors (compatible to NXP LPC2119) */
-struct cpc_sja1000_can_error {
+struct __packed cpc_sja1000_can_error {
 	u8 ecc;
 	u8 rxerr;
 	u8 txerr;
 };
 
+struct __packed cpc_lpc546xx_can_error {
+	__le32 psr; /* protocol status register */
+	__le32 ecr; /* error counter register */
+};
+
 /* structure for CAN error conditions */
-struct cpc_can_error {
+struct __packed cpc_can_error {
 	u8 ecode;
 
 	struct {
@@ -239,6 +261,7 @@ struct cpc_can_error {
 		/* Other controllers may also provide error code capture regs */
 		union {
 			struct cpc_sja1000_can_error sja1000;
+			struct cpc_lpc546xx_can_error lpc546xx;
 		} regs;
 	} cc;
 };
@@ -502,6 +525,85 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 				    CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
 			}
 		}
+
+		/* CPC-USB/FD */
+		else if (msg->msg.error.cc.cc_type == LPC546XX) {
+			struct net_device *netdev = dev->netdev;
+			u32 psr = msg->msg.error.cc.regs.lpc546xx.psr;
+			u8 txerr = (u8)msg->msg.error.cc.regs.lpc546xx.ecr;
+			u8 rxerr = (u8)(msg->msg.error.cc.regs.lpc546xx.ecr >> 8);
+
+			/* bus error interrupt */
+			dev->can.can_stats.bus_error++;
+
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+			switch (psr & LPC546XX_ERROR_MASK) {
+			case LPC546XX_ERROR_STUFF:
+				netdev_dbg(netdev, "stuff error\n");
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			case LPC546XX_ERROR_FORM:
+				netdev_dbg(netdev, "form error\n");
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case LPC546XX_ERROR_ACK:
+				netdev_dbg(netdev, "ack error\n");
+				cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+				break;
+			case LPC546XX_ERROR_BIT1:
+				netdev_dbg(netdev, "bit1 error\n");
+				cf->data[2] |= CAN_ERR_PROT_BIT1;
+				break;
+			case LPC546XX_ERROR_BIT0:
+				netdev_dbg(netdev, "bit0 error\n");
+				cf->data[2] |= CAN_ERR_PROT_BIT0;
+				break;
+			case LPC546XX_ERROR_CRC:
+				netdev_dbg(netdev, "CRC error\n");
+				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+				break;
+			default:
+				break;
+			}
+
+			/* Let activity flags decide direction */
+			switch (psr & LPC546XX_ACT_MASK) {
+			case LPC546XX_ACT_SYNC:
+				__attribute__((fallthrough));
+			case LPC546XX_ACT_IDLE:
+				__attribute__((fallthrough));
+			case LPC546XX_ACT_RX:
+				stats->rx_errors++;
+				break;
+			case LPC546XX_ACT_TX:
+				stats->tx_errors++;
+				break;
+			}
+
+			/* Error warning status */
+			if (psr & LPC546XX_ERROR_EW) {
+				cf->data[1] = (txerr > rxerr) ?
+					CAN_ERR_CRTL_TX_WARNING :
+					CAN_ERR_CRTL_RX_WARNING;
+				cf->can_id |= CAN_ERR_CRTL;
+			}
+
+			/* Error passive status */
+			if (psr & LPC546XX_ERROR_EP) {
+				cf->data[1] |= (txerr > rxerr) ?
+					CAN_ERR_CRTL_TX_PASSIVE :
+					CAN_ERR_CRTL_RX_PASSIVE;
+				cf->can_id |= CAN_ERR_CRTL;
+			}
+
+			/* Error bus off status */
+			if (psr & LPC546XX_ERROR_BO)
+				cf->can_id |= CAN_ERR_BUSOFF;
+
+			cf->data[6] = txerr;
+			cf->data[7] = rxerr;
+		}
 	} else if (msg->type == CPC_MSG_TYPE_OVERRUN) {
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
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
