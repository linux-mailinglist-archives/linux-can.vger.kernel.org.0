Return-Path: <linux-can+bounces-5912-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A4CD8FC6
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F8673021465
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7BF32D439;
	Tue, 23 Dec 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="hXmrWGYR"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505231355C;
	Tue, 23 Dec 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487398; cv=none; b=WMvvzUBbLsq1sMjwjhknqePDbqdt+O4vUU3uxFq2I5wzS9EH//I4PbfmC21Fj/Bq0Gf2lJ13we95juyt6aJGyDQTpXwfGZOCZdQyuRfxdAwTfKHHVxpBt1TNVBsHIVc4taUneHTpWvxzfBEOQ5XZJebjjvz+QnUx7C1eC9jx7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487398; c=relaxed/simple;
	bh=5nuYmtDIo1xkP7UImyOsAOk/6W2j04fEWx3lpFIWgw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPW4yM4gPRkq6IlbOoNcnHoiMcpjvwelXiAK3tACDwHZD8abYWOCLQ/e97luqf8f0VG6nEJETRYkvu8aTRKHUXHm6oBtd8ZYIrYxSKRgPSeGnzokL2XhtHyi/HNzKoxEEKBvvIfxSV5YYgLiJ3iz5XrK+UinhGmQjEiFlZkFqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=hXmrWGYR reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlD2VDLz1DHVZ;
	Tue, 23 Dec 2025 11:56:24 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlD0TJyz1DDgL;
	Tue, 23 Dec 2025 11:56:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487384;
	bh=npkggg7tOGIOrWu8aBerGnxSfTPWt4Z7jdrnizYzqoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hXmrWGYRIWYiDY6vtkEA7uN6srpPDdSSTh5koRoS9G23Jynng2EiaRuByv8FgVG0E
	 10SLNEeU7OU6ndr2l8GzqY/KhNuyJ4p0Lgv2ajJVMUhDfJC66IEZry7CXyMnW/vfSr
	 IRzXHLSbUCMtgH81gtY6q2rDoibJd05Jpz+r2oE0+Z2iNY+r56XAD+r5bLb3jla1wo
	 f+gHYiH2WUzfUnhE2bYyhTv5pYaBHLG2+tfLCZfn3Vcp4UQx2+6B0oWf4PoYjkd9dw
	 oEmdMLhJWv6L4gCkE50lFDQG8oIahrPF1v2CASHlDQm44o8ox2jBV/mW7dS7RaUXhv
	 eDvCv4gZt2HTw==
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
Subject: [PATCH v2 04/10] can: grcan: Add clock handling
Date: Tue, 23 Dec 2025 11:55:58 +0100
Message-ID: <20251223105604.12675-5-arun.muthusamy@gaisler.com>
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

Add clock handling and add error messages for missing 'freq' DT property.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 3b1b09943436..538a9b4f82ab 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -34,7 +34,7 @@
 #include <linux/spinlock.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-
+#include <linux/clk.h>
 #include <linux/dma-mapping.h>
 
 #define DRV_NAME	"grcan"
@@ -1644,6 +1644,7 @@ static int grcan_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct device_node *sysid_parent;
+	struct clk *clk;
 	u32 sysid, ambafreq;
 	int irq, err;
 	void __iomem *base;
@@ -1663,8 +1664,20 @@ static int grcan_probe(struct platform_device *ofdev)
 
 	err = of_property_read_u32(np, "freq", &ambafreq);
 	if (err) {
-		dev_err(&ofdev->dev, "unable to fetch \"freq\" property\n");
-		goto exit_error;
+		clk = devm_clk_get(&ofdev->dev, NULL);
+		if (IS_ERR(clk)) {
+			dev_err_probe(&ofdev->dev, PTR_ERR(clk),
+				      "Failed both to get \"freq\" property and clock for fallback\n");
+			err = PTR_ERR(clk);
+			goto exit_error;
+		}
+		if (clk) {
+			ambafreq = clk_get_rate(clk);
+			if (!ambafreq) {
+				dev_err(&ofdev->dev, "Invalid or Uninitialized clock\n");
+				return -EINVAL;
+			}
+		}
 	}
 
 	base = devm_platform_ioremap_resource(ofdev, 0);
-- 
2.51.0


