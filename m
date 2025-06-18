Return-Path: <linux-can+bounces-3853-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82559ADE6B0
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3345B7A487C
	for <lists+linux-can@lfdr.de>; Wed, 18 Jun 2025 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB35283FDC;
	Wed, 18 Jun 2025 09:23:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC97494
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238624; cv=none; b=BEdAqVDtLQWcbi7//YptY2kDiOX0Cy33jHLpbEarXb9GdL3oPtVaVERYg7DVu2fycGvvxUufwTgPcnmO7YbTVOw4SdMkMSxpQOI8WoVH6zjwMnSJ6ssVZAyIscmVmkGc3wDCtoXw3GZ6YB5p7sDnQgEd9VLwzpXaVN/8CcdAzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238624; c=relaxed/simple;
	bh=yG9+6mZLafdO5zPPZiR29k/5knnoOyxMgDZjiNh73VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWu/RaR2Oi72jZSmP0RGtuI2lpSTG9vco0YtWRZX8yA9+BzcfI9l9w8kOwWfaaKIrj7Gb6l6+GtltP3vtUxN4D3ZwVHC8VnY7lQJeWOlxrWpBRw4+I7DqhniNqvwJyZuZpR6q2l+vSZ5cf13rXldaxfkg1/bRVCBbiZ3OooN6IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1B-0006XH-4f
	for linux-can@vger.kernel.org; Wed, 18 Jun 2025 11:23:41 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRp1A-00476s-29
	for linux-can@vger.kernel.org;
	Wed, 18 Jun 2025 11:23:40 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 5321842B297
	for <linux-can@vger.kernel.org>; Wed, 18 Jun 2025 09:23:40 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id C5A1A42B270;
	Wed, 18 Jun 2025 09:23:38 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8fe1abaf;
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
Subject: [PATCH net-next 01/10] can: rcar_canfd: Consistently use ndev for net_device pointers
Date: Wed, 18 Jun 2025 11:19:55 +0200
Message-ID: <20250618092336.2175168-2-mkl@pengutronix.de>
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

Most net_device pointers are named "ndev", but some are called "dev".
Increase uniformity by always using "ndev".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/7593bdd484a35999030865f90e4c9063b22d2a54.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7f10213738e5..2174c9667cab 100644
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

base-commit: 6d4e01d29d87356924f1521ca6df7a364e948f13
-- 
2.47.2



