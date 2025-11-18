Return-Path: <linux-can+bounces-5480-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDFBC687DE
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 73D502A765
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8B319862;
	Tue, 18 Nov 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Stqx8TAO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCC3101DD;
	Tue, 18 Nov 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457697; cv=none; b=inUkeMQVXWWEY2vy619Pzxn3606rNqt6HynT5E6sdAVoMZCnWb0TMk2vhGMt1nIJ3ev84dFZMTUb8+BtniUOIIH8XmKvKwgthioeIkkjU7FShCGcTes7EHBzQeihZAg3gVNSFR3kpKEGkW1+illygeaOfMSeUBllQ5xzCuRhu6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457697; c=relaxed/simple;
	bh=m88D8lBJm4UALW3eQ1CFTCXSUl6mxjcAsqAkW2JLgt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzD0omku0eJ1rJA95FN04QiyUh8AaNhDF/7v+prsCvzTmkVQjQ43SGEmbNd+LkaTIG02FVrTgzOOHsAgW4VRSlbEipdumm395JRhS1CUp0Eq/fDPNjZKc7sycd0FmoqTLY4n632N1AZkQ7ajbYx22rPFWZLe+YC3SITULKjR49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Stqx8TAO reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fHw25Q1z1DHbg;
	Tue, 18 Nov 2025 10:21:32 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHv73djz1DQr4;
	Tue, 18 Nov 2025 10:21:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457692;
	bh=isp+XXy2t/sAgvrNrWukSWnOnRGpWab6nIVj+in0B7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Stqx8TAOfYCM3FB74gB8rF5pmY1WlqeNJjVdSpWU3ZBH5L3YFrjyx259Te94gKG/G
	 lzw0mTsI53SCWH0SF5Gas1eax/4hgTBsmM10geLDL/H3V595YvXQvDAjao0fbpIQyk
	 8oHsr49N+n6yiqFmp6qVZrz3kBIph7ZCR6zd6Je3WgsLW7Jkqs32S/1qQs117BHr7f
	 04PHWV2wmf+8/5vYlHHD3hbGEY4yBUB52IsnAE7I7sijMTamjwAsrWau2An5LLSzMQ
	 aDaN14Q7IaBcJjzYJ0Fu9t679BM0ZiQRhRNV0qn9wlwo5X+DVp2qvTzNDEVUpUEu+c
	 tE7eV8C/9Peag==
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
Subject: [PATCH 04/10] can: grcan: Add clock handling
Date: Tue, 18 Nov 2025 10:21:09 +0100
Message-ID: <20251118092115.3455-5-arun.muthusamy@gaisler.com>
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

Add clock handling and add error messages for missing 'freq' DT property.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
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


