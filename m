Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84E746BACD
	for <lists+linux-can@lfdr.de>; Tue,  7 Dec 2021 13:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhLGMTx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Dec 2021 07:19:53 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:49453 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhLGMTw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Dec 2021 07:19:52 -0500
Received: from localhost.localdomain ([114.149.34.46])
        by smtp.orange.fr with ESMTPA
        id uZNxmx8bRdmYbuZOGmwySo; Tue, 07 Dec 2021 13:16:21 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: MDU0YmViZGZmMDIzYiBlMiM2NTczNTRjNWZkZTMwOGRiOGQ4ODf3NWI1ZTMyMzdiODlhOQ==
X-ME-Date: Tue, 07 Dec 2021 13:16:21 +0100
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Jimmy Assarsson <extja@kvaser.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v5 1/5] can: do not increase rx statistics when generating a CAN rx error message frame
Date:   Tue,  7 Dec 2021 21:15:27 +0900
Message-Id: <20211207121531.42941-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211207121531.42941-1-mailhol.vincent@wanadoo.fr>
References: <20211207121531.42941-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN error message frames (i.e. error skb) are an interface
specific to socket CAN. The payload of the CAN error message frames
does not correspond to any actual data sent on the wire. Only an error
flag and a delimiter are transmitted when an error occurs (c.f. ISO
11898-1 section 10.4.4.2 "Error flag").

For this reason, it makes no sense to increment the rx_packets and
rx_bytes fields of struct net_device_stats because no actual payload
were transmitted on the wire.

This patch fixes all the CAN drivers.

CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Jernej Skrabec <jernej.skrabec@gmail.com>
CC: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
CC: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
CC: Michal Simek <michal.simek@xilinx.com>
CC: Stephane Grosjean <s.grosjean@peak-system.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com> # kvaser
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/at91_can.c                        | 6 ------
 drivers/net/can/c_can/c_can_main.c                | 5 -----
 drivers/net/can/cc770/cc770.c                     | 3 ---
 drivers/net/can/dev/dev.c                         | 4 ----
 drivers/net/can/dev/rx-offload.c                  | 6 ++++--
 drivers/net/can/ifi_canfd/ifi_canfd.c             | 5 -----
 drivers/net/can/kvaser_pciefd.c                   | 5 -----
 drivers/net/can/m_can/m_can.c                     | 7 -------
 drivers/net/can/mscan/mscan.c                     | 9 +++++----
 drivers/net/can/pch_can.c                         | 3 ---
 drivers/net/can/peak_canfd/peak_canfd.c           | 4 ----
 drivers/net/can/rcar/rcar_can.c                   | 6 +-----
 drivers/net/can/rcar/rcar_canfd.c                 | 4 ----
 drivers/net/can/sja1000/sja1000.c                 | 2 --
 drivers/net/can/sun4i_can.c                       | 7 ++-----
 drivers/net/can/usb/ems_usb.c                     | 2 --
 drivers/net/can/usb/esd_usb2.c                    | 2 --
 drivers/net/can/usb/etas_es58x/es58x_core.c       | 7 -------
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c  | 2 --
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 8 --------
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c  | 4 ----
 drivers/net/can/usb/peak_usb/pcan_usb.c           | 2 --
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c        | 3 ---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c       | 2 --
 drivers/net/can/usb/ucan.c                        | 6 ++++--
 drivers/net/can/usb/usb_8dev.c                    | 2 --
 drivers/net/can/xilinx_can.c                      | 9 +--------
 27 files changed, 17 insertions(+), 108 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 3aea32c9b108..3cd872cf9be6 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -553,8 +553,6 @@ static void at91_rx_overflow_err(struct net_device *dev)
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 }
 
@@ -779,8 +777,6 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 
 	at91_poll_err_frame(dev, cf, reg_sr);
 
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
@@ -1037,8 +1033,6 @@ static void at91_irq_err(struct net_device *dev)
 
 	at91_irq_err_state(dev, cf, new_state);
 
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += cf->len;
 	netif_rx(skb);
 
 	priv->can.state = new_state;
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index 52671d1ea17d..670754a12984 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -920,7 +920,6 @@ static int c_can_handle_state_change(struct net_device *dev,
 	unsigned int reg_err_counter;
 	unsigned int rx_err_passive;
 	struct c_can_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
@@ -996,8 +995,6 @@ static int c_can_handle_state_change(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
@@ -1064,8 +1061,6 @@ static int c_can_handle_bus_err(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 	return 1;
 }
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index f8a130f594e2..a5fd8ccedec2 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -499,7 +499,6 @@ static void cc770_rx(struct net_device *dev, unsigned int mo, u8 ctrl1)
 static int cc770_err(struct net_device *dev, u8 status)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u8 lec;
@@ -571,8 +570,6 @@ static int cc770_err(struct net_device *dev, u8 status)
 	}
 
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index e3d840b81357..4845ae6456e1 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -136,7 +136,6 @@ EXPORT_SYMBOL_GPL(can_change_state);
 static void can_restart(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	int err;
@@ -155,9 +154,6 @@ static void can_restart(struct net_device *dev)
 
 	cf->can_id |= CAN_ERR_RESTARTED;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	netif_rx_ni(skb);
 
 restart:
diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
index 37b0cc65237b..7dbf46b9ca5d 100644
--- a/drivers/net/can/dev/rx-offload.c
+++ b/drivers/net/can/dev/rx-offload.c
@@ -54,8 +54,10 @@ static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
 		struct can_frame *cf = (struct can_frame *)skb->data;
 
 		work_done++;
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
+		if (!(cf->can_id & CAN_ERR_FLAG)) {
+			stats->rx_packets++;
+			stats->rx_bytes += cf->len;
+		}
 		netif_receive_skb(skb);
 	}
 
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 5bb957a26bc6..e8318e984bf2 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -430,8 +430,6 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 	       priv->base + IFI_CANFD_INTERRUPT);
 	writel(IFI_CANFD_ERROR_CTR_ER_ENABLE, priv->base + IFI_CANFD_ERROR_CTR);
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
@@ -456,7 +454,6 @@ static int ifi_canfd_handle_state_change(struct net_device *ndev,
 					 enum can_state new_state)
 {
 	struct ifi_canfd_priv *priv = netdev_priv(ndev);
-	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
@@ -522,8 +519,6 @@ static int ifi_canfd_handle_state_change(struct net_device *ndev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_receive_skb(skb);
 
 	return 1;
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 74d9899fc904..483fbd9e6952 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1304,9 +1304,6 @@ static int kvaser_pciefd_rx_error_frame(struct kvaser_pciefd_can *can,
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	netif_rx(skb);
 	return 0;
 }
@@ -1504,8 +1501,6 @@ static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 
 	if (skb) {
 		cf->can_id |= CAN_ERR_BUSERROR;
-		stats->rx_bytes += cf->len;
-		stats->rx_packets++;
 		netif_rx(skb);
 	} else {
 		stats->rx_dropped++;
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f4f54012dea7..c33035e706bc 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -647,9 +647,6 @@ static int m_can_handle_lec_err(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	if (cdev->is_peripheral)
 		timestamp = m_can_get_timestamp(cdev);
 
@@ -706,7 +703,6 @@ static int m_can_handle_state_change(struct net_device *dev,
 				     enum can_state new_state)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
@@ -771,9 +767,6 @@ static int m_can_handle_state_change(struct net_device *dev,
 		break;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
-
 	if (cdev->is_peripheral)
 		timestamp = m_can_get_timestamp(cdev);
 
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index fa32e418eb29..9e1cce0260da 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -401,13 +401,14 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 			continue;
 		}
 
-		if (canrflg & MSCAN_RXF)
+		if (canrflg & MSCAN_RXF) {
 			mscan_get_rx_frame(dev, frame);
-		else if (canrflg & MSCAN_ERR_IF)
+			stats->rx_packets++;
+			stats->rx_bytes += frame->len;
+		} else if (canrflg & MSCAN_ERR_IF) {
 			mscan_get_err_frame(dev, frame, canrflg);
+		}
 
-		stats->rx_packets++;
-		stats->rx_bytes += frame->len;
 		work_done++;
 		netif_receive_skb(skb);
 	}
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 964c8a09226a..6b45840db1f9 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -561,9 +561,6 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 
 	priv->can.state = state;
 	netif_receive_skb(skb);
-
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 }
 
 static irqreturn_t pch_can_interrupt(int irq, void *dev_id)
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index d08718e98e11..d5b8bc6d2980 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -409,8 +409,6 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 		return -ENOMEM;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	pucan_netif_rx(skb, msg->ts_low, msg->ts_high);
 
 	return 0;
@@ -438,8 +436,6 @@ static int pucan_handle_cache_critical(struct peak_canfd_priv *priv)
 	cf->data[6] = priv->bec.txerr;
 	cf->data[7] = priv->bec.rxerr;
 
-	stats->rx_bytes += cf->len;
-	stats->rx_packets++;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 8999ec9455ec..f408ed9a6ccd 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -223,7 +223,6 @@ static void tx_failure_cleanup(struct net_device *ndev)
 static void rcar_can_error(struct net_device *ndev)
 {
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u8 eifr, txerr = 0, rxerr = 0;
@@ -362,11 +361,8 @@ static void rcar_can_error(struct net_device *ndev)
 		}
 	}
 
-	if (skb) {
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
+	if (skb)
 		netif_rx(skb);
-	}
 }
 
 static void rcar_can_tx_done(struct net_device *ndev)
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ff9d0f5ae0dd..db9d62874e15 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1033,8 +1033,6 @@ static void rcar_canfd_error(struct net_device *ndev, u32 cerfl,
 	/* Clear channel error interrupts that are handled */
 	rcar_canfd_write(priv->base, RCANFD_CERFL(ch),
 			 RCANFD_CERFL_ERR(~cerfl));
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
@@ -1174,8 +1172,6 @@ static void rcar_canfd_state_change(struct net_device *ndev,
 		rx_state = txerr <= rxerr ? state : 0;
 
 		can_change_state(ndev, cf, tx_state, rx_state);
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
 		netif_rx(skb);
 	}
 }
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 3fad54646746..a65546ca9461 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -487,8 +487,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			can_bus_off(dev);
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 54aa7c25c4de..599174098883 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -622,13 +622,10 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 			can_bus_off(dev);
 	}
 
-	if (likely(skb)) {
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
+	if (likely(skb))
 		netif_rx(skb);
-	} else {
+	else
 		return -ENOMEM;
-	}
 
 	return 0;
 }
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 2b5302e72435..7cf65936d02e 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -397,8 +397,6 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 		stats->rx_errors++;
 	}
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index c6068a251fbe..5f6915a27b3d 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -293,8 +293,6 @@ static void esd_usb2_rx_event(struct esd_usb2_net_priv *priv,
 		priv->bec.txerr = txerr;
 		priv->bec.rxerr = rxerr;
 
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
 		netif_rx(skb);
 	}
 }
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 8508a73d648e..2ed2370a3166 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -849,13 +849,6 @@ int es58x_rx_err_msg(struct net_device *netdev, enum es58x_err error,
 		break;
 	}
 
-	/* driver/net/can/dev.c:can_restart() takes in account error
-	 * messages in the RX stats. Doing the same here for
-	 * consistency.
-	 */
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += CAN_ERR_DLC;
-
 	if (cf) {
 		if (cf->data[1])
 			cf->can_id |= CAN_ERR_CRTL;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 0cc0fc866a2a..3e682ef43f8e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -279,8 +279,6 @@ int kvaser_usb_can_rx_over_error(struct net_device *netdev)
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index dcee8dc828ec..3398da323126 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -869,7 +869,6 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 	struct net_device *netdev = priv->netdev;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	struct net_device_stats *stats;
 	enum can_state new_state, old_state;
 
 	old_state = priv->can.state;
@@ -919,9 +918,6 @@ static void kvaser_usb_hydra_update_state(struct kvaser_usb_net_priv *priv,
 	cf->data[6] = bec->txerr;
 	cf->data[7] = bec->rxerr;
 
-	stats = &netdev->stats;
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
@@ -1074,8 +1070,6 @@ kvaser_usb_hydra_error_frame(struct kvaser_usb_net_priv *priv,
 	cf->data[6] = bec.txerr;
 	cf->data[7] = bec.rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 
 	priv->bec.txerr = bec.txerr;
@@ -1109,8 +1103,6 @@ static void kvaser_usb_hydra_one_shot_fail(struct kvaser_usb_net_priv *priv,
 	}
 
 	stats->tx_errors++;
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index 59ba7c7beec0..4aebaab9ea9c 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -575,8 +575,6 @@ static void kvaser_usb_leaf_tx_acknowledge(const struct kvaser_usb *dev,
 		if (skb) {
 			cf->can_id |= CAN_ERR_RESTARTED;
 
-			stats->rx_packets++;
-			stats->rx_bytes += cf->len;
 			netif_rx(skb);
 		} else {
 			netdev_err(priv->netdev,
@@ -777,8 +775,6 @@ static void kvaser_usb_leaf_rx_error(const struct kvaser_usb *dev,
 	cf->data[6] = es->txerr;
 	cf->data[7] = es->rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 876218752766..21b06a738595 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -520,8 +520,6 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 				     &hwts->hwtstamp);
 	}
 
-	mc->netdev->stats.rx_packets++;
-	mc->netdev->stats.rx_bytes += cf->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 6bd12549f101..185f5a98d217 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -577,9 +577,6 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	if (!skb)
 		return -ENOMEM;
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += cf->len;
-
 	peak_usb_netif_rx_64(skb, le32_to_cpu(sm->ts_low),
 			     le32_to_cpu(sm->ts_high));
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 858ab22708fc..f6d19879bf40 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -660,8 +660,6 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 
 	hwts = skb_hwtstamps(skb);
 	peak_usb_get_ts_time(&usb_if->time_ref, le32_to_cpu(er->ts32), &hwts->hwtstamp);
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += can_frame->len;
 	netif_rx(skb);
 
 	return 0;
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 1679cbe45ded..d582c39fc8d0 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -621,8 +621,10 @@ static void ucan_rx_can_msg(struct ucan_priv *up, struct ucan_message_in *m)
 		memcpy(cf->data, m->msg.can_msg.data, cf->len);
 
 	/* don't count error frames as real packets */
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
+	if (!(cf->can_id & CAN_ERR_FLAG)) {
+		stats->rx_packets++;
+		stats->rx_bytes += cf->len;
+	}
 
 	/* pass it to Linux */
 	netif_rx(skb);
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index d1b83bd1b3cb..040324362b26 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -449,8 +449,6 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 	priv->bec.txerr = txerr;
 	priv->bec.rxerr = rxerr;
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->len;
 	netif_rx(skb);
 }
 
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index e2b15d29d15e..275e240ab293 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -965,13 +965,8 @@ static void xcan_update_error_state_after_rxtx(struct net_device *ndev)
 
 		xcan_set_error_state(ndev, new_state, skb ? cf : NULL);
 
-		if (skb) {
-			struct net_device_stats *stats = &ndev->stats;
-
-			stats->rx_packets++;
-			stats->rx_bytes += cf->len;
+		if (skb)
 			netif_rx(skb);
-		}
 	}
 }
 
@@ -1095,8 +1090,6 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 		if (skb) {
 			skb_cf->can_id |= cf.can_id;
 			memcpy(skb_cf->data, cf.data, CAN_ERR_DLC);
-			stats->rx_packets++;
-			stats->rx_bytes += CAN_ERR_DLC;
 			netif_rx(skb);
 		}
 	}
-- 
2.32.0

