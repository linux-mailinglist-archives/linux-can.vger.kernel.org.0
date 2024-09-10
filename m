Return-Path: <linux-can+bounces-1469-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9E973FB3
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45671C21771
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC101BB6B0;
	Tue, 10 Sep 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbhNdog6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1811BB6A9;
	Tue, 10 Sep 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989015; cv=none; b=qB1WgfwnvtLaJ9D56skkBzvar8iEiKvsE3m1PSk1RHov+Kf3pQS0TEm0GY7Z7UhLS3FUX3cJYHDIT2Gp30aoSPVPC63cfpk3w54KWefYkF5zNhmlJ5bWhP4p1V1D5V1+gqkZ756pLZrzTR5Ncl6n7nPj0+v/nKoNkQ+HtXP6FHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989015; c=relaxed/simple;
	bh=wcksTIayPbC7R4ptNyxPgKHrUtQgD0J2DgCH9JdxTz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqimtjqzPGTBT6W4U1tDvpiolboE3SSINDnod9BdY154AO6/c8CvPhFM7wmm9FV0Wg0eAWwm0VoNKmb7vGwJ0pUPcqZJFzrbnaROZEmuIXTUGHb0WY8nOLRe8veOa+xD0ZQBYlqNuNgQzOb9nJUFSTqb5yCYfJCrLog2Dz9q7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbhNdog6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E50C4CEC3;
	Tue, 10 Sep 2024 17:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989014;
	bh=wcksTIayPbC7R4ptNyxPgKHrUtQgD0J2DgCH9JdxTz0=;
	h=From:To:Cc:Subject:Date:From;
	b=lbhNdog6UxYIEN8QQEJxu8C3q9Zek0PcIytI6gtQCWHJ5uziBBQm8wJ68snUMcEG+
	 CjTmM7uFrflSSaCnDepiuLmb/sgHoURiPgovVvnFqPlrLsOJYaCYDjmEucIPNrJpsR
	 1pMUTTF4xx128hNEgtVIYoTh3mQ/IsZ8EOygAvNeRx1QKb/uhBzWMwcEkSKuCF0Wy6
	 xUZ+gn0OEOk73Z3yaEBCVRyvrk6nVvvjDc4jwCBiVI6fHKtBaUsI/IoIsJtdZaxKp0
	 H2Kouog3rdhdpBohY9FNXYNlXSGIhu3w7ypMCG3I86gQPJZOiiUrSjOCAtABbtH45Y
	 VWTyhnlHLATCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	manivannan.sadhasivam@linaro.org,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/8] can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configuration
Date: Tue, 10 Sep 2024 13:23:21 -0400
Message-ID: <20240910172332.2416254-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.109
Content-Transfer-Encoding: 8bit

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit ac2b81eb8b2d104033560daea886ee84531e3d0a ]

When changing the interface from CAN-CC to CAN-FD mode the old
coalescing parameters are re-used. This might cause problem, as the
configured parameters are too big for CAN-FD mode.

During testing an invalid TX coalescing configuration has been seen.
The problem should be been fixed in the previous patch, but add a
safeguard here to ensure that the number of TEF coalescing buffers (if
configured) is exactly the half of all TEF buffers.

Link: https://lore.kernel.org/all/20240805-mcp251xfd-fix-ringconfig-v1-2-72086f0ca5ee@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 4d0246a0779a..f677a4cd00f3 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -279,7 +279,7 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	const struct mcp251xfd_rx_ring *rx_ring;
 	u16 base = 0, ram_used;
 	u8 fifo_nr = 1;
-	int i;
+	int err = 0, i;
 
 	netdev_reset_queue(priv->ndev);
 
@@ -375,10 +375,18 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 		netdev_err(priv->ndev,
 			   "Error during ring configuration, using more RAM (%u bytes) than available (%u bytes).\n",
 			   ram_used, MCP251XFD_RAM_SIZE);
-		return -ENOMEM;
+		err = -ENOMEM;
 	}
 
-	return 0;
+	if (priv->tx_obj_num_coalesce_irq &&
+	    priv->tx_obj_num_coalesce_irq * 2 != priv->tx->obj_num) {
+		netdev_err(priv->ndev,
+			   "Error during ring configuration, number of TEF coalescing buffers (%u) must be half of TEF buffers (%u).\n",
+			   priv->tx_obj_num_coalesce_irq, priv->tx->obj_num);
+		err = -EINVAL;
+	}
+
+	return err;
 }
 
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
-- 
2.43.0


