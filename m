Return-Path: <linux-can+bounces-4233-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F8B264D9
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75582A27F1
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEE2FCBE9;
	Thu, 14 Aug 2025 12:02:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235032FC891;
	Thu, 14 Aug 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172941; cv=none; b=b1OYIPqLNqb34hRA9EJ0HewZLv71Jbuzfwf0cGu2uP11f8GSvxsVey+Y/iLB30xxvmW+7HXGHqwLOw7764IeHliJB7Lvtx8F5lGMve5kBaovGMMjy9dBtsaEcUBTng8/kTmDqTZ21P50ega76eEmRFhrfvY13qcoZ0H6G3uept0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172941; c=relaxed/simple;
	bh=v+7xjUgrRmAhosRvIBeU7JUGdBwzdNfN+hBQIKv0y70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCBVdJOwS6vcLxXnKSzcfPDZ6e7mj3rsVN+Oh4pTtPFfrkL3P0k4ycHPwVx6Rh59DHdLzO3UAbevAF/wTRQUC+4cggdZXiffD/cTiojzdyL82G8fpXW/dNssnuKZP163m4UVJfGNY+QhUP2zKOFPuHJ/GTnb4eRvGoIqsTt0z+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975C6C4CEEF;
	Thu, 14 Aug 2025 12:02:19 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/9] can: rcar_can: Consistently use ndev for net_device pointers
Date: Thu, 14 Aug 2025 14:01:59 +0200
Message-ID: <abca36f2f35a02941c4c81192abae171ba52a255.1755172404.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755172404.git.geert+renesas@glider.be>
References: <cover.1755172404.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most net_device pointers are named "ndev", but some are called "dev".
Increase uniformity by always using "ndev".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 87c134bcd48db559..5b0b495d127cdcb3 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -420,9 +420,9 @@ static irqreturn_t rcar_can_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void rcar_can_set_bittiming(struct net_device *dev)
+static void rcar_can_set_bittiming(struct net_device *ndev)
 {
-	struct rcar_can_priv *priv = netdev_priv(dev);
+	struct rcar_can_priv *priv = netdev_priv(ndev);
 	struct can_bittiming *bt = &priv->can.bittiming;
 	u32 bcr;
 
@@ -715,10 +715,10 @@ static int rcar_can_do_set_mode(struct net_device *ndev, enum can_mode mode)
 	}
 }
 
-static int rcar_can_get_berr_counter(const struct net_device *dev,
+static int rcar_can_get_berr_counter(const struct net_device *ndev,
 				     struct can_berr_counter *bec)
 {
-	struct rcar_can_priv *priv = netdev_priv(dev);
+	struct rcar_can_priv *priv = netdev_priv(ndev);
 	int err;
 
 	err = clk_prepare_enable(priv->clk);
-- 
2.43.0


