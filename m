Return-Path: <linux-can+bounces-7623-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KnaEZD1BGoTQwIAu9opvQ
	(envelope-from <linux-can+bounces-7623-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:05:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E053B3E4
	for <lists+linux-can@lfdr.de>; Thu, 14 May 2026 00:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EA573068E52
	for <lists+linux-can@lfdr.de>; Wed, 13 May 2026 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EB3CAA41;
	Wed, 13 May 2026 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZ8CUHHy"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052F3CAA3B;
	Wed, 13 May 2026 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709826; cv=none; b=SIlwg35n2yPfXYL3dQTNyiVQ9fXtVAF5YytlSHMjzoqMu3bwhlnu5kbkHBxMcuLbD5i2VbtgNAiTvoU+SpeuHtlIoU7lLxWPet0GqbZsoFsoF3LVgEbaCbtP/Tbr4drODJJP9uBbXMLAQ2hw6C4qScoOPcWrDdBbQoKB4zk64qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709826; c=relaxed/simple;
	bh=Puy6ngsQY/0YjfmDOaDKNp63+djPMuQx42KTX9C5XYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLwZ5uV8GITce17IvYHmAjbF1s3ENGCZWkV7NyFNequeP7rWPHr85cHI/Bmy/WRrHvAj1UXKKy22n1aBeQBtaxrBeOrUm8aTPuODz0/O4620BqkN9hqv3feNDZ7lE5Y/4V5+3omjkOlQ6CUu4dC8lXvRGNuYmnSTv+unmqH84Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZ8CUHHy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778709825; x=1810245825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Puy6ngsQY/0YjfmDOaDKNp63+djPMuQx42KTX9C5XYQ=;
  b=IZ8CUHHyhF7+t0of/sJjhHNQBXDdsg6K3IsNSAVvb7tzODdr6UV6sqz4
   FqXXj9eEpGV57MZo31gNOzDNl11+RJcQ2+IEYntz+DR4MUFfGkd0J77/v
   eY2FDJlcbG38AOKvPanpxDC6jhZSfRrucdS7IwzYpVvqRClbwFtB4LQ2/
   DPt6wJkt106PmJo2bbjzhCxhnqwJOkH4KDd7L3AgBqoXg0mQIcStKvgrf
   WLkarq24rT8pkz2dT+rzaZXYTHB6T8t/TptIe+Oap8WFC1+hiDRtpI14l
   0suDN4YkzZNCVw18w2/hJbr/CTgIb5JgrmNn7AwpyV+QBLspOTppJ0AjL
   g==;
X-CSE-ConnectionGUID: wNJk7GFrTnKr9zlLBqZXAA==
X-CSE-MsgGUID: ywsNs1ibQOa4+JCKOaQ/vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79600728"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79600728"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 15:03:42 -0700
X-CSE-ConnectionGUID: JdczoZvNT8m5WKbYV/pxhA==
X-CSE-MsgGUID: 1HVDaJswTnqYRRsiQsh7sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="238447028"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 13 May 2026 15:03:39 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 9834299; Thu, 14 May 2026 00:03:38 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peng Fan <peng.fan@nxp.com>,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 2/6] phy: phy-can-transceiver: use device_get_match_data()
Date: Thu, 14 May 2026 00:01:27 +0200
Message-ID: <20260513220336.369628-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
References: <20260513220336.369628-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA7E053B3E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7623-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

Use the generic firmware node interface for retrieving
device match data instead of the OF-specific one.

While at it, drop unneeded argument to devm_phy_create() which
extracts device node from the given device by default.

Reviewed-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 1808f903c057..37b706d841ff 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -5,9 +5,9 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com
  *
  */
-#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/module.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
@@ -152,7 +152,6 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct can_transceiver_phy *can_transceiver_phy;
 	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
-	const struct of_device_id *match;
 	struct phy *phy;
 	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
@@ -161,11 +160,10 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	u32 max_bitrate = 0;
 	int err, i, num_ch = 1;
 
-	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
-	if (!match || !match->data)
+	drvdata = device_get_match_data(dev);
+	if (!drvdata)
 		return -ENODEV;
 
-	drvdata = match->data;
 	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
 		num_ch = 2;
 
@@ -190,7 +188,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		can_transceiver_phy = &priv->can_transceiver_phy[i];
 		can_transceiver_phy->priv = priv;
 
-		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		phy = devm_phy_create(dev, NULL, &can_transceiver_phy_ops);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create can transceiver phy\n");
 			return PTR_ERR(phy);
-- 
2.50.1


