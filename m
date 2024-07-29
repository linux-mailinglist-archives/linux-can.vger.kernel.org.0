Return-Path: <linux-can+bounces-1047-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B593F656
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFACB1F231A8
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5C15F3EA;
	Mon, 29 Jul 2024 13:07:15 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807D15DBAB
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258435; cv=none; b=d5mUoK7dSb8NidFZJYTIz3hM1eeYNO438w7asgYW6faGewmC75sdtnPYdZtNyFrakND/a5r269aYBmqzHEm9Nl8cpPAV0opgYUtTsXTqjl9bzZ2Ld4ZUmDa4dfIUSUPtORFXO1NXZI7ak14g1zikIfrIS+07Gp9b8M6oj9ZZfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258435; c=relaxed/simple;
	bh=BTDI17d/x6zfl95KLdW0t8KzpPaPurYCbbYkd5icNSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZSiKqpE64C0T3l88NyrlC5PiIWAhuCwbliJ9aKB4eZWXy8nJFPSo1EwceVyfrpWXaI5gX3p0Hh19yrEouH4ILr5MZBgEn2g5/tnvbYw6VH+QQuwkms0aEPE/N10FhkOI12cqqSOgktCv4ZJk7jrvPYfjp/qM3x6A2o52DINeHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5n-0000dG-L9
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:11 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5m-0033Dd-CW
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:10 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0965D310E69
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:09 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 098A6310DE7;
	Mon, 29 Jul 2024 13:06:59 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3e5b42a6;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:43 +0200
Subject: [PATCH can-next 12/21] can: rockchip_canfd: add TX PATH
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-12-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=9344; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=BTDI17d/x6zfl95KLdW0t8KzpPaPurYCbbYkd5icNSA=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5PG5zkhSfcYzHZYz83HLgw0D/8l1OJuXHnC9
 tCTJ2JxTmCJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTxgAKCRAoOKI+ei28
 bya2B/49wrPGrG5YRKkd/PUjHm6SsIPzMpeqPtiNGQRWJL25iSqCtG/EpjkYNIfnAdiEQaOlEN3
 rM4Vz73HsbGNNKuEBpyQpZ/7q9ZthfskSwcEfRFvDlk01I28Q/hQENKtaRV7wMxch25Wsh8oOuy
 +wHweHpanCD8/zNuUsrsbla2SILgAcCaktoluz7n8DgBBTGaorBAoHR/3aWzFDimeZlf9bm40J8
 eFXoLkrSiZsEu3t/QcwkjAoScMgoo17ePNG7HtRRKfqsh5GbRXy3PiCCzrMEMCXZwt45Osz/eRK
 JBqurLXHeG+h/wNZVTVoSvpJlDZ8uhmYy/r9UnpckRaH7aED
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The IP core has a TX event FIFO. In other IP cores, this type of FIFO
normally contains the event that a CAN frame has been successfully
sent. However, the IP core on the rk3568v2 the FIFO also holds events
of unsuccessful transmission attempts.

It turned out that the best way to work around this problem is to set
the IP core to self-receive mode (RXSTX), filter out the self-received
frames and insert them into the complete TX path.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c |  6 +-
 drivers/net/can/rockchip/rockchip_canfd-rx.c   | 54 +++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c   | 96 ++++++++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h      | 26 +++++++
 4 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 02291bd77deb..03ad7936034b 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -232,6 +232,7 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 	 * - CAN_FD: enable CAN-FD
 	 * - AUTO_RETX_MODE: auto retransmission on TX error
 	 * - COVER_MODE: RX-FIFO overwrite mode, do not send OVERLOAD frames
+	 * - RXSTX_MODE: Receive Self Transmit data mode
 	 * - WORK_MODE: transition from reset to working mode
 	 */
 	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
@@ -239,17 +240,20 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
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
index df5280375ca9..af90c66de60f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -4,6 +4,8 @@
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
+#include <net/netdev_queues.h>
+
 #include "rockchip_canfd.h"
 
 static bool rkcanfd_can_frame_header_equal(const struct canfd_frame *const cfd1,
@@ -89,6 +91,48 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
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
@@ -131,6 +175,16 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
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
index 89c65db3b2dc..85daf7b7be8b 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -4,9 +4,105 @@
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
+	struct sk_buff *skb;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	skb = priv->can.echo_skb[tx_tail];
+	stats->tx_bytes +=
+		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+							    tx_tail, ts,
+							    frame_len_p);
+	stats->tx_packets++;
+}
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 09369ea62797..ddc9cba1a095 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -470,10 +470,36 @@ rkcanfd_get_timestamp(const struct rkcanfd_priv *priv)
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
2.43.0



