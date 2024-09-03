Return-Path: <linux-can+bounces-1327-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6279698F3
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B101C244A9
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A21D6C7E;
	Tue,  3 Sep 2024 09:27:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738321D0967
	for <linux-can@vger.kernel.org>; Tue,  3 Sep 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355660; cv=none; b=Lhkx5WgBWc7nJu/E8KUJeS1hIl06nEGQLFiRgkTGZUDB0dlQUHtmjxKL2OuC0Pt0SewvqOACeYrGp+sy/PzSBXF61AJ9383k94xE6Xjif88+gokkXNz4h7OjU0vSfzG5+pX/Hs8DhWKH+FcLmCbmTvISzO4n05TQr7whSO7bedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355660; c=relaxed/simple;
	bh=sRQubshaT5v9vsvCT2lafCYIN0VsPNipEULSKOD/rxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZ+y3AltLhqm1i1T6MKqYEMW15e87EM0BGktcZiHnavcovln3LYNbluVrEN/abYPO3OkSY7DQU5KoN0t5tJV5jFFyvh9UP85ge7dV8dA4GoED0PYlpmQqLsyPdKhu7o0Hyifs1dgyRsMzcXGYjSlLne5qmn+8pgRph5uoAJNUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPp2-0004L9-Na
	for linux-can@vger.kernel.org; Tue, 03 Sep 2024 11:27:36 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slPp0-0059jO-Kh
	for linux-can@vger.kernel.org; Tue, 03 Sep 2024 11:27:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 52510331173
	for <linux-can@vger.kernel.org>; Tue, 03 Sep 2024 09:22:37 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 19E5033103F;
	Tue, 03 Sep 2024 09:22:28 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e51421b5;
	Tue, 3 Sep 2024 09:22:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 03 Sep 2024 11:21:54 +0200
Subject: [PATCH can-next v4 12/20] can: rockchip_canfd: implement
 workaround for erratum 6
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240903-rockchip-canfd-v4-12-1dc3f3f32856@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5113; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=sRQubshaT5v9vsvCT2lafCYIN0VsPNipEULSKOD/rxg=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm1tVEOq7S5Ne/ImiIiTLSwGd1ulbwRGWMv7++E
 s5q0K9FxyKJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtbVRAAKCRAoOKI+ei28
 byj8B/9PbEwwtkVq+Tn8NqOB7Tlxg651NtzF5jCva+5OED0KKFQ5B9LzHbzpzqiTmx7XwbJXyJG
 +CL7P+TuyuAOg0U0kdIOZdjL5L1cPxMbWLosQS4qbp3xE69L3jY4Yr0GY/5NYHNxKrHKqHHoZDb
 jQAz8ku91mDJhVYbn7PP4/anYqPtd6BgraFZdpJJEPEqvd3QgqgllE8VsoxLhyt+AcyldpQFhHl
 GOGzkMzLFFmTuPYPT9sHxO7pjqOONo9iiHBiO3nB96liUDn9FvNlNJYKl6MBIReJ3mAZ6l38IbT
 OmQ01LqodUH5VPmoVya6r3nH7YukgFbKen0tgUi1fWSKuK4R
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
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
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c | 44 ++++++++++++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c |  8 +++++
 drivers/net/can/rockchip/rockchip_canfd.h    | 19 ++++++++++++
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



