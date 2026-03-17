Return-Path: <linux-can+bounces-7100-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DdXKny6uWnJMQIAu9opvQ
	(envelope-from <linux-can+bounces-7100-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 21:33:00 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 273842B24D5
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 21:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBE51315461B
	for <lists+linux-can@lfdr.de>; Tue, 17 Mar 2026 20:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64F38A71D;
	Tue, 17 Mar 2026 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWig76wT"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC138CFE6;
	Tue, 17 Mar 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779429; cv=none; b=BsnItaYsAAkY4SHJ4Greefvq9j+Ts5FKChbtwZzY5mIIQLxjxWvhww69P2eyczMSBg5utR7yS/d+x/qg34d8C8ivFgouGVIyGnmLOS21MaHoLo3CM+Jpp1YKfxjoCRJNfO5hkWbIEAzR/gldjrpRAshwEFznFSAiy0njhxJSoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779429; c=relaxed/simple;
	bh=Voj+ack1teh1dnW09zwdJQRrs2brV0kRS+OfUhtRLCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqgxBNGmwyrdKijMY2ovuCfN465CZBguDn5Fobx+xJuIjqpWdalVk2XFC5iHNJGDMtuA7QLB6YO9pznjrD/WJbU0s/7E0lCMMaZPzuFUFAL3Eh5+KQ4ktHXqXfSKn6VG6w+A8JNieLIVFQ5PpgHyTRfDEun5cHNOUrYsHi78H5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWig76wT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773779428; x=1805315428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Voj+ack1teh1dnW09zwdJQRrs2brV0kRS+OfUhtRLCM=;
  b=JWig76wTyPyBRAZpF/hWzC7D2w31sovOYFMbh3rl7Hn2qzwVWho92rAO
   NH1zsRqXHIf/N70GyXi/TRjZFyclENR5vEX3OFyP5cPfln/Dj24dHjlPM
   oNVSOJ2bNiErt3Xq82zMW7DB8YKMeaRZiWeGU/acJyPe+WJr5wjUbUWhl
   CQNpZ3WLoUXVcJo9DVqaxgrK3/bt5CNN0riAJJ9EWOoppOFqqqHVNIJqf
   bzHiPiS90hrOog6+DGRsSX2LT04eQgN8rkUgN1ijKuH3DNyZbIDb+VSI+
   vl6s5hmuMnT6kk4k90Ca+N+t5qFNTVDyd5gM5W4qwJTouFi/y3ahItAEZ
   A==;
X-CSE-ConnectionGUID: DjZU04VmSJqh6qfeGCAWPA==
X-CSE-MsgGUID: CckWMaNpTziI6z9W3mwkfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77433976"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="77433976"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 13:30:24 -0700
X-CSE-ConnectionGUID: GicUGuPSQIqCZGcWtM+mUQ==
X-CSE-MsgGUID: SGxzjw47Qp+H9jmqmA2fKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222434440"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 17 Mar 2026 13:30:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0552298; Tue, 17 Mar 2026 21:30:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/4] phy: phy-can-transceiver: Convert to use device property API
Date: Tue, 17 Mar 2026 21:27:27 +0100
Message-ID: <20260317203001.2108568-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7100-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 273842B24D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It seems the driver is half-moved to use device property APIs.
Finish that by converting everything to use that.

While at it, drop unneeded argument to devm_phy_create() which
extracts device node from the given device by default.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 2b52e47f247a..80eece74f77d 100644
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
@@ -161,8 +160,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	u32 max_bitrate = 0;
 	int err, i, num_ch = 1;
 
-	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
-	drvdata = match->data;
+	drvdata = device_get_match_data(dev);
 	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
 		num_ch = 2;
 
@@ -187,7 +185,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		can_transceiver_phy = &priv->can_transceiver_phy[i];
 		can_transceiver_phy->priv = priv;
 
-		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		phy = devm_phy_create(dev, NULL, &can_transceiver_phy_ops);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create can transceiver phy\n");
 			return PTR_ERR(phy);
-- 
2.50.1


