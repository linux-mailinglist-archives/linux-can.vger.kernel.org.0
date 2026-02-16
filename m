Return-Path: <linux-can+bounces-6556-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rdmAH3khk2lJ1wEAu9opvQ
	(envelope-from <linux-can+bounces-6556-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:54:01 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0E14433A
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5004B300BD8A
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE9330E0EF;
	Mon, 16 Feb 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="g2TO0cJO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7942FFDD5;
	Mon, 16 Feb 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250038; cv=none; b=C2yTpLV2lYHA4CFqwH2VDF4Wa/i+QyFYbi1/TR/K82OHkqSpl6Esd13Jj7SzT1yE/0JXapxQdjJ2w7AESAzraERQYIaWAPPMhpTGPUAjQHRK27ONBMLsTAaV6HeI1cIxMBSXUlDNkwCXpt43mbk5MCi+hPeh1DxykMD9/Ad7Evs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250038; c=relaxed/simple;
	bh=pAbE7oUiYBzPGw0DKpSKNoz6vw1tL4Fy7hQ2s129X2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyp7l+ufsUsfz8JwbdZV0O3+AIHxBq3ESzuxHuUeqgtOfjAkLt48cRXJ8BWzvX/hnEQpad5EGgOn4rBQydJsZ4JLTroFLjoFezUsioH/wJHyErHFyZeEBNRAc3EDJ5KgCd4DvkVm76juurM9Xr264vzJwOarKAmlL3zH5qTDNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=g2TO0cJO reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44Y1DS4z1FbwN;
	Mon, 16 Feb 2026 14:53:49 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44X5kNGz1Fbw6;
	Mon, 16 Feb 2026 14:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250029;
	bh=IMU/wLjbU6RVE7LY0W7niv61k/USFwtxnDj46IVSkeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2TO0cJO6FQbZrQf/t2LmRw2X0Na8jJx2bcs7kuMYg5y4EPARpeB7zmw8bypkjq/G
	 Dp6QD4CZN+ZDvkDadImJPFSpflku0cIS2QQuJ6agyFqL+0hkAtdK7oDbSQ9CCo78T6
	 /HCzkHQp2zHBMUytNsxLRrpaeNHE8/RtfNPQVNFmhVNmgUL+U21CnuJgikRBn6ZAlU
	 r731G7CLF5Lwk8qGDA+fPb8/sYT0WK7UNtt4Z/QL8PrPzIFuf9QmJzCusBpzS0m3h6
	 LNfIdwXY7pRSMhFUEv1/KTkiMTwjDSvgUIRF4RIULMB+SQyk5wbUlmkuXTGMMlSYjX
	 N401rCGFFuXeQ==
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
Subject: [PATCH v5 04/16] can: grcan: Add clock handling
Date: Mon, 16 Feb 2026 14:53:32 +0100
Message-ID: <20260216135344.23246-5-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6556-lists,linux-can=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBB0E14433A
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


