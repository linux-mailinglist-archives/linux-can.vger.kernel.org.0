Return-Path: <linux-can+bounces-3813-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BBEAD5AAC
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D157A4948
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A21D130E;
	Wed, 11 Jun 2025 15:37:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4161B0412;
	Wed, 11 Jun 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656275; cv=none; b=BHN31rRKlqlzxTG+QhpbtZE3RX1b85oTG15RQEoLH4ZfoeMycEbxIAVxdK1FnLdPcKME+po9Cxwkg6dBjAeo/F7EptN3nTmUvygzdWyqOcnaY+odER6xpKPtR0DFpkI0+mNCpiBkNTNQ8/NyrQ5X290fgUJiaiXHBpD8JVAM47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656275; c=relaxed/simple;
	bh=pyJ8llq/pZeV/foCZFnGQeAu/yQMIU2+R8GhmYCh5fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoDmBCXKg6xiTz3HVtkSqgJdREvbGqA0ck5LpNirHoqseb9zajerKLSIb1yZBDQulRAQ7GkM3tmBpCnb4uRcLAVrGSd1+VMbLKBXIZ1Bx8ss64XHp2OFydfNatTrwIzVWYLStRg+1GwlNOTGwAB2JWJKNzrppAahQ7aSFCNuU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CB4C4CEE3;
	Wed, 11 Jun 2025 15:37:53 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 03/10] can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
Date: Wed, 11 Jun 2025 17:37:32 +0200
Message-ID: <22afe32a65f7c3e64ce3917aec943ac24d6e185a.1749655315.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749655315.git.geert+renesas@glider.be>
References: <cover.1749655315.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcar_canfd_rx_pkt() has many users of "priv->ndev".  Introduce a
shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
v2:
  - Add Reviewed-by.
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b353168f75f28565..ddf3b91d3d2bba97 100644
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
2.43.0


