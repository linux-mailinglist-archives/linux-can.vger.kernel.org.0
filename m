Return-Path: <linux-can+bounces-3744-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F70ACAD9E
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00A1D165F4E
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21F202978;
	Mon,  2 Jun 2025 11:54:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B8814F70;
	Mon,  2 Jun 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865284; cv=none; b=jkam6UznrdqXCyZCx2FBDxIYy/R6unse4MiWuvW4owBJFOKNIlgp+XQBri0BQMnXRTSxmzx/lRx4lIBXEiYHk/c1ZZZj+r15EVj5QTBDwS75pLzxEFXlHi+NoQioC4vYzgBE8/19mRw48XnO/2V/G3RNigsjW72i+qclMu1xxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865284; c=relaxed/simple;
	bh=+Eg7E4pXnScbKwbpKVTQLhDXWZ2sx/qrw7nbws9u448=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPQ8thCeDsWmrOKCTWcHmnMSwTkXo57nJsFL4AJ2dfDXZHs76erXp6EV3dbWkujdVqb9GnwAR0348aavf090vLTfLYcCY0gvpZhgylh61cWPdh5ozQ1EO0ZNApzzNDAFrghcZRkieqi/d+Z/+q9wRJnErE8ZiWKpkkjagXPYrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F7C4CEED;
	Mon,  2 Jun 2025 11:54:42 +0000 (UTC)
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
Subject: [PATCH 3/9] can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
Date: Mon,  2 Jun 2025 13:54:22 +0200
Message-ID: <62611ace99e793f682af930d292c5728581ef45e.1748863848.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748863848.git.geert+renesas@glider.be>
References: <cover.1748863848.git.geert+renesas@glider.be>
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
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index dbf17b16c18aa5cc..9251d8fd72472f22 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1690,7 +1690,8 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 {
-	struct net_device_stats *stats = &priv->ndev->stats;
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
@@ -1706,14 +1707,13 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
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
@@ -1734,7 +1734,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 
 		if (sts & RCANFD_RFFDSTS_RFESI) {
 			cf->flags |= CANFD_ESI;
-			netdev_dbg(priv->ndev, "ESI Error\n");
+			netdev_dbg(ndev, "ESI Error\n");
 		}
 
 		if (!(sts & RCANFD_RFFDSTS_RFFDF) && (id & RCANFD_RFID_RFRTR)) {
-- 
2.43.0


