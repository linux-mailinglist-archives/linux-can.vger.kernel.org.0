Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E237399A1
	for <lists+linux-can@lfdr.de>; Thu, 22 Jun 2023 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFVI2D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 22 Jun 2023 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFVI15 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 22 Jun 2023 04:27:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692A2688
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 01:27:34 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qCFf2-00036z-Uf
        for linux-can@vger.kernel.org; Thu, 22 Jun 2023 10:27:25 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id BB1BE1DF43C
        for <linux-can@vger.kernel.org>; Thu, 22 Jun 2023 08:27:06 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4F13F1DF3DC;
        Thu, 22 Jun 2023 08:27:05 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 4a36fa86;
        Thu, 22 Jun 2023 08:27:02 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 30/33] can: kvaser_pciefd: Use FIELD_{GET,PREP} and GENMASK where appropriate
Date:   Thu, 22 Jun 2023 10:26:55 +0200
Message-Id: <20230622082658.571150-31-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622082658.571150-1-mkl@pengutronix.de>
References: <20230622082658.571150-1-mkl@pengutronix.de>
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

From: Jimmy Assarsson <extja@kvaser.com>

Replace opencoded masking and shifting, with GENMASK, FIELD_GET and
FIELD_PREP macros.

Suggested-by: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-12-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 168 +++++++++++++++++---------------
 1 file changed, 89 insertions(+), 79 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index d2e520f9eaa7..8779091c448c 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -5,6 +5,7 @@
  *  - PEAK linux canfd driver
  */
 
+#include <linux/bitfield.h>
 #include <linux/can/dev.h>
 #include <linux/device.h>
 #include <linux/ethtool.h>
@@ -26,7 +27,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_BEC_POLL_FREQ (jiffies + msecs_to_jiffies(200))
 #define KVASER_PCIEFD_MAX_ERR_REP 256U
 #define KVASER_PCIEFD_CAN_TX_MAX_COUNT 17U
-#define KVASER_PCIEFD_MAX_CAN_CHANNELS 4U
+#define KVASER_PCIEFD_MAX_CAN_CHANNELS 4UL
 #define KVASER_PCIEFD_DMA_COUNT 2U
 
 #define KVASER_PCIEFD_DMA_SIZE (4U * 1024U)
@@ -79,15 +80,16 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 
 /* PCI interrupt fields */
 #define KVASER_PCIEFD_IRQ_SRB BIT(4)
-#define KVASER_PCIEFD_IRQ_ALL_MSK 0x1f
+#define KVASER_PCIEFD_IRQ_ALL_MASK GENMASK(4, 0)
 
 /* Enable 64-bit DMA address translation */
 #define KVASER_PCIEFD_64BIT_DMA_BIT BIT(0)
 
 /* System build information fields */
-#define KVASER_PCIEFD_SYSID_NRCHAN_SHIFT 24
-#define KVASER_PCIEFD_SYSID_MAJOR_VER_SHIFT 16
-#define KVASER_PCIEFD_SYSID_BUILD_VER_SHIFT 1
+#define KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK GENMASK(31, 24)
+#define KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK GENMASK(23, 16)
+#define KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK GENMASK(7, 0)
+#define KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK GENMASK(15, 1)
 
 /* Reset DMA buffer 0, 1 and FIFO offset */
 #define KVASER_PCIEFD_SRB_CMD_RDB1 BIT(5)
@@ -110,17 +112,18 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SRB_STAT_DI BIT(15)
 
 /* SRB current packet level */
-#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK 0xff
+#define KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK GENMASK(7, 0)
 
 /* DMA Enable */
 #define KVASER_PCIEFD_SRB_CTRL_DMA_ENABLE BIT(0)
 
 /* KCAN CTRL packet types */
-#define KVASER_PCIEFD_KCAN_CTRL_EFLUSH (4 << 29)
-#define KVASER_PCIEFD_KCAN_CTRL_EFRAME (5 << 29)
+#define KVASER_PCIEFD_KCAN_CTRL_TYPE_MASK GENMASK(31, 29)
+#define KVASER_PCIEFD_KCAN_CTRL_TYPE_EFLUSH 0x4
+#define KVASER_PCIEFD_KCAN_CTRL_TYPE_EFRAME 0x5
 
 /* Command sequence number */
-#define KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT 16
+#define KVASER_PCIEFD_KCAN_CMD_SEQ_MASK GENMASK(23, 16)
 /* Abort, flush and reset */
 #define KVASER_PCIEFD_KCAN_CMD_AT BIT(1)
 /* Request status packet */
@@ -148,10 +151,12 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_IRQ_TAR BIT(0)
 
 /* Tx FIFO size */
-#define KVASER_PCIEFD_KCAN_TX_NPACKETS_MAX_SHIFT 16
+#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK GENMASK(23, 16)
+/* Tx FIFO current packet level */
+#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK GENMASK(7, 0)
 
 /* Current status packet sequence number */
-#define KVASER_PCIEFD_KCAN_STAT_SEQNO_SHIFT 24
+#define KVASER_PCIEFD_KCAN_STAT_SEQNO_MASK GENMASK(31, 24)
 /* Controller got CAN FD capability */
 #define KVASER_PCIEFD_KCAN_STAT_FD BIT(19)
 /* Controller got one-shot capability */
@@ -187,12 +192,14 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_MODE_RM BIT(8)
 
 /* BTRN and BTRD fields */
-#define KVASER_PCIEFD_KCAN_BTRN_TSEG2_SHIFT 26
-#define KVASER_PCIEFD_KCAN_BTRN_TSEG1_SHIFT 17
-#define KVASER_PCIEFD_KCAN_BTRN_SJW_SHIFT 13
+#define KVASER_PCIEFD_KCAN_BTRN_TSEG2_MASK GENMASK(30, 26)
+#define KVASER_PCIEFD_KCAN_BTRN_TSEG1_MASK GENMASK(25, 17)
+#define KVASER_PCIEFD_KCAN_BTRN_SJW_MASK GENMASK(16, 13)
+#define KVASER_PCIEFD_KCAN_BTRN_BRP_MASK GENMASK(12, 0)
 
 /* PWM Control fields */
-#define KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT 16
+#define KVASER_PCIEFD_KCAN_PWM_TOP_MASK GENMASK(23, 16)
+#define KVASER_PCIEFD_KCAN_PWM_TRIGGER_MASK GENMASK(7, 0)
 
 /* KCAN packet type IDs */
 #define KVASER_PCIEFD_PACK_TYPE_DATA 0
@@ -206,13 +213,14 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_PACK_TYPE_BUS_LOAD 9
 
 /* Common KCAN packet definitions, second word */
-#define KVASER_PCIEFD_PACKET_TYPE_SHIFT 28
-#define KVASER_PCIEFD_PACKET_CHID_SHIFT 25
-#define KVASER_PCIEFD_PACKET_SEQ_MSK 0xff
+#define KVASER_PCIEFD_PACKET_TYPE_MASK GENMASK(31, 28)
+#define KVASER_PCIEFD_PACKET_CHID_MASK GENMASK(27, 25)
+#define KVASER_PCIEFD_PACKET_SEQ_MASK GENMASK(7, 0)
 
 /* KCAN Transmit/Receive data packet, first word */
 #define KVASER_PCIEFD_RPACKET_IDE BIT(30)
 #define KVASER_PCIEFD_RPACKET_RTR BIT(29)
+#define KVASER_PCIEFD_RPACKET_ID_MASK GENMASK(28, 0)
 /* KCAN Transmit data packet, second word */
 #define KVASER_PCIEFD_TPACKET_AREQ BIT(31)
 #define KVASER_PCIEFD_TPACKET_SMS BIT(16)
@@ -220,7 +228,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_RPACKET_FDF BIT(15)
 #define KVASER_PCIEFD_RPACKET_BRS BIT(14)
 #define KVASER_PCIEFD_RPACKET_ESI BIT(13)
-#define KVASER_PCIEFD_RPACKET_DLC_SHIFT 8
+#define KVASER_PCIEFD_RPACKET_DLC_MASK GENMASK(11, 8)
 
 /* KCAN Transmit acknowledge packet, first word */
 #define KVASER_PCIEFD_APACKET_NACK BIT(11)
@@ -233,7 +241,8 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_SPACK_IRM BIT(21)
 #define KVASER_PCIEFD_SPACK_IDET BIT(20)
 #define KVASER_PCIEFD_SPACK_BOFF BIT(16)
-#define KVASER_PCIEFD_SPACK_RXERR_SHIFT 8
+#define KVASER_PCIEFD_SPACK_RXERR_MASK GENMASK(15, 8)
+#define KVASER_PCIEFD_SPACK_TXERR_MASK GENMASK(7, 0)
 /* KCAN Status packet, second word */
 #define KVASER_PCIEFD_SPACK_EPLR BIT(24)
 #define KVASER_PCIEFD_SPACK_EWLR BIT(23)
@@ -318,7 +327,7 @@ static void kvaser_pciefd_request_status(struct kvaser_pciefd_can *can)
 	u32 cmd;
 
 	cmd = KVASER_PCIEFD_KCAN_CMD_SRQ;
-	cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
+	cmd |= FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq);
 	iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
 }
 
@@ -418,7 +427,7 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
 
 		/* If controller is already idle, run abort, flush and reset */
 		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
-		cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
+		cmd |= FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq);
 		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
 	} else if (!(status & KVASER_PCIEFD_KCAN_STAT_RMR)) {
 		u32 mode;
@@ -489,10 +498,10 @@ static void kvaser_pciefd_pwm_stop(struct kvaser_pciefd_can *can)
 
 	spin_lock_irqsave(&can->lock, irq);
 	pwm_ctrl = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
-	top = (pwm_ctrl >> KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT) & 0xff;
+	top = FIELD_GET(KVASER_PCIEFD_KCAN_PWM_TOP_MASK, pwm_ctrl);
 
 	/* Set duty cycle to zero */
-	pwm_ctrl |= top;
+	pwm_ctrl |= FIELD_PREP(KVASER_PCIEFD_KCAN_PWM_TRIGGER_MASK, top);
 	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
 	spin_unlock_irqrestore(&can->lock, irq);
 }
@@ -509,14 +518,14 @@ static void kvaser_pciefd_pwm_start(struct kvaser_pciefd_can *can)
 	/* Set frequency to 500 KHz*/
 	top = can->kv_pcie->bus_freq / (2 * 500000) - 1;
 
-	pwm_ctrl = top & 0xff;
-	pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
+	pwm_ctrl = FIELD_PREP(KVASER_PCIEFD_KCAN_PWM_TRIGGER_MASK, top);
+	pwm_ctrl |= FIELD_PREP(KVASER_PCIEFD_KCAN_PWM_TOP_MASK, top);
 	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
 
 	/* Set duty cycle to 95 */
 	trigger = (100 * top - 95 * (top + 1) + 50) / 100;
-	pwm_ctrl = trigger & 0xff;
-	pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
+	pwm_ctrl = FIELD_PREP(KVASER_PCIEFD_KCAN_PWM_TRIGGER_MASK, trigger);
+	pwm_ctrl |= FIELD_PREP(KVASER_PCIEFD_KCAN_PWM_TOP_MASK, top);
 	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
 	spin_unlock_irqrestore(&can->lock, irq);
 }
@@ -581,8 +590,8 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 	if (cf->can_id & CAN_EFF_FLAG)
 		p->header[0] |= KVASER_PCIEFD_RPACKET_IDE;
 
-	p->header[0] |= cf->can_id & CAN_EFF_MASK;
-	p->header[1] |= can_fd_len2dlc(cf->len) << KVASER_PCIEFD_RPACKET_DLC_SHIFT;
+	p->header[0] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_ID_MASK, cf->can_id);
+	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_RPACKET_DLC_MASK, can_fd_len2dlc(cf->len));
 	p->header[1] |= KVASER_PCIEFD_TPACKET_AREQ;
 
 	if (can_is_canfd_skb(skb)) {
@@ -593,7 +602,7 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 			p->header[1] |= KVASER_PCIEFD_RPACKET_ESI;
 	}
 
-	p->header[1] |= seq & KVASER_PCIEFD_PACKET_SEQ_MSK;
+	p->header[1] |= FIELD_PREP(KVASER_PCIEFD_PACKET_SEQ_MASK, seq);
 
 	packet_size = cf->len;
 	memcpy(p->data, cf->data, packet_size);
@@ -645,7 +654,8 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
 	}
 
-	count = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
+	count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
+			  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
 	/* No room for a new message, stop the queue until at least one
 	 * successful transmit
 	 */
@@ -670,12 +680,10 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
 	else
 		bt = &can->can.bittiming;
 
-	btrn = ((bt->phase_seg2 - 1) & 0x1f) <<
-	       KVASER_PCIEFD_KCAN_BTRN_TSEG2_SHIFT |
-	       (((bt->prop_seg + bt->phase_seg1) - 1) & 0x1ff) <<
-	       KVASER_PCIEFD_KCAN_BTRN_TSEG1_SHIFT |
-	       ((bt->sjw - 1) & 0xf) << KVASER_PCIEFD_KCAN_BTRN_SJW_SHIFT |
-	       ((bt->brp - 1) & 0x1fff);
+	btrn = FIELD_PREP(KVASER_PCIEFD_KCAN_BTRN_TSEG2_MASK, bt->phase_seg2 - 1) |
+	       FIELD_PREP(KVASER_PCIEFD_KCAN_BTRN_TSEG1_MASK, bt->prop_seg + bt->phase_seg1 - 1) |
+	       FIELD_PREP(KVASER_PCIEFD_KCAN_BTRN_SJW_MASK, bt->sjw - 1) |
+	       FIELD_PREP(KVASER_PCIEFD_KCAN_BTRN_BRP_MASK, bt->brp - 1);
 
 	spin_lock_irqsave(&can->lock, irq_flags);
 	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
@@ -771,7 +779,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 	for (i = 0; i < pcie->nr_channels; i++) {
 		struct net_device *netdev;
 		struct kvaser_pciefd_can *can;
-		u32 status, tx_npackets;
+		u32 status, tx_nr_packets_max;
 
 		netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
 				      KVASER_PCIEFD_CAN_TX_MAX_COUNT);
@@ -798,10 +806,10 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		/* Disable Bus load reporting */
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
 
-		tx_npackets = ioread32(can->reg_base +
-				       KVASER_PCIEFD_KCAN_TX_NPACKETS_REG);
-		if (((tx_npackets >> KVASER_PCIEFD_KCAN_TX_NPACKETS_MAX_SHIFT) &
-		      0xff) < KVASER_PCIEFD_CAN_TX_MAX_COUNT) {
+		tx_nr_packets_max =
+			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
+				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
+		if (tx_nr_packets_max < KVASER_PCIEFD_CAN_TX_MAX_COUNT) {
 			dev_err(&pcie->pci->dev,
 				"Max Tx count is smaller than expected\n");
 
@@ -924,8 +932,9 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
 
 	/* Empty Rx FIFO */
-	srb_packet_count = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG) &
-			   KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK;
+	srb_packet_count =
+		FIELD_GET(KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK,
+			  ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_RX_NR_PACKETS_REG));
 	while (srb_packet_count) {
 		/* Drop current packet in FIFO */
 		ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_FIFO_LAST_REG);
@@ -947,17 +956,17 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 
 static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 {
-	u32 sysid, srb_status, build;
+	u32 version, srb_status, build;
 
-	sysid = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_VERSION_REG);
+	version = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_VERSION_REG);
 	pcie->nr_channels = min(KVASER_PCIEFD_MAX_CAN_CHANNELS,
-				((sysid >> KVASER_PCIEFD_SYSID_NRCHAN_SHIFT) & 0xff));
+				FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_NR_CHAN_MASK, version));
 
 	build = ioread32(pcie->reg_base + KVASER_PCIEFD_SYSID_BUILD_REG);
-	dev_dbg(&pcie->pci->dev, "Version %u.%u.%u\n",
-		(sysid >> KVASER_PCIEFD_SYSID_MAJOR_VER_SHIFT) & 0xff,
-		sysid & 0xff,
-		(build >> KVASER_PCIEFD_SYSID_BUILD_VER_SHIFT) & 0x7fff);
+	dev_dbg(&pcie->pci->dev, "Version %lu.%lu.%lu\n",
+		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MAJOR_MASK, version),
+		FIELD_GET(KVASER_PCIEFD_SYSID_VERSION_MINOR_MASK, version),
+		FIELD_GET(KVASER_PCIEFD_SYSID_BUILD_SEQ_MASK, build));
 
 	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
@@ -986,7 +995,7 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	struct canfd_frame *cf;
 	struct can_priv *priv;
 	struct net_device_stats *stats;
-	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
+	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
@@ -1014,11 +1023,11 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		}
 	}
 
-	cf->can_id = p->header[0] & CAN_EFF_MASK;
+	cf->can_id = FIELD_GET(KVASER_PCIEFD_RPACKET_ID_MASK, p->header[0]);
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_IDE)
 		cf->can_id |= CAN_EFF_FLAG;
 
-	cf->len = can_fd_dlc2len(p->header[1] >> KVASER_PCIEFD_RPACKET_DLC_SHIFT);
+	cf->len = can_fd_dlc2len(FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK, p->header[1]));
 
 	if (p->header[0] & KVASER_PCIEFD_RPACKET_RTR) {
 		cf->can_id |= CAN_RTR_FLAG;
@@ -1095,8 +1104,8 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 
 	old_state = can->can.state;
 
-	bec.txerr = p->header[0] & 0xff;
-	bec.rxerr = (p->header[0] >> KVASER_PCIEFD_SPACK_RXERR_SHIFT) & 0xff;
+	bec.txerr = FIELD_GET(KVASER_PCIEFD_SPACK_TXERR_MASK, p->header[0]);
+	bec.rxerr = FIELD_GET(KVASER_PCIEFD_SPACK_RXERR_MASK, p->header[0]);
 
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state,
 				      &rx_state);
@@ -1145,7 +1154,7 @@ static int kvaser_pciefd_handle_error_packet(struct kvaser_pciefd *pcie,
 					     struct kvaser_pciefd_rx_packet *p)
 {
 	struct kvaser_pciefd_can *can;
-	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
+	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
@@ -1169,8 +1178,8 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 
 	old_state = can->can.state;
 
-	bec.txerr = p->header[0] & 0xff;
-	bec.rxerr = (p->header[0] >> KVASER_PCIEFD_SPACK_RXERR_SHIFT) & 0xff;
+	bec.txerr = FIELD_GET(KVASER_PCIEFD_SPACK_TXERR_MASK, p->header[0]);
+	bec.rxerr = FIELD_GET(KVASER_PCIEFD_SPACK_RXERR_MASK, p->header[0]);
 
 	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state,
 				      &rx_state);
@@ -1220,7 +1229,7 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 	struct kvaser_pciefd_can *can;
 	u8 cmdseq;
 	u32 status;
-	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
+	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
@@ -1228,34 +1237,35 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 	can = pcie->can[ch_id];
 
 	status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
-	cmdseq = (status >> KVASER_PCIEFD_KCAN_STAT_SEQNO_SHIFT) & 0xff;
+	cmdseq = FIELD_GET(KVASER_PCIEFD_KCAN_STAT_SEQNO_MASK, status);
 
 	/* Reset done, start abort and flush */
 	if (p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
 	    p->header[0] & KVASER_PCIEFD_SPACK_RMCD &&
 	    p->header[1] & KVASER_PCIEFD_SPACK_AUTO &&
-	    cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK) &&
+	    cmdseq == FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[1]) &&
 	    status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
 		u32 cmd;
 
 		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 			  can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
-		cmd |= ++can->cmd_seq << KVASER_PCIEFD_KCAN_CMD_SEQ_SHIFT;
+		cmd |= FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq);
 		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
 	} else if (p->header[0] & KVASER_PCIEFD_SPACK_IDET &&
 		   p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
-		   cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK) &&
+		   cmdseq == FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[1]) &&
 		   status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
 		/* Reset detected, send end of flush if no packet are in FIFO */
-		u8 count = ioread32(can->reg_base +
-				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
+		u8 count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
+				     ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
 
 		if (!count)
-			iowrite32(KVASER_PCIEFD_KCAN_CTRL_EFLUSH,
+			iowrite32(FIELD_PREP(KVASER_PCIEFD_KCAN_CTRL_TYPE_MASK,
+					     KVASER_PCIEFD_KCAN_CTRL_TYPE_EFLUSH),
 				  can->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG);
 	} else if (!(p->header[1] & KVASER_PCIEFD_SPACK_AUTO) &&
-		   cmdseq == (p->header[1] & KVASER_PCIEFD_PACKET_SEQ_MSK)) {
+		   cmdseq == FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[1])) {
 		/* Response to status request received */
 		kvaser_pciefd_handle_status_resp(can, p);
 		if (can->can.state != CAN_STATE_BUS_OFF &&
@@ -1306,7 +1316,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 {
 	struct kvaser_pciefd_can *can;
 	bool one_shot_fail = false;
-	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
+	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
@@ -1324,7 +1334,7 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 	if (p->header[0] & KVASER_PCIEFD_APACKET_FLU) {
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
-		int echo_idx = p->header[0] & KVASER_PCIEFD_PACKET_SEQ_MSK;
+		int echo_idx = FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[0]);
 		int dlc;
 		u8 count;
 		struct sk_buff *skb;
@@ -1333,8 +1343,8 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		if (skb)
 			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 		dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		count = ioread32(can->reg_base +
-				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
+		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
+				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
 
 		if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
 		    netif_queue_stopped(can->can.dev))
@@ -1355,7 +1365,7 @@ static int kvaser_pciefd_handle_eflush_packet(struct kvaser_pciefd *pcie,
 					      struct kvaser_pciefd_rx_packet *p)
 {
 	struct kvaser_pciefd_can *can;
-	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
+	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
 
 	if (ch_id >= pcie->nr_channels)
 		return -EIO;
@@ -1394,15 +1404,15 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 	pos += 2;
 	p->timestamp = le64_to_cpu(timestamp);
 
-	type = (p->header[1] >> KVASER_PCIEFD_PACKET_TYPE_SHIFT) & 0xf;
+	type = FIELD_GET(KVASER_PCIEFD_PACKET_TYPE_MASK, p->header[1]);
 	switch (type) {
 	case KVASER_PCIEFD_PACK_TYPE_DATA:
 		ret = kvaser_pciefd_handle_data_packet(pcie, p, &buffer[pos]);
 		if (!(p->header[0] & KVASER_PCIEFD_RPACKET_RTR)) {
 			u8 data_len;
 
-			data_len = can_fd_dlc2len(p->header[1] >>
-					       KVASER_PCIEFD_RPACKET_DLC_SHIFT);
+			data_len = can_fd_dlc2len(FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK,
+							    p->header[1]));
 			pos += DIV_ROUND_UP(data_len, 4);
 		}
 		break;
@@ -1520,7 +1530,7 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 
 	board_irq = ioread32(pcie->reg_base + KVASER_PCIEFD_IRQ_REG);
 
-	if (!(board_irq & KVASER_PCIEFD_IRQ_ALL_MSK))
+	if (!(board_irq & KVASER_PCIEFD_IRQ_ALL_MASK))
 		return IRQ_NONE;
 
 	if (board_irq & KVASER_PCIEFD_IRQ_SRB)
@@ -1612,7 +1622,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	iowrite32(KVASER_PCIEFD_IRQ_ALL_MSK,
+	iowrite32(KVASER_PCIEFD_IRQ_ALL_MASK,
 		  pcie->reg_base + KVASER_PCIEFD_IEN_REG);
 
 	/* Ready the DMA buffers */
-- 
2.40.1


