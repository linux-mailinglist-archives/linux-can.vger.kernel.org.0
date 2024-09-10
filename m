Return-Path: <linux-can+bounces-1466-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF2973F49
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 19:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446641F23E7F
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A951A2C32;
	Tue, 10 Sep 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BROZu51Y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E36187325;
	Tue, 10 Sep 2024 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988937; cv=none; b=CyRp22AKRuG1A2ATyTlH2ltJAD69J03lvlfcrCAavsPh8veSw7dn4YBgj734OBngbr8oym/ouc4OJvSdEnXfY+FpHwZ6Spicsa1zss1d025/sVGsOscej8zA7BmbEjf//d0antotpK4YccTCq20M5UV84LBbvev6Hp4LmRUTv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988937; c=relaxed/simple;
	bh=iGrCBjaAJgyXl6EajV1JoPS+WhJRGQMa2OxDxAzIA4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+IVmvQJftMVj/2kq/kquTgJWdGhBYIHWeq0htyGCVbn0RHMEKPsKJHH8mzlKAam6fafVddrWyZRdLj0Q6gvojJaXb8+McMiC2bcYDlXyk8fRv3UkeJvpu1WDau4RNyfgQ2RraslTXG/7HoIDkk+8blyIsGp0sddwPgIRqgHQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BROZu51Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1057C4CEC3;
	Tue, 10 Sep 2024 17:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988937;
	bh=iGrCBjaAJgyXl6EajV1JoPS+WhJRGQMa2OxDxAzIA4A=;
	h=From:To:Cc:Subject:Date:From;
	b=BROZu51Y6mD1r7jH9YIiOsYw6rwd8gGgbOk68Wz1KzPGXCT4Sn8JWqrrbXetaRMWV
	 J4t/eh0W+aQH5/azAaswunJ4KHDAjTDvhJ90XuPIacB2uR32bcE+hthKufcBldXIEJ
	 nJbapXZnA+RE4k9ISfZ7ag/PwJ9D8KWy8lIHNF2JZWyJsYgltdEgcpnJM9w+37Et48
	 jJpHzlbqeMGKoopJuj9VLKZ2XJxetnSwb8Q7o7TNRnZRxxu8feGW3ScO+fYzLbcmVM
	 Wx1D8WxLhvdduaVWhRZZJSNlMMiN16DulwJSdFoJrYSXnJsDSULA6EoSnB3NdcO28D
	 i+TDr9nOxu0Mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	rcsekar@samsung.com,
	mailhol.vincent@wanadoo.fr,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 01/18] can: m_can: Limit coalescing to peripheral instances
Date: Tue, 10 Sep 2024 13:21:46 -0400
Message-ID: <20240910172214.2415568-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.9
Content-Transfer-Encoding: 8bit

From: Markus Schneider-Pargmann <msp@baylibre.com>

[ Upstream commit e443d15b949952ee039b731d5c35bcbafa300024 ]

The use of coalescing for non-peripheral chips in the current
implementation is limited to non-existing. Disable the possibility to
set coalescing through ethtool.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240805183047.305630-8-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/m_can/m_can.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 14b231c4d7ec..6f5899f2e593 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2129,7 +2129,7 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static const struct ethtool_ops m_can_ethtool_ops = {
+static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
 		ETHTOOL_COALESCE_TX_USECS_IRQ |
@@ -2140,18 +2140,20 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 	.set_coalesce = m_can_set_coalesce,
 };
 
-static const struct ethtool_ops m_can_ethtool_ops_polling = {
+static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
-static int register_m_can_dev(struct net_device *dev)
+static int register_m_can_dev(struct m_can_classdev *cdev)
 {
+	struct net_device *dev = cdev->net;
+
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
-	if (dev->irq)
-		dev->ethtool_ops = &m_can_ethtool_ops;
+	if (dev->irq && cdev->is_peripheral)
+		dev->ethtool_ops = &m_can_ethtool_ops_coalescing;
 	else
-		dev->ethtool_ops = &m_can_ethtool_ops_polling;
+		dev->ethtool_ops = &m_can_ethtool_ops;
 
 	return register_candev(dev);
 }
@@ -2337,7 +2339,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	if (ret)
 		goto rx_offload_del;
 
-	ret = register_m_can_dev(cdev->net);
+	ret = register_m_can_dev(cdev);
 	if (ret) {
 		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
 			cdev->net->name, ret);
-- 
2.43.0


