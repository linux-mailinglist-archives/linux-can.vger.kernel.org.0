Return-Path: <linux-can+bounces-3811-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF74AD5AD6
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1559F1885F23
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EDD1D7E41;
	Wed, 11 Jun 2025 15:37:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7551ABEA5;
	Wed, 11 Jun 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656271; cv=none; b=PROg1an0A4OhVQHKQ8F0dYWQL4p/jcJCL2V+43zxS0SON/v7ucDJolmqCwXSOEu36WIH3JZVRsNrqCK2EVjld/9B0Ojdtkt4brNSbR2WjHtACEEYU+MBHem5hhHo4dIibLqTIQgL+e3NwttjE0gpvRlANQj8fHpb4ELcbKCv2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656271; c=relaxed/simple;
	bh=MdmffwVUJd0qv/qHKUcleani7YBtmOgHu9wJo0pydGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heuJk2rWWL7gnjc2CUzyiwxOdcZeD5Wwtkf9ekwXsBC32NzKwIbtOGZiH8r3PlBXjXyQP61Sjw9wr4zC2kOPK8x67AJY++8a8kXtkdZlyY2AkHQ7kPb/c1xH9PFwOBkAtHVl7ELri8/5bn5aRmUssHwlzZiwtcW/lbxkz66AWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B34DC4CEEA;
	Wed, 11 Jun 2025 15:37:49 +0000 (UTC)
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
Subject: [PATCH v2 01/10] can: rcar_canfd: Consistently use ndev for net_device pointers
Date: Wed, 11 Jun 2025 17:37:30 +0200
Message-ID: <7593bdd484a35999030865f90e4c9063b22d2a54.1749655315.git.geert+renesas@glider.be>
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

Most net_device pointers are named "ndev", but some are called "dev".
Increase uniformity by always using "ndev".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
v2:
  - Add Reviewed-by.
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7f10213738e5cee7..2174c9667cabce54 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1436,9 +1436,9 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void rcar_canfd_set_bittiming(struct net_device *dev)
+static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
-	struct rcar_canfd_channel *priv = netdev_priv(dev);
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
@@ -1818,10 +1818,10 @@ static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
 	}
 }
 
-static int rcar_canfd_get_berr_counter(const struct net_device *dev,
+static int rcar_canfd_get_berr_counter(const struct net_device *ndev,
 				       struct can_berr_counter *bec)
 {
-	struct rcar_canfd_channel *priv = netdev_priv(dev);
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 	u32 val, ch = priv->channel;
 
 	/* Peripheral clock is already enabled in probe */
-- 
2.43.0


