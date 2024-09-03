Return-Path: <linux-can+bounces-1323-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646FE9698FA
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7FEB28C71
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F3B1D097B;
	Tue,  3 Sep 2024 09:27:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF11D0945
	for <linux-can@vger.kernel.org>; Tue,  3 Sep 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355659; cv=none; b=ZOasRYokGPu1DUoSvvzA6ta7zYTi0/5voQr86PoQ+s++CKJG3gOHWsALlHbnUVX4mRfXSmoP5FagdwFlD33LPRmBTGYDBK/XCAK1+e5N5TNqZ34CUNR65nscFvFokIwSPPHMiflioVScAmrRlpZL1UY1ofCl5i6O4xn9W9P9qQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355659; c=relaxed/simple;
	bh=YuwCD3I+XqgAKfBKKX+ipqusj2W94Al2//omfOQm2OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpnplV0AfKvPUcKtO8blXlxgMrJNZHcH+nwrTNvgQNTppCnchTXZZkfCsO9PKxv7qh8btlrLxZHMFYKFWO7jLgHGeNYPd+1NLHujqxIDDNZ40SZQD7J1Gb4Pcxm/eCT6jFaaZgjusPYW4G5qFlYmR1JokRwkVZJIhZ0qrNLsRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPp1-0004Kk-Gt
	for linux-can@vger.kernel.org; Tue, 03 Sep 2024 11:27:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPp0-0059jL-Hn
	for linux-can@vger.kernel.org; Tue, 03 Sep 2024 11:27:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 50744331172
	for <linux-can@vger.kernel.org>; Tue, 03 Sep 2024 09:22:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F30A933103B;
	Tue, 03 Sep 2024 09:22:27 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id a0c82ce4;
	Tue, 3 Sep 2024 09:22:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 03 Sep 2024 11:21:53 +0200
Subject: [PATCH can-next v4 11/20] can: rockchip_canfd: add TX PATH
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-rockchip-canfd-v4-11-1dc3f3f32856@pengutronix.de>
References: <20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de>
In-Reply-To: <20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=10684; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=YuwCD3I+XqgAKfBKKX+ipqusj2W94Al2//omfOQm2OA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm1tVDlsI72ibFHXje3zD8RYqzWDOZY47+wWeVg
 fOkuK9K/vOJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtbVQwAKCRAoOKI+ei28
 b+nHB/0XrctfZfmZ7F5uYCVePxH5O8E4XBborSYQPjTbPQ+AHsVkG9i9sRnPlRdbtxYOU9DX1AU
 IKorf+myfARQ8rN0TpNcYuP0Np5/w8R3KoctcIB5+AyW4/idRYe3BkoN1MEV4RhCCd1KATSVboD
 +8demVrHPwixNLGzeCjA4xHR2u9y2505YA5LvNeYooaUOYEtSCNqzCdz4I5d0K4PuMfdCFF3ml2
 keidt1H1QACNhtC5LgPNnRJDJ/DaK8YaA/1hQnNB3qoSIsgDAjqiWoMRa30T/hU36IqqlGQc+4/
 HvyPrHboJArzwEV26PnOT9scw0FYdNUcoTELkrSGJ1GhKUES
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The IP core has a TX event FIFO. In other IP cores, this type of FIFO
usually contains the events that a CAN frame has been successfully
sent. However, the IP core on the rk3568v2 the FIFO also holds events
of unsuccessful transmission attempts.

It turned out that the best way to work around this problem is to set
the IP core to self-receive mode (RXSTX), filter out the self-received
frames and insert them into the complete TX path.

Add a pair new functions to check if 2 struct canfd_frame are equal.
The 1st checks if the header of the CAN frames are equal, the 2nd
checks if the data portion are equal:

- rkcanfd_can_frame_header_equal()
- rkcanfd_can_frame_data_equal()

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c |  6 +-
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 96 ++++++++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c   | 94 +++++++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h      | 26 +++++++
 4 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index d6c0f2fe8d2b..700702e4d2ed 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -229,6 +229,7 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 	 * - CAN_FD: enable CAN-FD
 	 * - AUTO_RETX_MODE: auto retransmission on TX error
 	 * - COVER_MODE: RX-FIFO overwrite mode, do not send OVERLOAD frames
+	 * - RXSTX_MODE: Receive Self Transmit data mode
 	 * - WORK_MODE: transition from reset to working mode
 	 */
 	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
@@ -236,17 +237,20 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE |
 		RKCANFD_REG_MODE_AUTO_RETX_MODE |
 		RKCANFD_REG_MODE_COVER_MODE |
+		RKCANFD_REG_MODE_RXSTX_MODE |
 		RKCANFD_REG_MODE_WORK_MODE;
 
 	/* mask, i.e. ignore:
 	 * - TIMESTAMP_COUNTER_OVERFLOW_INT - timestamp counter overflow interrupt
 	 * - TX_ARBIT_FAIL_INT - TX arbitration fail interrupt
 	 * - OVERLOAD_INT - CAN bus overload interrupt
+	 * - TX_FINISH_INT - Transmit finish interrupt
 	 */
 	priv->reg_int_mask_default =
 		RKCANFD_REG_INT_TIMESTAMP_COUNTER_OVERFLOW_INT |
 		RKCANFD_REG_INT_TX_ARBIT_FAIL_INT |
-		RKCANFD_REG_INT_OVERLOAD_INT;
+		RKCANFD_REG_INT_OVERLOAD_INT |
+		RKCANFD_REG_INT_TX_FINISH_INT;
 
 	rkcanfd_chip_fifo_setup(priv);
 	rkcanfd_timestamp_init(priv);
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 609282359bca..650dfd41e0a0 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -4,8 +4,52 @@
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
+#include <net/netdev_queues.h>
+
 #include "rockchip_canfd.h"
 
+static bool rkcanfd_can_frame_header_equal(const struct canfd_frame *const cfd1,
+					   const struct canfd_frame *const cfd2,
+					   const bool is_canfd)
+{
+	const u8 mask_flags = CANFD_BRS | CANFD_ESI | CANFD_FDF;
+	canid_t mask = CAN_EFF_FLAG;
+
+	if (canfd_sanitize_len(cfd1->len) != canfd_sanitize_len(cfd2->len))
+		return false;
+
+	if (!is_canfd)
+		mask |= CAN_RTR_FLAG;
+
+	if (cfd1->can_id & CAN_EFF_FLAG)
+		mask |= CAN_EFF_MASK;
+	else
+		mask |= CAN_SFF_MASK;
+
+	if ((cfd1->can_id & mask) != (cfd2->can_id & mask))
+		return false;
+
+	if (is_canfd &&
+	    (cfd1->flags & mask_flags) != (cfd2->flags & mask_flags))
+		return false;
+
+	return true;
+}
+
+static bool rkcanfd_can_frame_data_equal(const struct canfd_frame *cfd1,
+					 const struct canfd_frame *cfd2,
+					 const bool is_canfd)
+{
+	u8 len;
+
+	if (!is_canfd && (cfd1->can_id & CAN_RTR_FLAG))
+		return true;
+
+	len = canfd_sanitize_len(cfd1->len);
+
+	return !memcmp(cfd1->data, cfd2->data, len);
+}
+
 static unsigned int
 rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 				  const struct rkcanfd_fifo_header *header,
@@ -47,6 +91,48 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
+static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
+				const struct canfd_frame *cfd_rx, const u32 ts,
+				bool *tx_done)
+{
+	const struct canfd_frame *cfd_nominal;
+	const struct sk_buff *skb;
+	unsigned int tx_tail;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	skb = priv->can.echo_skb[tx_tail];
+	if (!skb) {
+		netdev_err(priv->ndev,
+			   "%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n",
+			   __func__, tx_tail,
+			   priv->tx_head, priv->tx_tail);
+
+		return -ENOMSG;
+	}
+	cfd_nominal = (struct canfd_frame *)skb->data;
+
+	/* We RX'ed a frame identical to our pending TX frame. */
+	if (rkcanfd_can_frame_header_equal(cfd_rx, cfd_nominal,
+					   cfd_rx->flags & CANFD_FDF) &&
+	    rkcanfd_can_frame_data_equal(cfd_rx, cfd_nominal,
+					 cfd_rx->flags & CANFD_FDF)) {
+		unsigned int frame_len;
+
+		rkcanfd_handle_tx_done_one(priv, ts, &frame_len);
+
+		WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
+		netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
+					      rkcanfd_get_tx_free(priv),
+					      RKCANFD_TX_START_THRESHOLD);
+
+		*tx_done = true;
+
+		return 0;
+	}
+
+	return 0;
+}
+
 static inline bool
 rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
 {
@@ -89,6 +175,16 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 		return 0;
 	}
 
+	if (rkcanfd_get_tx_pending(priv)) {
+		bool tx_done = false;
+
+		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
+		if (err)
+			return err;
+		if (tx_done)
+			return 0;
+	}
+
 	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF)
 		skb = alloc_canfd_skb(priv->ndev, &skb_cfd);
 	else
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 89c65db3b2dc..668a902f4c2a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -4,9 +4,103 @@
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
+#include <net/netdev_queues.h>
+
 #include "rockchip_canfd.h"
 
+static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
+					 const u32 reg_cmd)
+{
+	rkcanfd_write(priv, RKCANFD_REG_CMD, reg_cmd);
+}
+
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct rkcanfd_priv *priv = netdev_priv(ndev);
+	u32 reg_frameinfo, reg_id, reg_cmd;
+	unsigned int tx_head, frame_len;
+	const struct canfd_frame *cfd;
+	int err;
+	u8 i;
+
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
+	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
+				       rkcanfd_get_tx_free(priv),
+				       RKCANFD_TX_STOP_THRESHOLD,
+				       RKCANFD_TX_START_THRESHOLD)) {
+		if (net_ratelimit())
+			netdev_info(priv->ndev,
+				    "Stopping tx-queue (tx_head=0x%08x, tx_tail=0x%08x, tx_pending=%d)\n",
+				    priv->tx_head, priv->tx_tail,
+				    rkcanfd_get_tx_pending(priv));
+
+		return NETDEV_TX_BUSY;
+	}
+
+	cfd = (struct canfd_frame *)skb->data;
+
+	if (cfd->can_id & CAN_EFF_FLAG) {
+		reg_frameinfo = RKCANFD_REG_FD_FRAMEINFO_FRAME_FORMAT;
+		reg_id = FIELD_PREP(RKCANFD_REG_FD_ID_EFF, cfd->can_id);
+	} else {
+		reg_frameinfo = 0;
+		reg_id = FIELD_PREP(RKCANFD_REG_FD_ID_SFF, cfd->can_id);
+	}
+
+	if (cfd->can_id & CAN_RTR_FLAG)
+		reg_frameinfo |= RKCANFD_REG_FD_FRAMEINFO_RTR;
+
+	if (can_is_canfd_skb(skb)) {
+		reg_frameinfo |= RKCANFD_REG_FD_FRAMEINFO_FDF;
+
+		if (cfd->flags & CANFD_BRS)
+			reg_frameinfo |= RKCANFD_REG_FD_FRAMEINFO_BRS;
+
+		reg_frameinfo |= FIELD_PREP(RKCANFD_REG_FD_FRAMEINFO_DATA_LENGTH,
+					    can_fd_len2dlc(cfd->len));
+	} else {
+		reg_frameinfo |= FIELD_PREP(RKCANFD_REG_FD_FRAMEINFO_DATA_LENGTH,
+					    cfd->len);
+	}
+
+	tx_head = rkcanfd_get_tx_head(priv);
+	reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
+
+	rkcanfd_write(priv, RKCANFD_REG_FD_TXFRAMEINFO, reg_frameinfo);
+	rkcanfd_write(priv, RKCANFD_REG_FD_TXID, reg_id);
+	for (i = 0; i < cfd->len; i += 4)
+		rkcanfd_write(priv, RKCANFD_REG_FD_TXDATA0 + i,
+			      *(u32 *)(cfd->data + i));
+
+	frame_len = can_skb_get_frame_len(skb);
+	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
+	if (!err)
+		netdev_sent_queue(priv->ndev, frame_len);
+
+	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
+
+	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
+
+	netif_subqueue_maybe_stop(priv->ndev, 0,
+				  rkcanfd_get_tx_free(priv),
+				  RKCANFD_TX_STOP_THRESHOLD,
+				  RKCANFD_TX_START_THRESHOLD);
+
 	return NETDEV_TX_OK;
 }
+
+void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
+				unsigned int *frame_len_p)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	unsigned int tx_tail;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	stats->tx_bytes +=
+		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+							    tx_tail, ts,
+							    frame_len_p);
+	stats->tx_packets++;
+}
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index c775e75a2740..a4688411e586 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -471,10 +471,36 @@ rkcanfd_get_timestamp(const struct rkcanfd_priv *priv)
 	return rkcanfd_read(priv, RKCANFD_REG_TIMESTAMP);
 }
 
+static inline unsigned int
+rkcanfd_get_tx_head(const struct rkcanfd_priv *priv)
+{
+	return READ_ONCE(priv->tx_head) & (RKCANFD_TXFIFO_DEPTH - 1);
+}
+
+static inline unsigned int
+rkcanfd_get_tx_tail(const struct rkcanfd_priv *priv)
+{
+	return READ_ONCE(priv->tx_tail) & (RKCANFD_TXFIFO_DEPTH - 1);
+}
+
+static inline unsigned int
+rkcanfd_get_tx_pending(const struct rkcanfd_priv *priv)
+{
+	return READ_ONCE(priv->tx_head) - READ_ONCE(priv->tx_tail);
+}
+
+static inline unsigned int
+rkcanfd_get_tx_free(const struct rkcanfd_priv *priv)
+{
+	return RKCANFD_TXFIFO_DEPTH - rkcanfd_get_tx_pending(priv);
+}
+
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
+void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
+				unsigned int *frame_len_p);
 
 #endif

-- 
2.45.2



