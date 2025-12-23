Return-Path: <linux-can+bounces-5913-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE75CD906D
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 12:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C262C3059E82
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3E3314B7;
	Tue, 23 Dec 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TiwklGZP"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027532B9BD;
	Tue, 23 Dec 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487401; cv=none; b=eGzZLBDVrbvXEFWpmdX6pCxUUQPFkwxKm8zxshJZtrmAavadyG1LGj9R89GZhN80TvCmTjUzOP8+M++zuDmntc/ty5qVulR6IuDmGvcQBlfywfDGa11QQAfPeGOPxJzSSMj5TshJVJsBvsAkjOfuH2CX8jXb6SCImYX8syGlajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487401; c=relaxed/simple;
	bh=V4B81ldGHaQr4Fo6sQ46ag8QdAvOe2EzrCi6sXLaTcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeneMRWkdM5Je8xmH+FDo85yew9Hq9Kx1P3qEFNh/IK3wFZsbu3aWHO+tHhX1S0btmiEFzw/OTVpaVGwLcybJ0W9bbP5dfwxSaxHMuItqWDfkIe5DSBHS6aaTK9z8vdDFmc/BxW3HpZjeURGRaNDH2L60sAqtMAVwZrOlYwOi0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TiwklGZP reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlF3GBfz1DR2l;
	Tue, 23 Dec 2025 11:56:25 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlF0qHCz1DHcd;
	Tue, 23 Dec 2025 11:56:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487385;
	bh=YAYzPUEcArEa3JVRdCueQZUu9bqLktofuk5IHtJ8aTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TiwklGZPxHszH//2ErVZoOTfU0p6HQBSkdNRNOOYVYMz+XWelVJzvILUDyVkYAYJa
	 dqJHY091m99dBMa8XBgHMdHqxhvn+RGPlAoNjP3eE9a6WBIY5cdgoC2UxOLfezkj8I
	 KpRxNOlRcEM+lfZzNb9TJ13SfnZMXNYv73jLz6qdnHI0tJz4R1THtLrI4venXhYj8U
	 SuVg008cV6u7j7TkmxRVhBgc9a8ZvoiPRWX+1U/O/9u10FAaMcT7huyG7nkZJJ8ORX
	 YK4Dgz+Utb2Cc0LN+Vgn5oWJhRp4bzAlCDN1jXS8SimxUPHoUNg3LvjggUBEY+PRXO
	 drIfwqzCXaVxw==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Daniel Hellstrom <daniel@gaisler.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v2 08/10] can: grcan: Add saving and restoring of CAN FD baud-rate registers
Date: Tue, 23 Dec 2025 11:56:02 +0100
Message-ID: <20251223105604.12675-9-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
References: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Hellstrom <daniel@gaisler.com>

While reset the GRCAN baud-rates are preserved, since GRCANFD has the
baud-rate in different registers we need to add saving of those
registers too.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index cdb9498cf783..dc14b3145e73 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -520,15 +520,27 @@ static void grcan_reset(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_registers __iomem *regs = priv->regs;
 	u32 config = grcan_read_reg(&regs->conf);
+	u32 nbtr, fdbtr;
+
+	if (priv->hwcap->fd) {
+		nbtr = grcan_read_reg(&regs->nbtr);
+		fdbtr = grcan_read_reg(&regs->fdbtr);
+	}
 
 	grcan_set_bits(&regs->ctrl, GRCAN_CTRL_RESET);
 	grcan_write_reg(&regs->conf, config);
+	if (priv->hwcap->fd) {
+		grcan_write_reg(&regs->nbtr, nbtr);
+		grcan_write_reg(&regs->fdbtr, fdbtr);
+	}
 
 	priv->eskbp = grcan_read_reg(&regs->txrd);
 	priv->can.state = CAN_STATE_STOPPED;
 
 	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
 	grcan_write_reg(&regs->rxmask, 0);
+
+	priv->hwcap->set_bittiming(dev);
 }
 
 /* stop device without changing any configurations */
-- 
2.51.0


