Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF96738524
	for <lists+linux-can@lfdr.de>; Wed, 21 Jun 2023 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjFUNaW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Jun 2023 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjFUN3y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Jun 2023 09:29:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316731BE6
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 06:29:40 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qBxty-00076G-3b
        for linux-can@vger.kernel.org; Wed, 21 Jun 2023 15:29:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id A6B1E1DE955
        for <linux-can@vger.kernel.org>; Wed, 21 Jun 2023 13:29:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 3EDF31DE91A;
        Wed, 21 Jun 2023 13:29:21 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 22632c08;
        Wed, 21 Jun 2023 13:29:17 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 32/33] can: kvaser_pciefd: Refactor code
Date:   Wed, 21 Jun 2023 15:29:13 +0200
Message-Id: <20230621132914.412546-33-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
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

Refactor code;
 - Format code
 - Rename variables and macros
 - Remove intermediate variables
 - Add/remove blank lines
 - Reduce scope of variables
 - Add helper functions

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-14-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 221 +++++++++++++-------------------
 1 file changed, 87 insertions(+), 134 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index e3d730264462..0321b70a3b71 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -70,7 +70,7 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_CMD_REG 0x400
 #define KVASER_PCIEFD_KCAN_IEN_REG 0x408
 #define KVASER_PCIEFD_KCAN_IRQ_REG 0x410
-#define KVASER_PCIEFD_KCAN_TX_NPACKETS_REG 0x414
+#define KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG 0x414
 #define KVASER_PCIEFD_KCAN_STAT_REG 0x418
 #define KVASER_PCIEFD_KCAN_MODE_REG 0x41c
 #define KVASER_PCIEFD_KCAN_BTRN_REG 0x420
@@ -124,6 +124,8 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 
 /* Command sequence number */
 #define KVASER_PCIEFD_KCAN_CMD_SEQ_MASK GENMASK(23, 16)
+/* Command bits */
+#define KVASER_PCIEFD_KCAN_CMD_MASK GENMASK(5, 0)
 /* Abort, flush and reset */
 #define KVASER_PCIEFD_KCAN_CMD_AT BIT(1)
 /* Request status packet */
@@ -172,9 +174,9 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 /* Abort request */
 #define KVASER_PCIEFD_KCAN_STAT_AR BIT(7)
 /* Controller is bus off */
-#define KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MSK (KVASER_PCIEFD_KCAN_STAT_AR | \
-	KVASER_PCIEFD_KCAN_STAT_BOFF | KVASER_PCIEFD_KCAN_STAT_RMR | \
-	KVASER_PCIEFD_KCAN_STAT_IRM)
+#define KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MASK \
+	(KVASER_PCIEFD_KCAN_STAT_AR | KVASER_PCIEFD_KCAN_STAT_BOFF | \
+	 KVASER_PCIEFD_KCAN_STAT_RMR | KVASER_PCIEFD_KCAN_STAT_IRM)
 
 /* Classic CAN mode */
 #define KVASER_PCIEFD_KCAN_MODE_CCM BIT(31)
@@ -202,15 +204,15 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
 #define KVASER_PCIEFD_KCAN_PWM_TRIGGER_MASK GENMASK(7, 0)
 
 /* KCAN packet type IDs */
-#define KVASER_PCIEFD_PACK_TYPE_DATA 0
-#define KVASER_PCIEFD_PACK_TYPE_ACK 1
-#define KVASER_PCIEFD_PACK_TYPE_TXRQ 2
-#define KVASER_PCIEFD_PACK_TYPE_ERROR 3
-#define KVASER_PCIEFD_PACK_TYPE_EFLUSH_ACK 4
-#define KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK 5
-#define KVASER_PCIEFD_PACK_TYPE_ACK_DATA 6
-#define KVASER_PCIEFD_PACK_TYPE_STATUS 8
-#define KVASER_PCIEFD_PACK_TYPE_BUS_LOAD 9
+#define KVASER_PCIEFD_PACK_TYPE_DATA 0x0
+#define KVASER_PCIEFD_PACK_TYPE_ACK 0x1
+#define KVASER_PCIEFD_PACK_TYPE_TXRQ 0x2
+#define KVASER_PCIEFD_PACK_TYPE_ERROR 0x3
+#define KVASER_PCIEFD_PACK_TYPE_EFLUSH_ACK 0x4
+#define KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK 0x5
+#define KVASER_PCIEFD_PACK_TYPE_ACK_DATA 0x6
+#define KVASER_PCIEFD_PACK_TYPE_STATUS 0x8
+#define KVASER_PCIEFD_PACK_TYPE_BUS_LOAD 0x9
 
 /* Common KCAN packet definitions, second word */
 #define KVASER_PCIEFD_PACKET_TYPE_MASK GENMASK(31, 28)
@@ -322,13 +324,21 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, kvaser_pciefd_id_table);
 
-static void kvaser_pciefd_request_status(struct kvaser_pciefd_can *can)
+static inline void kvaser_pciefd_send_kcan_cmd(struct kvaser_pciefd_can *can, u32 cmd)
 {
-	u32 cmd;
+	iowrite32(FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_MASK, cmd) |
+		  FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq),
+		  can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
+}
 
-	cmd = KVASER_PCIEFD_KCAN_CMD_SRQ;
-	cmd |= FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq);
-	iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
+static inline void kvaser_pciefd_request_status(struct kvaser_pciefd_can *can)
+{
+	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_SRQ);
+}
+
+static inline void kvaser_pciefd_abort_flush_reset(struct kvaser_pciefd_can *can)
+{
+	kvaser_pciefd_send_kcan_cmd(can, KVASER_PCIEFD_KCAN_CMD_AT);
 }
 
 static void kvaser_pciefd_enable_err_gen(struct kvaser_pciefd_can *can)
@@ -383,7 +393,6 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	spin_lock_irqsave(&can->lock, irq);
-
 	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
 	if (can->can.ctrlmode & CAN_CTRLMODE_FD) {
 		mode &= ~KVASER_PCIEFD_KCAN_MODE_CCM;
@@ -400,7 +409,6 @@ static void kvaser_pciefd_setup_controller(struct kvaser_pciefd_can *can)
 		mode |= KVASER_PCIEFD_KCAN_MODE_LOM;
 	else
 		mode &= ~KVASER_PCIEFD_KCAN_MODE_LOM;
-
 	mode |= KVASER_PCIEFD_KCAN_MODE_EEN;
 	mode |= KVASER_PCIEFD_KCAN_MODE_EPEN;
 	/* Use ACK packet type */
@@ -417,18 +425,13 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	spin_lock_irqsave(&can->lock, irq);
-	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
+	iowrite32(GENMASK(31, 0), can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-
 	status = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_STAT_REG);
 	if (status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
-		u32 cmd;
-
 		/* If controller is already idle, run abort, flush and reset */
-		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
-		cmd |= FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq);
-		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
+		kvaser_pciefd_abort_flush_reset(can);
 	} else if (!(status & KVASER_PCIEFD_KCAN_STAT_RMR)) {
 		u32 mode;
 
@@ -437,7 +440,6 @@ static void kvaser_pciefd_start_controller_flush(struct kvaser_pciefd_can *can)
 		mode |= KVASER_PCIEFD_KCAN_MODE_RM;
 		iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
 	}
-
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
@@ -447,7 +449,6 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 	unsigned long irq;
 
 	del_timer(&can->bec_poll_timer);
-
 	if (!completion_done(&can->flush_comp))
 		kvaser_pciefd_start_controller_flush(can);
 
@@ -459,11 +460,9 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 
 	spin_lock_irqsave(&can->lock, irq);
 	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-
+	iowrite32(GENMASK(31, 0), can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 	iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 		  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-
 	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
 	mode &= ~KVASER_PCIEFD_KCAN_MODE_RM;
 	iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
@@ -476,11 +475,10 @@ static int kvaser_pciefd_bus_on(struct kvaser_pciefd_can *can)
 	}
 	/* Reset interrupt handling */
 	iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-	iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
+	iowrite32(GENMASK(31, 0), can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 
 	kvaser_pciefd_set_tx_irq(can);
 	kvaser_pciefd_setup_controller(can);
-
 	can->can.state = CAN_STATE_ERROR_ACTIVE;
 	netif_wake_queue(can->can.dev);
 	can->bec.txerr = 0;
@@ -499,7 +497,6 @@ static void kvaser_pciefd_pwm_stop(struct kvaser_pciefd_can *can)
 	spin_lock_irqsave(&can->lock, irq);
 	pwm_ctrl = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
 	top = FIELD_GET(KVASER_PCIEFD_KCAN_PWM_TOP_MASK, pwm_ctrl);
-
 	/* Set duty cycle to zero */
 	pwm_ctrl |= FIELD_PREP(KVASER_PCIEFD_KCAN_PWM_TRIGGER_MASK, top);
 	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
@@ -514,8 +511,7 @@ static void kvaser_pciefd_pwm_start(struct kvaser_pciefd_can *can)
 
 	kvaser_pciefd_pwm_stop(can);
 	spin_lock_irqsave(&can->lock, irq);
-
-	/* Set frequency to 500 KHz*/
+	/* Set frequency to 500 KHz */
 	top = can->kv_pcie->bus_freq / (2 * 500000) - 1;
 
 	pwm_ctrl = FIELD_PREP(KVASER_PCIEFD_KCAN_PWM_TRIGGER_MASK, top);
@@ -580,7 +576,6 @@ static int kvaser_pciefd_prepare_tx_packet(struct kvaser_pciefd_tx_packet *p,
 	int seq = can->echo_idx;
 
 	memset(p, 0, sizeof(*p));
-
 	if (can->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		p->header[1] |= KVASER_PCIEFD_TPACKET_SMS;
 
@@ -621,16 +616,15 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	struct kvaser_pciefd_can *can = netdev_priv(netdev);
 	unsigned long irq_flags;
 	struct kvaser_pciefd_tx_packet packet;
-	int nwords;
+	int nr_words;
 	u8 count;
 
 	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
-	nwords = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
+	nr_words = kvaser_pciefd_prepare_tx_packet(&packet, can, skb);
 
 	spin_lock_irqsave(&can->echo_lock, irq_flags);
-
 	/* Prepare and save echo skb in internal slot */
 	can_put_echo_skb(skb, netdev, can->echo_idx, 0);
 
@@ -643,13 +637,13 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	iowrite32(packet.header[1],
 		  can->reg_base + KVASER_PCIEFD_KCAN_FIFO_REG);
 
-	if (nwords) {
-		u32 data_last = ((u32 *)packet.data)[nwords - 1];
+	if (nr_words) {
+		u32 data_last = ((u32 *)packet.data)[nr_words - 1];
 
 		/* Write data to fifo, except last word */
 		iowrite32_rep(can->reg_base +
 			      KVASER_PCIEFD_KCAN_FIFO_REG, packet.data,
-			      nwords - 1);
+			      nr_words - 1);
 		/* Write last word to end of fifo */
 		__raw_writel(data_last, can->reg_base +
 			     KVASER_PCIEFD_KCAN_FIFO_LAST_REG);
@@ -660,14 +654,13 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	}
 
 	count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-			  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
+			  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
 	/* No room for a new message, stop the queue until at least one
 	 * successful transmit
 	 */
 	if (count >= KVASER_PCIEFD_CAN_TX_MAX_COUNT ||
 	    can->can.echo_skb[can->echo_idx])
 		netif_stop_queue(netdev);
-
 	spin_unlock_irqrestore(&can->echo_lock, irq_flags);
 
 	return NETDEV_TX_OK;
@@ -692,16 +685,13 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
 
 	spin_lock_irqsave(&can->lock, irq_flags);
 	mode = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
-
 	/* Put the circuit in reset mode */
 	iowrite32(mode | KVASER_PCIEFD_KCAN_MODE_RM,
 		  can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
 
 	/* Can only set bittiming if in reset mode */
 	ret = readl_poll_timeout(can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG,
-				 test, test & KVASER_PCIEFD_KCAN_MODE_RM,
-				 0, 10);
-
+				 test, test & KVASER_PCIEFD_KCAN_MODE_RM, 0, 10);
 	if (ret) {
 		spin_unlock_irqrestore(&can->lock, irq_flags);
 		return -EBUSY;
@@ -711,11 +701,10 @@ static int kvaser_pciefd_set_bittiming(struct kvaser_pciefd_can *can, bool data)
 		iowrite32(btrn, can->reg_base + KVASER_PCIEFD_KCAN_BTRD_REG);
 	else
 		iowrite32(btrn, can->reg_base + KVASER_PCIEFD_KCAN_BTRN_REG);
-
 	/* Restore previous reset mode status */
 	iowrite32(mode, can->reg_base + KVASER_PCIEFD_KCAN_MODE_REG);
-
 	spin_unlock_irqrestore(&can->lock, irq_flags);
+
 	return 0;
 }
 
@@ -753,6 +742,7 @@ static int kvaser_pciefd_get_berr_counter(const struct net_device *ndev,
 
 	bec->rxerr = can->bec.rxerr;
 	bec->txerr = can->bec.txerr;
+
 	return 0;
 }
 
@@ -796,7 +786,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		netdev->ethtool_ops = &kvaser_pciefd_ethtool_ops;
 		can->reg_base = pcie->reg_base + KVASER_PCIEFD_KCAN0_BASE +
 				i * KVASER_PCIEFD_KCAN_BASE_OFFSET;
-
 		can->kv_pcie = pcie;
 		can->cmd_seq = 0;
 		can->err_rep_cnt = 0;
@@ -805,15 +794,14 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 
 		init_completion(&can->start_comp);
 		init_completion(&can->flush_comp);
-		timer_setup(&can->bec_poll_timer, kvaser_pciefd_bec_poll_timer,
-			    0);
+		timer_setup(&can->bec_poll_timer, kvaser_pciefd_bec_poll_timer, 0);
 
 		/* Disable Bus load reporting */
 		iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_BUS_LOAD_REG);
 
 		tx_nr_packets_max =
 			FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_MAX_MASK,
-				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
+				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
 		if (tx_nr_packets_max < KVASER_PCIEFD_CAN_TX_MAX_COUNT) {
 			dev_err(&pcie->pci->dev,
 				"Max Tx count is smaller than expected\n");
@@ -827,16 +815,13 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->echo_idx = 0;
 		spin_lock_init(&can->echo_lock);
 		spin_lock_init(&can->lock);
+
 		can->can.bittiming_const = &kvaser_pciefd_bittiming_const;
 		can->can.data_bittiming_const = &kvaser_pciefd_bittiming_const;
-
 		can->can.do_set_bittiming = kvaser_pciefd_set_nominal_bittiming;
-		can->can.do_set_data_bittiming =
-			kvaser_pciefd_set_data_bittiming;
-
+		can->can.do_set_data_bittiming = kvaser_pciefd_set_data_bittiming;
 		can->can.do_set_mode = kvaser_pciefd_set_mode;
 		can->can.do_get_berr_counter = kvaser_pciefd_get_berr_counter;
-
 		can->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 					      CAN_CTRLMODE_FD |
 					      CAN_CTRLMODE_FD_NON_ISO |
@@ -855,10 +840,9 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 			can->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 
 		netdev->flags |= IFF_ECHO;
-
 		SET_NETDEV_DEV(netdev, &pcie->pci->dev);
 
-		iowrite32(-1, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
+		iowrite32(GENMASK(31, 0), can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 			  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 
@@ -917,18 +901,16 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 	for (i = 0; i < KVASER_PCIEFD_DMA_COUNT; i++) {
 		unsigned int offset = KVASER_PCIEFD_DMA_MAP_BASE + 8 * i;
 
-		pcie->dma_data[i] =
-			dmam_alloc_coherent(&pcie->pci->dev,
-					    KVASER_PCIEFD_DMA_SIZE,
-					    &dma_addr[i],
-					    GFP_KERNEL);
+		pcie->dma_data[i] = dmam_alloc_coherent(&pcie->pci->dev,
+							KVASER_PCIEFD_DMA_SIZE,
+							&dma_addr[i],
+							GFP_KERNEL);
 
 		if (!pcie->dma_data[i] || !dma_addr[i]) {
 			dev_err(&pcie->pci->dev, "Rx dma_alloc(%u) failure\n",
 				KVASER_PCIEFD_DMA_SIZE);
 			return -ENOMEM;
 		}
-
 		kvaser_pciefd_write_dma_map(pcie, dma_addr[i], offset);
 	}
 
@@ -936,7 +918,6 @@ static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
 	iowrite32(KVASER_PCIEFD_SRB_CMD_FOR | KVASER_PCIEFD_SRB_CMD_RDB0 |
 		  KVASER_PCIEFD_SRB_CMD_RDB1,
 		  pcie->reg_base + KVASER_PCIEFD_SRB_CMD_REG);
-
 	/* Empty Rx FIFO */
 	srb_packet_count =
 		FIELD_GET(KVASER_PCIEFD_SRB_RX_NR_PACKETS_MASK,
@@ -976,8 +957,7 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 
 	srb_status = ioread32(pcie->reg_base + KVASER_PCIEFD_SRB_STAT_REG);
 	if (!(srb_status & KVASER_PCIEFD_SRB_STAT_DMA)) {
-		dev_err(&pcie->pci->dev,
-			"Hardware without DMA is not supported\n");
+		dev_err(&pcie->pci->dev, "Hardware without DMA is not supported\n");
 		return -ENODEV;
 	}
 
@@ -987,9 +967,9 @@ static int kvaser_pciefd_setup_board(struct kvaser_pciefd *pcie)
 	pcie->freq_to_ticks_div = pcie->freq / 1000000;
 	if (pcie->freq_to_ticks_div == 0)
 		pcie->freq_to_ticks_div = 1;
-
 	/* Turn off all loopback functionality */
 	iowrite32(0, pcie->reg_base + KVASER_PCIEFD_LOOP_REG);
+
 	return 0;
 }
 
@@ -1000,7 +980,6 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 	struct sk_buff *skb;
 	struct canfd_frame *cf;
 	struct can_priv *priv;
-	struct net_device_stats *stats;
 	u8 ch_id = FIELD_GET(KVASER_PCIEFD_PACKET_CHID_MASK, p->header[1]);
 	u8 dlc;
 
@@ -1008,26 +987,24 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		return -EIO;
 
 	priv = &pcie->can[ch_id]->can;
-	stats = &priv->dev->stats;
 	dlc = FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK, p->header[1]);
 
 	if (p->header[1] & KVASER_PCIEFD_RPACKET_FDF) {
 		skb = alloc_canfd_skb(priv->dev, &cf);
 		if (!skb) {
-			stats->rx_dropped++;
+			priv->dev->stats.rx_dropped++;
 			return -ENOMEM;
 		}
 
 		cf->len = can_fd_dlc2len(dlc);
 		if (p->header[1] & KVASER_PCIEFD_RPACKET_BRS)
 			cf->flags |= CANFD_BRS;
-
 		if (p->header[1] & KVASER_PCIEFD_RPACKET_ESI)
 			cf->flags |= CANFD_ESI;
 	} else {
 		skb = alloc_can_skb(priv->dev, (struct can_frame **)&cf);
 		if (!skb) {
-			stats->rx_dropped++;
+			priv->dev->stats.rx_dropped++;
 			return -ENOMEM;
 		}
 		can_frame_set_cc_len((struct can_frame *)cf, dlc, priv->ctrlmode);
@@ -1041,10 +1018,9 @@ static int kvaser_pciefd_handle_data_packet(struct kvaser_pciefd *pcie,
 		cf->can_id |= CAN_RTR_FLAG;
 	} else {
 		memcpy(cf->data, data, cf->len);
-
-		stats->rx_bytes += cf->len;
+		priv->dev->stats.rx_bytes += cf->len;
 	}
-	stats->rx_packets++;
+	priv->dev->stats.rx_packets++;
 	kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
 
 	return netif_rx(skb);
@@ -1065,7 +1041,6 @@ static void kvaser_pciefd_change_state(struct kvaser_pciefd_can *can,
 		spin_lock_irqsave(&can->lock, irq_flags);
 		netif_stop_queue(can->can.dev);
 		spin_unlock_irqrestore(&can->lock, irq_flags);
-
 		/* Prevent CAN controller from auto recover from bus off */
 		if (!can->can.restart_ms) {
 			kvaser_pciefd_start_controller_flush(can);
@@ -1083,7 +1058,7 @@ static void kvaser_pciefd_packet_to_state(struct kvaser_pciefd_rx_packet *p,
 	if (p->header[0] & KVASER_PCIEFD_SPACK_BOFF ||
 	    p->header[0] & KVASER_PCIEFD_SPACK_IRM)
 		*new_state = CAN_STATE_BUS_OFF;
-	else if (bec->txerr >= 255 ||  bec->rxerr >= 255)
+	else if (bec->txerr >= 255 || bec->rxerr >= 255)
 		*new_state = CAN_STATE_BUS_OFF;
 	else if (p->header[1] & KVASER_PCIEFD_SPACK_EPLR)
 		*new_state = CAN_STATE_ERROR_PASSIVE;
@@ -1108,22 +1083,16 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	struct net_device *ndev = can->can.dev;
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
-	struct net_device_stats *stats = &ndev->stats;
 
 	old_state = can->can.state;
 
 	bec.txerr = FIELD_GET(KVASER_PCIEFD_SPACK_TXERR_MASK, p->header[0]);
 	bec.rxerr = FIELD_GET(KVASER_PCIEFD_SPACK_RXERR_MASK, p->header[0]);
 
-	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state,
-				      &rx_state);
-
+	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
 	skb = alloc_can_err_skb(ndev, &cf);
-
 	if (new_state != old_state) {
-		kvaser_pciefd_change_state(can, cf, new_state, tx_state,
-					   rx_state);
-
+		kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
 		if (old_state == CAN_STATE_BUS_OFF &&
 		    new_state == CAN_STATE_ERROR_ACTIVE &&
 		    can->can.restart_ms) {
@@ -1136,25 +1105,25 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	can->err_rep_cnt++;
 	can->can.can_stats.bus_error++;
 	if (p->header[1] & KVASER_PCIEFD_EPACK_DIR_TX)
-		stats->tx_errors++;
+		ndev->stats.tx_errors++;
 	else
-		stats->rx_errors++;
+		ndev->stats.rx_errors++;
 
 	can->bec.txerr = bec.txerr;
 	can->bec.rxerr = bec.rxerr;
 
 	if (!skb) {
-		stats->rx_dropped++;
+		ndev->stats.rx_dropped++;
 		return -ENOMEM;
 	}
 
 	kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
 	cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_CNT;
-
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
 	netif_rx(skb);
+
 	return 0;
 }
 
@@ -1168,13 +1137,13 @@ static int kvaser_pciefd_handle_error_packet(struct kvaser_pciefd *pcie,
 		return -EIO;
 
 	can = pcie->can[ch_id];
-
 	kvaser_pciefd_rx_error_frame(can, p);
 	if (can->err_rep_cnt >= KVASER_PCIEFD_MAX_ERR_REP)
 		/* Do not report more errors, until bec_poll_timer expires */
 		kvaser_pciefd_disable_err_gen(can);
 	/* Start polling the error counters */
 	mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
+
 	return 0;
 }
 
@@ -1189,9 +1158,7 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 	bec.txerr = FIELD_GET(KVASER_PCIEFD_SPACK_TXERR_MASK, p->header[0]);
 	bec.rxerr = FIELD_GET(KVASER_PCIEFD_SPACK_RXERR_MASK, p->header[0]);
 
-	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state,
-				      &rx_state);
-
+	kvaser_pciefd_packet_to_state(p, &bec, &new_state, &tx_state, &rx_state);
 	if (new_state != old_state) {
 		struct net_device *ndev = can->can.dev;
 		struct sk_buff *skb;
@@ -1199,15 +1166,11 @@ static int kvaser_pciefd_handle_status_resp(struct kvaser_pciefd_can *can,
 
 		skb = alloc_can_err_skb(ndev, &cf);
 		if (!skb) {
-			struct net_device_stats *stats = &ndev->stats;
-
-			stats->rx_dropped++;
+			ndev->stats.rx_dropped++;
 			return -ENOMEM;
 		}
 
-		kvaser_pciefd_change_state(can, cf, new_state, tx_state,
-					   rx_state);
-
+		kvaser_pciefd_change_state(can, cf, new_state, tx_state, rx_state);
 		if (old_state == CAN_STATE_BUS_OFF &&
 		    new_state == CAN_STATE_ERROR_ACTIVE &&
 		    can->can.restart_ms) {
@@ -1253,21 +1216,18 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 	    p->header[1] & KVASER_PCIEFD_SPACK_AUTO &&
 	    cmdseq == FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[1]) &&
 	    status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
-		u32 cmd;
-
 		iowrite32(KVASER_PCIEFD_KCAN_IRQ_ABD,
 			  can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-		cmd = KVASER_PCIEFD_KCAN_CMD_AT;
-		cmd |= FIELD_PREP(KVASER_PCIEFD_KCAN_CMD_SEQ_MASK, ++can->cmd_seq);
-		iowrite32(cmd, can->reg_base + KVASER_PCIEFD_KCAN_CMD_REG);
+		kvaser_pciefd_abort_flush_reset(can);
 	} else if (p->header[0] & KVASER_PCIEFD_SPACK_IDET &&
 		   p->header[0] & KVASER_PCIEFD_SPACK_IRM &&
 		   cmdseq == FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[1]) &&
 		   status & KVASER_PCIEFD_KCAN_STAT_IDLE) {
 		/* Reset detected, send end of flush if no packet are in FIFO */
-		u8 count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-				     ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
+		u8 count;
 
+		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
+				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
 		if (!count)
 			iowrite32(FIELD_PREP(KVASER_PCIEFD_KCAN_CTRL_TYPE_MASK,
 					     KVASER_PCIEFD_KCAN_CTRL_TYPE_EFLUSH),
@@ -1278,11 +1238,10 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 		kvaser_pciefd_handle_status_resp(can, p);
 		if (can->can.state != CAN_STATE_BUS_OFF &&
 		    can->can.state != CAN_STATE_ERROR_ACTIVE) {
-			mod_timer(&can->bec_poll_timer,
-				  KVASER_PCIEFD_BEC_POLL_FREQ);
+			mod_timer(&can->bec_poll_timer, KVASER_PCIEFD_BEC_POLL_FREQ);
 		}
 	} else if (p->header[0] & KVASER_PCIEFD_SPACK_RMCD &&
-		   !(status & KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MSK)) {
+		   !(status & KVASER_PCIEFD_KCAN_STAT_BUS_OFF_MASK)) {
 		/* Reset to bus on detected */
 		if (!completion_done(&can->start_comp))
 			complete(&can->start_comp);
@@ -1295,12 +1254,10 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 					     struct kvaser_pciefd_rx_packet *p)
 {
 	struct sk_buff *skb;
-	struct net_device_stats *stats = &can->can.dev->stats;
 	struct can_frame *cf;
 
 	skb = alloc_can_err_skb(can->can.dev, &cf);
-
-	stats->tx_errors++;
+	can->can.dev->stats.tx_errors++;
 	if (p->header[0] & KVASER_PCIEFD_APACKET_ABL) {
 		if (skb)
 			cf->can_id |= CAN_ERR_LOSTARB;
@@ -1314,7 +1271,7 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 		kvaser_pciefd_set_skb_timestamp(can->kv_pcie, skb, p->timestamp);
 		netif_rx(skb);
 	} else {
-		stats->rx_dropped++;
+		can->can.dev->stats.rx_dropped++;
 		netdev_warn(can->can.dev, "No memory left for err_skb\n");
 	}
 }
@@ -1343,26 +1300,24 @@ static int kvaser_pciefd_handle_ack_packet(struct kvaser_pciefd *pcie,
 		netdev_dbg(can->can.dev, "Packet was flushed\n");
 	} else {
 		int echo_idx = FIELD_GET(KVASER_PCIEFD_PACKET_SEQ_MASK, p->header[0]);
-		int dlc;
+		int len;
 		u8 count;
 		struct sk_buff *skb;
 
 		skb = can->can.echo_skb[echo_idx];
 		if (skb)
 			kvaser_pciefd_set_skb_timestamp(pcie, skb, p->timestamp);
-		dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
+		len = can_get_echo_skb(can->can.dev, echo_idx, NULL);
 		count = FIELD_GET(KVASER_PCIEFD_KCAN_TX_NR_PACKETS_CURRENT_MASK,
-				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NPACKETS_REG));
+				  ioread32(can->reg_base + KVASER_PCIEFD_KCAN_TX_NR_PACKETS_REG));
 
 		if (count < KVASER_PCIEFD_CAN_TX_MAX_COUNT &&
 		    netif_queue_stopped(can->can.dev))
 			netif_wake_queue(can->can.dev);
 
 		if (!one_shot_fail) {
-			struct net_device_stats *stats = &can->can.dev->stats;
-
-			stats->tx_bytes += dlc;
-			stats->tx_packets++;
+			can->can.dev->stats.tx_bytes += len;
+			can->can.dev->stats.tx_packets++;
 		}
 	}
 
@@ -1562,13 +1517,12 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 {
 	int i;
-	struct kvaser_pciefd_can *can;
 
 	for (i = 0; i < pcie->nr_channels; i++) {
-		can = pcie->can[i];
+		struct kvaser_pciefd_can *can = pcie->can[i];
+
 		if (can) {
-			iowrite32(0,
-				  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			kvaser_pciefd_pwm_stop(can);
 			free_candev(can->can.dev);
 		}
@@ -1669,14 +1623,13 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 
 static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
 {
-	struct kvaser_pciefd_can *can;
 	int i;
 
 	for (i = 0; i < pcie->nr_channels; i++) {
-		can = pcie->can[i];
+		struct kvaser_pciefd_can *can = pcie->can[i];
+
 		if (can) {
-			iowrite32(0,
-				  can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
 			unregister_candev(can->can.dev);
 			del_timer(&can->bec_poll_timer);
 			kvaser_pciefd_pwm_stop(can);
-- 
2.40.1


