Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740F52B0C3F
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKLSFK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:05:10 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:56066 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKLSFK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:05:10 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 76983FFAAD
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oipx-6FNgr7M for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:05:08 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 15/16] can: ems_usb: Added error reporting for CPC-USB/FD
Date:   Thu, 12 Nov 2020 19:03:45 +0100
Message-Id: <20201112180346.29070-16-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
References: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Added struct and defines to handle errors reported from CPC-USB/FD
accordingly. Added needed code for that purpose

Signed-off-by: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
---
 drivers/net/can/usb/ems_usb.c | 105 ++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 677ed4bc47b9..b94364d8f390 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -62,7 +62,9 @@ MODULE_LICENSE("GPL v2");
 
 /* CPC-USB/FD
  * Initialization is done with a generic CAN controller representation
+ * However error reporting brings two registers of the used controller type
  */
+#define CPC_CC_TYPE_LPC546XX 5
 #define CPC_CC_TYPE_GENERIC 6
 
 #define CPC_CAN_ECODE_ERRFRAME 0x01 /* Ecode type */
@@ -108,6 +110,25 @@ MODULE_LICENSE("GPL v2");
 
 #define SJA1000_DEFAULT_OUTPUT_CONTROL 0xDA
 
+/* CPC-USB/FD PSR */
+#define CPCFD_LEC_MASK  0x07
+#define CPCFD_LEC_STUFF 0x01
+#define CPCFD_LEC_FORM  0x02
+#define CPCFD_LEC_ACK   0x03
+#define CPCFD_LEC_BIT1  0x04
+#define CPCFD_LEC_BIT0  0x05
+#define CPCFD_LEC_CRC   0x06
+
+#define CPCFD_ERR_EP BIT(5)
+#define CPCFD_ERR_EW BIT(6)
+#define CPCFD_ERR_BO BIT(7)
+
+#define CPCFD_ACT_MASK 0x18
+#define CPCFD_ACT_SYNC 0x00
+#define CPCFD_ACT_IDLE 0x08
+#define CPCFD_ACT_RX   0x10
+#define CPCFD_ACT_TX   0x18
+
 /* CPC-USB/ARM7 actually uses a 16MHz clock to generate the CAN clock
  * but it expects SJA1000 bit settings based on 8MHz (is internally
  * converted).
@@ -230,6 +251,11 @@ struct __packed cpc_sja1000_can_error {
 	u8 txerr;
 };
 
+struct __packed cpc_lpc546xx_can_error {
+	__le32 psr; /* protocol status register */
+	__le32 ecr; /* error counter register */
+};
+
 /* structure for CAN error conditions */
 struct __packed cpc_can_error {
 	u8 ecode;
@@ -240,6 +266,7 @@ struct __packed cpc_can_error {
 		/* Other controllers may also provide error code capture regs */
 		union {
 			struct cpc_sja1000_can_error sja1000;
+			struct cpc_lpc546xx_can_error lpc546xx;
 		} regs;
 	} cc;
 };
@@ -504,6 +531,84 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 					       CAN_ERR_CRTL_RX_PASSIVE;
 			}
 		}
+		/* CPC-USB/FD */
+		else if (msg->msg.error.cc.cc_type == CPC_CC_TYPE_LPC546XX) {
+			struct net_device *netdev = dev->netdev;
+			u32 psr = le32_to_cpu(msg->msg.error.cc.regs.lpc546xx.psr);
+			u8 txerr = le32_to_cpu(msg->msg.error.cc.regs.lpc546xx.ecr);
+			u8 rxerr = le32_to_cpu(msg->msg.error.cc.regs.lpc546xx.ecr) >> 8;
+
+			/* bus error interrupt */
+			dev->can.can_stats.bus_error++;
+
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+			switch (psr & CPCFD_LEC_MASK) {
+			case CPCFD_LEC_STUFF:
+				netdev_dbg(netdev, "stuff error\n");
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			case CPCFD_LEC_FORM:
+				netdev_dbg(netdev, "form error\n");
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case CPCFD_LEC_ACK:
+				netdev_dbg(netdev, "ack error\n");
+				cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+				break;
+			case CPCFD_LEC_BIT1:
+				netdev_dbg(netdev, "bit1 error\n");
+				cf->data[2] |= CAN_ERR_PROT_BIT1;
+				break;
+			case CPCFD_LEC_BIT0:
+				netdev_dbg(netdev, "bit0 error\n");
+				cf->data[2] |= CAN_ERR_PROT_BIT0;
+				break;
+			case CPCFD_LEC_CRC:
+				netdev_dbg(netdev, "CRC error\n");
+				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+				break;
+			default:
+				break;
+			}
+
+			/* Let activity flags decide direction */
+			switch (psr & CPCFD_ACT_MASK) {
+			case CPCFD_ACT_SYNC:
+				/* fallthrough */
+			case CPCFD_ACT_IDLE:
+				/* fallthrough */
+			case CPCFD_ACT_RX:
+				stats->rx_errors++;
+				break;
+			case CPCFD_ACT_TX:
+				stats->tx_errors++;
+				break;
+			}
+
+			/* Error warning status */
+			if (psr & CPCFD_ERR_EW) {
+				cf->data[1] = (txerr > rxerr) ?
+					CAN_ERR_CRTL_TX_WARNING :
+					CAN_ERR_CRTL_RX_WARNING;
+				cf->can_id |= CAN_ERR_CRTL;
+			}
+
+			/* Error passive status */
+			if (psr & CPCFD_ERR_EP) {
+				cf->data[1] |= (txerr > rxerr) ?
+					CAN_ERR_CRTL_TX_PASSIVE :
+					CAN_ERR_CRTL_RX_PASSIVE;
+				cf->can_id |= CAN_ERR_CRTL;
+			}
+
+			/* Error bus off status */
+			if (psr & CPCFD_ERR_BO)
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
