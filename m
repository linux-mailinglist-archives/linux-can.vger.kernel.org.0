Return-Path: <linux-can+bounces-3742-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC29ACAD9A
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B633189F358
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 11:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BEC20DD75;
	Mon,  2 Jun 2025 11:54:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674814F70;
	Mon,  2 Jun 2025 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865280; cv=none; b=sSIhuF9+BMAlZ+6xQkwKdgMcDWbUIxD3mIk0CFSNJKYCeYhsg5L+XyyGnIV16UTnKtuTe2Lyq+9YF8CKbOGO6OQRhwDdOf9tqgVTrXB8LVC5JlW8+GDi2koACEixHkyKkVNN5W62EirJmOB5nN3v5a5nScp91FoXWtRIiRD70PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865280; c=relaxed/simple;
	bh=yPw6yv45QUu0CQk3a6DFNUuBIdl0GKcexRI0Wz0nYkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLwEibgp1qIzZugvss6hZZ9cuMbVxFnOsWoKaJEjeKONCQFr8m+Bt75VpJWqve6ICwqti6EcrmErpq8efazm7phIHSlfK7Kqs7CCjX3G+XSfL3iHOY2VUMe24I/qZ6d8aqXHrqsNztaWoQVKnQFxPCXqQVoUwS4KP65RCfTOwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CCAC4CEED;
	Mon,  2 Jun 2025 11:54:37 +0000 (UTC)
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
Subject: [PATCH 1/9] can: rcar_canfd: Consistently use ndev for net_device pointers
Date: Mon,  2 Jun 2025 13:54:20 +0200
Message-ID: <4aa2a9064b8422757f8c0c61a74f75ba152687c0.1748863848.git.geert+renesas@glider.be>
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

Most net_device pointers are named "ndev", but some are called "dev".
Increase uniformity by always using "ndev".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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


