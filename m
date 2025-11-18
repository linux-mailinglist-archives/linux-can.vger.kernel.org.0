Return-Path: <linux-can+bounces-5484-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADAC68827
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3086835F969
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE9328B4C;
	Tue, 18 Nov 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="bsOUKvUa"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BA320CB6;
	Tue, 18 Nov 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457701; cv=none; b=cehDh05Pu005TyTJSnBHbeMzdDCObFus+Pb67dvDwhuLbFNB4zPB/+mI8DzvCxdChUW3SvRoHNKSMnTXpA1tOoRv1nHz2ktNGj0QmH0HbkSgTgaqg6jZH64V3p8lwjzoZd+BaAO304dpVrL8rP4agpJCvi9CxqHVv+iNjai3+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457701; c=relaxed/simple;
	bh=LVS6eRyUPiqzjSOcNIID21CJbnwYaMkpo/BaNL/MUK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCW6VXenJy7+Hb2b6n/ESmMQZR3M13lp6QpYXez7jfpRf0NPYAvf4lIuM6xJunNtmwwuAd/LGHuq1EH/R6b3Z17WZbBn++iKvS7FyJreMaiqGAlGFmHJ3Dwkzg1E8CU/klizVcNY0ZWtbZosiklaD5VaMcwzYVmCGl9RGFO4krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=bsOUKvUa reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fJ1205sz1DHbS;
	Tue, 18 Nov 2025 10:21:37 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fJ06h3Hz1DDMt;
	Tue, 18 Nov 2025 10:21:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457697;
	bh=i26IscNrG/yGOdmDusxDjybIBfuxBgNEq0EZpswnJek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bsOUKvUaxz1e867e0JANCawlYLJJinJVUGBUGujdJLis3W6mNLPHqfUbyxkoDgNnu
	 QWIcSK9Guaz0Xi6Cmoknl4mLxuEjQ4g2s9ZoTIRl9on+KUMmd7gTt8Bi6InTW0+AYz
	 uF/3luCg5PX7tg4uRoAvckXHXAhB8Zef23TDXtC45Lk9AO9pkK67RsiZzALf8cu0h5
	 tH00dB15AIf7DvsjO+QGdoyZOrqsmYpsESevkYWF/Z1HQR1rak3nR+8mGYurhqO6Q8
	 Hhg8rLYxE2ZfDjQTpDDAi6dTKqmxN3dSgP8ZpZcwINP/xL2b2Dow4TMyih8ogDGZpc
	 cYEWXWuiucVOA==
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
Subject: [PATCH 08/10] can: grcan: Add saving and restoring of CAN FD baud-rate registers
Date: Tue, 18 Nov 2025 10:21:13 +0100
Message-ID: <20251118092115.3455-9-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
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

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/grcan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 51a10fae2faf..b0e2367fb163 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -589,9 +589,19 @@ static void grcan_reset(struct net_device *dev)
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
--
2.51.0


