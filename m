Return-Path: <linux-can+bounces-7605-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB2xLD0zA2qX1gEAu9opvQ
	(envelope-from <linux-can+bounces-7605-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 16:03:41 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C1521E77
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 16:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 370583236DAB
	for <lists+linux-can@lfdr.de>; Tue, 12 May 2026 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CD3397339;
	Tue, 12 May 2026 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftif8nLZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D43394E91;
	Tue, 12 May 2026 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591171; cv=none; b=aMYezXwfncFZfGTlcCbwXkjiMnNNcs7/X/JJ83XrdO77j1xSxlR8a43ZsT2yBdoUfhU99teJKAH2WTlptjkWUrkJZomlAeZdLMlW7YZt1OIPhXX4w29K46Kju37mym/bIjasMXVI3Xfkx4JuX/LnAIL+p7GPf/PaInyzaEOI/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591171; c=relaxed/simple;
	bh=bHWrPhTiJL2fP/DH1DaMkMAaneZI5rRXmH5SsOzULJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDf1z6kDJh/QETmY6s1pIpebgiroxYu66Nw9d7sWCzKl78ktJ6BdNOaAsQo3Q0rV9qmTfFuAnP2Ec9Zm2yvH0nVxejmTX1hyNKCXW/gg1iytSy9UcTpHkZq26zk1yQX6TBABM3hiKa0J4VrK9tNRl9/bzMDmjkwaNhyb6YuwqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftif8nLZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778591170; x=1810127170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHWrPhTiJL2fP/DH1DaMkMAaneZI5rRXmH5SsOzULJw=;
  b=ftif8nLZqp18Dbb/E4fqH7pPjIqM1sYnotR0C+m2qDx/aAK+flVGCKwG
   dBHleRpvdEWONw3olHO6bH9Ui0odBCRjinpcD8WFZ9l/4cGsl9DtKd6if
   i3Q+x7FOPqnx1wTi+iTvNjpSR96aoNj6N+Lf4WhWsA3Q2ncke9LyuYxEh
   RJj/HyT+hRxWyfRHqXIWAMPGObV/io2Ctku6Dy5yTsir0QYYN/vAQwjLQ
   zkZAPBZGaHkBP5DY/UCEUzYI/8mz+lybDraQUix/WljCEaMBdolCZWu6q
   vVHmn4SA7Z6DIP0XlJTLPQJv558yysSacVgcDEZ7gguOaDSN/L7OV0MCH
   A==;
X-CSE-ConnectionGUID: bG2iSKb5QwqnTIut/nwiHA==
X-CSE-MsgGUID: 5m3YPKQtSZ2h+smVYZFsrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90600384"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90600384"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:06:00 -0700
X-CSE-ConnectionGUID: /mJvE0wNS7anVBFuForJMQ==
X-CSE-MsgGUID: a2XOIYexRYGNV6ODYrbgFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233294184"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 12 May 2026 06:05:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 74E8A9B; Tue, 12 May 2026 15:05:55 +0200 (CEST)
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
Subject: [PATCH v4 2/5] phy: phy-can-transceiver: use device_get_match_data()
Date: Tue, 12 May 2026 15:01:50 +0200
Message-ID: <20260512130552.272476-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260512130552.272476-1-andriy.shevchenko@linux.intel.com>
References: <20260512130552.272476-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B26C1521E77
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
	TAGGED_FROM(0.00)[bounces-7605-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,solid-run.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:url,linux.intel.com:mid]
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
index 1808f903c057..5cfd09735204 100644
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
+	if (drvdata)
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


