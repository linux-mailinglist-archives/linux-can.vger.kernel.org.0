Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC32F104E
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 11:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbhAKKnz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 05:43:55 -0500
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:45882 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbhAKKnz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 05:43:55 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d90 with ME
        id FNhv2400z3PnFJp03Ni6mL; Mon, 11 Jan 2021 11:42:08 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Jan 2021 11:42:08 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] can: dev: can_put_echo_skb(): extend to store can frame length
Date:   Mon, 11 Jan 2021 19:41:39 +0900
Message-Id: <20210111104139.47318-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>
References: <20210109174013.534145-1-mkl@pengutronix.de> <20210109174013.534145-12-mkl@pengutronix.de> <CAMZ6RqKfVZ-Z10EK611NZots0Q61bJ6b5TPxSgWAv3nWo0+ryg@mail.gmail.com> <CAMZ6RqJ23-T8doazD+=0AO38VzetfudLWO3si+pO+mqE3vSgKw@mail.gmail.com> <20210111061335.39983-1-mailhol.vincent@wanadoo.fr> <28ab072d-a075-ce6b-6fed-a6d623a86a52@pengutronix.de> <CAMZ6Rq+irzbsiLP+bKL=h4JRh7pNXacwc9v4YO4NK=eNqOT3ew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Add a frame_len argument to can_put_echo_skb() which is used to save
length of the CAN frame into field frame_len of struct can_skb_priv so
that it can be later used after transmission completion. Convert all
users of this function, too.

Drivers which implement BQL call can_put_echo_skb() with the output of
can_skb_get_frame_len(skb) and drivers which do not simply pass zero
as an input (in the same way that NULL would be given to
can_get_echo_skb()). This way, we have a nice symmetry between the two
echo functions.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
--
v2: make the assignemend unconditional.

Hi Marc,

If you like the idea to modify can_put_echo_skb(), you can use this
patch. Just put it between patches 12 and 13 of your series.

Yours sincerely,
Vincent Mailhol
---
 drivers/net/can/at91_can.c                       | 2 +-
 drivers/net/can/c_can/c_can.c                    | 2 +-
 drivers/net/can/cc770/cc770.c                    | 2 +-
 drivers/net/can/dev/skb.c                        | 5 ++++-
 drivers/net/can/flexcan.c                        | 2 +-
 drivers/net/can/grcan.c                          | 2 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c            | 2 +-
 drivers/net/can/kvaser_pciefd.c                  | 2 +-
 drivers/net/can/m_can/m_can.c                    | 2 +-
 drivers/net/can/mscan/mscan.c                    | 2 +-
 drivers/net/can/pch_can.c                        | 2 +-
 drivers/net/can/peak_canfd/peak_canfd.c          | 2 +-
 drivers/net/can/rcar/rcar_can.c                  | 2 +-
 drivers/net/can/rcar/rcar_canfd.c                | 2 +-
 drivers/net/can/sja1000/sja1000.c                | 2 +-
 drivers/net/can/softing/softing_main.c           | 2 +-
 drivers/net/can/spi/hi311x.c                     | 2 +-
 drivers/net/can/spi/mcp251x.c                    | 2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c   | 2 +-
 drivers/net/can/sun4i_can.c                      | 2 +-
 drivers/net/can/ti_hecc.c                        | 2 +-
 drivers/net/can/usb/ems_usb.c                    | 2 +-
 drivers/net/can/usb/esd_usb2.c                   | 2 +-
 drivers/net/can/usb/gs_usb.c                     | 2 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c | 2 +-
 drivers/net/can/usb/mcba_usb.c                   | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c     | 2 +-
 drivers/net/can/usb/ucan.c                       | 2 +-
 drivers/net/can/usb/usb_8dev.c                   | 2 +-
 drivers/net/can/xilinx_can.c                     | 4 ++--
 include/linux/can/skb.h                          | 2 +-
 31 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index ae015ec227d4..9ad9b39f480e 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -484,7 +484,7 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	stats->tx_bytes += cf->len;
 
 	/* _NOTE_: subtract AT91_MB_TX_FIRST offset from mb! */
-	can_put_echo_skb(skb, dev, mb - get_mb_tx_first(priv));
+	can_put_echo_skb(skb, dev, mb - get_mb_tx_first(priv), 0);
 
 	/*
 	 * we have to stop the queue and deliver all messages in case
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e7ee60b2c76b..ef474bae47a1 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -476,7 +476,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	 */
 	c_can_setup_tx_object(dev, IF_TX, frame, idx);
 	priv->dlc[idx] = frame->len;
-	can_put_echo_skb(skb, dev, idx);
+	can_put_echo_skb(skb, dev, idx, 0);
 
 	/* Update the active bits */
 	atomic_add((1 << idx), &priv->tx_active);
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 5ecb2afd6bbf..f8a130f594e2 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -702,7 +702,7 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 	stats->tx_bytes += cf->len;
 	stats->tx_packets++;
 
-	can_put_echo_skb(priv->tx_skb, dev, 0);
+	can_put_echo_skb(priv->tx_skb, dev, 0, 0);
 	can_get_echo_skb(dev, 0, NULL);
 	priv->tx_skb = NULL;
 
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 568dc28f7a4e..53683d4312f1 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -38,7 +38,7 @@ void can_flush_echo_skb(struct net_device *dev)
  * priv->echo_skb, if necessary.
  */
 int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
-		     unsigned int idx)
+		     unsigned int idx, unsigned int frame_len)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
@@ -62,6 +62,9 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		skb->dev = dev;
 
+		/* save frame_len to reuse it when transmission is completed */
+		can_skb_prv(skb)->frame_len = frame_len;
+
 		/* save this skb for tx interrupt echo handling */
 		priv->echo_skb[idx] = skb;
 	} else {
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 038fe1036df2..5e51e040ea09 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -776,7 +776,7 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *de
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
 	}
 
-	can_put_echo_skb(skb, dev, 0);
+	can_put_echo_skb(skb, dev, 0, 0);
 
 	priv->write(can_id, &priv->tx_mb->can_id);
 	priv->write(ctrl, &priv->tx_mb->can_ctrl);
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 6aaebbcb7e76..4a8453290530 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1448,7 +1448,7 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	 * taken.
 	 */
 	priv->txdlc[slotindex] = cf->len; /* Store dlc for statistics */
-	can_put_echo_skb(skb, dev, slotindex);
+	can_put_echo_skb(skb, dev, slotindex, 0);
 
 	/* Make sure everything is written before allowing hardware to
 	 * read from the memory
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index b3ec32f60e67..5bb957a26bc6 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -922,7 +922,7 @@ static netdev_tx_t ifi_canfd_start_xmit(struct sk_buff *skb,
 	writel(0, priv->base + IFI_CANFD_TXFIFO_REPEATCOUNT);
 	writel(0, priv->base + IFI_CANFD_TXFIFO_SUSPEND_US);
 
-	can_put_echo_skb(skb, ndev, 0);
+	can_put_echo_skb(skb, ndev, 0, 0);
 
 	/* Start the transmission */
 	writel(IFI_CANFD_TXSTCMD_ADD_MSG, priv->base + IFI_CANFD_TXSTCMD);
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 6602791b3b81..37e05010ca91 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -778,7 +778,7 @@ static netdev_tx_t kvaser_pciefd_start_xmit(struct sk_buff *skb,
 	spin_lock_irqsave(&can->echo_lock, irq_flags);
 
 	/* Prepare and save echo skb in internal slot */
-	can_put_echo_skb(skb, netdev, can->echo_idx);
+	can_put_echo_skb(skb, netdev, can->echo_idx, 0);
 
 	/* Move echo index to the next slot */
 	can->echo_idx = (can->echo_idx + 1) % can->can.echo_skb_max;
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 262ca98cc2b1..8c71b3a5a27b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1483,7 +1483,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 					 M_CAN_FIFO_DATA(i / 4),
 					 *(u32 *)(cf->data + i));
 
-		can_put_echo_skb(skb, dev, 0);
+		can_put_echo_skb(skb, dev, 0, 0);
 
 		if (cdev->can.ctrlmode & CAN_CTRLMODE_FD) {
 			cccr = m_can_read(cdev, M_CAN_CCCR);
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 6caa89fe7184..fa32e418eb29 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -270,7 +270,7 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	list_add_tail(&priv->tx_queue[buf_id].list, &priv->tx_head);
 
-	can_put_echo_skb(skb, dev, buf_id);
+	can_put_echo_skb(skb, dev, buf_id, 0);
 
 	/* Enable interrupt. */
 	priv->tx_active |= 1 << buf_id;
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 6faadac983b6..92a54a5fd4c5 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -924,7 +924,7 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
 			  &priv->regs->ifregs[1].data[i / 2]);
 	}
 
-	can_put_echo_skb(skb, ndev, tx_obj_no - PCH_RX_OBJ_END - 1);
+	can_put_echo_skb(skb, ndev, tx_obj_no - PCH_RX_OBJ_END - 1, 0);
 
 	/* Set the size of the data. Update if2_mcont */
 	iowrite32(cf->len | PCH_IF_MCONT_NEWDAT | PCH_IF_MCONT_TXRQXT |
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 86df3b2b701a..00847cbaf7b6 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -716,7 +716,7 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 	spin_lock_irqsave(&priv->echo_lock, flags);
 
 	/* prepare and save echo skb in internal slot */
-	can_put_echo_skb(skb, ndev, priv->echo_idx);
+	can_put_echo_skb(skb, ndev, priv->echo_idx, 0);
 
 	/* move echo index to the next slot */
 	priv->echo_idx = (priv->echo_idx + 1) % priv->can.echo_skb_max;
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index ae76ea3ae0e6..4870c4ea190a 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -617,7 +617,7 @@ static netdev_tx_t rcar_can_start_xmit(struct sk_buff *skb,
 	writeb(cf->len, &priv->regs->mb[RCAR_CAN_TX_FIFO_MBX].dlc);
 
 	priv->tx_dlc[priv->tx_head % RCAR_CAN_FIFO_DEPTH] = cf->len;
-	can_put_echo_skb(skb, ndev, priv->tx_head % RCAR_CAN_FIFO_DEPTH);
+	can_put_echo_skb(skb, ndev, priv->tx_head % RCAR_CAN_FIFO_DEPTH, 0);
 	priv->tx_head++;
 	/* Start Tx: write 0xff to the TFPCR register to increment
 	 * the CPU-side pointer for the transmit FIFO to the next
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ba658664e7ee..d8d233e62990 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1390,7 +1390,7 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 	}
 
 	priv->tx_len[priv->tx_head % RCANFD_FIFO_DEPTH] = cf->len;
-	can_put_echo_skb(skb, ndev, priv->tx_head % RCANFD_FIFO_DEPTH);
+	can_put_echo_skb(skb, ndev, priv->tx_head % RCANFD_FIFO_DEPTH, 0);
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
 	priv->tx_head++;
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ded7dacaecd1..9e86488ba55f 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -318,7 +318,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	for (i = 0; i < cf->len; i++)
 		priv->write_reg(priv, dreg++, cf->data[i]);
 
-	can_put_echo_skb(skb, dev, 0);
+	can_put_echo_skb(skb, dev, 0, 0);
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
 		cmd_reg_val |= CMD_AT;
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 583e1246ac92..c44f3411e561 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -104,7 +104,7 @@ static netdev_tx_t softing_netdev_start_xmit(struct sk_buff *skb,
 	card->tx.last_bus = priv->index;
 	++card->tx.pending;
 	++priv->tx.pending;
-	can_put_echo_skb(skb, dev, priv->tx.echo_put);
+	can_put_echo_skb(skb, dev, priv->tx.echo_put, 0);
 	++priv->tx.echo_put;
 	if (priv->tx.echo_put >= TX_ECHO_SKB_MAX)
 		priv->tx.echo_put = 0;
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index c1358826074f..c3e020c90111 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -586,7 +586,7 @@ static void hi3110_tx_work_handler(struct work_struct *ws)
 			frame = (struct can_frame *)priv->tx_skb->data;
 			hi3110_hw_tx(spi, frame);
 			priv->tx_len = 1 + frame->len;
-			can_put_echo_skb(priv->tx_skb, net, 0);
+			can_put_echo_skb(priv->tx_skb, net, 0, 0);
 			priv->tx_skb = NULL;
 		}
 	}
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 114ac4c303b6..f69fb4238a65 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1002,7 +1002,7 @@ static void mcp251x_tx_work_handler(struct work_struct *ws)
 				frame->len = CAN_FRAME_MAX_DATA_LEN;
 			mcp251x_hw_tx(spi, frame, 0);
 			priv->tx_len = 1 + frame->len;
-			can_put_echo_skb(priv->tx_skb, net, 0);
+			can_put_echo_skb(priv->tx_skb, net, 0, 0);
 			priv->tx_skb = NULL;
 		}
 	}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 77129d5f410b..978f29d624db 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2437,7 +2437,7 @@ static netdev_tx_t mcp251xfd_start_xmit(struct sk_buff *skb,
 	if (tx_ring->head - tx_ring->tail >= tx_ring->obj_num)
 		netif_stop_queue(ndev);
 
-	can_put_echo_skb(skb, ndev, tx_head);
+	can_put_echo_skb(skb, ndev, tx_head, 0);
 
 	err = mcp251xfd_tx_obj_write(priv, tx_obj);
 	if (err)
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index faabfe74c19e..54aa7c25c4de 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -448,7 +448,7 @@ static netdev_tx_t sun4ican_start_xmit(struct sk_buff *skb, struct net_device *d
 
 	writel(msg_flag_n, priv->base + SUN4I_REG_BUF0_ADDR);
 
-	can_put_echo_skb(skb, dev, 0);
+	can_put_echo_skb(skb, dev, 0, 0);
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
 		sun4i_can_write_cmdreg(priv, SUN4I_CMD_SELF_RCV_REQ);
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index a6850ff0b55b..485c19bc98c2 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -513,7 +513,7 @@ static netdev_tx_t ti_hecc_xmit(struct sk_buff *skb, struct net_device *ndev)
 			       be32_to_cpu(*(__be32 *)(cf->data + 4)));
 	else
 		*(u32 *)(cf->data + 4) = 0;
-	can_put_echo_skb(skb, ndev, mbxno);
+	can_put_echo_skb(skb, ndev, mbxno, 0);
 
 	spin_lock_irqsave(&priv->mbx_lock, flags);
 	--priv->tx_head;
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index d27567139935..18f40eb20360 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -801,7 +801,7 @@ static netdev_tx_t ems_usb_start_xmit(struct sk_buff *skb, struct net_device *ne
 	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
-	can_put_echo_skb(skb, netdev, context->echo_index);
+	can_put_echo_skb(skb, netdev, context->echo_index, 0);
 
 	atomic_inc(&dev->active_tx_urbs);
 
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 4f653e221a5b..562acbf454fd 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -783,7 +783,7 @@ static netdev_tx_t esd_usb2_start_xmit(struct sk_buff *skb,
 
 	usb_anchor_urb(urb, &priv->tx_submitted);
 
-	can_put_echo_skb(skb, netdev, context->echo_index);
+	can_put_echo_skb(skb, netdev, context->echo_index, 0);
 
 	atomic_inc(&priv->active_tx_jobs);
 
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 992a511bcd95..a00dc1904415 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -525,7 +525,7 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
-	can_put_echo_skb(skb, netdev, idx);
+	can_put_echo_skb(skb, netdev, idx, 0);
 
 	atomic_inc(&dev->active_tx_urbs);
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index e2d58846c40c..2b7efd296758 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -578,7 +578,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
 
 	context->priv = priv;
 
-	can_put_echo_skb(skb, netdev, context->echo_index);
+	can_put_echo_skb(skb, netdev, context->echo_index, 0);
 
 	usb_fill_bulk_urb(urb, dev->udev,
 			  usb_sndbulkpipe(dev->udev,
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 23cec88aafc3..4232a7126c1b 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -355,7 +355,7 @@ static netdev_tx_t mcba_usb_start_xmit(struct sk_buff *skb,
 	if (cf->can_id & CAN_RTR_FLAG)
 		usb_msg.dlc |= MCBA_DLC_RTR_MASK;
 
-	can_put_echo_skb(skb, priv->netdev, ctx->ndx);
+	can_put_echo_skb(skb, priv->netdev, ctx->ndx, 0);
 
 	err = mcba_usb_xmit(priv, (struct mcba_usb_msg *)&usb_msg, ctx);
 	if (err)
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 6a97c29e25e7..573b11559d73 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -365,7 +365,7 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
-	can_put_echo_skb(skb, netdev, context->echo_index);
+	can_put_echo_skb(skb, netdev, context->echo_index, 0);
 
 	atomic_inc(&dev->active_tx_urbs);
 
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index cceb142afc3e..fa403c080871 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1137,7 +1137,7 @@ static netdev_tx_t ucan_start_xmit(struct sk_buff *skb,
 
 	/* put the skb on can loopback stack */
 	spin_lock_irqsave(&up->echo_skb_lock, flags);
-	can_put_echo_skb(skb, up->netdev, echo_index);
+	can_put_echo_skb(skb, up->netdev, echo_index, 0);
 	spin_unlock_irqrestore(&up->echo_skb_lock, flags);
 
 	/* transmit it */
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index e16efdbb8f39..e8c42430a4fc 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -664,7 +664,7 @@ static netdev_tx_t usb_8dev_start_xmit(struct sk_buff *skb,
 	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 	usb_anchor_urb(urb, &priv->tx_submitted);
 
-	can_put_echo_skb(skb, netdev, context->echo_index);
+	can_put_echo_skb(skb, netdev, context->echo_index, 0);
 
 	atomic_inc(&priv->active_tx_urbs);
 
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 7cda3d64cc05..37fa19c62d73 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -592,9 +592,9 @@ static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 
 	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
 	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
-		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max);
+		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max, 0);
 	else
-		can_put_echo_skb(skb, ndev, 0);
+		can_put_echo_skb(skb, ndev, 0, 0);
 
 	priv->tx_head++;
 
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index 3296e2144d5a..685f34cfba20 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -18,7 +18,7 @@
 
 void can_flush_echo_skb(struct net_device *dev);
 int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
-		     unsigned int idx);
+		     unsigned int idx, unsigned int frame_len);
 struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx,
 				   u8 *len_ptr, unsigned int *frame_len_ptr);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx,
-- 
2.26.2

