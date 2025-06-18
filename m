Return-Path: <linux-can+bounces-3854-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D350ADE6B4
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 11:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3FD17A26C
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74026283FF7;
	Wed, 18 Jun 2025 09:23:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0D28032D
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238624; cv=none; b=FaMfKIrx/J4xU9ezIVk2MZSyZO7jX+cSpbWqzkxpHgegqHs0Lf0fs7tSLBNA0tpNq8LqgAxLeiasb56nHmkUgu3Z6gkLJo5IliXGjhRdJ6sOOGkaqtK23bmdF/cEc4CqGfRLFDanoGpZDc21CT0y21Uq0ZB26kI9kvfFgn9ORFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238624; c=relaxed/simple;
	bh=dM1W4JzUakjDokAh4VvFPEIerOg3XmvfRS0FZXNv/MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX1KWREmZ6gcrs09Eax3+GJxUti+S5YYJoeG+OLfRxCWd9B/xiLyf7bBLOr5IxlxFIZTIPpE+ReqVB/7ffcOvA1mLRhPKYGsJZXNu7VreAzcAlv7NJGxpqDsBxEqf90LfetgNCW2DlwCgDUn1EbN1JNjWh+9k2OJvsaCf9ZFDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1B-0006Xj-BT
	for linux-can@vger.kernel.org; Wed, 18 Jun 2025 11:23:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1A-004774-2W
	for linux-can@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 72B9342B299
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F19ED42B273;
	Wed, 18 Jun 2025 09:23:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1bd0a2f6;
	Wed, 18 Jun 2025 09:23:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/10] can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
Date: Wed, 18 Jun 2025 11:19:57 +0200
Message-ID: <20250618092336.2175168-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250618092336.2175168-1-mkl@pengutronix.de>
References: <20250618092336.2175168-1-mkl@pengutronix.de>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

rcar_canfd_rx_pkt() has many users of "priv->ndev".  Introduce a
shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/22afe32a65f7c3e64ce3917aec943ac24d6e185a.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b353168f75f2..ddf3b91d3d2b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1684,7 +1684,8 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 {
-	struct net_device_stats *stats = &priv->ndev->stats;
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
@@ -1700,14 +1701,13 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
 		if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) &&
 		    sts & RCANFD_RFFDSTS_RFFDF)
-			skb = alloc_canfd_skb(priv->ndev, &cf);
+			skb = alloc_canfd_skb(ndev, &cf);
 		else
-			skb = alloc_can_skb(priv->ndev,
-					    (struct can_frame **)&cf);
+			skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
 	} else {
 		id = rcar_canfd_read(priv->base, RCANFD_C_RFID(ridx));
 		dlc = rcar_canfd_read(priv->base, RCANFD_C_RFPTR(ridx));
-		skb = alloc_can_skb(priv->ndev, (struct can_frame **)&cf);
+		skb = alloc_can_skb(ndev, (struct can_frame **)&cf);
 	}
 
 	if (!skb) {
@@ -1728,7 +1728,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
 		if (sts & RCANFD_RFFDSTS_RFESI) {
 			cf->flags |= CANFD_ESI;
-			netdev_dbg(priv->ndev, "ESI Error\n");
+			netdev_dbg(ndev, "ESI Error\n");
 		}
 
 		if (!(sts & RCANFD_RFFDSTS_RFFDF) && (id & RCANFD_RFID_RFRTR)) {
-- 
2.47.2



