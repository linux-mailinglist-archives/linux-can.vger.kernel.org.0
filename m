Return-Path: <linux-can+bounces-5483-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB79C687E4
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A38912A884
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7C326D70;
	Tue, 18 Nov 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="HwiiElPM"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085C31A7E6;
	Tue, 18 Nov 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457700; cv=none; b=mx2GmCiAZQejFWntJt5KAVqCiq4El+v/2SBMMAzr+N5ZS/myN2uUAz3Z+zjzlixwexeg+qZk5suNLG7oaHiQL8jRI8y0YE/2BQHoCiP8H5RdDL4gTz8svDdAYA0e9Ju6RhTagslNsc+jGGDua1lgQe2adbc2afvC8nKNuhXQLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457700; c=relaxed/simple;
	bh=lZdwI/r+jFdYNMBHCoNFfYnxlV9yVg8rteHV9kgTw3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj6oESthWzT9Ep+8owW7UWqRouJX9UwFCAENrSoCh2lfPMK1sl0Gp+/XVIyJ0gXiN9/BFvf+KyBQzOwXF6TDN62w3rsdqB3TfrvCMFEHWMshulenUzXw7mUVN75UMlaXyBwHr5OCGNkXleuU/0GL9hyfuocLlt7L3XxbxSDxWtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=HwiiElPM reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fJ01RGJz1DHc4;
	Tue, 18 Nov 2025 10:21:36 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHz0HZRz1DQrn;
	Tue, 18 Nov 2025 10:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457696;
	bh=6tkl5nHID9oP8tfKbnGzaF98n5Rgglr41s9KC7FnAGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwiiElPMW122zNa1zcr880l1YdRd3B3I/171eNMWu8nXdrq6SuZYGV3tn5C4/VnEB
	 uINwq18fWnAwimI65Ekhks5TpxMSxi9F2sjwjUhKl5s6hFwkG2SA5k/1huD+cRP950
	 kFYXFvQ+dT8qBJtGBf0JeKBAuoJsrZcjFlOXOVFwAv0Ihg0LEjDDX3gnE+bzDAY0mC
	 3kaSDC27IZGYefLrKRgfSHvoNmuPfw3SL9IIeLJK/qHGX243Vd8g04r4kTWbke07sf
	 USDoqfd00F1iCs+qGP6mI8NKuzjNfHshKTLtR9InM+S74sajv8dvFkTCINgrXCw6R1
	 x7y+5/vqgD2CA==
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
Subject: [PATCH 07/10] can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
Date: Tue, 18 Nov 2025 10:21:12 +0100
Message-ID: <20251118092115.3455-8-arun.muthusamy@gaisler.com>
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

Sets the DMA mask for GRCAN and GRCANFD devices to 32-bit.
Setting the DMA mask and coherent DMA mask to 32-bit ensures proper
memory addressing during DMA operations

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/net/can/grcan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index e367581faa57..51a10fae2faf 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1074,6 +1074,12 @@ static int grcan_allocate_dma_buffers(struct net_device *dev,

 	/* Extra GRCAN_BUFFER_ALIGNMENT to allow for alignment */
 	dma->base_size = lsize + ssize + GRCAN_BUFFER_ALIGNMENT;
+
+	/* On 64-bit systems.. GRCAN and GRCANFD can only address 32-bit */
+	if (dma_set_mask_and_coherent(priv->ofdev_dev, DMA_BIT_MASK(32))) {
+		netdev_warn(dev, "No suitable DMA available\n");
+		return -ENOMEM;
+	}
 	dma->base_buf = dma_alloc_coherent(priv->ofdev_dev,
 					   dma->base_size,
 					   &dma->base_handle,
--
2.51.0


