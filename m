Return-Path: <linux-can+bounces-4311-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E62B314F8
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE60604D64
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7EB296BAF;
	Fri, 22 Aug 2025 10:17:21 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F28285CBA;
	Fri, 22 Aug 2025 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857841; cv=none; b=QJ71Qfzvh6jZif+vF7/9U+D7bT1iUPryMsCF4r0E9e5Jd5AuYRjMlk+G/viQ50Lw0oGzJugf3NzLlXHfJeVH+26MmZ3BNVcy5zvrNJ1PWVAtwEKv1BbYWNbWBavNyByvetSCEuUbeiyXafQ8DlFVJco7siR0CWg9Z06G2yGYC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857841; c=relaxed/simple;
	bh=Q5eHiyG/nWhjQiYpt2JX5SRLeDhZ8ofHgk7lcsXCRmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APFowryS0KLGzPOJnpwtSjHEUE6k7/UK7J04+DSenCAFDTNCej5BYwY7VCnk92aBn47TaAfFXuO8MzHuBlO03EAayKCkuHAKXQik6UHq+05xjXp4rXPf/zzRee0WzTHSTULoW4qb+vivvFoeL4xSyagaNwfH2RjmxllueBq5xHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E766C4CEF1;
	Fri, 22 Aug 2025 10:17:19 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 01/11] can: rcar_can: Consistently use ndev for net_device pointers
Date: Fri, 22 Aug 2025 12:17:02 +0200
Message-ID: <aac66fb5b5e1d6787121cf2ec36b551b41d4b32e.1755857536.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755857536.git.geert+renesas@glider.be>
References: <cover.1755857536.git.geert+renesas@glider.be>
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
v2:
  - No changes.
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


