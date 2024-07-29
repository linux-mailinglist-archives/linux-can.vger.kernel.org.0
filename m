Return-Path: <linux-can+bounces-1052-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8A93F66C
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F17B21E5C
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08C187560;
	Mon, 29 Jul 2024 13:07:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC315F319
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258444; cv=none; b=eNaxqilQNi1LXQGcuiDiSgHseNddFadUzg47bb1ocY9Hs9Gu7YuZlzqL7iVFnOs/YfSMeT4N8JrQVJyu9Og25Muct6EgChcoQ//ZCRemLsKLsMzFd727wSnp8ojZcSYtSz2A2GZrrI9aPue5Y65oqX5EtvniurgVjGRKbX0De+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258444; c=relaxed/simple;
	bh=YF1Mc8Vi1p3nIUTgw1XLWs+JimwbfIPDvGq5g+3GG9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbiimD5apcXTofAs/ys0pIwEtPdGN0E6F/Dmka5s6mcVw+THBKEgtcHZqw4rmeEY/1tf0lDmUFN2XPLVZCJnbuIbsIYwvyo19Dm99kCKh7uEhAMGNVer7xlqLFf0Ku/imt8T49TBzQ3HAW+8OGeEu9fMo3VuQD82cg9Z9LxSCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5w-0000xQ-EZ
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5v-0033K9-C5
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id F2501310EDB
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6B332310E52;
	Mon, 29 Jul 2024 13:07:08 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 552e2b04;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:48 +0200
Subject: [PATCH can-next 17/21] can: rockchip_canfd: prepare to use full
 TX-FIFO depth
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-17-fa1250fd6be3@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4154; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=YF1Mc8Vi1p3nIUTgw1XLWs+JimwbfIPDvGq5g+3GG9k=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBmp5PP8/+tD+XKOKT41bRaTD71dk4AWvmzhui8b
 ArlLDvSR6aJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZqeTzwAKCRAoOKI+ei28
 b8Z8CACLWc29SoQK6DzVckNkDmVgbNsWVA4S+Gyj1zX5diw0ZAj5y8ubBxrSrdv48yz33y9u4QO
 RKo3cBtt7fioe+mmpyPs7xOdRaPb4pMyca3afQpqYJ7qq6vAZ+iv5HfG2oJ8kAA0xg0rAsggt8N
 DFevUZZTqtWkJ+rLlkEmtIkkgrhM5PX7FYXUdg+O/uBU0ZyW+4rZglirZaxh787gX0w2uwL121z
 LeL8o5InmhBgFx0Ukto8I8Ls94v3/Km0q6cge8D6vZQXExZd6zL9KaknXG5SPlO90skwUum5qkJ
 a59vt26AyiTKSDCVXV87RNQ4BDlnZTjAhO/MftPp3T1zG7lk
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

So far the TX-FIFO is only used with a depth of 1, although the
hardware offers a depth of 2.

The workaround for the chips that are affected by erratum 6, i.e. EFF
frames may be send as standard frames, is to re-send the EFF frame.
This means the driver cannot queue the next frame for sending, as long
ad the EFF frame has not been successfully send out.

Introduce rkcanfd_get_effective_tx_free() that returns "0" space in
the TX-FIFO if an EFF frame is pending and the actual free space in
the TX-FIFO otherwise. Then replace rkcanfd_get_tx_free() with
rkcanfd_get_effective_tx_free() everywhere.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c |  2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 38 ++++++++++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd.h    |  1 +
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 4289dc0ced0d..fa7913ef415d 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -124,7 +124,7 @@ static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
 
 		WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
 		netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
-					      rkcanfd_get_tx_free(priv),
+					      rkcanfd_get_effective_tx_free(priv),
 					      RKCANFD_TX_START_THRESHOLD);
 
 		*tx_done = true;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index d604994755d3..d719a52258e3 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -8,6 +8,40 @@
 
 #include "rockchip_canfd.h"
 
+static bool rkcanfd_tx_tail_is_eff(const struct rkcanfd_priv *priv)
+{
+	const struct canfd_frame *cfd;
+	const struct sk_buff *skb;
+	unsigned int tx_tail;
+
+	if (!rkcanfd_get_tx_pending(priv))
+		return false;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	skb = priv->can.echo_skb[tx_tail];
+	if (!skb) {
+		netdev_err(priv->ndev,
+			   "%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n",
+			   __func__, tx_tail,
+			   priv->tx_head, priv->tx_tail);
+
+		return false;
+	}
+
+	cfd = (struct canfd_frame *)skb->data;
+
+	return cfd->can_id & CAN_EFF_FLAG;
+}
+
+unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv)
+{
+	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6 &&
+	    rkcanfd_tx_tail_is_eff(priv))
+		return 0;
+
+	return rkcanfd_get_tx_free(priv);
+}
+
 static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
 					 const u32 reg_cmd)
 {
@@ -42,7 +76,7 @@ int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_OK;
 
 	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
-				       rkcanfd_get_tx_free(priv),
+				       rkcanfd_get_effective_tx_free(priv),
 				       RKCANFD_TX_STOP_THRESHOLD,
 				       RKCANFD_TX_START_THRESHOLD)) {
 		if (net_ratelimit())
@@ -99,7 +133,7 @@ int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
 
 	netif_subqueue_maybe_stop(priv->ndev, 0,
-				  rkcanfd_get_tx_free(priv),
+				  rkcanfd_get_effective_tx_free(priv),
 				  RKCANFD_TX_STOP_THRESHOLD,
 				  RKCANFD_TX_START_THRESHOLD);
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index b736a10e8f1f..3c1d61c8632f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -532,6 +532,7 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 
+unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv);
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,

-- 
2.43.0



