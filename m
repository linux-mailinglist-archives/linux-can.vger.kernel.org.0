Return-Path: <linux-can+bounces-6976-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHP+BlICq2nDZQEAu9opvQ
	(envelope-from <linux-can+bounces-6976-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:35:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE72225228
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6FF305B97E
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2431D3EFD00;
	Fri,  6 Mar 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="KRVt+oSw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E136F3ED10B;
	Fri,  6 Mar 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814597; cv=none; b=d5Rd0OQxD8m6ZHxVhZK22jaglF2aPKg/zQGjtnn2yP6EdnIYDQy0DH571MmuE8v06a3I+Hc+R3y/EntnmofT/rzb5u5tBjcmLYW2bEzmi6qurBGEaX5d/i7gC2BYKSlOEukERy0DfzY0VmV7e4nIMhVDcNjifKRLEEnNuTsRNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814597; c=relaxed/simple;
	bh=pAbE7oUiYBzPGw0DKpSKNoz6vw1tL4Fy7hQ2s129X2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwVfmis60j49o7+K7Qjg6gSmDC+oXg/MfJfOkWfPt52pmZ76732xGsrxOe2+NavSizH/mTxccH/CtaE8aSTILYz9bOPySJR56yUljKzSmmqluIAIOLs9NNv2MhflzjxFffqf709NhJliPhJ0IBBo3F/T5LmXSyIxWJ5dp2PwAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=KRVt+oSw reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBh95rdjz1Fljh;
	Fri,  6 Mar 2026 17:29:45 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBh93p7Rz1Fg8v;
	Fri,  6 Mar 2026 17:29:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814585;
	bh=IMU/wLjbU6RVE7LY0W7niv61k/USFwtxnDj46IVSkeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRVt+oSw9PnRdqNE569zq+1jM1e//TMrO54VyqnVfcakUnmSoZ+LUZuSuD7wWOJxh
	 h5j+35jl5M4knvrKJCdHIxQ90Nkadqcx4V1NRfo6y6Hcg/R8wNquIrYia2AS8+VUw8
	 24thYXBt5Yhc0yeQm8pLt2GZm37PMMVwEiI32B8f1XVtVLJIU0CVbcP5kJ3V+tTZsY
	 MN+MvWV3fv38HHT/HUHTGn1onNXV/ur9XQl1jrZBKQpJSu+BvSKXpraT5LASbQSysR
	 FLAKijQdW7Epn3+RhPAfd2SYmDIujfBKCanMVIpeNEVhE99eYJDD8q0Q75qciNoEOU
	 3uhyeaWIZtlQw==
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
Subject: [PATCH v6 04/15] can: grcan: Add clock handling
Date: Fri,  6 Mar 2026 17:29:23 +0100
Message-ID: <20260306162934.22955-5-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
References: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8CE72225228
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6976-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.713];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Daniel Hellstrom <daniel@gaisler.com>

Add clock handling and add error messages for missing 'freq' DT property.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 3b1b09943436..f3821e224f4f 100644
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
@@ -1663,8 +1664,19 @@ static int grcan_probe(struct platform_device *ofdev)
 
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
+
+		ambafreq = clk_get_rate(clk);
+		if (!ambafreq) {
+			dev_err(&ofdev->dev, "Invalid or Uninitialized clock\n");
+			return -EINVAL;
+		}
 	}
 
 	base = devm_platform_ioremap_resource(ofdev, 0);
-- 
2.51.0


