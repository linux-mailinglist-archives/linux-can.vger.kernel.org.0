Return-Path: <linux-can+bounces-5914-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F454CD9070
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 12:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45EDF305C4D9
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A593314D4;
	Tue, 23 Dec 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="h/TQqO9A"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91433030D;
	Tue, 23 Dec 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487402; cv=none; b=HLaQ0EECbTZC5xWrJWeBzpTDv8hwSm+GKpafpmUQS/pATIeskVZDVY+C8knSBA9AMIlA9PNK83xht2rA8C0uzYmpTo5cXWnQB4BRwgmQ25/i7WECh18FtL3aJIvKvR28/qQkxkoG4IgzpF4FMDIB/hKy+pr92o9VaLXdBZ8YpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487402; c=relaxed/simple;
	bh=lWqGwdFl8tS+18dKv4LLOCagY7vhQ7BLpdb1qUJbpzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6t7iSBWYp+12+pKAALTS4okxowXS+jjGdAyVrpn/Q1rdx3g6h6h8VsfHAriGvQmYg3J4L1x4PYTHAh957DmhG5+SEv/o4hAMVMflpRZ03QpiYuXWK6AbGXOAkSec/oPZvSWdo6twuqDKrUWnlgbFO57mbdc5rL3xn7COn3OC3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=h/TQqO9A reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlF12T1z1DR2j;
	Tue, 23 Dec 2025 11:56:25 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlD5wgvz1DDN0;
	Tue, 23 Dec 2025 11:56:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487385;
	bh=OGb0u8/dBE5mIlzxDiXljrEL8G7LO8iwH9wpS1qUMUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/TQqO9AkSfLKuYnKXBbNDGFiKjwYFl6ljWbsI9QcVQdgXCnvgfbZRq2AtCedisND
	 eFu2pSJzl8CII72cNxNf2Vkgp43TYCroa6DRKPXyri+rHSV2/qOGjGIjkX4xKkDi2O
	 e+oyyzstjHA0ijFNzD0B2YR3lruHhWLg20ugadda8DjtuQ8cZSMYuQ1AmS49DyQ/AT
	 930AZ0OU+TIzoiINd7PNrA2GIhruQuNhAkOmLUyurCAeyoyY6oS+Dk7Cvse4fC/y2z
	 nZ/LpAU4iLMh6sY8T8/AHK6m8n1+Q3MPHeI+rlHggfdmC7AJW8ks4v/dKp92Es+PUI
	 7WBeqz5sadJiA==
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
Subject: [PATCH v2 07/10] can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
Date: Tue, 23 Dec 2025 11:56:01 +0100
Message-ID: <20251223105604.12675-8-arun.muthusamy@gaisler.com>
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

Sets the DMA mask for GRCAN and GRCANFD devices to 32-bit.
Setting the DMA mask and coherent DMA mask to 32-bit ensures proper
memory addressing during DMA operations

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 8a6c59473cf4..cdb9498cf783 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1753,6 +1753,13 @@ static int grcan_probe(struct platform_device *ofdev)
 		goto exit_error;
 	}
 
+	/* On 64-bit systems.. GRCAN and GRCANFD can only address 32-bit */
+	err = dma_set_mask_and_coherent(&ofdev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err_probe(&ofdev->dev, err, "No usable DMA configuration.\n");
+		goto exit_error;
+	}
+
 	irq = irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
 	if (!irq) {
 		dev_err(&ofdev->dev, "no irq found\n");
-- 
2.51.0


