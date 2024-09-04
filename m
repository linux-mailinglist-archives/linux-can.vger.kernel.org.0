Return-Path: <linux-can+bounces-1374-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DA896B72A
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACDA1C21E74
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D11D0167;
	Wed,  4 Sep 2024 09:42:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096621CF5E3
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442957; cv=none; b=qvnuAREccBEXreWkJQ0PCy9vFKVlYzLZxULOIsld6+myztJEg1U5xCLp/elNF3Cr6nMDwNvWksXuUKgO+XAF4PtiQmIbFeBArB/1o8W8DQC+0GTBYmC6HHoGWdQCKR3zD1Bo5GdWvfr6acaGIjsyZ6eETnwr8DyMYeHVHPYy1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442957; c=relaxed/simple;
	bh=iHrK7UlM6U1GS2K172/ramAZ1RaZEThfPD2YcmPJk1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmLP6gp04osWs5CM6hilgG0dpNJLzznfQDgah6J7KnPSG6Qcx/Rc8Xy1dMxB6W61oRtJs2e7Fod5sIVrqoK4C1EPS/DLrqhMOAiKJoUdhaYt7QlsZsWnuBdpTgg7AyZ9DzjBuWLP3W0ltgpSDni+QBGVc5HZkFLU0W7ZAqfv+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmX2-0004WW-S4
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:32 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWz-005QDp-Am
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 11:42:29 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 053B2332413
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 09:42:28 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 4CCFA332378;
	Wed, 04 Sep 2024 09:42:23 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 468d46d7;
	Wed, 4 Sep 2024 09:42:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 16/20] can: rockchip_canfd: prepare to use full TX-FIFO depth
Date: Wed,  4 Sep 2024 11:38:51 +0200
Message-ID: <20240904094218.1925386-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904094218.1925386-1-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
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

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-16-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-rx.c |  2 +-
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 38 ++++++++++++++++++--
 drivers/net/can/rockchip/rockchip_canfd.h    |  1 +
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 9f72483dab18..bacef5e5dc39 100644
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
index f8e74e814b3b..d10da548ba71 100644
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
index f24a1d18be66..37d90400429f 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -533,6 +533,7 @@ int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 
+unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv);
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
-- 
2.45.2



