Return-Path: <linux-can+bounces-6599-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UByxMZ9yl2kdywIAu9opvQ
	(envelope-from <linux-can+bounces-6599-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:29:19 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE91624FB
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 21:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BCE83019F18
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6F318132;
	Thu, 19 Feb 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyNquUY/"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C73176E0;
	Thu, 19 Feb 2026 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532956; cv=none; b=fKWHwK2BqfFkhs/LOk4ThmUpdPaMlD8aszfyp1nTkILU2g91zf35A+Vdc48J1ymPLe5C5JHCgDs4HAcuB1egZjt75n7Te2IlD3h8dtNQ7933OwKhAUm79kt1+q2dpMYFMq7WgYwMJ0dn9DazxBUi3YKJXBLg64v5ne6R0AYke7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532956; c=relaxed/simple;
	bh=hd5cj1VyA/d0T/ntQwiii7GhLKEXsJXcwSYU99VWdng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2hBC4cSJ3J0mcTB+UPjmZpGldEcnVhmqvcm44ool5QOPI3wZYGEQGLRnkuNC9wXFPJADpeVqcX5Gjkm+fu8AALjReAnb2Sr6SEeeL0taS3etmXyDPYGpPAYrEIiNGvoRHGxgNTL06fpPLum1txr75YYRwywZDhSCOoNN2aeSm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyNquUY/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771532955; x=1803068955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hd5cj1VyA/d0T/ntQwiii7GhLKEXsJXcwSYU99VWdng=;
  b=CyNquUY/+bM4EdqlDwhLWpSzq/m81LMwvuuURce/OODF1HlptpEQmXrQ
   jjnFJ5MkASqqfurKt0xMt0bBCtmzRJ7JXSTUcw37ZdKKJgPThdQWtPYl5
   xP7s4Lt+lezeTAxo1r4NdVlxnFzOPWKn2IcZv1LVhftAypYoWiy8yWcxF
   LUFK0RT4DGSBxq/493k6ugJlK0Qp7Xwp3u3boENjhGVBSOsusIuiCL+xb
   4K5tNWSazwLIh9LDH/0ylJvv1BjStS7uSvYaOnsrk6dkBhH5cA8vvKXjF
   T/E2eikdbmGkmJ6DZ3CrCxmKhjm9XAkD36xRQ0Vb/DmXchuiKjEsjYKDs
   Q==;
X-CSE-ConnectionGUID: 1QD2piwbRcaSXispmPq0FA==
X-CSE-MsgGUID: g5o+XwKbRe2/7ZtgZMG6qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72532327"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72532327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:29:14 -0800
X-CSE-ConnectionGUID: E/tMwy0FQ+eY6JvUZmo1lw==
X-CSE-MsgGUID: Q0hV3O4bSIi5mewv/TNg3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="219183206"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 19 Feb 2026 12:29:13 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F387298; Thu, 19 Feb 2026 21:29:11 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] phy: phy-can-transceiver: Convert to use device property API
Date: Thu, 19 Feb 2026 21:26:19 +0100
Message-ID: <20260219202910.2304440-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
References: <20260219202910.2304440-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-6599-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 15EE91624FB
X-Rspamd-Action: no action

It seems the driver is half-moved to use device property APIs.
Finish that by converting everything to use that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/phy/phy-can-transceiver.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 330356706ad7..f2259af4af8a 100644
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
@@ -130,7 +130,7 @@ MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
 static inline struct mux_state *
 devm_mux_state_get_optional(struct device *dev, const char *mux_name)
 {
-	if (!of_property_present(dev->of_node, "mux-states"))
+	if (!device_property_present(dev, "mux-states"))
 		return NULL;
 
 	return devm_mux_state_get(dev, mux_name);
@@ -162,7 +162,6 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	struct can_transceiver_phy *can_transceiver_phy;
 	struct can_transceiver_priv *priv;
 	const struct can_transceiver_data *drvdata;
-	const struct of_device_id *match;
 	struct phy *phy;
 	struct gpio_desc *silent_gpio;
 	struct gpio_desc *standby_gpio;
@@ -171,8 +170,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	u32 max_bitrate = 0;
 	int err, i, num_ch = 1;
 
-	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
-	drvdata = match->data;
+	drvdata = device_get_match_data(dev);
 	if (drvdata->flags & CAN_TRANSCEIVER_DUAL_CH)
 		num_ch = 2;
 
@@ -197,7 +195,7 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 		can_transceiver_phy = &priv->can_transceiver_phy[i];
 		can_transceiver_phy->priv = priv;
 
-		phy = devm_phy_create(dev, dev->of_node, &can_transceiver_phy_ops);
+		phy = devm_phy_create(dev, NULL, &can_transceiver_phy_ops);
 		if (IS_ERR(phy)) {
 			dev_err(dev, "failed to create can transceiver phy\n");
 			return PTR_ERR(phy);
-- 
2.50.1


