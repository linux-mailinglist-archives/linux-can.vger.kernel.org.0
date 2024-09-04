Return-Path: <linux-can+bounces-1396-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A2B96BDAD
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E525A1C24D67
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216E1DB938;
	Wed,  4 Sep 2024 13:03:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F471DB537
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454993; cv=none; b=fhPSwYDz4qHs57WLlMZsnufO49r8Uv4DsQuNWyNEU8p+fvCf7trvUhQTLl5w7tZh2jhsqew7lw+zyvsCIgglkPdSO05AcoYbnjrRkUZFttsEhFj8eenxrqnd0Y793v8JSSW/RYcZ7tUJTY1xW2FXot833w/nv6oYJV2N26tkM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454993; c=relaxed/simple;
	bh=/wx77IodT0GepTANOEqRK+xKlnfKu7rYee3gKD5l4I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLqxQ0lwV0Ur8cui+hPDRS/LWN/VTJf+v56280qVswOd2nTc3Ts3wKxncGDV6JbFmvWTN+WXbDPvMY9S7wiJtZol5Vb5WptsZN0MOIZaNII+ikocVoxSEXB3KrxjDlzObSwU/T9HAembtFYcLyYJIDEE9CwvpG1LummWqXnhmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpfA-00070f-Jm
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 15:03:08 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slpf6-005SW8-1b
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 15:03:04 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B3EEF3327DF
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 13:03:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 9485D332772;
	Wed, 04 Sep 2024 13:03:00 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 99952c62;
	Wed, 4 Sep 2024 13:02:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 10/18] can: rockchip_canfd: implement workaround for erratum 6
Date: Wed,  4 Sep 2024 14:55:26 +0200
Message-ID: <20240904130256.1965582-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904130256.1965582-1-mkl@pengutronix.de>
References: <20240904130256.1965582-1-mkl@pengutronix.de>
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

The rk3568 CAN-FD errata sheet as of Tue 07 Nov 2023 11:25:31 +08:00
says:

| The CAN controller's transmission of extended frames may
| intermittently change into standard frames.
|
| When using the CAN controller to send extended frames, if the
| 'tx_req' is configured as 1 and coincides with the internal
| transmission point, the extended frame will be transmitted onto the
| bus in the format of a standard frame.

To work around Erratum 6, the driver is in self-receiving mode (RXSTX)
and all received CAN frames are passed through rkcanfd_rxstx_filter().

Add a check in rkcanfd_rxstx_filter() whether the received frame
corresponds to the current outgoing frame, but the extended CAN ID has
been mangled to a standard ID. In this case re-send the original CAN
frame.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-12-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c | 44 ++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c |  8 ++++
 drivers/net/can/rockchip/rockchip_canfd.h    | 19 +++++++++
 3 files changed, 71 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 650dfd41e0a0..31cee3362f1e 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -95,6 +95,7 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 				const struct canfd_frame *cfd_rx, const u32 ts,
 				bool *tx_done)
 {
+	struct net_device_stats *stats = &priv->ndev->stats;
 	const struct canfd_frame *cfd_nominal;
 	const struct sk_buff *skb;
 	unsigned int tx_tail;
@@ -130,6 +131,49 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 		return 0;
 	}
 
+	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6))
+		return 0;
+
+	/* Erratum 6: Extended frames may be send as standard frames.
+	 *
+	 * Not affected if:
+	 * - TX'ed a standard frame -or-
+	 * - RX'ed an extended frame
+	 */
+	if (!(cfd_nominal->can_id & CAN_EFF_FLAG) ||
+	    (cfd_rx->can_id & CAN_EFF_FLAG))
+		return 0;
+
+	/* Not affected if:
+	 * - standard part and RTR flag of the TX'ed frame
+	 *   is not equal the CAN-ID and RTR flag of the RX'ed frame.
+	 */
+	if ((cfd_nominal->can_id & (CAN_RTR_FLAG | CAN_SFF_MASK)) !=
+	    (cfd_rx->can_id & (CAN_RTR_FLAG | CAN_SFF_MASK)))
+		return 0;
+
+	/* Not affected if:
+	 * - length is not the same
+	 */
+	if (cfd_nominal->len != cfd_rx->len)
+		return 0;
+
+	/* Not affected if:
+	 * - the data of non RTR frames is different
+	 */
+	if (!(cfd_nominal->can_id & CAN_RTR_FLAG) &&
+	    memcmp(cfd_nominal->data, cfd_rx->data, cfd_nominal->len))
+		return 0;
+
+	/* Affected by Erratum 6 */
+
+	*tx_done = true;
+
+	stats->tx_packets++;
+	stats->tx_errors++;
+
+	rkcanfd_xmit_retry(priv);
+
 	return 0;
 }
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 668a902f4c2a..e98e7a836b83 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -14,6 +14,14 @@ static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 	rkcanfd_write(priv, RKCANFD_REG_CMD, reg_cmd);
 }
 
+void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
+{
+	const unsigned int tx_head = rkcanfd_get_tx_head(priv);
+	const u32 reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
+
+	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
+}
+
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index a4688411e586..3fe6ddcdd8ac 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -342,6 +342,24 @@
 
 /* Erratum 6: The CAN controller's transmission of extended frames may
  * intermittently change into standard frames
+ *
+ * Work around this issue by activating self reception (RXSTX). If we
+ * have pending TX CAN frames, check all RX'ed CAN frames in
+ * rkcanfd_rxstx_filter().
+ *
+ * If it's a frame we've send and it's OK, call the TX complete
+ * handler: rkcanfd_handle_tx_done_one(). Mask the TX complete IRQ.
+ *
+ * If it's a frame we've send, but the CAN-ID is mangled, resend the
+ * original extended frame.
+ *
+ * To reproduce:
+ * host:
+ *   canfdtest -evx -g can0
+ *   candump any,0:80000000 -cexdtA
+ * dut:
+ *   canfdtest -evx can0
+ *   ethtool -S can0
  */
 #define RKCANFD_QUIRK_RK3568_ERRATUM_6 BIT(5)
 
@@ -499,6 +517,7 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 
+void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 				unsigned int *frame_len_p);
-- 
2.45.2



